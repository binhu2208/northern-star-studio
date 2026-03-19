## Ember Card Effect Handler
## 
## Handles the execution of Ember card effects in combat.
## Integrates with DamageEngine for fire damage.

class_name EmberCardEffectHandler
extends Node

## Reference to damage engine
var damage_engine: DamageEngine
## Reference to the player (EmberCharacter)
var ember_character: EmberCharacter

## Phase card access
var card_data: EmberCardData

## Lightweight launch hotfix controls.
@export var feature_toggles: Dictionary = {}
@export var card_overrides: Dictionary = {}

func _init() -> void:
	card_data = EmberCardData.new()

## Initialize with dependencies
func initialize(p_damage_engine: DamageEngine, p_ember_character: EmberCharacter) -> void:
	damage_engine = p_damage_engine
	ember_character = p_ember_character

func apply_config(config: GameConfig) -> void:
	feature_toggles = config.feature_toggles.duplicate(true)
	card_overrides = config.card_overrides.duplicate(true)

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

func execute_card_effect(card: Card, target: Node = null, _source: Node = null) -> Dictionary:
	var result := {
		"damage_dealt": 0,
		"healing": 0,
		"shield": 0,
		"cards_drawn": 0,
		"energy_change": 0,
		"special_effects": []
	}
	if card == null or ember_character == null or not is_card_enabled(card.id):
		result["cancelled"] = card != null and not is_card_enabled(card.id)
		return result

	var card_info = EmberCardData.get_card_by_id(card.id)
	if card.card_type == Card.CardType.ATTACK and target != null:
		var tuned_base_damage = apply_effect_scalar(card.id, card.value + ember_character.get_attack_power(), "damage")
		var damage = ember_character.calculate_fire_damage(tuned_base_damage)
		var damage_result = damage_engine.deal_damage(damage, target, ember_character, DamageEngine.DamageType.FIRE)
		result["damage_dealt"] = damage_result.final_damage
		if card_info.get("burn_damage", 0) > 0 and target is Character:
			ember_character.apply_burn(target, int(card_info.get("burn_damage", 0)), int(card_info.get("burn_turns", 0)))
			result["special_effects"].append("burn")
	elif card.card_type == Card.CardType.DEFENSE:
		var shield_amount = apply_effect_scalar(card.id, card.value, "shield")
		damage_engine.create_shield(ember_character, shield_amount)
		result["shield"] = shield_amount
	else:
		result["special_effects"].append("heat")

	if int(card_info.get("heat_gain", 0)) > 0:
		ember_character.add_heat(int(card_info.get("heat_gain", 0)))
	if bool(card_info.get("heat_gain_on_damage", false)) and result["damage_dealt"] > 0:
		ember_character.add_heat(int(result["damage_dealt"]))
	if int(card_info.get("draw", 0)) > 0:
		result["cards_drawn"] = int(card_info.get("draw", 0))

	## Handle heat reduction (Cooling Embers)
	if card_info.has("heat_reduction"):
		ember_character.remove_heat(card_info.get("heat_reduction"))
	
	## Handle heal on kill (Regret)
	if card_info.has("heal_on_kill"):
		result["heal_on_kill"] = card_info.get("heal_on_kill")
	
	## Handle low heat bonus (Trembling Spark)
	if card_info.has("low_heat_bonus"):
		var threshold = card_info.get("low_heat_threshold", 2)
		if ember_character.get_heat() <= threshold:
			result["low_heat_bonus"] = card_info.get("low_heat_bonus")
	
	## Handle wanting buff (Wanting to Change)
	if card_info.has("apply_wanting"):
		ember_character.add_status("wanting", 1)
		result["special_effects"].append("wanting")
	
	## Handle vulnerable (Cautious Flame)
	if card_info.has("apply_vulnerable"):
		result["apply_vulnerable"] = true
		result["first_attack_only"] = card_info.get("first_attack_only", false)
	
	## Handle damage reduction (What Have I Done)
	if card_info.has("damage_reduction"):
		result["damage_reduction"] = card_info.get("damage_reduction")
	
	## Handle self damage
	if card_info.has("self_damage"):
		result["self_damage"] = card_info.get("self_damage")
	
	## Handle soot debuff (Ash Fall)
	if card_info.has("apply_soot"):
		result["apply_soot"] = true
		result["soot_stacks"] = 1

	return result

