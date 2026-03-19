## Maya Card Effects Integration
## Handles how Maya's emotion cards interact with the combat damage engine.
## Connects card effects to the DamageEngine for combat resolution.

class_name MayaCardEffects
extends Node

## Reference to damage engine
var damage_engine: DamageEngine
## Reference to Maya character
var maya: MayaCharacter
## Reference to turn system
var turn_system: TurnSystem

## Lightweight post-launch hotfix scaffolding.
## card_overrides format example:
## {
##   "burning_resentment": {"damage_delta": 1},
##   "open_question": {"disabled": true}
## }
@export var feature_toggles: Dictionary = {}
@export var card_overrides: Dictionary = {}

## Card effect signals
signal card_effect_triggered(card_id: String, effect_type: String)
signal resonance_active(family: int)
signal emotional_shift_occurred(from_state: int, to_state: int)

func _init() -> void:
	pass

## Initialize with required references
func initialize(maya_ref: MayaCharacter, damage: DamageEngine, turn_sys: TurnSystem) -> void:
	maya = maya_ref
	damage_engine = damage
	turn_system = turn_sys

func apply_config(config: GameConfig) -> void:
	feature_toggles = config.feature_toggles.duplicate(true)
	card_overrides = config.card_overrides.duplicate(true)

func is_card_enabled(card_id: String) -> bool:
	var override_value = card_overrides.get(card_id, {})
	return not bool(override_value.get("disabled", false))

func get_card_override(card_id: String) -> Dictionary:
	var override_value = card_overrides.get(card_id, {})
	if override_value is Dictionary:
		return override_value
	return {}

func apply_effect_scalar(card_id: String, base_value: int, field_name: String) -> int:
	var override_value = get_card_override(card_id)
	var delta_key = "%s_delta" % field_name
	var scalar_key = "%s_scalar" % field_name
	var adjusted = base_value + int(override_value.get(delta_key, 0))
	adjusted = int(round(float(adjusted) * float(override_value.get(scalar_key, 1.0))))
	return maxi(0, adjusted)

## Execute a card effect and return results
## [code]card[/code] - The card being played
## [code]target[/code] - Target node (can be enemy or self)
## [code]source[/code] - Source character (Maya)
func execute_card_effect(card: Card, target: Node, source: Node = null) -> Dictionary:
	if source == null:
		source = maya
	
	var result = {
		"cancelled": false,
		"damage_dealt": 0,
		"healing": 0,
		"shield": 0,
		"energy_change": 0,
		"cards_drawn": 0,
		"cards_discarded": 0,
		"special_effects": [],
		"narrative_text": ""
	}
	
	if card == null or not is_card_enabled(card.id):
		result["cancelled"] = true
		result["special_effects"].append("card_disabled")
		return result
	
	## Get resonance bonus
	var resonance_bonus = 0
	if maya:
		resonance_bonus = maya.get_resonance_bonus()
	
	## Process based on card emotion type
	match card.emotion_type:
		Card.EmotionType.SADNESS:
			result = _process_shadow_card(card, target, source, resonance_bonus, result)
		
		Card.EmotionType.ANGER:
			result = _process_fire_card(card, target, source, resonance_bonus, result)
		
		Card.EmotionType.JOY, Card.EmotionType.LOVE:
			result = _process_warmth_card(card, target, source, resonance_bonus, result)
		
		Card.EmotionType.FEAR:
			result = _process_storm_card(card, target, source, resonance_bonus, result)
		
		Card.EmotionType.CONFUSION:
			result = _process_complex_card(card, target, source, resonance_bonus, result)
	
	## Apply resonance check after playing
	if maya:
		maya.check_and_apply_resonance()
		if maya.resonance_bonus_active:
			resonance_active.emit(maya.last_resonance_family)
	
	card_effect_triggered.emit(card.id, "effect_executed")
	return result

