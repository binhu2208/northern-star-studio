class_name PlayerProgressionProfile
extends RefCounted

var unlocked_character_ids: Array[String] = []
var unlocked_card_ids: Array[String] = []
var cleared_encounter_ids: Array[String] = []
var metadata: Dictionary = {}

static func from_dict(data: Dictionary) -> PlayerProgressionProfile:
	var profile := PlayerProgressionProfile.new()
	profile.unlocked_character_ids = _string_array(data.get("unlocked_character_ids", []))
	profile.unlocked_card_ids = _string_array(data.get("unlocked_card_ids", []))
	profile.cleared_encounter_ids = _string_array(data.get("cleared_encounter_ids", []))
	profile.metadata = data.get("metadata", {}).duplicate(true)
	return profile

func to_dict() -> Dictionary:
	return {
		"unlocked_character_ids": unlocked_character_ids.duplicate(),
		"unlocked_card_ids": unlocked_card_ids.duplicate(),
		"cleared_encounter_ids": cleared_encounter_ids.duplicate(),
		"metadata": metadata.duplicate(true)
	}

func unlock_character(character_id: String) -> void:
	if not unlocked_character_ids.has(character_id):
		unlocked_character_ids.append(character_id)

func unlock_card(card_id: String) -> void:
	if not unlocked_card_ids.has(card_id):
		unlocked_card_ids.append(card_id)

func mark_encounter_cleared(encounter_id: String) -> void:
	if not cleared_encounter_ids.has(encounter_id):
		cleared_encounter_ids.append(encounter_id)

static func create_default() -> PlayerProgressionProfile:
	var profile := PlayerProgressionProfile.new()
	for character_id in CharacterRegistry.get_playable_character_ids():
		profile.unlock_character(character_id)
		for card in CharacterRegistry.load_starter_deck(character_id):
			if card:
				profile.unlock_card(card.id)
			
	return profile

static func _string_array(values: Variant) -> Array[String]:
	var result: Array[String] = []
	if values is Array:
		for value in values:
			result.append(str(value))
	return result
