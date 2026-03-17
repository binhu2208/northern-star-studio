## Wren Character Package
##
## Main entry point for loading Wren character and cards.
## Use this to initialize Wren in your game.

class_name WrenPackage
extends RefCounted

## Load and return all Wren cards
static func load_cards() -> Array[Card]:
	return WrenCardData.create_all_cards()

## Load starter deck (Denial phase cards)
static func load_starter_deck() -> Array[Card]:
	return WrenCardData.get_starter_deck()

## Create a new Wren character instance
static func create_character() -> WrenCharacter:
	return WrenCharacter.new()

## Create card effects handler
static func create_card_effects() -> WrenCardEffects:
	return WrenCardEffects.new()

## Create phase manager
static func create_phase_manager(wren: WrenCharacter) -> WrenPhaseManager:
	var manager = WrenPhaseManager.new()
	manager.initialize(wren)
	return manager

## Get all card IDs
static func get_all_card_ids() -> Array[String]:
	var cards = load_cards()
	var ids: Array[String] = []
	for card in cards:
		ids.append(card.id)
	return ids

## Phase descriptions for UI
static func get_phase_descriptions() -> Dictionary:
	return {
		"DENIAL": {
			"name": "Denial",
			"description": "Pretending nothing changed",
			"cards": ["Pretend", "Everything's Fine", "Photo Album", "Ghost"]
		},
		"WEIGHT": {
			"name": "Weight",
			"description": "The heaviness of absence",
			"cards": ["Heavy Heart", "Anchor", "Sinking", "Gravity", "Burden", "Stone"]
		},
		"HAUNTING": {
			"name": "Haunting",
			"description": "Memories that won't let go",
			"cards": ["Memory Strike", "Echo", "Phantom Pain", "Reminiscence", "Hallucination"]
		},
		"BARGAINING": {
			"name": "Bargaining",
			"description": "\"If I just tried harder...\"",
			"cards": ["Acceptance", "Flight", "What If"]
		},
		"SHADOWS": {
			"name": "Shadows",
			"description": "Accepting the loss exists",
			"cards": ["Shadows"]
		},
		"WREN": {
			"name": "Wren",
			"description": "Carrying memory forward",
			"cards": ["Songbird", "Legacy", "Carry Forward"]
		}
	}

## Character summary for UI
static func get_character_summary() -> Dictionary:
	return {
		"id": "wren",
		"name": "Wren",
		"theme": "Grief & Memory",
		"emotion_family": "Shadow",
		"arc": "Learning to carry loss without being consumed by it",
		"starting_health": 90,
		"starting_energy": 3,
		"starting_plays": 3,
		"special_mechanics": [
			"Memory Tokens - persist across encounters",
			"Grief Counter - accumulates through combat",
			"Phase Progression - cards unlock as emotional journey progresses",
			"Echo Mechanic - repeat previous card effects"
		],
		"phases": ["Denial", "Weight", "Haunting", "Bargaining", "Shadows", "Wren"]
	}
