class_name CombatGameplayLoop
extends Node

signal combat_started(player: Character, enemy: Character)
signal turn_started(owner: Character, is_player: bool, round: int)
signal card_resolved(owner: Character, card: Card, result: Dictionary)
signal turn_finished(owner: Character, is_player: bool, round: int)
signal combat_finished(outcome: String, winner: Node, loser: Node)

@export var opening_hand_size: int = 5
@export var cards_per_turn: int = 1

var player_manager: CardManager
var enemy_manager: CardManager
var damage_engine: DamageEngine
var combat_state_machine: CombatStateMachine
var turn_system: TurnSystem
var win_conditions: WinConditions

var player_character: Character
var enemy_character: Character
var enemy_ai: EnemyAI
var player_effect_handler: Node
var enemy_effect_handler: Node

func _ready() -> void:
	_ensure_systems()

func _ensure_systems() -> void:
	if damage_engine == null:
		damage_engine = DamageEngine.new()
		add_child(damage_engine)
	if combat_state_machine == null:
		combat_state_machine = CombatStateMachine.new()
		add_child(combat_state_machine)
	if turn_system == null:
		turn_system = TurnSystem.new()
		add_child(turn_system)
	if win_conditions == null:
		win_conditions = WinConditions.new()
		add_child(win_conditions)
	if player_manager == null:
		player_manager = CardManager.new()
		add_child(player_manager)
	if enemy_manager == null:
		enemy_manager = CardManager.new()
		add_child(enemy_manager)
	if not combat_state_machine.combat_victory.is_connected(_on_combat_victory):
		combat_state_machine.combat_victory.connect(_on_combat_victory)
	if not combat_state_machine.combat_defeat.is_connected(_on_combat_defeat):
		combat_state_machine.combat_defeat.connect(_on_combat_defeat)
	if not combat_state_machine.combat_draw.is_connected(_on_combat_draw):
		combat_state_machine.combat_draw.connect(_on_combat_draw)

func start_combat(player_package: CombatantPackage, enemy_package: CombatantPackage) -> void:
	_ensure_systems()
	player_character = player_package.character
	enemy_character = enemy_package.character
	enemy_ai = enemy_package.enemy_ai
	player_effect_handler = player_package.card_effect_handler
	enemy_effect_handler = enemy_package.card_effect_handler
	_add_character_if_needed(player_character)
	_add_character_if_needed(enemy_character)
	_prepare_character(player_character, player_manager)
	_prepare_character(enemy_character, enemy_manager)
	combat_state_machine.player_entity = player_character
	combat_state_machine.enemy_entity = enemy_character
	combat_state_machine.reset_combat()
	turn_system._start_game()
	damage_engine.reset()
	win_conditions.configure_runtime_dependencies(combat_state_machine, turn_system)
	win_conditions.clear_conditions()
	win_conditions.add_defeat_all_enemies_condition()
	_initialize_handler(player_effect_handler, player_character, player_manager)
	_initialize_handler(enemy_effect_handler, enemy_character, enemy_manager)
	player_manager.initialize_deck(player_package.deck)
	enemy_manager.initialize_deck(enemy_package.deck)
	player_manager.draw_cards(opening_hand_size)
	enemy_manager.draw_cards(opening_hand_size)
	combat_started.emit(player_character, enemy_character)
	_start_player_turn()

func start_encounter_combat(player_character_id: String, encounter_payload: Dictionary) -> bool:
	var packages = GameplayFactory.create_packages_for_encounter(player_character_id, encounter_payload)
	if packages.is_empty():
		return false
	start_combat(packages.get("player"), packages.get("enemy"))
	var encounter = encounter_payload.get("definition")
	if encounter and encounter is EncounterDefinition:
		EncounterLoader.new().apply_objectives_to_win_conditions(encounter, win_conditions)
	return true

func play_player_card(hand_index: int, target: Node = null) -> Dictionary:
	if combat_state_machine == null or not combat_state_machine.is_player_turn() or combat_state_machine.is_combat_ended():
		return {"success": false, "reason": "not_player_turn"}
	return _play_card_from_manager(player_character, player_manager, player_effect_handler, hand_index, enemy_character if target == null else target)

func end_player_turn() -> void:
	if combat_state_machine == null or not combat_state_machine.is_player_turn() or combat_state_machine.is_combat_ended():
		return
	_finish_turn(player_character, true)
	combat_state_machine.end_player_turn()
	turn_system.end_turn()
	if not combat_state_machine.is_combat_ended():
		_run_enemy_turn()

