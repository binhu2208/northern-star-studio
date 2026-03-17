## Base Character Class
##
## Foundation class for all playable characters in Emotion Cards.
## Provides common stats, health management, and card integration.

class_name Character
extends Node

## Signals
signal health_changed(current: int, max: int)
signal died
signal took_damage(amount: int, source: Node)
signal healed(amount: int)

## Character stats
@export var character_id: String = ""
@export var character_name: String = "Unnamed"
@export var description: String = ""

@export var max_health: int = 100
@export var current_health: int = 100

## Combat stats
@export var attack_power: int = 10
@export var defense_power: int = 5
@export var speed: int = 10

## Emotional capacity - plays per turn
@export var emotional_capacity: int = 3
@export var current_plays: int = 3

## Energy system
@export var max_energy: int = 3
@export var current_energy: int = 3

## Status effects
var _status_effects: Dictionary = {}

## Active cards in play (persistent effects)
var _active_cards: Array[Card] = []

## Card manager reference
var card_manager: CardManager

func _init() -> void:
	current_health = max_health
	current_plays = emotional_capacity
	current_energy = max_energy

## Get current HP
func get_hp() -> int:
	return current_health

## Get max HP
func get_max_hp() -> int:
	return max_health

## Get health percentage (0.0 to 1.0)
func get_health_percent() -> float:
	if max_health <= 0:
		return 0.0
	return float(current_health) / float(max_health)

## Take damage
func take_damage(amount: int, source: Node = null) -> void:
	var damage = maxi(0, amount)
	current_health = maxi(0, current_health - damage)
	health_changed.emit(current_health, max_health)
	took_damage.emit(damage, source)
	
	if current_health <= 0:
		died.emit()

## Heal
func heal(amount: int) -> void:
	var heal_amount = maxi(0, amount)
	current_health = mini(current_health + heal_amount, max_health)
	health_changed.emit(current_health, max_health)
	healed.emit(heal_amount)

## Check if alive
func is_alive() -> bool:
	return current_health > 0

## Reset plays for new turn
func reset_turn() -> void:
	current_plays = emotional_capacity
	current_energy = max_energy

## Use a play (emotional capacity)
func use_play() -> bool:
	if current_plays > 0:
		current_plays -= 1
		return true
	return false

## Get remaining plays
func get_remaining_plays() -> int:
	return current_plays

## Use energy
func use_energy(amount: int) -> bool:
	if current_energy >= amount:
		current_energy -= amount
		return true
	return false

## Get remaining energy
func get_remaining_energy() -> int:
	return current_energy

## Add status effect
func add_status(effect_name: String, turns: int, value: int = 0) -> void:
	if not _status_effects.has(effect_name):
		_status_effects[effect_name] = {"turns": turns, "value": value}
	elif turns > 0:
		_status_effects[effect_name]["turns"] = turns

## Remove status effect
func remove_status(effect_name: String) -> void:
	_status_effects.erase(effect_name)

## Get status value
func get_status_value(effect_name: String) -> int:
	if _status_effects.has(effect_name):
		return _status_effects[effect_name].get("value", 0)
	return 0

## Check if has status
func has_status(effect_name: String) -> bool:
	return _status_effects.has(effect_name)

## Update status effects (call at end of turn)
func update_status_effects() -> void:
	var to_remove: Array[String] = []
	
	for effect in _status_effects.keys():
		var data = _status_effects[effect]
		data["turns"] -= 1
		if data["turns"] <= 0:
			to_remove.append(effect)
	
	for effect in to_remove:
		_status_effects.erase(effect)

## Add active card effect
func add_active_card(card: Card) -> void:
	_active_cards.append(card)

## Remove active card effect
func remove_active_card(card: Card) -> void:
	_active_cards.erase(card)

## Get all active cards
func get_active_cards() -> Array[Card]:
	return _active_cards.duplicate()

## Set card manager
func set_card_manager(manager: CardManager) -> void:
	card_manager = manager

## Get attack power (with modifiers)
func get_attack_power() -> int:
	return attack_power

## Get defense power (with modifiers)
func get_defense_power() -> int:
	return defense_power

## Get speed (for turn order)
func get_speed() -> int:
	return speed

## Virtual method for character-specific mechanics
func _on_turn_start() -> void:
	pass

## Virtual method for character-specific mechanics
func _on_turn_end() -> void:
	pass

func reset_combat() -> void:
	current_health = max_health
	current_plays = emotional_capacity
	current_energy = max_energy
	_status_effects.clear()
	_active_cards.clear()

func get_persistent_progression_state() -> Dictionary:
	return {
		"character_id": character_id
	}

func apply_persistent_progression_state(state: Dictionary) -> void:
	if state.is_empty():
		return

func get_run_progression_state() -> Dictionary:
	return {
		"character_id": character_id,
		"current_health": current_health,
		"current_plays": current_plays,
		"current_energy": current_energy,
		"status_effects": _status_effects.duplicate(true),
		"active_card_ids": _serialize_card_ids(_active_cards)
	}

func apply_run_progression_state(state: Dictionary) -> void:
	if state.is_empty():
		return
	current_health = int(state.get("current_health", current_health))
	current_plays = int(state.get("current_plays", current_plays))
	current_energy = int(state.get("current_energy", current_energy))
	_status_effects = state.get("status_effects", {}).duplicate(true)

func _serialize_card_ids(cards: Array) -> Array[String]:
	var ids: Array[String] = []
	for card in cards:
		if card is Card:
			ids.append(card.id)
	return ids
