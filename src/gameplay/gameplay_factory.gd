class_name GameplayFactory
extends RefCounted

static func create_character_package(character_id: String, is_enemy: bool = false) -> CombatantPackage:
	var package = CharacterRegistry.get_package(character_id)
	if package == null:
		return null
	var character = package.create_character()
	var deck = package.load_starter_deck()
	var effects = package.create_card_effects(character)
	var ai = EnemyAI.new() if is_enemy else null
	return CombatantPackage.create(character, deck, ai, effects)

static func create_ember_player() -> CombatantPackage:
	return create_character_package(EmberCharacter.CHARACTER_ID)

static func create_wren_enemy() -> CombatantPackage:
	return create_character_package(WrenCharacter.CHARACTER_ID, true)

static func create_maya_player() -> CombatantPackage:
	return create_character_package(MayaCharacter.CHARACTER_ID)

static func create_packages_for_encounter(player_character_id: String, encounter_payload: Dictionary) -> Dictionary:
	var player_package = create_character_package(player_character_id)
	var primary_enemy = encounter_payload.get("primary_enemy")
	if player_package == null or primary_enemy == null:
		return {}
	var enemy_deck: Array[Card] = []
	var definition = encounter_payload.get("definition")
	if definition and definition is EncounterDefinition:
		var enemy_setup = definition.get_primary_enemy()
		if enemy_setup:
			var available_enemy_cards = CharacterRegistry.load_cards(enemy_setup.enemy_id)
			var card_lookup := {}
			for candidate in available_enemy_cards:
				if candidate:
					card_lookup[candidate.id] = candidate
			for card_id in enemy_setup.deck:
				if card_lookup.has(card_id):
					enemy_deck.append(card_lookup[card_id])
	if enemy_deck.is_empty():
		enemy_deck = CharacterRegistry.load_starter_deck(primary_enemy.character_id)
	var enemy_package = CombatantPackage.create(primary_enemy, enemy_deck, EnemyAI.new(), CharacterRegistry.create_card_effects(primary_enemy.character_id, primary_enemy))
	return {
		"player": player_package,
		"enemy": enemy_package
	}
