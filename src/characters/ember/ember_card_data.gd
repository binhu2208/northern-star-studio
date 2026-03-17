## Ember Card Data
## 
## All 20 Ember (Fire) cards across 6 phases.
## Phases: Ignition → Blaze → Scorched Earth → Smoldering → Controlled Burn → Ember

class_name EmberCardData
extends Node

## Card definitions organized by phase
## Each card: { id, name, description, type, cost, value, phase }

const CARDS: Array[Dictionary] = [
	## ============ PHASE 1: IGNITION (Cards 1-4) ============
	{
		"id": "ember_spark",
		"name": "Spark",
		"description": "A small flame to ignite the battle. Deal 3 fire damage.",
		"type": Card.CardType.ATTACK,
		"cost": 1,
		"value": 3,
		"phase": 1,
		"damage_type": "FIRE"
	},
	{
		"id": "ember_flare",
		"name": "Flare",
		"description": "A burst of flame that adds Heat. Deal 2 damage and gain 10 Heat.",
		"type": Card.CardType.ATTACK,
		"cost": 1,
		"value": 2,
		"phase": 1,
		"heat_gain": 10,
		"damage_type": "FIRE"
	},
	{
		"id": "ember_warm_up",
		"name": "Warm Up",
		"description": "Prepare for bigger flames. Gain 15 Heat.",
		"type": "SKILL",
		"cost": 0,
		"phase": 1,
		"heat_gain": 15
	},
	{
		"id": "ember_ Kindle",
		"name": "Kindle",
		"description": "Build the foundation for fire. Gain 8 Heat and draw 1 card.",
		"type": "SKILL",
		"cost": 1,
		"phase": 1,
		"heat_gain": 8,
		"draw": 1
	},
	
	## ============ PHASE 2: BLAZE (Cards 5-8) ============
	{
		"id": "ember_fireball",
		"name": "Fireball",
		"description": "A ball of flames that explodes. Deal 6 fire damage.",
		"type": Card.CardType.ATTACK,
		"cost": 2,
		"value": 6,
		"phase": 2,
		"damage_type": "FIRE"
	},
	{
		"id": "ember_inferno",
		"name": "Inferno",
		"description": "Unleash a raging fire. Deal 5 damage and apply 2 burn.",
		"type": Card.CardType.ATTACK,
		"cost": 2,
		"value": 5,
		"phase": 2,
		"burn_damage": 2,
		"burn_turns": 2,
		"damage_type": "FIRE"
	},
	{
		"id": "ember_heat_wave",
		"name": "Heat Wave",
		"description": "Sweltering heat damages all. Deal 4 damage to all enemies and gain 15 Heat.",
		"type": Card.CardType.ATTACK,
		"cost": 2,
		"value": 4,
		"phase": 2,
		"aoe": true,
		"heat_gain": 15,
		"damage_type": "FIRE"
	},
	{
		"id": "ember_flashpoint",
		"name": "Flashpoint",
		"description": "Reach the point of ignition. Gain 20 Heat.",
		"type": "SKILL",
		"cost": 1,
		"phase": 2,
		"heat_gain": 20
	},
	
	## ============ PHASE 3: SCORCHED EARTH (Cards 9-12) ============
	{
		"id": "ember_immolate",
		"name": "Immolate",
		"description": "Burn everything to ash. Deal 8 fire damage and apply 3 burn.",
		"type": Card.CardType.ATTACK,
		"cost": 3,
		"value": 8,
		"phase": 3,
		"burn_damage": 3,
		"burn_turns": 3,
		"damage_type": "FIRE"
	},
	{
		"id": "ember_thermal_strike",
		"name": "Thermal Strike",
		"description": "Extreme heat strikes. Deal 10 fire damage.",
		"type": Card.CardType.ATTACK,
		"cost": 3,
		"value": 10,
		"phase": 3,
		"damage_type": "FIRE"
	},
	{
		"id": "ember_rain_of_fire",
		"name": "Rain of Fire",
		"description": "Fire falls from above. Deal 7 damage to all enemies and apply 2 burn.",
		"type": Card.CardType.ATTACK,
		"cost": 3,
		"value": 7,
		"phase": 3,
		"aoe": true,
		"burn_damage": 2,
		"burn_turns": 2,
		"damage_type": "FIRE"
	},
	{
		"id": "ember_combustion",
		"name": "Combustion",
		"description": "Explosive chain reaction. Deal 6 damage and gain Heat equal to damage dealt.",
		"type": Card.CardType.ATTACK,
		"cost": 2,
		"value": 6,
		"phase": 3,
		"damage_type": "FIRE",
		"heat_gain_on_damage": true
	},
	
	## ============ PHASE 4: SMOLDERING (Cards 13-14) ============
	{
		"id": "ember_smolder",
		"name": "Smolder",
		"description": "Low flames that persist. Deal 3 damage and gain 5 Heat.",
		"type": Card.CardType.ATTACK,
		"cost": 1,
		"value": 3,
		"phase": 4,
		"damage_type": "FIRE",
		"heat_gain": 5
	},
	{
		"id": "ember_coals",
		"name": "Coals",
		"description": "Banked embers grow stronger. Gain 12 Heat. If Heat is below 30, gain double.",
		"type": "SKILL",
		"cost": 1,
		"phase": 4,
		"heat_gain": 12,
		"heat_boost_low": true
	},
	
	## ============ PHASE 5: CONTROLLED BURN (Cards 15-17) ============
	{
		"id": "ember_efficient_blaze",
		"name": "Efficient Blaze",
		"description": "Controlled fire hits harder with less energy. Deal 7 fire damage. Costs 1 less energy if above 40 Heat.",
		"type": Card.CardType.ATTACK,
		"cost": 2,
		"value": 7,
		"phase": 5,
		"damage_type": "FIRE",
		"energy_discount_heat": 40
	},
	{
		"id": "ember_guided_flame",
		"name": "Guided Flame",
		"description": "Precise flame attack. Deal 5 damage and draw 1 card.",
		"type": Card.CardType.ATTACK,
		"cost": 1,
		"value": 5,
		"phase": 5,
		"damage_type": "FIRE",
		"draw": 1
	},
	{
		"id": "ember_backdraft",
		"name": "Backdraft",
		"description": "Explosive release of built-up heat. Deal damage equal to current Heat / 2.",
		"type": Card.CardType.ATTACK,
		"cost": 2,
		"value": 0,  ## Calculated from heat
		"phase": 5,
		"damage_type": "FIRE",
		"heat_scaling_damage": true
	},
	
	## ============ PHASE 6: EMBER (Cards 18-20) ============
	{
		"id": "ember_final_form",
		"name": "Phoenix Blaze",
		"description": "The final form of fire. Deal 12 fire damage and become immune to Heat loss this turn.",
		"type": Card.CardType.ATTACK,
		"cost": 3,
		"value": 12,
		"phase": 6,
		"damage_type": "FIRE",
		"heat_immunity": true
	},
	{
		"id": "ember_eternal_flame",
		"name": "Eternal Flame",
		"description": "Fire that never dies. Gain 25 Heat and reduce all burn on you by 1 turn.",
		"type": "SKILL",
		"cost": 2,
		"phase": 6,
		"heat_gain": 25,
		"burn_reduction": 1
	},
	{
		"id": "ember_supernova",
		"name": "Supernova",
		"description": "The ultimate fire attack. Deal 15 damage to all enemies and apply 4 burn.",
		"type": Card.CardType.ATTACK,
		"cost": 4,
		"value": 15,
		"phase": 6,
		"aoe": true,
		"burn_damage": 4,
		"burn_turns": 4,
		"damage_type": "FIRE"
	}
]

## Get all cards
static func get_all_cards() -> Array[Dictionary]:
	return CARDS.duplicate()

## Get cards by phase
static func get_cards_by_phase(phase: int) -> Array[Dictionary]:
	return CARDS.filter(func(card): return card.get("phase") == phase)

## Get card by ID
static func get_card_by_id(card_id: String) -> Dictionary:
	for card in CARDS:
		if card.get("id") == card_id:
			return card
	return {}

## Get card count
static func get_card_count() -> int:
	return CARDS.size()

## Get phase count
static func get_phase_count() -> int:
	return 6
