## Wren Phase Manager
##
## Manages Wren's emotional phase progression throughout the game.
## Tracks progress through the 6 phases of grief.

class_name WrenPhaseManager
extends Node

## Reference to Wren character
var wren: WrenCharacter

## Phase thresholds (cumulative cards needed to advance)
var phase_thresholds: Array[int] = [4, 10, 15, 18, 19, 20]

## Current progress tracking
var total_cards_played: int = 0

## Signal for phase advancement
signal phase_advanced(from_phase: int, to_phase: int)
signal phase_progress_updated(progress: float)

func _init() -> void:
	pass

## Initialize with Wren reference
func initialize(p_wren: WrenCharacter) -> void:
	wren = p_wren
	total_cards_played = 0

## Check if should advance phase
func check_phase_advance() -> bool:
	if wren == null:
		return false
	
	var current_phase_idx = wren.phase_index
	
	# Already at max phase
	if current_phase_idx >= phase_thresholds.size() - 1:
		return false
	
	var cards_needed = phase_thresholds[current_phase_idx + 1]
	
	if total_cards_played >= cards_needed:
		var old_phase = current_phase_idx
		_advance_phase()
		phase_advanced.emit(old_phase, wren.phase_index)
		return true
	
	return false

## Internal phase advancement
func _advance_phase() -> void:
	if wren.phase_index < phase_thresholds.size() - 1:
		wren.phase_index += 1
		wren.current_phase = wren.phase_index

## Record card played
func record_card_played() -> void:
	total_cards_played += 1
	check_phase_advance()
	_update_progress()

## Get current progress (0.0 to 1.0)
func get_phase_progress() -> float:
	if wren == null:
		return 0.0
	
	var current_phase_idx = wren.phase_index
	
	# At max phase
	if current_phase_idx >= phase_thresholds.size() - 1:
		return 1.0
	
	var current_threshold = phase_thresholds[current_phase_idx]
	var next_threshold = phase_thresholds[current_phase_idx + 1]
	
	var progress = float(total_cards_played - current_threshold) / float(next_threshold - current_threshold)
	return clampf(progress, 0.0, 1.0)

## Internal progress update
func _update_progress() -> void:
	phase_progress_updated.emit(get_phase_progress())

## Get phase name
func get_current_phase_name() -> String:
	if wren == null:
		return "Unknown"
	return wren.get_phase_name()

## Get phase description
func get_current_phase_description() -> String:
	if wren == null:
		return ""
	return wren.get_phase_description()

## Get cards needed for next phase
func get_cards_for_next_phase() -> int:
	if wren == null:
		return 0
	
	var current_phase_idx = wren.phase_index
	
	if current_phase_idx >= phase_thresholds.size() - 1:
		return 0  # At max phase
	
	var next_threshold = phase_thresholds[current_phase_idx + 1]
	return next_threshold - total_cards_played

## Reset progress (new game)
func reset() -> void:
	total_cards_played = 0
	if wren:
		wren.phase_index = 0
		wren.current_phase = WrenCharacter.Phase.DENIAL

## Get all phase info for UI
func get_phase_info() -> Dictionary:
	return {
		"current_phase": get_current_phase_name(),
		"phase_description": get_current_phase_description(),
		"progress": get_phase_progress(),
		"cards_played": total_cards_played,
		"cards_for_next": get_cards_for_next_phase(),
		"max_phase": phase_thresholds.size() - 1,
		"current_phase_index": wren.phase_index if wren else 0
	}

## Get bonus for current phase (for card effects)
func get_phase_bonus() -> Dictionary:
	if wren == null:
		return {"defense": 0, "attack": 0, "memory": 0}
	
	match wren.current_phase:
		WrenCharacter.Phase.DENIAL:
			return {"defense": 0, "attack": 0, "memory": 0}
		WrenCharacter.Phase.WEIGHT:
			return {"defense": 2, "attack": 0, "memory": 0}
		WrenCharacter.Phase.HAUNTING:
			return {"defense": 0, "attack": 2, "memory": 1}
		WrenCharacter.Phase.BARGAINING:
			return {"defense": 0, "attack": 3, "memory": 1}
		WrenCharacter.Phase.SHADOWS:
			return {"defense": 3, "attack": 0, "memory": 2}
		WrenCharacter.Phase.WREN:
			return {"defense": 2, "attack": 4, "memory": 3}
		_:
			return {"defense": 0, "attack": 0, "memory": 0}

## Check if specific phase is unlocked
func is_phase_unlocked(phase: int) -> bool:
	if wren == null:
		return false
	return wren.phase_index >= phase
