class_name RunProgressionState
extends RefCounted

var run_id: String = ""
var active_character_id: String = ""
var current_encounter_id: String = ""
var current_encounter_index: int = 0
var encounter_order: Array[String] = []
var unlocked_run_card_ids: Array[String] = []
var character_state: Dictionary = {}
var deck_state: Dictionary = {}
var encounter_states: Dictionary = {}
var story_flags: Dictionary = {}
var metadata: Dictionary = {}

static func from_dict(data: Dictionary) -> RunProgressionState:
	var state := RunProgressionState.new()
	state.run_id = str(data.get("run_id", ""))
	state.active_character_id = str(data.get("active_character_id", ""))
	state.current_encounter_id = str(data.get("current_encounter_id", ""))
	state.current_encounter_index = int(data.get("current_encounter_index", 0))
	state.encounter_order = _string_array(data.get("encounter_order", []))
	state.unlocked_run_card_ids = _string_array(data.get("unlocked_run_card_ids", []))
	state.character_state = data.get("character_state", {}).duplicate(true)
	state.deck_state = data.get("deck_state", {}).duplicate(true)
	state.encounter_states = data.get("encounter_states", {}).duplicate(true)
	state.story_flags = data.get("story_flags", {}).duplicate(true)
	state.metadata = data.get("metadata", {}).duplicate(true)
	return state

func to_dict() -> Dictionary:
	return {
		"run_id": run_id,
		"active_character_id": active_character_id,
		"current_encounter_id": current_encounter_id,
		"current_encounter_index": current_encounter_index,
		"encounter_order": encounter_order.duplicate(),
		"unlocked_run_card_ids": unlocked_run_card_ids.duplicate(),
		"character_state": character_state.duplicate(true),
		"deck_state": deck_state.duplicate(true),
		"encounter_states": encounter_states.duplicate(true),
		"story_flags": story_flags.duplicate(true),
		"metadata": metadata.duplicate(true)
	}

func set_encounter_state(encounter_state: EncounterProgressState) -> void:
	if encounter_state == null or encounter_state.encounter_id.is_empty():
		return
	encounter_states[encounter_state.encounter_id] = encounter_state.to_dict()

func get_encounter_state(encounter_id: String) -> EncounterProgressState:
	if not encounter_states.has(encounter_id):
		return null
	return EncounterProgressState.from_dict(encounter_states.get(encounter_id, {}))

func unlock_run_card(card_id: String) -> void:
	if not unlocked_run_card_ids.has(card_id):
		unlocked_run_card_ids.append(card_id)

static func _string_array(values: Variant) -> Array[String]:
	var result: Array[String] = []
	if values is Array:
		for value in values:
			result.append(str(value))
	return result