func get_battle_snapshot() -> Dictionary:
	return {
		"player": _character_snapshot(player_character, player_manager),
		"enemy": _character_snapshot(enemy_character, enemy_manager),
		"turn": turn_system.get_turn_info() if turn_system else {},
		"state": CombatStateMachine.CombatState.keys()[combat_state_machine.current_state] if combat_state_machine else "UNKNOWN"
	}

func _start_player_turn() -> void:
	_prepare_turn(player_character, player_manager, true)
	combat_state_machine.start_player_turn()
	turn_system.start_player_turn()
	turn_started.emit(player_character, true, turn_system.current_round)

func _run_enemy_turn() -> void:
	_prepare_turn(enemy_character, enemy_manager, false)
	combat_state_machine.start_enemy_turn()
	turn_system.start_enemy_turn()
	turn_started.emit(enemy_character, false, turn_system.current_round)
	var action = _decide_enemy_action()
	if action.get("play_card", false):
		_play_card_from_manager(enemy_character, enemy_manager, enemy_effect_handler, action.get("hand_index", -1), player_character)
	_finish_turn(enemy_character, false)
	combat_state_machine.end_enemy_turn()
	turn_system.end_turn()
	if not combat_state_machine.is_combat_ended():
		_start_player_turn()

func _prepare_turn(character: Character, manager: CardManager, is_player: bool) -> void:
	if character == null:
		return
	character.reset_turn()
	character._on_turn_start()
	if not (character.has_status("skip_draw") and character.get_status_value("skip_draw") > 0):
		manager.draw_cards(cards_per_turn)
	damage_engine.advance_turn()

func _finish_turn(character: Character, is_player: bool) -> void:
	if character == null:
		return
	character._on_turn_end()
	character.update_status_effects()
	turn_finished.emit(character, is_player, turn_system.current_round)
	combat_state_machine._check_win_conditions()
	win_conditions.check_conditions()

func _play_card_from_manager(owner: Character, manager: CardManager, effect_handler: Node, hand_index: int, default_target: Node) -> Dictionary:
	if owner == null or manager == null:
		return {"success": false, "reason": "missing_owner"}
	if hand_index < 0 or hand_index >= manager.hand.get_hand_size():
		return {"success": false, "reason": "invalid_index"}
	var card = manager.hand.get_card(hand_index)
	if card == null:
		return {"success": false, "reason": "missing_card"}
	var effective_cost = _get_effective_cost(owner, card)
	if owner.get_remaining_energy() < effective_cost:
		return {"success": false, "reason": "not_enough_energy"}
	if owner.get_remaining_plays() <= 0:
		return {"success": false, "reason": "no_plays_remaining"}
	owner.use_energy(effective_cost)
	owner.use_play()
	var played_card = manager.play_card_from_hand(hand_index)
	var result = _resolve_card(owner, played_card, effect_handler, default_target)
	manager.discard_card(played_card)
	_record_character_card_play(owner, played_card)
	win_conditions.record_card_played(played_card.id)
	card_resolved.emit(owner, played_card, result)
	combat_state_machine._check_win_conditions()
	return result

func _resolve_card(owner: Character, card: Card, effect_handler: Node, target: Node) -> Dictionary:
	if effect_handler != null and effect_handler.has_method("execute_card_effect"):
		if effect_handler is WrenCardEffects:
			var effect_result = effect_handler.execute_card_effect(card, target)
			effect_result["success"] = true
			return effect_result
		var generic_result = effect_handler.execute_card_effect(card, target, owner)
		generic_result["success"] = true
		_apply_draw_and_resource_changes(owner, target, generic_result)
		return generic_result
	var fallback = _resolve_generic_card(owner, card, target)
	fallback["success"] = true
	return fallback

func _resolve_generic_card(owner: Character, card: Card, target: Node) -> Dictionary:
	var actual_target = target if target != null else enemy_character
	var result := {
		"damage_dealt": 0,
		"healing": 0,
		"shield": 0,
		"cards_drawn": 0,
		"energy_change": 0,
		"special_effects": []
	}
	match card.card_type:
		Card.CardType.ATTACK:
			var damage_result = damage_engine.deal_damage(_scaled_damage(owner, card), actual_target, owner, _map_damage_type(card))
			result["damage_dealt"] = damage_result.final_damage
		Card.CardType.DEFENSE:
			damage_engine.create_shield(owner, card.value)
			result["shield"] = card.value
		Card.CardType.EMOTION:
			if card.emotion_type == Card.EmotionType.JOY or card.emotion_type == Card.EmotionType.LOVE:
				owner.heal(card.value)
				result["healing"] = card.value
			else:
				var emotion_damage = damage_engine.deal_damage(_scaled_damage(owner, card), actual_target, owner, _map_damage_type(card))
				result["damage_dealt"] = emotion_damage.final_damage
	_apply_draw_and_resource_changes(owner, actual_target, result)
	return result

