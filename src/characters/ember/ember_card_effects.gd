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

func _init() -> void:
	card_data = EmberCardData.new()

## Initialize with dependencies
func initialize(p_damage_engine: DamageEngine, p_ember_character: EmberCharacter) -> void:
	damage_engine = p_damage_engine
	ember_character = p_ember_character

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
	
	## Apply phase bonus
	var phase_bonus = ember_character.get_phase_bonus()
	final_damage = int(final_damage * phase_bonus.damage_mult)
	
	## Handle AOE
	if card_info.get("aoe", false):
		for aoe_target in all_targets:
			if is_instance_valid(aoe_target):
				_apply_damage_to_target(final_damage, damage_type, aoe_target)
				_apply_burn_effect(card_info, aoe_target)
	else:
		_apply_damage_to_target(final_damage, damage_type, target)
		_apply_burn_effect(card_info, target)
	
	## Handle heat gain on damage
	if card_info.get("heat_gain_on_damage", false):
		ember_character.add_heat(final_damage)
	
	## Handle heat immunity
	if card_info.get("heat_immunity", false):
		ember_character.apply_status("heat_immunity", 1)
	
	## Handle draw
	_draw_cards(card_info.get("draw", 0))

## Execute defense card effect
func _execute_defense(card_info: Dictionary) -> void:
	ember_character.set_defending(true)
	# Future: Shield creation via damage_engine.create_shield()
	
	## Some defense cards also give heat
	if card_info.has("heat_gain"):
		ember_character.add_heat(card_info.get("heat_gain"))

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
