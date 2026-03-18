## Wren Card Effects
##
## Handles the execution of Wren's special card effects.
## Implements Shadow-specific mechanics: Memory tokens, grief effects, Echo, etc.

class_name WrenCardEffects
extends Node

## Reference to the Wren character
var wren: WrenCharacter

## Reference to the damage engine
var damage_engine: DamageEngine

## Reference to the card manager
var card_manager: CardManager

## Lightweight launch hotfix controls.
@export var feature_toggles: Dictionary = {}
@export var card_overrides: Dictionary = {}

func _init() -> void:
	pass

## Initialize with references
func initialize(p_wren: WrenCharacter, p_damage_engine: DamageEngine, p_card_manager: CardManager) -> void:
	wren = p_wren
	damage_engine = p_damage_engine
	card_manager = p_card_manager

func is_card_enabled(card_id: String) -> bool:
	var override_value = card_overrides.get(card_id, {})
	return not bool(override_value.get("disabled", false))

func get_card_override(card_id: String) -> Dictionary:
	var override_value = card_overrides.get(card_id, {})
	if override_value is Dictionary:
		return override_value
	return {}

func apply_effect_scalar(card_id: String, base_value: int, field_name: String) -> int:
	var override_value = get_card_override(card_id)
	var adjusted = base_value + int(override_value.get("%s_delta" % field_name, 0))
	adjusted = int(round(float(adjusted) * float(override_value.get("%s_scalar" % field_name, 1.0))))
	return maxi(0, adjusted)

