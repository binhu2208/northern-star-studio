## Maya Chen - The Estranged Sibling
## Character class for the Warmth path protagonist.
## Extends base Character with Maya-specific mechanics and starting state.

class_name Maya
extends Character

## Maya's emotional state tracking
enum EmotionalState {
	RESENTMENT,    ## Initial state - Shadow dominant
	CURIOSITY,     ## Shadow/Warmth blend - player is questioning
	CONFLICT,      ## Shadow/Fire blend - confrontation
	VULNERABILITY, ## Warmth emerging
	UNDERSTANDING, ## Warmth/Shadow blend
	RESOLUTION     ## Player-chosen endpoint
}

var current_emotional_state: EmotionalState = EmotionalState.RESENTMENT

## Story progression flags
var has_seen_memory_orb_1: bool = false
var has_read_letter: bool = false
var has_confrontation_occurred: bool = false
var knows_full_truth: bool = false
var confrontation_path: String = ""

## Resonance tracking
var resonance_bonus_active: bool = false
var last_resonance_family: Character.EmotionFamily = Character.EmotionFamily.NONE

## Signals for story integration
signal emotional_state_changed(from_state: EmotionalState, to_state: EmotionalState)
signal resonance_triggered(family: Character.EmotionFamily)
signal story_flag_changed(flag: String, value: bool)

func _init() -> void:
	character_id = "maya_chen"
	character_name = "Maya Chen"
	description = "A ceramicist who inherited her grandmother's pottery studio. Estranged from her brother Leo for five years."
	
	## Maya starts with moderate health and capacity
	max_health = 80
	emotional_capacity = 3

## Initialize Maya with her starting deck
func initialize_maya() -> void:
	initialize(_get_starting_deck())
	current_emotional_state = EmotionalState.RESENTMENT

## Get Maya's starting deck from DES-001B
func _get_starting_deck() -> Array[Card]:
	var cards: Array[Card] = []
	
	## 4x "Unfair Burden" (Resentment - basic Shadow card)
	for i in range(4):
		cards.append(_create_card("unfair_burden", "Unfair Burden", 
			"Carry the weight of what should have been shared.", 
			Card.CardType.EMOTION, Card.EmotionType.SADNESS, 2, 3))
	
	## 3x "What He Said" (Grief - replaying the argument)
	for i in range(3):
		cards.append(_create_card("what_he_said", "What He Said", 
			"The words echo in your mind, over and over.", 
			Card.CardType.EMOTION, Card.EmotionType.SADNESS, 2, 4))
	
	## 3x "Should Have Been Different" (Longing - idealized past)
	for i in range(3):
		cards.append(_create_card("should_have_been_different", "Should Have Been Different", 
			"Remembering how things used to be.", 
			Card.CardType.EMOTION, Card.EmotionType.SADNESS, 1, 3))
	
	## 2x "I Was Right" (Stubbornness - Fire/Shadow blend)
	for i in range(2):
		cards.append(_create_card("i_was_right", "I Was Right", 
			"Certainty in being wronged. A heavy comfort.", 
			Card.CardType.EMOTION, Card.EmotionType.ANGER, 2, 4))
	
	## 2x "Empty Studio" (Melancholy - loneliness)
	for i in range(2):
		cards.append(_create_card("empty_studio", "Empty Studio", 
			"The kiln sits cold. The wheel turns no more.", 
			Card.CardType.EMOTION, Card.EmotionType.SADNESS, 1, 2))
	
	## 1x "Grandmother's Hands" (Gratitude - Warmth anchor)
	cards.append(_create_card("grandmothers_hands", "Grandmother's Hands", 
		"Her hands shaped clay and lives. You carry that legacy.", 
		Card.CardType.EMOTION, Card.EmotionType.JOY, 3, 5))
	
	return cards

## Helper to create cards
func _create_card(id: String, name: String, desc: String, type: Card.CardCardType, 
				 emotion: Card.EmotionType, cost: int, value: int) -> Card:
	var card = Card.new(id, name, desc)
	card.card_type = type
	card.emotion_type = emotion
	card.cost = cost
	card.value = value
	return card

## Update emotional state based on story choices
func update_emotional_state(new_state: EmotionalState) -> void:
	if new_state != current_emotional_state:
		var old_state = current_emotional_state
		current_emotional_state = new_state
		emotional_state_changed.emit(old_state, new_state)

## Check and trigger resonance
func check_and_apply_resonance() -> Character.EmotionFamily:
	var family = check_resonance()
	
	if family != Character.EmotionFamily.NONE and family != last_resonance_family:
		resonance_bonus_active = true
		last_resonance_family = family
		resonance_triggered.emit(family)
	elif family == Character.EmotionFamily.NONE:
		resonance_bonus_active = false
		last_resonance_family = Character.EmotionFamily.NONE
	
	return family