## Process Shadow (Sadness) cards
func _process_shadow_card(card: Card, target: Node, source: Node, 
						  bonus: int, result: Dictionary) -> Dictionary:
	var damage = apply_effect_scalar(card.id, card.value + bonus, "damage")
	
	match card.id:
		"unfair_burden":
			## Basic shadow damage
			_deal_emotional_damage(damage, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = damage
			result["narrative_text"] = "The weight settles on you both."
		
		"what_he_said":
			## Heavy grief damage
			_deal_emotional_damage(damage + 1, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = damage + 1
			result["narrative_text"] = "The words cut deeper each time."
		
		"should_have_been_different":
			## Setup - draw card
			result["cards_drawn"] = 1
			result["special_effects"].append("longing_setup")
			result["narrative_text"] = "Memories of better days."
		
		"empty_studio":
			## Self-damage + shield (melancholy)
			_deal_emotional_damage(1, DamageEngine.DamageType.EMOTIONAL, source, source)
			var shield = _create_shield(source, card.value)
			result["shield"] = shield.max_shield
			result["damage_dealt"] = 1
			result["narrative_text"] = "The emptiness echoes."
		
		"bitter_memory":
			## Conditional bonus damage
			var extra = 0
			if maya and maya.get_emotion_counts()[Character.EmotionFamily.SHADOW] >= 3:
				extra = 2
			_deal_emotional_damage(damage + extra, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = damage + extra
			result["special_effects"].append("shadow_resonance")
			result["narrative_text"] = "A sharp flash of memory."
		
		"lost_connection":
			## Damage + draw
			_deal_emotional_damage(damage, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = damage
			result["cards_drawn"] = 1
			result["narrative_text"] = "The silence between calls."
		
		"gentle_goodbye":
			## Acceptance ending card
			result["healing"] = card.value + bonus
			result["shield"] = 3
			result["special_effects"].append("removes_card")
			result["narrative_text"] = "Making peace with what cannot be."
		
		_:
			_deal_emotional_damage(damage, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = damage
	
	return result

## Process Fire (Anger) cards
func _process_fire_card(card: Card, target: Node, source: Node, 
						bonus: int, result: Dictionary) -> Dictionary:
	var damage = apply_effect_scalar(card.id, card.value + bonus, "damage")
	
	match card.id:
		"i_was_right":
			## Stubborn fire damage
			_deal_emotional_damage(damage, DamageEngine.DamageType.FIRE, source, target)
			result["damage_dealt"] = damage
			result["narrative_text"] = "The certainty burns."
		
		"burning_resentment":
			## Damage + energy
			_deal_emotional_damage(damage - 1, DamageEngine.DamageType.FIRE, source, target)
			result["damage_dealt"] = damage - 1
			result["energy_change"] = 1
			result["narrative_text"] = "The anger that keeps you warm."
		
		"burst_of_frustration":
			## Heavy damage + discard
			_deal_emotional_damage(damage, DamageEngine.DamageType.FIRE, source, target)
			result["damage_dealt"] = damage
			result["cards_discarded"] = 1
			result["narrative_text"] = "When it all becomes too much."
		
		"righteous_fire":
			## Conditional bonus based on health
			var extra = 0
			if maya and maya.get_health_percentage() < 0.5:
				extra = 2
			_deal_emotional_damage(damage + extra, DamageEngine.DamageType.FIRE, source, target)
			result["damage_dealt"] = damage + extra
			result["special_effects"].append("low_health_bonus")
			result["narrative_text"] = "Righteous fury."
		
		"burning_certainty":
			## Powerful + healing reduction
			_deal_emotional_damage(damage, DamageEngine.DamageType.FIRE, source, target)
			result["damage_dealt"] = damage
			result["special_effects"].append("healing_reduction")
			result["narrative_text"] = "Nothing will change what you know."
		
		_:
			_deal_emotional_damage(damage, DamageEngine.DamageType.FIRE, source, target)
			result["damage_dealt"] = damage
	
	return result

## Process Warmth (Joy/Love) cards
func _process_warmth_card(card: Card, target: Node, source: Node, 
						  bonus: int, result: Dictionary) -> Dictionary:
	match card.id:
		"grandmothers_hands":
			## Basic healing
			result["healing"] = apply_effect_scalar(card.id, card.value + bonus, "healing")
			result["narrative_text"] = "Her legacy guides you."
		
		"twinge_of_hope":
			## Heal + draw
			result["healing"] = apply_effect_scalar(card.id, card.value + bonus - 2, "healing")
			result["cards_drawn"] = apply_effect_scalar(card.id, 1, "draw")
			result["narrative_text"] = "Maybe things could be different."
		
		"gratitude":
			## Heal + boost
			result["healing"] = apply_effect_scalar(card.id, card.value + bonus, "healing")
			result["special_effects"].append("value_boost")
			result["narrative_text"] = "For what was. For what remains."
		
		"warm_embrace":
			## Shield + heal
			result["healing"] = apply_effect_scalar(card.id, 2, "healing")
			result["shield"] = apply_effect_scalar(card.id, card.value + bonus, "shield")
			result["narrative_text"] = "The comfort of being understood."
		
		"family_love":
			## Shield + cost reduction
			result["shield"] = apply_effect_scalar(card.id, card.value + bonus, "shield")
			result["special_effects"].append("cost_reduction")
			result["narrative_text"] = "Blood is thicker than water."
		
		"hopeful_heart":
			## Big heal + draw
			result["healing"] = apply_effect_scalar(card.id, card.value + bonus, "healing")
			result["cards_drawn"] = apply_effect_scalar(card.id, 2, "draw")
			result["special_effects"].append("ending_preparation")
			result["narrative_text"] = "The door is open."
		
		_:
			result["healing"] = apply_effect_scalar(card.id, card.value + bonus, "healing")
	
	## Apply healing
	if result["healing"] > 0 and maya:
		maya.heal(result["healing"])
	
	## Apply shield
	if result["shield"] > 0:
		_create_shield(maya if target == null else target, result["shield"])
	
	return result

## Process Storm (Fear) cards
func _process_storm_card(card: Card, target: Node, source: Node, 
						bonus: int, result: Dictionary) -> Dictionary:
	var damage = apply_effect_scalar(card.id, card.value + bonus, "damage")
	
	match card.id:
		"uncertain_future":
			## Damage + draw
			_deal_emotional_damage(damage - 1, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = damage - 1
			result["cards_drawn"] = 1
			result["narrative_text"] = "What if...?"
		
		"anxiety":
			## Damage + heal limit
			_deal_emotional_damage(damage, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = damage
			result["special_effects"].append("heal_limit")
			result["narrative_text"] = "The racing thoughts won't stop."
		
		"doubt":
			## Conditional draw
			var cards_to_draw = 1
			if maya and maya.card_manager and maya.card_manager.hand and maya.card_manager.hand.get_hand_size() >= 3:
				cards_to_draw = 2
			_deal_emotional_damage(damage, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = damage
			result["cards_drawn"] = cards_to_draw
			result["narrative_text"] = "Questions without answers."
		
		"overwhelmed":
			## Self-damage + heavy damage
			_deal_emotional_damage(4, DamageEngine.DamageType.EMOTIONAL, source, source)
			_deal_emotional_damage(6, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = 6
			result["special_effects"].append("self_damage")
			result["narrative_text"] = "Too much. All at once."
		
		"open_question":
			## Wild card - no effect now, handled by game logic
			result["special_effects"].append("wild_card")
			result["narrative_text"] = "An open door."
		
		_:
			_deal_emotional_damage(damage, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = damage
	
	return result

## Process Complex/Confusion cards
func _process_complex_card(card: Card, target: Node, source: Node, 
						   bonus: int, result: Dictionary) -> Dictionary:
	match card.id:
		"conflicting_memory":
			## Enables complex emotions
			result["special_effects"].append("unlock_complex")
			result["narrative_text"] = "Wait... did it happen differently?"
		
		"unexpected_detail":
			## Draw + reveal
			result["cards_drawn"] = 2
			result["special_effects"].append("reveal_truth")
			result["narrative_text"] = "Something new emerges."
		
		"bittersweet_memory":
			## Complex: Joy + Sadness
			result["healing"] = 3
			_deal_emotional_damage(2, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = 2
			result["narrative_text"] = "Joy and sadness, together."
		
		"understanding":
			## Complex: Anger + Sadness
			_deal_emotional_damage(4, DamageEngine.DamageType.EMOTIONAL, source, target)
			result["damage_dealt"] = 4
			result["cards_drawn"] = 2
			result["narrative_text"] = "When anger meets time."
		
		"acceptance":
			## Complex: Joy + Anger
			result["healing"] = card.value + bonus
			result["special_effects"].append("max_hp_boost")
			result["narrative_text"] = "Peace from letting go."
		
		_:
			pass
	
	return result

## ============================================================
## HELPER METHODS
## ============================================================

## Deal emotional damage through the damage engine
func _deal_emotional_damage(amount: int, damage_type: int, source: Node, target: Node) -> void:
	if damage_engine and is_instance_valid(target):
		var result = damage_engine.deal_damage(amount, target, source, damage_type)

## Create a shield on a target
func _create_shield(target: Node, amount: int) -> DamageEngine.Shield:
	if damage_engine and is_instance_valid(target):
		return damage_engine.create_shield(target, amount)
	return null

## Check if a combo is active (for complex cards)
func has_combo(emotion1: Card.EmotionType, emotion2: Card.EmotionType) -> bool:
	if not maya:
		return false
	
	var counts = maya.get_emotion_counts()
	
	## Simplified check - would need full implementation
	match emotion1:
		Card.EmotionType.JOY:
			return counts[Character.EmotionFamily.WARMTH] > 0
		Card.EmotionType.SADNESS:
			return counts[Character.EmotionFamily.SHADOW] > 0
		Card.EmotionType.ANGER:
			return counts[Character.EmotionFamily.FIRE] > 0
		Card.EmotionType.FEAR:
			return counts[Character.EmotionFamily.STORM] > 0
	
	return false

## Get current combat state info
func get_combat_state() -> Dictionary:
	if not maya:
		return {}
	
	return {
		"maya_health": maya.current_health,
		"maya_max_health": maya.max_health,
		"emotions": maya.get_emotion_dominance(),
		"resonance_active": maya.resonance_bonus_active,
		"resonance_family": Character.EmotionFamily.keys()[maya.last_resonance_family] if maya.last_resonance_family != Character.EmotionFamily.NONE else "none",
		"emotional_state": maya.get_emotional_state_name()
	}
