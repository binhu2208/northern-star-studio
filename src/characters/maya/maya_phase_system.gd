## Maya Phase Progression System
## Handles story progression and encounter phases for Maya's emotional journey.
## Integrates with TurnSystem for combat phases.

class_name MayaPhaseSystem
extends Node

## Phase progression states
enum ProgressionPhase {
	AWAKENING,       ## Character select / Intro
	ENCOUNTER,       ## Active gameplay
	MEMORY_ORB,      ## Viewing memories
	LETTER,          ## Reading the letter
	CONFRONTATION,   ## Facing Leo's echo
	TRUTH,           ## Seeking the truth
	RESOLUTION,      ## Ending the run
	COOLDOWN         ## Between encounters
}

## Current progression state
var current_phase: ProgressionPhase = ProgressionPhase.AWAKENING
var encounter_number: int = 0
var choice_history: Array[String] = []

## References
var maya_character: Maya
var turn_system: TurnSystem

## Signals
signal phase_entered(new_phase: ProgressionPhase)
signal encounter_started(encounter_num: int)
signal choice_made(choice_id: String, result: Dictionary)
signal ending_reached(ending_type: String)

func _init() -> void:
	pass

## Initialize with Maya character reference
func initialize(maya: Maya, turn_sys: TurnSystem) -> void:
	maya_character = maya
	turn_system = turn_sys

## Start the game/awakening
func start_game() -> void:
	current_phase = ProgressionPhase.AWAKENING
	encounter_number = 0
	choice_history.clear()
	_change_phase(ProgressionPhase.ENCOUNTER)

## Start a new encounter
func start_encounter() -> void:
	encounter_number += 1
	encounter_started.emit(encounter_number)
	
	## Maya resets for each encounter
	if maya_character:
		maya_character.reset_for_new_encounter()
	
	_change_phase(ProgressionPhase.ENCOUNTER)

## Process a choice made during encounter
func process_choice(choice_id: String, choice_data: Dictionary) -> Dictionary:
	var result = {
		"cards_added": [],
		"cards_removed": [],
		"state_change": false,
		"unlocks": [],
		"narrative": ""
	}
	
	choice_history.append(choice_id)
	
	match current_phase:
		ProgressionPhase.ENCOUNTER:
			result = _process_encounter_choice(choice_id, choice_data)
		
		ProgressionPhase.MEMORY_ORB:
			result = _process_memory_choice(choice_id, choice_data)
		
		ProgressionPhase.LETTER:
			result = _process_letter_choice(choice_id, choice_data)
		
		ProgressionPhase.CONFRONTATION:
			result = _process_confrontation_choice(choice_id, choice_data)
		
		ProgressionPhase.TRUTH:
			result = _process_truth_choice(choice_id, choice_data)
	
	choice_made.emit(choice_id, result)
	return result

## Handle encounter choices
func _process_encounter_choice(choice_id: String, data: Dictionary) -> Dictionary:
	var result: Dictionary = {"cards_added": [], "cards_removed": [], "state_change": false}
	
	match choice_id:
		"curiosity_path":
			## Player chose to explore with curiosity
			result["cards_added"].append("conflicting_memory")
			result["state_change"] = true
			result["narrative"] = "You chose to look closer. Something shifts."
			if maya_character:
				maya_character.update_emotional_state(Maya.EmotionalState.CURIOSITY)
				maya_character.set_story_flag("memory_orb_1", true)
		
		"avoidance_path":
			## Player avoided the memory
			result["cards_removed"].append("grandmothers_hands")
			result["narrative"] = "You looked away. The moment passes."
			if maya_character:
				maya_character.emotional_capacity = max(1, maya_character.emotional_capacity - 1)
		
		"watch_fully":
			result["cards_added"].append("unexpected_detail")
			result["narrative"] = "You watched fully. New details emerge."
			if maya_character:
				maya_character.set_story_flag("memory_orb_1", true)
	
	_change_phase(ProgressionPhase.ENCOUNTER)
	return result

## Handle memory orb choices
func _process_memory_choice(choice_id: String, data: Dictionary) -> Dictionary:
	var result: Dictionary = {"cards_added": [], "cards_removed": [], "state_change": false}
	
	match choice_id:
		"watch_fully":
			result["narrative"] = "You see Leo was there more than you remembered."
			result["state_change"] = true
			if maya_character:
				maya_character.update_emotional_state(Maya.EmotionalState.CURIOSITY)
		
		"skip_memory":
			result["narrative"] = "You couldn't bear to watch. The resentment hardens."
			if maya_character:
				maya_character.update_emotional_state(Maya.EmotionalState.RESENTMENT)
		
		"watch_with_curiosity":
			result["cards_added"].append("conflicting_memory")
			result["narrative"] = "You see Leo crying. A crack forms in your certainties."
			result["state_change"] = true
			if maya_character:
				maya_character.update_emotional_state(Maya.EmotionalState.CURIOSITY)
	
	_change_phase(ProgressionPhase.ENCOUNTER)
	return result

