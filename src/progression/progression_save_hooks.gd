class_name ProgressionSaveHooks
extends RefCounted

static func capture_run_state(character: Character, card_manager: CardManager = null, encounter_state: EncounterProgressState = null) -> RunProgressionState:
	var run_state := RunProgressionState.new()
	if character:
		run_state.active_character_id = character.character_id
		run_state.character_state = character.get_run_progression_state()
		if run_state.character_state.has("story_flags"):
			run_state.story_flags = run_state.character_state.get("story_flags", {}).duplicate(true)
	if card_manager:
		run_state.deck_state = card_manager.get_progression_state()
	if encounter_state:
		run_state.current_encounter_id = encounter_state.encounter_id
		run_state.set_encounter_state(encounter_state)
	return run_state

static func apply_run_state(run_state: RunProgressionState, character: Character, card_manager: CardManager = null) -> void:
	if run_state == null:
		return
	if character:
		character.apply_run_progression_state(run_state.character_state)
	if card_manager and character:
		var available_cards = CharacterRegistry.load_cards(character.character_id)
		for card in CharacterRegistry.load_starter_deck(character.character_id):
			available_cards.append(card)
		card_manager.apply_progression_state(run_state.deck_state, available_cards)

static func capture_profile_state(profile: PlayerProgressionProfile, character: Character = null) -> Dictionary:
	var payload = {
		"profile": profile.to_dict() if profile else {},
		"characters": {}
	}
	if character:
		payload["characters"][character.character_id] = character.get_persistent_progression_state()
	return payload

static func apply_profile_state(payload: Dictionary, character: Character = null) -> PlayerProgressionProfile:
	var profile = PlayerProgressionProfile.from_dict(payload.get("profile", {}))
	if character:
		var characters = payload.get("characters", {})
		character.apply_persistent_progression_state(characters.get(character.character_id, {}))
	return profile