func _apply_draw_and_resource_changes(owner: Character, target: Node, result: Dictionary) -> void:
	var manager = player_manager if owner == player_character else enemy_manager
	if result.get("cards_drawn", 0) > 0 and manager != null:
		manager.draw_cards(result["cards_drawn"])
	if result.get("energy_change", 0) > 0:
		owner.current_energy = mini(owner.max_energy, owner.current_energy + result["energy_change"])

func _record_character_card_play(owner: Character, card: Card) -> void:
	if owner is EmberCharacter:
		owner.record_card_played()
	elif owner is WrenCharacter:
		owner.record_card_played(card)
	elif owner is MayaCharacter:
		owner.on_card_played(card)

func _scaled_damage(owner: Character, card: Card) -> int:
	var damage = card.value + owner.get_attack_power()
	if owner is EmberCharacter and card.emotion_type == Card.EmotionType.ANGER:
		return owner.calculate_fire_damage(damage)
	if owner is WrenCharacter and card.emotion_type == Card.EmotionType.SADNESS:
		return owner.get_grief_damage(damage)
	return damage

func _map_damage_type(card: Card) -> DamageEngine.DamageType:
	match card.emotion_type:
		Card.EmotionType.ANGER:
			return DamageEngine.DamageType.FIRE
		Card.EmotionType.FEAR:
			return DamageEngine.DamageType.LIGHTNING
		Card.EmotionType.SADNESS, Card.EmotionType.CONFUSION, Card.EmotionType.LOVE, Card.EmotionType.JOY:
			return DamageEngine.DamageType.EMOTIONAL
	return DamageEngine.DamageType.PHYSICAL

func _get_effective_cost(owner: Character, card: Card) -> int:
	var effective_cost = card.cost
	if owner is EmberCharacter:
		effective_cost = maxi(0, card.cost - owner.get_phase_energy_discount())
	return effective_cost

func _decide_enemy_action() -> Dictionary:
	if enemy_ai == null:
		return {"play_card": enemy_manager.hand.get_hand_size() > 0, "hand_index": 0}
	var hand_cards: Array[Card] = []
	for i in range(enemy_manager.hand.get_hand_size()):
		hand_cards.append(enemy_manager.hand.get_card(i))
	var action = enemy_ai.decide(enemy_character.get_hp(), enemy_character.get_max_hp(), player_character.get_hp(), player_character.get_max_hp(), hand_cards, combat_state_machine.turn_count)
	if action.card != null:
		for i in range(hand_cards.size()):
			if hand_cards[i] == action.card:
				return {"play_card": true, "hand_index": i, "action_type": action.type}
	return {"play_card": hand_cards.size() > 0 and action.type != EnemyAI.ActionType.WAIT, "hand_index": 0, "action_type": action.type}

func _initialize_handler(handler: Node, owner: Character, manager: CardManager) -> void:
	if handler == null:
		return
	_add_character_if_needed(handler)
	if handler is WrenCardEffects:
		handler.initialize(owner, damage_engine, manager)
	elif handler is MayaCardEffects:
		handler.initialize(owner, damage_engine, turn_system)
	elif handler is EmberCardEffectHandler:
		handler.initialize(damage_engine, owner)

func _prepare_character(character: Character, manager: CardManager) -> void:
	character.reset_combat()
	character.set_card_manager(manager)

func _add_character_if_needed(node: Node) -> void:
	if node != null and node.get_parent() == null:
		add_child(node)

func _character_snapshot(character: Character, manager: CardManager) -> Dictionary:
	var hand_cards: Array[String] = []
	if manager != null:
		for i in range(manager.hand.get_hand_size()):
			var card = manager.hand.get_card(i)
			hand_cards.append(card.name if card else "")
	return {
		"name": character.character_name if character else "",
		"hp": character.get_hp() if character else 0,
		"max_hp": character.get_max_hp() if character else 0,
		"energy": character.get_remaining_energy() if character else 0,
		"plays": character.get_remaining_plays() if character else 0,
		"shield": damage_engine.get_total_shield(character) if character and damage_engine else 0,
		"hand": hand_cards
	}

func _on_combat_victory() -> void:
	combat_finished.emit("victory", player_character, enemy_character)

func _on_combat_defeat() -> void:
	combat_finished.emit("defeat", enemy_character, player_character)

func _on_combat_draw() -> void:
	combat_finished.emit("draw", null, null)