## Handle letter choices
func _process_letter_choice(choice_id: String, data: Dictionary) -> Dictionary:
	var result: Dictionary = {"cards_added": [], "cards_removed": [], "state_change": true}
	
	match choice_id:
		"read_coldly":
			result["cards_added"].append("confirmed_anger")
			result["cards_removed"].append("grandmothers_hands")
			result["narrative"] = "The letter confirms what you believed. Leo wanted to sell."
			if maya_character:
				maya_character.set_story_flag("read_letter", true)
				maya_character.update_emotional_state(Maya.EmotionalState.CONFLICT)
		
		"read_with_pain":
			result["cards_added"].append("his_words_hurt")
			result["narrative"] = "The letter shows Leo felt excluded. A different picture emerges."
			result["state_change"] = true
			if maya_character:
				maya_character.set_story_flag("read_letter", true)
				maya_character.update_emotional_state(Maya.EmotionalState.CURIOSITY)
		
		"cant_read_yet":
			result["narrative"] = "Not yet. The letter waits."
			if maya_character:
				maya_character.set_story_flag("read_letter", false)
		
		"read_with_grandmother":
			result["cards_added"].append("family_love")
			result["narrative"] = "Through grandmother's eyes, you see Leo wanted your approval, not money."
			result["state_change"] = true
			result["unlocks"].append("truth_revelation")
			if maya_character:
				maya_character.set_story_flag("read_letter", true)
				maya_character.set_story_flag("knows_truth", true)
				maya_character.update_emotional_state(Maya.EmotionalState.VULNERABILITY)
	
	_change_phase(ProgressionPhase.ENCOUNTER)
	return result

## Handle confrontation choices
func _process_confrontation_choice(choice_id: String, data: Dictionary) -> Dictionary:
	var result: Dictionary = {"cards_added": [], "cards_removed": [], "state_change": true}
	var dominance = maya_character.get_emotion_dominance() if maya_character else {}
	
	match choice_id:
		"you_abandoned_us":
			result["narrative"] = "The argument escalates. Leo's echo becomes defensive."
			if maya_character:
				maya_character.confrontation_path = "argument"
				maya_character.update_emotional_state(Maya.EmotionalState.CONFLICT)
		
		"i_did_everything_alone":
			result["narrative"] = "You state your case. Leo's echo apologizes but feels distant."
			if maya_character:
				maya_character.confrontation_path = "victim"
				maya_character.update_emotional_state(Maya.EmotionalState.CONFLICT)
		
		"i_miss_him":
			result["narrative"] = "Vulnerability opens the door. Leo's echo opens up."
			result["cards_added"].append("hopeful_heart")
			if maya_character:
				maya_character.confrontation_path = "vulnerability"
				maya_character.set_story_flag("confrontation", true)
				maya_character.update_emotional_state(Maya.EmotionalState.VULNERABILITY)
		
		"grandmother_would_want":
			result["narrative"] = "Shared grief brings connection. A path forward appears."
			result["cards_added"].append("family_love")
			if maya_character:
				maya_character.confrontation_path = "legacy"
				maya_character.set_story_flag("confrontation", true)
				maya_character.update_emotional_state(Maya.EmotionalState.VULNERABILITY)
		
		"need_to_settle":
			result["narrative"] = "Direct approach. Intense but potentially productive."
			if maya_character:
				maya_character.confrontation_path = "direct"
				maya_character.set_story_flag("confrontation", true)
				maya_character.update_emotional_state(Maya.EmotionalState.CONFLICT)
		
		"anger_is_okay":
			result["narrative"] = "Honesty breeds honesty. Leo's echo mirrors your candor."
			if maya_character:
				maya_character.confrontation_path = "honest"
				maya_character.set_story_flag("confrontation", true)
				maya_character.update_emotional_state(Maya.EmotionalState.CONFLICT)
		
		"dont_know_how":
			result["narrative"] = "Uncertainty. Leo's echo admits the same."
			if maya_character:
				maya_character.confrontation_path = "uncertainty"
				maya_character.set_story_flag("confrontation", true)
				maya_character.update_emotional_state(Maya.EmotionalState.CURIOSITY)
		
		"can_we_start_over":
			result["cards_added"].append("open_question")
			result["narrative"] = "A fresh start. The most open-ended outcome."
			if maya_character:
				maya_character.confrontation_path = "reset"
				maya_character.set_story_flag("confrontation", true)
				maya_character.update_emotional_state(Maya.EmotionalState.UNDERSTANDING)
	
	_change_phase(ProgressionPhase.TRUTH)
	return result