## Get resonance bonus value
func get_resonance_bonus() -> int:
	if resonance_bonus_active:
		return 2  # +2 to card values when resonance active
	return 0

## Set story flags
func set_story_flag(flag: String, value: bool) -> void:
	match flag:
		"memory_orb_1":
			has_seen_memory_orb_1 = value
		"read_letter":
			has_read_letter = value
		"confrontation":
			has_confrontation_occurred = value
		"knows_truth":
			knows_full_truth = value
	
	story_flag_changed.emit(flag, value)

## Check available endings based on current state
func get_available_endings() -> Array[String]:
	var endings: Array[String] = []
	var dominance = get_emotion_dominance()
	
	## Ending A: Reconciliation (Warmth 50%+)
	if dominance["WARMTH"] >= 0.5 and has_confrontation_occurred and knows_full_truth:
		endings.append("reconciliation")
	
	## Ending B: Acceptance (Shadow 40%+, no Fire 30%+)
	if dominance["SHADOW"] >= 0.4 and dominance["FIRE"] < 0.3:
		endings.append("acceptance")
	
	## Ending C: Righteous Anger (Fire 50%+)
	if dominance["FIRE"] >= 0.5:
		endings.append("righteous_anger")
	
	## Ending D: Uncertain Path (Balanced, no family 40%+)
	if dominance["WARMTH"] < 0.4 and dominance["SHADOW"] < 0.4 and \
	   dominance["FIRE"] < 0.4 and dominance["STORM"] < 0.4:
		endings.append("uncertain_path")
	
	return endings

## Get state display name
func get_emotional_state_name() -> String:
	return EmotionalState.keys()[current_emotional_state]

## Reset for new encounter/reset
func reset_for_new_encounter() -> void:
	resonance_bonus_active = false
	last_resonance_family = Character.EmotionFamily.NONE
	emotional_capacity = 3  # Reset capacity

## Apply card effect based on Maya's specific mechanics
func apply_card_effect(card: Card, target: Node, damage_engine: Node) -> Dictionary:
	var result = {
		"damage_dealt": 0,
		"healing": 0,
		"shield": 0,
		"special_effect": ""
	}
	
	## Apply resonance bonus if active
	var bonus = get_resonance_bonus()
	
	match card.id:
		"unfair_burden":
			## Basic Shadow - deal emotional damage
			result["damage_dealt"] = card.value + bonus
			_change_state_toward(EmotionalState.RESENTMENT)
		
		"what_he_said":
			## Grief - heavy emotional damage
			result["damage_dealt"] = card.value + bonus + 1
			_change_state_toward(EmotionalState.CONFLICT)
		
		"should_have_been_different":
			## Longing - set up for future combos
			result["special_effect"] = "longing"
			_change_state_toward(EmotionalState.CURIOSITY)
		
		"i_was_right":
			## Stubbornness - fire damage
			result["damage_dealt"] = card.value + bonus
			_change_state_toward(EmotionalState.CONFLICT)
		
		"empty_studio":
			## Melancholy - self-damage + defense
			result["damage_dealt"] = card.value
			result["shield"] = card.value
			_change_state_toward(EmotionalState.RESENTMENT)
		
		"grandmothers_hands":
			## Gratitude - healing + warmth
			result["healing"] = card.value + bonus
			_change_state_toward(EmotionalState.VULNERABILITY)
		
		## Warmth cards (unlocked through story)
		"hopeful_heart":
			result["healing"] = card.value + bonus + 2
			_change_state_toward(EmotionalState.UNDERSTANDING)
		
		"family_love":
			result["shield"] = card.value + bonus
			result["special_effect"] = "love"
			_change_state_toward(EmotionalState.VULNERABILITY)
		
		"conflicting_memory":
			result["special_effect"] = "confusion"
			_change_state_toward(EmotionalState.CURIOSITY)
	
	## Check for resonance after playing
	check_and_apply_resonance()
	
	return result

## Shift emotional state toward a target
func _change_state_toward(target_state: EmotionalState) -> void:
	var current_idx = int(current_emotional_state)
	var target_idx = int(target_state)
	
	## Only progress, don't regress (unless it's resolution)
	if target_idx > current_idx:
		update_emotional_state(target_state)

## Override to add Maya-specific turn start behavior
func start_turn() -> void:
	super.start_turn()
	## Check for resonance at turn start
	check_and_apply_resonance()

## Get story state for debugging/display
func get_debug_state() -> Dictionary:
	return {
		"name": character_name,
		"state": get_emotional_state_name(),
		"health": "%d/%d" % [current_health, max_health],
		"emotions": get_emotion_dominance(),
		"resonance": resonance_bonus_active,
		"flags": {
			"memory_orb": has_seen_memory_orb_1,
			"read_letter": has_read_letter,
			"confrontation": has_confrontation_occurred,
			"knows_truth": knows_full_truth
		}
	}
