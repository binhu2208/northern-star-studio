class_name LoseConditions
extends Node

## Manages lose conditions for Emotion Cards combat.
## Checks various defeat conditions and signals when the player loses.

signal defeat_triggered(defeat_type: LoseConditionType, message: String)
signal fatigue_damage_applied(damage: int)
signal time_limit_warning(time_remaining: float)
signal objective_failed(objective_id: String, reason: String)

enum LoseConditionType {
	HP_ZERO,
	FATIGUE,
	TIME_LIMIT,
	CRITICAL_OBJECTIVE
}

@export var combat_state_machine: CombatStateMachine
@export var turn_system: TurnSystem
@export var card_manager: CardManager

## Configuration
var enable_fatigue: bool = true
var enable_time_limit: bool = true
var enable_critical_objectives: bool = true

## Fatigue settings
var fatigue_damage_per_empty_turn: int = 3
var max_fatigue_stacks: int = 3

## Time limit settings
var time_limit_seconds: float = 120.0
var warning_threshold_seconds: float = 30.0
var _time_remaining: float = 0.0
var _timer_node: Timer = null

## Critical objectives
var _active_objectives: Dictionary = {}  # objective_id -> objective data
var _current_objectives: Array[String] = []

## Internal state
var _fatigue_stacks: int = 0
var _is_monitoring: bool = false

func _ready() -> void:
	_setup_timer()
	_connect_signals()

func _setup_timer() -> void:
	_timer_node = Timer.new()
	_timer_node.wait_time = 0.1
	_timer_node.timeout.connect(_on_timer_tick)
	add_child(_timer_node)

func _connect_signals() -> void:
	if turn_system:
		turn_system.turn_ended.connect(_on_turn_ended)
		turn_system.phase_changed.connect(_on_phase_changed)
	
	if combat_state_machine:
		combat_state_machine.state_changed.connect(_on_state_changed)

## ============================================================
## PUBLIC API
## ============================================================

## Start monitoring lose conditions
func start_monitoring() -> void:
	_is_monitoring = true
	_reset_state()
	_start_timer()

## Stop monitoring lose conditions
func stop_monitoring() -> void:
	_is_monitoring = false
	_stop_timer()

## Set time limit for combat (in seconds)
func set_time_limit(seconds: float) -> void:
	time_limit_seconds = seconds
	_time_remaining = seconds

## Add a critical objective to track
## [code]objective_id[/code] - Unique identifier for the objective
## [code]description[/code] - Human-readable description
## [code]check_func[/code] - Callable that returns true if objective is met
func add_critical_objective(
	objectivE_id: String,
	description: String,
	check_func: Callable
) -> void:
	_active_objectives[objectivE_id] = {
		"description": description,
		"check": check_func,
		"failed": false
	}
	_current_objectives.append(objectivE_id)

## Remove a critical objective
func remove_critical_objective(objective_id: String) -> void:
	_active_objectives.erase(objective_id)
	_current_objectives.erase(objective_id)

## Get all active objectives
func get_active_objectives() -> Array[Dictionary]:
	var objectives: Array[Dictionary] = []
	for id in _current_objectives:
		if _active_objectives.has(id):
			objectives.append({
				"id": id,
				"description": _active_objectives[id]["description"],
				"failed": _active_objectives[id]["failed"]
			})
	return objectives

## Manually trigger a defeat (for testing or special cases)
func trigger_defeat(type: LoseConditionType, message: String) -> void:
	if combat_state_machine and not combat_state_machine.is_combat_ended():
		defeat_triggered.emit(type, message)
		combat_state_machine.force_defeat()

## Get current fatigue stacks
func get_fatigue_stacks() -> int:
	return _fatigue_stacks

## Get remaining time
func get_time_remaining() -> float:
	return _time_remaining

## Check all lose conditions (called after each turn)
func check_lose_conditions() -> void:
	if not _is_monitoring:
		return
	
	_check_hp_zero()
	_check_fatigue()
	_check_time_limit()
	_check_critical_objectives()

## ============================================================
## INTERNAL METHODS
## ============================================================

func _reset_state() -> void:
	_fatigue_stacks = 0
	_time_remaining = time_limit_seconds
	
	for obj_id in _active_objectives.keys():
		_active_objectives[obj_id]["failed"] = false

func _start_timer() -> void:
	if _timer_node:
		_time_remaining = time_limit_seconds
		_timer_node.start()

func _stop_timer() -> void:
	if _timer_node:
		_timer_node.stop()