## Handle truth revelation choices
func _process_truth_choice(choice_id: String, data: Dictionary) -> Dictionary:
	var result: Dictionary = {"cards_added": [], "cards_removed": [], "state_change": true}
	
	match choice_id:
		"seek_full_truth":
			result["narrative"] = "Both were trying to honor Grandmother. A misunderstanding destroyed everything."
			if maya_character:
				maya_character.set_story_flag("knows_truth", true)
				maya_character.update_emotional_state(Maya.EmotionalState.UNDERSTANDING)
		
		"accept_partial_truth":
			result["narrative"] = "You see what supports your current feelings."
			if maya_character:
				maya_character.update_emotional_state(maya_character.current_emotional_state)
		
		"let_it_go":
			result["cards_added"].append("acceptance")
			result["narrative"] = "Peace matters more than answers. You focus on the future."
			if maya_character:
				maya_character.update_emotional_state(Maya.EmotionalState.RESOLUTION)
	
	## Check for ending availability
	_check_for_ending()
	
	return result

## Check if player has reached an ending
func _check_for_ending() -> void:
	if not maya_character:
		return
	
	var endings = maya_character.get_available_endings()
	
	if not endings.is_empty():
		## Player can end - let them choose
		pass

## Trigger a specific ending
func trigger_ending(ending_type: String) -> void:
	var result: Dictionary = {"cards_added": [], "narrative": ""}
	
	match ending_type:
		"reconciliation":
			result["cards_added"].append("hopeful_heart")
			result["narrative"] = "Maya writes to Leo. An invitation. The door is open."
		
		"acceptance":
			result["cards_added"].append("gentle_goodbye")
			result["narrative"] = "Maya accepts what cannot be healed. She finds peace."
		
		"righteous_anger":
			result["cards_added"].append("burning_certainty")
			result["narrative"] = "Maya leaves certain of her rightness. Powerful but alone."
		
		"uncertain_path":
			result["cards_added"].append("open_question")
			result["narrative"] = "Maya leaves without answers. She's okay with not knowing yet."
	
	ending_reached.emit(ending_type)
	_change_phase(ProgressionPhase.RESOLUTION)

## Get current phase name
func get_phase_name() -> String:
	return ProgressionPhase.keys()[current_phase]

## Get progress info
func get_progress_info() -> Dictionary:
	return {
		"phase": get_phase_name(),
		"encounter": encounter_number,
		"choices": choice_history.size(),
		"available_endings": maya_character.get_available_endings() if maya_character else []
	}

## Change phase
func _change_phase(new_phase: ProgressionPhase) -> void:
	current_phase = new_phase
	phase_entered.emit(new_phase)

## Check if a choice is available based on current state
func is_choice_available(choice_id: String) -> bool:
	match choice_id:
		"read_with_grandmother":
			## Requires 2x Grandmother's Hands + 1x Gratitude
			return _has_cards(["grandmothers_hands", "grandmothers_hands", "gratitude"], 2)
		
		"watch_with_curiosity":
			## Requires Grandmother's Hands + 1 Shadow
			return _has_card("grandmothers_hands") and _has_emotion_card(Card.EmotionType.SADNESS)
		
		"seek_full_truth":
			## Requires memory orb seen + conflicting memory or family love
			return maya_character.has_seen_memory_orb_1 and \
				   (_has_card("conflicting_memory") or _has_card("family_love"))
		
		"let_it_go":
			## Requires 2x Gratitude + Acceptance
			return _has_cards(["gratitude", "gratitude", "acceptance"], 2)
	
	return true

## Helper: Check for specific cards
func _has_card(card_id: String) -> bool:
	if not maya_character:
		return false
	## Check deck, hand, and discard
	return true  ## Simplified - would check actual card lists

## Helper: Check for multiple cards
func _has_cards(card_ids: Array[String], min_count: int) -> bool:
	## Simplified check
	return _has_card(card_ids[0])

## Helper: Check for emotion type
func _has_emotion_card(emotion: Card.EmotionType) -> bool:
	if not maya_character:
		return false
	## Check emotion counts
	return true  ## Simplified

## Advance phase manually (for testing/debug)
func advance_phase() -> void:
	var next = int(current_phase) + 1
	if next < ProgressionPhase.size():
		_change_phase(next)
