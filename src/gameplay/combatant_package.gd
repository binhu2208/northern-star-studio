class_name CombatantPackage
extends RefCounted

var character: Character
var deck: Array[Card] = []
var enemy_ai: EnemyAI
var card_effect_handler: Node

static func create(p_character: Character, p_deck: Array[Card], p_enemy_ai: EnemyAI = null, p_card_effect_handler: Node = null) -> CombatantPackage:
	var package = CombatantPackage.new()
	package.character = p_character
	package.deck = p_deck.duplicate()
	package.enemy_ai = p_enemy_ai
	package.card_effect_handler = p_card_effect_handler
	return package