## Execute a card effect
## [code]card_info[/code] - Dictionary containing card data
## [code]target[/code] - Target node (enemy)
## [code]all_targets[/code] - Array of all targets for AOE effects
func execute_card(card_info: Dictionary, target: Node, all_targets: Array[Node] = []) -> void:
	var card_type = card_info.get("type", Card.CardType.ATTACK)
	
	## Check if player can afford the card
	var cost = card_info.get("cost", 1)
	var heat_threshold = card_info.get("energy_discount_heat", 0)
	
	## Apply energy discount if applicable
	if heat_threshold > 0 and ember_character.get_heat() >= heat_threshold:
		cost = maxi(cost - 1, 0)
	
	if not ember_character.use_energy(cost):
		return  ## Not enough energy
	
	match card_type:
		Card.CardType.ATTACK:
			_execute_attack(card_info, target, all_targets)
		Card.CardType.DEFENSE:
			_execute_defense(card_info)
		_:  ## SKILL type
			_execute_skill(card_info)

## Execute attack card effect
func _execute_attack(card_info: Dictionary, target: Node, all_targets: Array[Node]) -> void:
	var damage_type = _get_damage_type(card_info.get("damage_type", "FIRE"))
	var base_damage = card_info.get("value", 0)
	
	## Handle heat scaling damage (Backdraft)
	if card_info.get("heat_scaling_damage", false):
		base_damage = ember_character.get_heat() / 2
	
	## Calculate final damage with heat bonus
	var final_damage = ember_character.calculate_fire_damage(base_damage)
	
	## Apply low heat bonus (Trembling Spark)
	if card_info.has("low_heat_bonus"):
		var threshold = card_info.get("low_heat_threshold", 2)
		if ember_character.get_heat() <= threshold:
			final_damage += card_info.get("low_heat_bonus", 0)
	
	## Apply phase bonus
	var phase_bonus = ember_character.get_phase_bonus()
	final_damage = int(final_damage * phase_bonus.damage_mult)
	
	## Handle AOE
	if card_info.get("aoe", false):
		for aoe_target in all_targets:
			if is_instance_valid(aoe_target):
				_apply_damage_to_target(final_damage, damage_type, aoe_target)
				_apply_burn_effect(card_info, aoe_target)
				_apply_soot_effect(card_info, aoe_target)
				_apply_vulnerable_effect(card_info, aoe_target)
	else:
		_apply_damage_to_target(final_damage, damage_type, target)
		_apply_burn_effect(card_info, target)
		_apply_soot_effect(card_info, target)
		_apply_vulnerable_effect(card_info, target)
	
	## Handle heat gain on damage
	if card_info.get("heat_gain_on_damage", false):
		ember_character.add_heat(final_damage)
	
	## Handle heat immunity
	if card_info.get("heat_immunity", false):
		ember_character.apply_status("heat_immunity", 1)
	
	## Handle heal on kill (Regret) - check if target is dead after damage
	if card_info.has("heal_on_kill"):
		_handle_heal_on_kill(card_info, target, final_damage)
	
	## Handle wanting buff (heal ally on damage)
	if card_info.has("apply_wanting") == false and ember_character.has_status("wanting"):
		_handle_wanting_heal(final_damage)
	
	## Handle draw
	_draw_cards(card_info.get("draw", 0))

## Execute defense card effect
func _execute_defense(card_info: Dictionary) -> void:
	ember_character.set_defending(true)
	
	## Handle shield (Scars, Cooling Embers)
	if card_info.has("shield"):
		var shield_amount = card_info.get("shield", 0)
		if damage_engine:
			damage_engine.create_shield(ember_character, shield_amount)
	
	## Some defense cards also give heat (Scars)
	if card_info.has("heat_gain"):
		ember_character.add_heat(card_info.get("heat_gain"))
	
	## Some defense cards reduce heat (Cooling Embers)
	if card_info.has("heat_reduction"):
		ember_character.remove_heat(card_info.get("heat_reduction"))

