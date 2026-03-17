class_name EnemyAI
extends Node

## Base Enemy AI for Emotion Cards combat system.
## Provides decision-making framework with priority-based action selection.
## Extend this class to create specific enemy behaviors.

signal action_selected(action: EnemyAction)
signal decision_made(decision: String)

enum ActionType { ATTACK, DEFEND, USE_CARD, WAIT }

class EnemyAction:
	var type: ActionType
	var priority: int
	var card: Card
	var target: Node
	var value: int
	
	func _init(p_type: ActionType, p_priority: int, p_value: int = 0):
		type = p_type
		priority = p_priority
		value = p_value

var _action_queue: Array[EnemyAction] = []
var _current_priority_modifiers: Dictionary = {}

## Override in subclasses to customize behavior
func get_aggression_level() -> float:
	return 0.5  # 0.0 = defensive, 1.0 = aggressive

## Override in subclasses to define card preferences
func get_preferred_card_types() -> Array[Card.CardType]:
	return [Card.CardType.ATTACK, Card.CardType.DEFENSE, Card.CardType.EMOTION]

## Main decision function - call this each turn
func decide(enemy_health: int, enemy_max_health: int, player_health: int, 
			player_max_health: int, hand: Array[Card], turn_count: int) -> EnemyAction:
	
	_action_queue.clear()
	_current_priority_modifiers.clear()
	
	# Build priority modifiers based on game state
	_setup_priority_modifiers(enemy_health, enemy_max_health, player_health, player_max_health, turn_count)
	
	# Generate all possible actions
	_generate_actions(hand, enemy_health, player_health)
	
	# Select the highest priority action
	var selected = _select_best_action()
	
	action_selected.emit(selected)
	decision_made.emit(_action_type_to_string(selected.type))
	
	return selected

func _setup_priority_modifiers(e_hp: int, e_max: int, p_hp: int, p_max: int, turns: int) -> void:
	var health_ratio := float(e_hp) / float(e_max) if e_max > 0 else 0.0
	var player_health_ratio := float(p_hp) / float(p_max) if p_max > 0 else 0.0
	
	# Low health - prefer defense
	if health_ratio < 0.3:
		_current_priority_modifiers[ActionType.DEFEND] = 30
		_current_priority_modifiers[ActionType.ATTACK] = -20
	
	# Player low - go aggressive
	if player_health_ratio < 0.25:
		_current_priority_modifiers[ActionType.ATTACK] = 25
	
	# Apply aggression level
	var agg = get_aggression_level()
	_current_priority_modifiers[ActionType.ATTACK] += int(agg * 20)
	_current_priority_modifiers[ActionType.DEFEND] += int((1.0 - agg) * 15)
	
	# Early turns - be more careful
	if turns < 3:
		_current_priority_modifiers[ActionType.DEFEND] += 10

func _generate_actions(hand: Array[Card], enemy_health: int, player_health: int) -> void:
	# Add attack actions
	var attack_priority = _calculate_base_priority(ActionType.ATTACK)
	_action_queue.append(EnemyAction.new(ActionType.ATTACK, attack_priority, _estimate_attack_damage(hand)))
	
	# Add defend actions
	var defend_priority = _calculate_base_priority(ActionType.DEFEND)
	_action_queue.append(EnemyAction.new(ActionType.DEFEND, defend_priority, _estimate_defend_value()))
	
	# Add card-based actions
	for card in hand:
		if card == null:
			continue
		var card_priority = _calculate_card_priority(card, enemy_health, player_health)
		var action = EnemyAction.new(ActionType.USE_CARD, card_priority, card.value)
		action.card = card
		_action_queue.append(action)
	
	# Add wait as fallback
	var wait_priority = _calculate_base_priority(ActionType.WAIT)
	_action_queue.append(EnemyAction.new(ActionType.WAIT, wait_priority))

func _calculate_base_priority(action_type: ActionType) -> int:
	var priority := 10  # Default base priority
	
	match action_type:
		ActionType.ATTACK:
			priority = 20
		ActionType.DEFEND:
			priority = 15
		ActionType.USE_CARD:
			priority = 25
		ActionType.WAIT:
			priority = 5
	
	# Apply modifiers
	if _current_priority_modifiers.has(action_type):
		priority += _current_priority_modifiers[action_type]
	
	return priority

func _calculate_card_priority(card: Card, enemy_health: int, player_health: int) -> int:
	var priority := _calculate_base_priority(ActionType.USE_CARD)
	
	# Card type modifiers
	match card.card_type:
		Card.CardType.ATTACK:
			priority += card.value
			if player_health <= card.value:
				priority += 50  # Finishing move bonus
		Card.CardType.DEFENSE:
			priority += card.value
			if float(enemy_health) / 100.0 < 0.3:
				priority += 20  # Heal when low
		Card.CardType.EMOTION:
			priority += 15  # Emotion cards are valuable
	
	# Check if card fits preferred types
	var preferred = get_preferred_card_types()
	if card.card_type in preferred:
		priority += 10
	
	return priority

func _select_best_action() -> EnemyAction:
	if _action_queue.is_empty():
		return EnemyAction.new(ActionType.WAIT, 0, 0)
	
	_action_queue.sort_custom(func(a, b): return a.priority > b.priority)
	return _action_queue[0]

func _estimate_attack_damage(hand: Array[Card]) -> int:
	var max_damage := 0
	for card in hand:
		if card and card.card_type == Card.CardType.ATTACK:
			max_damage = max(max_damage, card.value)
	return max_damage

func _estimate_defend_value(hand: Array[Card] = []) -> int:
	var max_defense := 0
	for card in hand:
		if card and card.card_type == Card.CardType.DEFENSE:
			max_defense = max(max_defense, card.value)
	return max_defense

func _action_type_to_string(type: ActionType) -> String:
	match type:
		ActionType.ATTACK:
			return "ATTACK"
		ActionType.DEFEND:
			return "DEFEND"
		ActionType.USE_CARD:
			return "USE_CARD"
		ActionType.WAIT:
			return "WAIT"
		_:
			return "UNKNOWN"

## Placeholder for future complexity - learning AI
func learn_from_result(success: bool, action: EnemyAction) -> void:
	# TODO: Implement learning system
	# Track which actions lead to good outcomes
	# Adjust priority modifiers based on history
	pass

## Placeholder for personality system
func apply_personality_modifiers(personality: Dictionary) -> void:
	# TODO: Implement personality-based adjustments
	# E.g., aggressive enemies prefer attacks
	# Defensive enemies prefer defense
	# Random enemies have more variance
	pass
