class_name WinConditions
extends Node

## Manages win conditions for Emotion Cards combat.
## Supports multiple condition types and checks them after each turn.

signal condition_met(condition: WinCondition)
signal all_conditions_met
signal objective_completed(objective_id: String)
signal score_threshold_reached(current: int, required: int)
signal round_survived(round_number: int)

## Types of win conditions
enum ConditionType {
	DEFEAT_ALL_ENEMIES,
	SURVIVE_ROUNDS,
	SCORE_THRESHOLD,
	COMPLETE_OBJECTIVE,
	HP_ABOVE_THRESHOLD,
	CARD_PLAYED,
	EMOTION_MASTERED
}

## Win condition data class
class WinCondition:
	var type: ConditionType
	var description: String
	var is_optional: bool = false
	
	# For SURVIVE_ROUNDS
	var rounds_to_survive: int = 0
	
	# For SCORE_THRESHOLD
	var score_required: int = 0
	
	# For COMPLETE_OBJECTIVE
	var objective_id: String = ""
	var objective_completed: bool = false
	
	# For HP_ABOVE_THRESHOLD
	var hp_threshold: int = 0
	
	# For CARD_PLAYED
	var card_id: String = ""
	var cards_to_play: int = 0
	var cards_played: int = 0
	
	# For EMOTION_MASTERED
	var emotion_type: String = ""
	var emotion_level_required: int = 0
	
	func _init(p_type: ConditionType, p_description: String, p_optional: bool = false) -> void:
		type = p_type
		description = p_description
		is_optional = p_optional

@export var combat_state_machine: CombatStateMachine
@export var turn_system: TurnSystem

var _conditions: Array[WinCondition] = []
var _active_objectives: Array[String] = []
var _current_score: int = 0

func _ready() -> void:
	_setup_connections()

func _setup_connections() -> void:
	if combat_state_machine:
		combat_state_machine.player_turn_ended.connect(_on_turn_ended)
		combat_state_machine.enemy_turn_ended.connect(_on_turn_ended)
	
	if turn_system:
		turn_system.round_ended.connect(_on_round_ended)

## Add a win condition
func add_condition(condition: WinCondition) -> void:
	_conditions.append(condition)

## Add defeat all enemies condition (default)
func add_defeat_all_enemies_condition(optional: bool = false) -> void:
	var condition = WinCondition.new(
		ConditionType.DEFEAT_ALL_ENEMIES,
		"Defeat all enemies",
		optional
	)
	add_condition(condition)

## Add survive X rounds condition
func add_survive_rounds_condition(rounds: int, optional: bool = false) -> void:
	var condition = WinCondition.new(
		ConditionType.SURVIVE_ROUNDS,
		"Survive for %d rounds" % rounds,
		optional
	)
	condition.rounds_to_survive = rounds
	add_condition(condition)

## Add score threshold condition
func add_score_threshold_condition(score: int, optional: bool = false) -> void:
	var condition = WinCondition.new(
		ConditionType.SCORE_THRESHOLD,
		"Reach a score of %d" % score,
		optional
	)
	condition.score_required = score
	add_condition(condition)

## Add objective completion condition
func add_objective_condition(objective_id: String, description: String, optional: bool = false) -> void:
	var condition = WinCondition.new(
		ConditionType.COMPLETE_OBJECTIVE,
		description,
		optional
	)
	condition.objective_id = objective_id
	_active_objectives.append(objective_id)
	add_condition(condition)

## Add HP threshold condition
func add_hp_threshold_condition(hp: int, optional: bool = false) -> void:
	var condition = WinCondition.new(
		ConditionType.HP_ABOVE_THRESHOLD,
		"Maintain above %d HP" % hp,
		optional
	)
	condition.hp_threshold = hp
	add_condition(condition)

## Add card played condition
func add_card_played_condition(card_id: String, count: int, description: String, optional: bool = false) -> void:
	var condition = WinCondition.new(
		ConditionType.CARD_PLAYED,
		description,
		optional
	)
	condition.card_id = card_id
	condition.cards_to_play = count
	add_condition(condition)

## Add emotion mastered condition
func add_emotion_mastered_condition(emotion: String, level: int, description: String, optional: bool = false) -> void:
	var condition = WinCondition.new(
		ConditionType.EMOTION_MASTERED,
		description,
		optional
	)
	condition.emotion_type = emotion
	condition.emotion_level_required = level
	add_condition(condition)

## Update the current score
func set_score(score: int) -> void:
	_current_score = score

## Increment score
func add_score(amount: int) -> void:
	_current_score += amount

## Mark an objective as completed
func complete_objective(objective_id: String) -> void:
	if objective_id in _active_objectives:
		objective_completed.emit(objective_id)
		
		for condition in _conditions:
			if condition.type == ConditionType.COMPLETE_OBJECTIVE and condition.objective_id == objective_id:
				condition.objective_completed = true
				condition_met.emit(condition)
				_check_all_conditions()

