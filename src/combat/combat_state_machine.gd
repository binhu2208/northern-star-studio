class_name CombatStateMachine
extends Node

## Manages combat state flow including turns and win/lose conditions.

signal state_changed(old_state: CombatState, new_state: CombatState)
signal player_turn_started
signal player_turn_ended
signal enemy_turn_started
signal enemy_turn_ended
signal combat_victory
signal combat_defeat
signal combat_draw

enum CombatState {
	PLAYER_TURN,
	ENEMY_TURN,
	VICTORY,
	DEFEAT,
	DRAW
}

@export var player_entity: Node
@export var enemy_entity: Node

var current_state: CombatState = CombatState.PLAYER_TURN
var turn_count: int = 0

func _ready() -> void:
	_set_state(CombatState.PLAYER_TURN)

func _set_state(new_state: CombatState) -> void:
	var old_state = current_state
	current_state = new_state
	state_changed.emit(old_state, new_state)
	
	match new_state:
		CombatState.PLAYER_TURN:
			player_turn_started.emit()
		CombatState.ENEMY_TURN:
			enemy_turn_started.emit()
		CombatState.VICTORY:
			combat_victory.emit()
		CombatState.DEFEAT:
			combat_defeat.emit()
		CombatState.DRAW:
			combat_draw.emit()

func start_player_turn() -> void:
	if current_state == CombatState.PLAYER_TURN:
		return
	_set_state(CombatState.PLAYER_TURN)
	turn_count += 1

func end_player_turn() -> void:
	if current_state != CombatState.PLAYER_TURN:
		return
	player_turn_ended.emit()
	_check_win_conditions()
	if _is_combat_ended():
		return
	_set_state(CombatState.ENEMY_TURN)

func start_enemy_turn() -> void:
	if current_state == CombatState.ENEMY_TURN:
		return
	_set_state(CombatState.ENEMY_TURN)

func end_enemy_turn() -> void:
	if current_state != CombatState.ENEMY_TURN:
		return
	enemy_turn_ended.emit()
	_check_win_conditions()
	if _is_combat_ended():
		return
	_set_state(CombatState.PLAYER_TURN)

func _check_win_conditions() -> void:
	if not _entities_valid():
		return
	
	var player_hp = _get_hp(player_entity)
	var enemy_hp = _get_hp(enemy_entity)
	
	if enemy_hp <= 0 and player_hp <= 0:
		_set_state(CombatState.DRAW)
	elif enemy_hp <= 0:
		_set_state(CombatState.VICTORY)
	elif player_hp <= 0:
		_set_state(CombatState.DEFEAT)

func check_victory() -> bool:
	return current_state == CombatState.VICTORY

func check_defeat() -> bool:
	return current_state == CombatState.DEFEAT

func check_draw() -> bool:
	return current_state == CombatState.DRAW

func is_combat_ended() -> bool:
	return _is_combat_ended()

func is_player_turn() -> bool:
	return current_state == CombatState.PLAYER_TURN

func is_enemy_turn() -> bool:
	return current_state == CombatState.ENEMY_TURN

func _is_combat_ended() -> bool:
	return current_state == CombatState.VICTORY \
		or current_state == CombatState.DEFEAT \
		or current_state == CombatState.DRAW

func _entities_valid() -> bool:
	return is_instance_valid(player_entity) and is_instance_valid(enemy_entity)

func _get_hp(entity: Node) -> int:
	if entity.has_method("get_hp"):
		return entity.get_hp()
	return 0

func force_victory() -> void:
	_set_state(CombatState.VICTORY)

func force_defeat() -> void:
	_set_state(CombatState.DEFEAT)

func force_draw() -> void:
	_set_state(CombatState.DRAW)

func reset_combat() -> void:
	current_state = CombatState.PLAYER_TURN
	turn_count = 0
	_set_state(CombatState.PLAYER_TURN)