## Execute card effect based on card ID
## Returns: Dictionary with effect results
func execute_card_effect(card: Card, target: Node = null) -> Dictionary:
	var result := {
		"success": false,
		"damage": 0,
		"heal": 0,
		"defense": 0,
		"cards_drawn": 0,
		"memory_tokens": 0,
		"grief": 0,
		"special": ""
	}
	
	if card == null or not is_card_enabled(card.id):
		result["special"] = "Card disabled" if card != null else result["special"]
		return result
	
	match card.id:
		# ============================================================
		# DENIAL PHASE CARDS
		# ============================================================
		
		"wren_pretend":
			# Ignore all damage this turn - implemented as status effect
			wren.add_status("pretending", 1, card.value)
			result["defense"] = card.value
			result["special"] = "Ignoring damage"
			result["success"] = true
		
		"wren_everythings_fine":
			# Heal now, damage later
			wren.heal(card.value)
			result["heal"] = card.value
			wren.add_status("delayed_pain", 2, 3)  # 3 damage in 2 turns
			result["special"] = "Healed, but pain coming"
			result["success"] = true
		
		"wren_photo_album":
			# Draw cards
			var draw_amount = apply_effect_scalar(card.id, card.value, "draw")
			if card_manager:
				result["cards_drawn"] = card_manager.draw_cards(draw_amount)
			else:
				result["cards_drawn"] = draw_amount
			wren.add_memory_token(1)  # Gather memory
			result["memory_tokens"] = 1
			result["special"] = "Memories gathered"
			result["success"] = true
		
		"wren_ghost":
			# Create memory token
			wren.add_memory_token(card.value)
			result["memory_tokens"] = card.value
			result["special"] = "Memory ghost summoned"
			result["success"] = true
		
		# ============================================================
		# WEIGHT PHASE CARDS
		# ============================================================
		
		"wren_heavy_heart":
			# Gain defense, lose speed
			wren.add_status("heavy_heart", 1, card.value)
			result["defense"] = card.value
			wren.add_status("slowed", 1, -2)  # -2 speed
			result["special"] = "Heavy but protected"
			result["success"] = true
		
		"wren_anchor":
			# Defense based on memory tokens
			var defense = card.value
			if wren.get_memory_tokens() > 0:
				defense += 3
				result["special"] = "Anchored by memories"
			else:
				result["special"] = "Anchored alone"
			wren.add_status("anchor", 1, defense)
			result["defense"] = defense
			result["success"] = true
		
		"wren_sinking":
			# Take damage to remove debuff
			wren.take_damage(card.value)
			result["damage"] = card.value
			# Remove one debuff
			var debuffs = ["slowed", "vulnerable", "weak"]
			for debuff in debuffs:
				if wren.has_status(debuff):
					wren.remove_status(debuff)
					result["special"] = "Sank through " + debuff
					break
			result["success"] = true
		
		"wren_gravity":
			# Damage target, self damage
			var tuned_damage = apply_effect_scalar(card.id, card.value, "damage")
			if target and damage_engine:
				var damage_result = damage_engine.deal_damage(tuned_damage, target, wren, DamageEngine.DamageType.SHADOW)
				result["damage"] = damage_result.final_damage
			# Self damage
			wren.take_damage(2)
			result["damage"] += 2
			result["special"] = "Pulled down"
			result["success"] = true
		
		"wren_burden":
			# Take damage, draw cards
			wren.take_damage(card.value)
			result["damage"] = card.value
			if card_manager:
				result["cards_drawn"] = card_manager.draw_cards(2)
			else:
				result["cards_drawn"] = 2
			result["special"] = "Burden shared"
			result["success"] = true
		
		"wren_stone":
			# Heavy defense, skip draw
			wren.add_status("stone", 1, card.value)
			result["defense"] = card.value
			wren.add_status("skip_draw", 1, 1)
			result["special"] = "Immovable"
			result["success"] = true
		
		# ============================================================
		# HAUNTING PHASE CARDS
		# ============================================================
		
		"wren_memory_strike":
			# Damage based on cards played
			var bonus_damage = wren.cards_played_this_combat * 2
			var total_damage = card.value + bonus_damage
			if target and damage_engine:
				var damage_result = damage_engine.deal_damage(total_damage, target, wren, DamageEngine.DamageType.SHADOW)
				result["damage"] = damage_result.final_damage
				result["special"] = "Memory Strike: " + str(bonus_damage) + " bonus"
			result["success"] = true
		
		"wren_echo":
			# Repeat last card effect
			var last_effect = wren.get_last_card_effect()
			if last_effect.is_empty():
				result["special"] = "No echo to repeat"
			else:
				# Find and re-execute the last card
				# For simplicity, draw a card as echo
				if card_manager:
					result["cards_drawn"] = card_manager.draw_cards(1)
				result["special"] = "Echo of " + last_effect.get("card_id", "unknown")
				result["success"] = true
		
		"wren_phantom_pain":
			# Delayed damage
			if target and damage_engine:
				var damage_result = damage_engine.deal_damage(card.value, target, wren, DamageEngine.DamageType.SHADOW)
				result["damage"] = damage_result.final_damage
			# Delayed damage in 2 turns
			wren.add_status("phantom_pain", 2, 3)
			result["special"] = "Pain coming"
			result["success"] = true
		
		"wren_reminiscence":
			# Look at top cards - handled by UI
			result["special"] = "Reminiscence"
			result["success"] = true
		
		"wren_hallucination":
			# Random effect
			var rng = randi() % 2
			if rng == 0:
				# Good: Heal
				wren.heal(card.value)
				result["heal"] = card.value
				result["special"] = "Kind hallucination"
			else:
				# Bad: Self damage + draw
				wren.take_damage(card.value)
				result["damage"] = card.value
				if card_manager:
					result["cards_drawn"] = card_manager.draw_cards(2)
				result["special"] = "Cruel hallucination"
			result["success"] = true
		
		# ============================================================
		# BARGAINING PHASE CARDS
		# ============================================================
		
		"wren_acceptance":
			# Transform debuff to defense
			var debuffs = ["vulnerable", "weak", "slowed"]
			var removed = false
			for debuff in debuffs:
				if wren.has_status(debuff):
					wren.remove_status(debuff)
					wren.add_status("acceptance_buff", 1, 3)
					result["defense"] = 3
					removed = true
					result["special"] = "Accepted and transformed " + debuff
					break
			if not removed:
				result["special"] = "No debuff to accept"
			result["success"] = true
		
		"wren_flight":
			# Avoid damage, lose memory token
			wren.add_status("evasion", 1, 1)
			wren.remove_memory_token(1)
			result["memory_tokens"] = -1
			result["special"] = "Fled"
			result["success"] = true
		
		"wren_what_if":
			# Look at opponent hand, discard one - handled by UI
			result["special"] = "What if..."
			result["success"] = true
		
		# ============================================================
		# SHADOWS PHASE CARDS
		# ============================================================
		
		"wren_shadows":
			# Defense + memory tokens + grief
			wren.add_status("shadows", 1, card.value)
			result["defense"] = card.value
			wren.add_memory_token(2)
			result["memory_tokens"] = 2
			wren.add_grief(2)
			result["grief"] = 2
			result["special"] = "Embraced shadows"
			result["success"] = true
		
		# ============================================================
		# WREN PHASE CARDS
		# ============================================================
		
		"wren_songbird":
			# Damage with memory token bonus
			var damage = card.value
			if wren.get_memory_tokens() >= 3:
				damage += 4
				result["special"] = "Songbird soars"
			else:
				result["special"] = "Songbird sings"
			if target and damage_engine:
				var damage_result = damage_engine.deal_damage(damage, target, wren, DamageEngine.DamageType.SHADOW)
				result["damage"] = damage_result.final_damage
			result["success"] = true
		
		"wren_legacy":
			# Damage based on memory tokens
			var legacy_damage = wren.get_memory_tokens() * 3
			if target and damage_engine:
				var damage_result = damage_engine.deal_damage(legacy_damage, target, wren, DamageEngine.DamageType.SHADOW)
				result["damage"] = damage_result.final_damage
			result["special"] = "Legacy: " + str(legacy_damage) + " damage"
			result["success"] = true
		
		"wren_carry_forward":
			# Heal based on cards played
			var heal_amount = wren.cards_played_this_combat * 2
			wren.heal(heal_amount)
			result["heal"] = heal_amount
			result["special"] = "Carried forward: " + str(heal_amount) + " healing"
			result["success"] = true
	
	# Record card played for tracking
	wren.record_card_played(card)
	
	return result

## Handle delayed effects (call at start of each turn)
func process_delayed_effects() -> void:
	# Process delayed pain
	if wren.has_status("phantom_pain"):
		var turns_left = wren.get_status_value("phantom_pain")
		# This would need target reference - simplified for now
		wren.remove_status("phantom_pain")
	
	# Process delayed pain from Everything's Fine
	if wren.has_status("delayed_pain"):
		wren.take_damage(3)
		wren.remove_status("delayed_pain")