func _on_timer_tick() -> void:
	if not _is_monitoring:
		return
	
	_time_remaining -= 0.1
	
	if _time_remaining <= warning_threshold_seconds and _time_remaining > 0:
		time_limit_warning.emit(_time_remaining)
	
	if _time_remaining <= 0:
		_check_time_limit()

func _on_turn_ended(_is_player_turn: bool) -> void:
	if _is_monitoring:
		check_lose_conditions()

func _on_phase_changed(_from_phase: int, to_phase: int) -> void:
	# Check conditions at specific phases
	if turn_system:
		var phase_enum = turn_system.Phase
		if to_phase == phase_enum.COMBAT_RESOLUTION:
			check_lose_conditions()

func _on_state_changed(_old_state: CombatStateMachine.CombatState, new_state: CombatStateMachine.CombatState) -> void:
	if new_state == CombatStateMachine.CombatState.VICTORY or \
	   new_state == CombatStateMachine.CombatState.DEFEAT or \
	   new_state == CombatStateMachine.CombatState.DRAW:
		stop_monitoring()

## ============================================================
## LOSE CONDITION CHECKS
## ============================================================

func _check_hp_zero() -> void:
	if not combat_state_machine:
		return
	
	var player_entity = combat_state_machine.player_entity
	if not player_entity:
		return
	
	var player_hp = _get_hp(player_entity)
	
	if player_hp <= 0:
		trigger_defeat(LoseConditionType.HP_ZERO, "Player HP reached 0")

func _check_fatigue() -> void:
	if not enable_fatigue:
		return
	
	if not card_manager:
		return
	
	# Check if player has no cards in hand and draw pile is empty
	var hand_empty = card_manager.hand.get_hand_size() == 0
	var draw_empty = card_manager.draw_pile.is_empty()
	var discard_not_empty = not card_manager.discard_pile.is_empty()
	
	if hand_empty and draw_empty:
		# Check if we can reshuffle
		if not discard_not_empty:
			# No cards left at all - apply fatigue damage
			_apply_fatigue_damage()
		else:
			# Will reshuffle on next draw, apply fatigue if already at max stacks
			if _fatigue_stacks >= max_fatigue_stacks:
				_apply_fatigue_damage()
	elif hand_empty:
		# Player has no cards in hand but can draw
		_fatigue_stacks = minf(_fatigue_stacks + 1, max_fatigue_stacks)

func _apply_fatigue_damage() -> void:
	if not combat_state_machine or not combat_state_machine.player_entity:
		return
	
	var damage = fatigue_damage_per_empty_turn * (_fatigue_stacks + 1)
	var player = combat_state_machine.player_entity
	
	if player.has_method("take_damage"):
		player.take_damage(damage)
	
	fatigue_damage_applied.emit(damage)
	_fatigue_stacks = 0
	
	# Check if this killed the player
	check_lose_conditions()

func _check_time_limit() -> void:
	if not enable_time_limit:
		return
	
	if _time_remaining <= 0:
		trigger_defeat(LoseConditionType.TIME_LIMIT, "Time limit exceeded")

func _check_critical_objectives() -> void:
	if not enable_critical_objectives:
		return
	
	for obj_id in _current_objectives:
		if not _active_objectives.has(obj_id):
			continue
		
		var obj_data = _active_objectives[obj_id]
		if obj_data["failed"]:
			continue
		
		var check_func: Callable = obj_data["check"]
		if check_func.is_valid():
			var objective_met = check_func.call()
			if not objective_met:
				obj_data["failed"] = true
				var reason = "Failed objective: " + obj_data["description"]
				objective_failed.emit(obj_id, reason)
				trigger_defeat(LoseConditionType.CRITICAL_OBJECTIVE, reason)

func _get_hp(entity: Node) -> int:
	if entity.has_method("get_hp"):
		return entity.get_hp()
	return 0

## ============================================================
## INTEGRATION HELPERS
## ============================================================

## Connect to existing combat entities
func connect_to_combat(
	state_machine: CombatStateMachine,
	turn_sys: TurnSystem,
	card_mgr: CardManager,
	player_entity: Node
) -> void:
	combat_state_machine = state_machine
	turn_system = turn_sys
	card_manager = card_mgr
	
	if combat_state_machine:
		combat_state_machine.player_entity = player_entity
	
	_connect_signals()
	start_monitoring()

## Reset all lose condition state
func reset() -> void:
	stop_monitoring()
	_reset_state()
	_fatigue_stacks = 0
	_current_objectives.clear()
