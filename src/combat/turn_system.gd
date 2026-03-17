## Turn System and Phase Transitions
## 
## Implements the turn-based combat flow for Emotion Cards

class_name TurnSystem
extends Node

## Signals
signal turn_started(is_player_turn: bool)
signal turn_ended(is_player_turn: bool)
signal phase_changed(from_phase: int, to_phase: int)
signal round_started(round_num: int)
signal round_ended(round_num: int)

## Turn phases
enum Phase {
	START,
	PLAYER_DRAW,
	PLAYER_MAIN,
	PLAYER_END,
	ENEMY_START,
	ENEMY_ACTION,
	ENEMY_END,
	COMBAT_RESOLUTION,
	END
}

## Turn state
var current_turn: bool = true  ## true = player, false = enemy
var current_phase: Phase = Phase.START
var current_round: int = 1
var turn_count: int = 0

## Turn limits
var max_turns_per_round: int = 10
var time_limit_seconds: int = 60

func _ready() -> void:
	_start_game()

## Start the game
func _start_game() -> void:
	current_round = 1
	current_turn = true
	current_phase = Phase.START
	turn_count = 0
	_change_phase(Phase.PLAYER_DRAW)

## Start a new round
func start_round() -> void:
	current_round += 1
	round_started.emit(current_round)
	current_phase = Phase.START
	_change_phase(Phase.PLAYER_DRAW)

## End current turn
func end_turn() -> void:
	turn_ended.emit(current_turn)
	turn_count += 1
	
	if current_turn:
		## Player turn ending, switch to enemy
		current_turn = false
		_change_phase(Phase.ENEMY_START)
	else:
		## Enemy turn ending, check for round end
		if turn_count >= max_turns_per_round:
			_change_phase(Phase.COMBAT_RESOLUTION)
		else:
			current_round += 1
			current_turn = true
			_change_phase(Phase.PLAYER_DRAW)
			round_started.emit(current_round)

## Start player turn
func start_player_turn() -> void:
	current_turn = true
	turn_started.emit(true)
	_change_phase(Phase.PLAYER_DRAW)

## Start enemy turn  
func start_enemy_turn() -> void:
	current_turn = false
	turn_started.emit(false)
	_change_phase(Phase.ENEMY_ACTION)

## Phase transitions
func _change_phase(new_phase: Phase) -> void:
	var old_phase = current_phase
	current_phase = new_phase
	phase_changed.emit(old_phase, new_phase)
	_process_phase()

## Process current phase
func _process_phase() -> void:
	match current_phase:
		Phase.PLAYER_DRAW:
			## Player draws cards - handled by CardManager
			_change_phase(Phase.PLAYER_MAIN)
		Phase.PLAYER_MAIN:
			## Waiting for player input - handled by UI
			pass
		Phase.PLAYER_END:
			## Player ends their turn
			end_turn()
		Phase.ENEMY_START:
			start_enemy_turn()
		Phase.ENEMY_ACTION:
			## Enemy AI makes decisions - handled by EnemyAI
			pass
		Phase.ENEMY_END:
			end_turn()
		Phase.COMBAT_RESOLUTION:
			## Check win/lose conditions
			_change_phase(Phase.END)
		Phase.END:
			round_ended.emit(current_round)

## Get current turn info
func get_turn_info() -> Dictionary:
	return {
		"is_player_turn": current_turn,
		"phase": Phase.keys()[current_phase],
		"round": current_round,
		"turn_count": turn_count
	}

## Check if it's player's turn
func is_player_turn() -> bool:
	return current_turn

## Get current phase name
func get_phase_name() -> String:
	return Phase.keys()[current_phase]
