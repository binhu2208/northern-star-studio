class_name EncounterDefinition
extends RefCounted

## Authorable encounter content model for Emotion Cards.
## Keeps combat metadata, enemy setup data, rewards, and objective payloads in one place.

class EnemySetup:
	extends RefCounted

	var enemy_id: String = ""
	var display_name: String = ""
	var description: String = ""
	var stats: Dictionary = {}
	var ai_profile: String = "default"
	var tags: Array[String] = []
	var deck: Array[String] = []
	var metadata: Dictionary = {}

	static func from_dict(data: Dictionary) -> EnemySetup:
		var enemy := EnemySetup.new()
		enemy.enemy_id = str(data.get("id", ""))
		enemy.display_name = str(data.get("name", enemy.enemy_id.capitalize()))
		enemy.description = str(data.get("description", ""))
		enemy.stats = data.get("stats", {}).duplicate(true)
		enemy.ai_profile = str(data.get("ai_profile", "default"))
		enemy.tags = _to_string_array(data.get("tags", []))
		enemy.deck = _to_string_array(data.get("deck", []))
		enemy.metadata = data.get("metadata", {}).duplicate(true)
		return enemy

	func to_dict() -> Dictionary:
		return {
			"id": enemy_id,
			"name": display_name,
			"description": description,
			"stats": stats.duplicate(true),
			"ai_profile": ai_profile,
			"tags": tags.duplicate(),
			"deck": deck.duplicate(),
			"metadata": metadata.duplicate(true)
		}

class RewardDefinition:
	extends RefCounted

	var reward_type: String = ""
	var reward_id: String = ""
	var amount: int = 0
	var label: String = ""
	var metadata: Dictionary = {}

	static func from_dict(data: Dictionary) -> RewardDefinition:
		var reward := RewardDefinition.new()
		reward.reward_type = str(data.get("type", ""))
		reward.reward_id = str(data.get("id", ""))
		reward.amount = int(data.get("amount", 0))
		reward.label = str(data.get("label", reward.reward_id))
		reward.metadata = data.get("metadata", {}).duplicate(true)
		return reward

	func to_dict() -> Dictionary:
		return {
			"type": reward_type,
			"id": reward_id,
			"amount": amount,
			"label": label,
			"metadata": metadata.duplicate(true)
		}

var encounter_id: String = ""
var title: String = ""
var summary: String = ""
var biome: String = ""
var difficulty: int = 1
var recommended_character_ids: Array[String] = []
var enemy_setups: Array[EnemySetup] = []
var rewards: Array[RewardDefinition] = []
var objectives: Array[Dictionary] = []
var metadata: Dictionary = {}

static func from_dict(data: Dictionary) -> EncounterDefinition:
	var encounter := EncounterDefinition.new()
	encounter.encounter_id = str(data.get("id", ""))
	encounter.title = str(data.get("title", encounter.encounter_id.capitalize()))
	encounter.summary = str(data.get("summary", ""))
	encounter.biome = str(data.get("biome", ""))
	encounter.difficulty = int(data.get("difficulty", 1))
	encounter.recommended_character_ids = _to_string_array(data.get("recommended_characters", []))
	encounter.metadata = data.get("metadata", {}).duplicate(true)

	for enemy_data in data.get("enemies", []):
		if enemy_data is Dictionary:
			encounter.enemy_setups.append(EnemySetup.from_dict(enemy_data))

	for reward_data in data.get("rewards", []):
		if reward_data is Dictionary:
			encounter.rewards.append(RewardDefinition.from_dict(reward_data))

	for objective in data.get("objectives", []):
		if objective is Dictionary:
			encounter.objectives.append(objective.duplicate(true))

	return encounter

func to_dict() -> Dictionary:
	var enemy_payload: Array[Dictionary] = []
	for enemy in enemy_setups:
		enemy_payload.append(enemy.to_dict())

	var reward_payload: Array[Dictionary] = []
	for reward in rewards:
		reward_payload.append(reward.to_dict())

	var objective_payload: Array[Dictionary] = []
	for objective in objectives:
		objective_payload.append(objective.duplicate(true))

	return {
		"id": encounter_id,
		"title": title,
		"summary": summary,
		"biome": biome,
		"difficulty": difficulty,
		"recommended_characters": recommended_character_ids.duplicate(),
		"enemies": enemy_payload,
		"rewards": reward_payload,
		"objectives": objective_payload,
		"metadata": metadata.duplicate(true)
	}

func get_enemy_count() -> int:
	return enemy_setups.size()

func get_primary_enemy() -> EnemySetup:
	return enemy_setups[0] if not enemy_setups.is_empty() else null

func create_progress_state() -> EncounterProgressState:
	var state := EncounterProgressState.new()
	state.encounter_id = encounter_id
	state.objective_progress = _build_objective_progress_template()
	state.metadata = {
		"title": title,
		"difficulty": difficulty,
		"biome": biome
	}
	return state

func _build_objective_progress_template() -> Dictionary:
	var progress := {}
	for objective in objectives:
		var objective_id = str(objective.get("id", "objective_%d" % progress.size()))
		progress[objective_id] = {
			"complete": false,
			"target": objective.get("target", 0),
			"current": 0,
			"metadata": objective.duplicate(true)
		}
	return progress

static func _to_string_array(values: Variant) -> Array[String]:
	var result: Array[String] = []
	if values is Array:
		for value in values:
			result.append(str(value))
	return result
