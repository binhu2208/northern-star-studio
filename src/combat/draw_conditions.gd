class_name DrawConditions
extends Node

## Manages draw/tie conditions for Emotion Cards combat.
## Handles scenarios where combat ends in a draw rather than victory/defeat.

signal draw_triggered(draw_type: DrawType, details: Dictionary)
signal stalemate_detected
signal max_turns_reached
signal infinite_loop_detected

## Types of draw conditions
enum DrawType {
	SIMULTANEOUS_DEATH,    ## Both player and enemy reach 0 HP at same time
	STALEMATE,             ## No valid actions available to either side
	MAX_TURNS_EXCEEDED,   ## Turn limit reached with no winner
	INFINITE_LOOP          ## Prevention of infinite combat loops
}

## Configuration
@export var max_turns: int = 50
@export var max_consecutive_skips: int = 3  ## Detect stalemate by counting skips

## Internal state
var turn_count: int = 0
var consecutive_skips: int = 0
var last_player_hp: int = 0
var last_enemy_hp: int = 0
var hp_history: Array[Vector2i] = []  ## Track HP changes for loop detection
var max_history_size: int = 10

## References
var combat_state_machine: CombatStateMachine
var turn_system: TurnSystem

func _ready() -> void:
	_init_references()


## Initialize references to other combat systems
func _init_references() -> void:
	## Try to get combat state machine from parent or find it
	if has_parent():
		var parent = get_parent()
		if parent is CombatStateMachine:
			combat_state_machine = parent
		elif parent.has_node("CombatStateMachine"):
			combat_state_machine = parent.get_node("CombatStateMachine")
	
	## Try to get turn system
	if has_node("../TurnSystem"):
		turn_system = get_node("../TurnSystem")


## Reset all draw condition tracking
func reset() -> void:
	turn_count = 0
	consecutive_skips = 0
	last_player_hp = 0
	last_enemy_hp = 0
	hp_history.clear()


## Check all draw conditions after each turn
func check_draw_conditions(player_entity: Node, enemy_entity: Node) -> bool:
	if not _entities_valid(player_entity, enemy_entity):
		return false
	
	var player_hp = _get_hp(player_entity)
	var enemy_hp = _get_hp(enemy_entity)
	
	## Increment turn count
	turn_count += 1
	
	## Check each draw condition
	if _check_simultaneous_death(player_hp, enemy_hp):
		return true
	
	if _check_stalemate(player_entity, enemy_entity):
		return true
	
	if _check_max_turns():
		return true
	
	if _check_infinite_loop(player_hp, enemy_hp):
		return true
	
	## Update tracking for next check
	_update_hp_tracking(player_hp, enemy_hp)
	last_player_hp = player_hp
	last_enemy_hp = enemy_hp
	
	return false


## Check if both player and enemy reached 0 HP simultaneously
func _check_simultaneous_death(player_hp: int, enemy_hp: int) -> bool:
	if player_hp <= 0 and enemy_hp <= 0:
		var details := {
			"player_hp": player_hp,
			"enemy_hp": enemy_hp,
			"turn_count": turn_count
		}
		_draw_triggered(DrawType.SIMULTANEOUS_DEATH, details)
		return true
	return false


## Check for stalemate - no valid actions available
func _check_stalemate(player_entity: Node, enemy_entity: Node) -> bool:
	var player_can_act := _can_entity_act(player_entity)
	var enemy_can_act := _can_entity_act(enemy_entity)
	
	if not player_can_act and not enemy_can_act:
		var details := {
			"turn_count": turn_count,
			"reason": "No valid actions available to either side"
		}
		_draw_triggered(DrawType.STALEMATE, details)
		stalemate_detected.emit()
		return true
	
	## Track consecutive skips for additional stalemate detection
	if not player_can_act:
		consecutive_skips += 1
	else:
		consecutive_skips = 0
	
	if consecutive_skips >= max_consecutive_skips:
		var details := {
			"turn_count": turn_count,
			"consecutive_skips": consecutive_skips
		}
		_draw_triggered(DrawType.STALEMATE, details)
		stalemate_detected.emit()
		return true
	
	return false


## Check if max turns have been reached
func _check_max_turns() -> bool:
	if turn_count >= max_turns:
		var details := {
			"turn_count": turn_count,
			"max_turns": max_turns
		}
		_draw_triggered(DrawType.MAX_TURNS_EXCEEDED, details)
		max_turns_reached.emit()
		return true
	return false


## Check for infinite loop patterns in HP
func _check_infinite_loop(player_hp: int, enemy_hp: int) -> bool:
	if hp_history.size() < 3:
		return false
	
	## Check if HP has been stable for too long (no progress)
	var recent_hp := Vector2i(player_hp, enemy_hp)
	var stable_count := 0
	
	for i in range(hp_history.size() - 1, -1, -1):
		if hp_history[i] == recent_hp:
			stable_count += 1
		else:
			break
	
	## If HP hasn't changed in more than half the history, likely a loop
	if stable_count >= (max_history_size / 2):
		var details := {
			"turn_count": turn_count,
			"player_hp": player_hp,
			"enemy_hp": enemy_hp,
			"stable_turns": stable_count
		}
		_draw_triggered(DrawType.INFINITE_LOOP, details)
		infinite_loop_detected.emit()
		return true
	
	return false


## Update HP history tracking
func _update_hp_tracking(player_hp: int, enemy_hp: int) -> void:
	hp_history.append(Vector2i(player_hp, enemy_hp))
	
	## Keep history at max size
	if hp_history.size() > max_history_size:
		hp_history.pop_front()


## Check if an entity can take actions
func _can_entity_act(entity: Node) -> bool:
	if not is_instance_valid(entity):
		return false
	
	## Check if entity is alive
	if entity.has_method("get_hp"):
		var hp = entity.get_hp()
		if hp <= 0:
			return false
	
	## Check if entity has any valid actions/cards
	if entity.has_method("has_valid_actions"):
		return entity.has_valid_actions()
	
	if entity.has_method("get_available_cards"):
		var cards = entity.get_available_cards()
		return cards.size() > 0
	
	## Default: entity can act if alive
	return true


## Internal method to trigger draw state
func _draw_triggered(draw_type: DrawType, details: Dictionary) -> void:
	draw_triggered.emit(draw_type, details)
	
	## Signal combat state machine if available
	if combat_state_machine != null:
		combat_state_machine.force_draw()


## Helper: Check if entities are valid
func _entities_valid(player: Node, enemy: Node) -> bool:
	return is_instance_valid(player) and is_instance_valid(enemy)


## Helper: Get HP from entity
func _get_hp(entity: Node) -> int:
	if entity.has_method("get_hp"):
		return entity.get_hp()
	return 0


## Public: Set max turns limit
func set_max_turns(new_max: int) -> void:
	max_turns = new_max


## Public: Get current turn count
func get_turn_count() -> int:
	return turn_count


## Public: Get draw condition type name
func get_draw_type_name(draw_type: DrawType) -> String:
	return DrawType.keys()[draw_type]


## Public: Check if current state is a draw
func is_draw() -> bool:
	if combat_state_machine != null:
		return combat_state_machine.check_draw()
	return false
