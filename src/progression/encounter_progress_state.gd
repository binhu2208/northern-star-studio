class_name EncounterProgressState
extends RefCounted

var encounter_id: String = ""
var attempt_count: int = 0
var cleared: bool = false
var current_stage_index: int = 0
var objective_progress: Dictionary = {}
var last_result: String = ""
var metadata: Dictionary = {}

static func from_dict(data: Dictionary) -> EncounterProgressState:
	var state := EncounterProgressState.new()
	state.encounter_id = str(data.get("encounter_id", data.get("id", "")))
	state.attempt_count = int(data.get("attempt_count", 0))
	state.cleared = bool(data.get("cleared", false))
	state.current_stage_index = int(data.get("current_stage_index", 0))
	state.objective_progress = data.get("objective_progress", {}).duplicate(true)
	state.last_result = str(data.get("last_result", ""))
	state.metadata = data.get("metadata", {}).duplicate(true)
	return state

func to_dict() -> Dictionary:
	return {
		"encounter_id": encounter_id,
		"attempt_count": attempt_count,
		"cleared": cleared,
		"current_stage_index": current_stage_index,
		"objective_progress": objective_progress.duplicate(true),
		"last_result": last_result,
		"metadata": metadata.duplicate(true)
	}

func begin_attempt() -> void:
	attempt_count += 1
	last_result = "in_progress"

func mark_cleared() -> void:
	cleared = true
	last_result = "cleared"

func mark_failed() -> void:
	last_result = "failed"
