class_name GameplayFactory
extends RefCounted

static func create_ember_player() -> CombatantPackage:
	var ember = EmberCharacter.new()
	return CombatantPackage.create(ember, EmberCardFactory.create_all_cards())

static func create_wren_enemy() -> CombatantPackage:
	var wren = WrenPackage.create_character()
	var ai = EnemyAI.new()
	var effects = WrenPackage.create_card_effects()
	return CombatantPackage.create(wren, WrenPackage.load_starter_deck(), ai, effects)

static func create_maya_player() -> CombatantPackage:
	var maya = MayaCharacter.new()
	return CombatantPackage.create(maya, MayaCards.get_starting_deck())