## Record a card being played
func record_card_played(card_id: String) -> void:
	for condition in _conditions:
		if condition.type == ConditionType.CARD_PLAYED:
			if condition.card_id.is_empty() or condition.card_id == card_id:
				condition.cards_played += 1
				if condition.cards_played >= condition.cards_to_play:
					condition_met.emit(condition)

## Check all win conditions
func check_conditions() -> void:
	for condition in _conditions:
		_check_condition(condition)
	
	_check_all_conditions()

func _check_condition(condition: WinCondition) -> void:
	match condition.type:
		ConditionType.DEFEAT_ALL_ENEMIES:
			_check_defeat_all_enemies(condition)
		
		ConditionType.SURVIVE_ROUNDS:
			_check_survive_rounds(condition)
		
		ConditionType.SCORE_THRESHOLD:
			_check_score_threshold(condition)
		
		ConditionType.COMPLETE_OBJECTIVE:
			_check_objective(condition)
		
		ConditionType.HP_ABOVE_THRESHOLD:
			_check_hp_threshold(condition)
		
		ConditionType.EMOTION_MASTERED:
			_check_emotion_mastered(condition)

func _check_defeat_all_enemies(condition: WinCondition) -> void:
	if combat_state_machine and combat_state_machine.check_victory():
		condition_met.emit(condition)

func _check_survive_rounds(condition: WinCondition) -> void:
	if turn_system:
		var current_round = turn_system.current_round
		if current_round >= condition.rounds_to_survive:
			round_survived.emit(current_round)
			condition_met.emit(condition)

func _check_score_threshold(condition: WinCondition) -> void:
	if _current_score >= condition.score_required:
		score_threshold_reached.emit(_current_score, condition.score_required)
		condition_met.emit(condition)

func _check_objective(condition: WinCondition) -> void:
	if condition.objective_completed:
		condition_met.emit(condition)

func _check_hp_threshold(condition: WinCondition) -> void:
	if combat_state_machine and combat_state_machine.player_entity:
		var player = combat_state_machine.player_entity
		if player.has_method("get_hp"):
			var hp = player.get_hp()
			if hp >= condition.hp_threshold:
				condition_met.emit(condition)

func _check_emotion_mastered(condition: WinCondition) -> void:
	# TODO: Implement emotion mastery checking when emotion system is ready
	pass

func _check_all_conditions() -> void:
	var required_conditions = _conditions.filter(func(c): return not c.is_optional)
	var met_conditions = _conditions.filter(func(c): return _is_condition_met(c))
	
	if met_conditions.size() >= required_conditions.size():
		all_conditions_met.emit()
		if combat_state_machine:
			combat_state_machine.force_victory()

func _is_condition_met(condition: WinCondition) -> bool:
	match condition.type:
		ConditionType.DEFEAT_ALL_ENEMIES:
			return combat_state_machine and combat_state_machine.check_victory()
		ConditionType.SURVIVE_ROUNDS:
			return turn_system and turn_system.current_round >= condition.rounds_to_survive
		ConditionType.SCORE_THRESHOLD:
			return _current_score >= condition.score_required
		ConditionType.COMPLETE_OBJECTIVE:
			return condition.objective_completed
		ConditionType.HP_ABOVE_THRESHOLD:
			if combat_state_machine and combat_state_machine.player_entity:
				var player = combat_state_machine.player_entity
				return player.has_method("get_hp") and player.get_hp() >= condition.hp_threshold
		ConditionType.CARD_PLAYED:
			return condition.cards_played >= condition.cards_to_play
		ConditionType.EMOTION_MASTERED:
			return false  # TODO: Implement
	return false

## Called when a turn ends
func _on_turn_ended() -> void:
	check_conditions()

## Called when a round ends
func _on_round_ended(round_num: int) -> void:
	check_conditions()

## Get all active conditions
func get_conditions() -> Array[WinCondition]:
	return _conditions.duplicate()

## Get condition progress for UI
func get_condition_progress(condition: WinCondition) -> Dictionary:
	var progress = {
		"description": condition.description,
		"type": ConditionType.keys()[condition.type],
		"completed": _is_condition_met(condition),
		"optional": condition.is_optional
	}
	
	match condition.type:
		ConditionType.SURVIVE_ROUNDS:
			progress["current"] = turn_system.current_round if turn_system else 0
			progress["required"] = condition.rounds_to_survive
		
		ConditionType.SCORE_THRESHOLD:
			progress["current"] = _current_score
			progress["required"] = condition.score_required
		
		ConditionType.CARD_PLAYED:
			progress["current"] = condition.cards_played
			progress["required"] = condition.cards_to_play
		
		ConditionType.COMPLETE_OBJECTIVE:
			progress["objective_id"] = condition.objective_id
	
	return progress

## Clear all conditions
func clear_conditions() -> void:
	_conditions.clear()
	_active_objectives.clear()
	_current_score = 0

## Reset for new combat
func reset() -> void:
	_current_score = 0
	for condition in _conditions:
		condition.objective_completed = false
		condition.cards_played = 0
