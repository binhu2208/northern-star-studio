## Maya Character Class (Warmth)
##
## Maya Chen represents Warmth & Love from the Warmth emotion family.
## Her arc progresses through emotional states from Resentment to Resolution.
##
## Special Mechanics:
## - Resonance: Playing 3+ cards from same family triggers bonus effects
## - Emotional State: Progresses through Resentment → Curiosity → Conflict → Vulnerability → Understanding → Resolution
## - Story Flags: Tracks memory orbs, letter reading, confrontation, and truth discovery

class_name MayaCharacter
extends Character

## Character constants
const CHARACTER_ID := "maya"
const CHARACTER_NAME := "Maya Chen"

## Emotional State enumeration - Maya's journey stages
enum EmotionalState {
	RESENTMENT,    ## Initial state - Shadow dominant
	CURIOSITY,     ## Shadow/Warmth blend - player is questioning
	CONFLICT,      ## Shadow/Fire blend - confrontation
	VULNERABILITY, ## Warmth emerging
	UNDERSTANDING, ## Warmth/Shadow blend
	RESOLUTION     ## Player-chosen endpoint
}

## Warmth-specific damage/effect types
enum WarmthEffect {
	NONE,
	HEAL_OVER_TIME,    ## Healing applied over turns
	SHIELD_GRANT,      ## Grant shield to self or ally
	EMOTIONAL_BOOST,  ## Boost next card value
	CLEAR_NEGATIVE,   ## Remove negative status
	RESONANCE_BONUS   ## Bonus from emotion resonance
}

## Current emotional state
var current_emotional_state: EmotionalState = EmotionalState.RESENTMENT
var emotional_state_index: int = 0

## Resonance tracking - when 3+ cards from same family are played
var resonance_bonus_active: bool = false
var last_resonance_family: int = 0  ## Using Character.EmotionFamily values

## Story progression flags
var has_seen_memory_orb_1: bool = false
var has_read_letter: bool = false
var has_confrontation_occurred: bool = false
var knows_full_truth: bool = false
var confrontation_path: String = ""

## Card tracking for resonance calculations
var cards_played_this_turn: int = 0

## Starting deck cache
var _starting_deck_cache: Array[Card] = []

func _init() -> void:
	## Set character identity
	character_id = CHARACTER_ID
	character_name = CHARACTER_NAME
	description = "A ceramicist who inherited her grandmother's pottery studio. Estranged from her brother Leo for five years."
	
	## Maya starts with moderate health and capacity
	max_health = 80
	emotional_capacity = 3
	max_energy = 3

## Initialize Maya with her starting deck (called by game manager)
func setup() -> void:
	current_health = max_health
	current_emotional_state = EmotionalState.RESENTMENT
	_reset_story_flags()
	
	## Build starting deck
	_build_starting_deck()

## Reset story flags for new run
func _reset_story_flags() -> void:
	has_seen_memory_orb_1 = false
	has_read_letter = false
	has_confrontation_occurred = false
	knows_full_truth = false
	confrontation_path = ""
	resonance_bonus_active = false

## Build Maya's starting deck from DES-001B
func _build_starting_deck() -> void:
	var cards = MayaCards.get_starting_deck()
	for card in cards:
		card_manager.draw_pile.add_card(card) if card_manager else add_to_deck(card)
	
	## Shuffle the deck
	shuffle_deck()

## Add card to deck (if no card_manager)
func add_to_deck(card: Card) -> void:
	## Would be handled by deck system
	pass

## Shuffle the deck
func shuffle_deck() -> void:
	## Would use deck.shuffle()
	pass

## Override: Called at turn start
override func _on_turn_start() -> void:
	super._on_turn_start()
	cards_played_this_turn = 0
	_check_resonance()

## Update emotional state based on story choices
func update_emotional_state(new_state: EmotionalState) -> void:
	if new_state != current_emotional_state:
		var old_state = current_emotional_state
		current_emotional_state = new_state
		emotional_state_index = new_state
		emotional_state_changed.emit(old_state, new_state)

## Check for resonance (3+ cards from same family)
func _check_resonance() -> bool:
	## Simplified: check hand and active cards
	var emotion_counts = _count_emotions_in_hand()
	
	for family in emotion_counts.keys():
		if emotion_counts[family] >= 3:
			resonance_bonus_active = true
			last_resonance_family = family
			resonance_triggered.emit(family)
			return true
	
	resonance_bonus_active = false
	return false

## Count emotions in hand
func _count_emotions_in_hand() -> Dictionary:
	var counts = {
		Character.EmotionFamily.WARMTH: 0,
		Character.EmotionFamily.SHADOW: 0,
		Character.EmotionFamily.FIRE: 0,
		Character.EmotionFamily.STORM: 0
	}
	
	## Would iterate through hand cards
	return counts

## Get current resonance bonus value
func get_resonance_bonus() -> int:
	if resonance_bonus_active:
		return 2
	return 0

## Track card played for resonance
func on_card_played(card: Card) -> void:
	cards_played_this_turn += 1
	
	## Update emotion tracking
	if card:
		_track_emotion_from_card(card)

## Track emotion family from card
func _track_emotion_from_card(card: Card) -> void:
	## Add status or track for resonance
	pass

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

## Get available endings based on current state
func get_available_endings() -> Array[String]:
	var endings: Array[String] = []
	var dominance = _get_emotion_dominance()
	
	## Ending A: Reconciliation (Warmth 50%+)
	if dominance.get("WARMTH", 0.0) >= 0.5 and has_confrontation_occurred and knows_full_truth:
		endings.append("reconciliation")
	
	## Ending B: Acceptance (Shadow 40%+, no Fire 30%+)
	if dominance.get("SHADOW", 0.0) >= 0.4 and dominance.get("FIRE", 0.0) < 0.3:
		endings.append("acceptance")
	
	## Ending C: Righteous Anger (Fire 50%+)
	if dominance.get("FIRE", 0.0) >= 0.5:
		endings.append("righteous_anger")
	
	## Ending D: Uncertain Path (Balanced)
	var max_dominance = 0.0
	for family in dominance.values():
		max_dominance = max(max_dominance, family)
	
	if max_dominance < 0.4:
		endings.append("uncertain_path")
	
	return endings

## Get emotion dominance percentages
func _get_emotion_dominance() -> Dictionary:
	## Simplified - would track actual card counts
	return {
		"WARMTH": 0.0,
		"SHADOW": 0.0,
		"FIRE": 0.0,
		"STORM": 0.0
	}

## Get emotional state name
func get_emotional_state_name() -> String:
	return EmotionalState.keys()[current_emotional_state]

## Get debug state info
func get_debug_state() -> Dictionary:
	return {
		"name": character_name,
		"state": get_emotional_state_name(),
		"health": "%d/%d" % [current_health, max_health],
		"resonance": resonance_bonus_active,
		"flags": {
			"memory_orb": has_seen_memory_orb_1,
			"read_letter": has_read_letter,
			"confrontation": has_confrontation_occurred,
			"knows_truth": knows_full_truth
		}
	}

## Signals
signal emotional_state_changed(from_state: EmotionalState, to_state: EmotionalState)
signal resonance_triggered(family: int)
signal story_flag_changed(flag: String, value: bool)