## Execute skill card effect
func _execute_skill(card_info: Dictionary) -> void:
	## Handle heat gain
	if card_info.has("heat_gain"):
		var heat_gain = card_info.get("heat_gain")
		## Handle heat boost when low
		if card_info.get("heat_boost_low", false) and ember_character.get_heat() < 30:
			heat_gain *= 2
		ember_character.add_heat(heat_gain)
	
	## Handle burn reduction
	if card_info.has("burn_reduction"):
		var reduction = card_info.get("burn_reduction")
		if ember_character.has_status("burn"):
			var current_burn_turns = ember_character.get_status_turns("burn")
			ember_character.apply_status("burn", maxi(current_burn_turns - reduction, 0))
	
	## Handle draw
	_draw_cards(card_info.get("draw", 0))

## Apply damage to a single target
func _apply_damage_to_target(damage: int, damage_type: int, target: Node) -> void:
	if not is_instance_valid(target):
		return
	
	if damage_engine:
		damage_engine.deal_damage(damage, target, ember_character, damage_type)
	else:
		## Fallback if no damage engine
		if target.has_method("take_damage"):
			target.take_damage(damage)

## Apply burn effect to target
func _apply_burn_effect(card_info: Dictionary, target: Node) -> void:
	if card_info.has("burn_damage") and card_info.has("burn_turns"):
		var burn_damage = card_info.get("burn_damage", 0)
		var burn_turns = card_info.get("burn_turns", 0)
		
		if target.has_method("apply_status"):
			target.apply_status("burn", burn_turns)
			## Also set burn damage value
			if target.has_method("set_burn_damage"):
				target.set_burn_damage(burn_damage)

## Apply soot effect to target (Ash Fall)
func _apply_soot_effect(card_info: Dictionary, target: Node) -> void:
	if card_info.has("apply_soot"):
		var soot_stacks = card_info.get("soot_stacks", 1)
		if target.has_method("add_status"):
			## Soot reduces healing received by 3 per stack
			target.add_status("soot", 999, soot_stacks * 3)  ## Lasts rest of combat

## Apply vulnerable effect to target (Cautious Flame)
func _apply_vulnerable_effect(card_info: Dictionary, target: Node) -> void:
	if card_info.has("apply_vulnerable"):
		var is_first_attack = card_info.get("first_attack_only", false)
		## For now, always apply if the card has it
		## In full implementation, track attacks this turn
		if target.has_method("add_status"):
			target.add_status("vulnerable", 1)  ## Next hit takes +50%

## Handle heal on kill (Regret)
func _handle_heal_on_kill(card_info: Dictionary, target: Node, damage: int) -> void:
	## Check if target is dead (no health remaining)
	## This is a simplified check - in full implementation, check target's current_health
	var heal_amount = card_info.get("heal_on_kill", 0)
	if heal_amount > 0 and target.has_method("is_dead") and target.is_dead():
		ember_character.heal(heal_amount)

## Handle wanting buff - heal ally for 50% of damage dealt
func _handle_wanting_heal(damage_dealt: int) -> void:
	var heal_amount = int(damage_dealt * 0.5)
	if heal_amount > 0:
		## Remove the wanting status after use
		ember_character.remove_status("wanting")
		## In full implementation, this would heal an ally
		## For now, self-heal as fallback
		if ember_character.has_method("heal"):
			ember_character.heal(heal_amount)

## Draw cards (integration point with CardManager)
func _draw_cards(amount: int) -> void:
	## This would integrate with CardManager
	## For now, it's a placeholder for the hook
	pass

## Get damage type enum from string
func _get_damage_type(type_string: String) -> int:
	if damage_engine:
		match type_string.to_upper():
			"FIRE":
				return damage_engine.DamageType.FIRE
			"ICE":
				return damage_engine.DamageType.ICE
			"LIGHTNING":
				return damage_engine.DamageType.LIGHTNING
			"PHYSICAL":
				return damage_engine.DamageType.PHYSICAL
	return damage_engine.DamageType.FIRE if damage_engine else 0

## Get phase cards for a specific phase
func get_phase_cards(phase: int) -> Array[Dictionary]:
	return card_data.get_cards_by_phase(phase)

## Get all ember cards
func get_all_cards() -> Array[Dictionary]:
	return card_data.get_all_cards()
