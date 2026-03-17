class_name DamageEngine
extends Node

## Handles all damage calculations and applications in combat.
## Supports multiple damage types, modifiers, shields, and card-based effects.

signal damage_dealt(source: Node, target: Node, damage: DamageResult)
signal damage_blocked(target: Node, blocked_amount: int)
signal shield_broken(target: Node, shield: Shield, damage: DamageResult)

## Represents different types of damage in the game.
enum DamageType {
	PHYSICAL,
	FIRE,
	ICE,
	LIGHTNING,
	EARTH,
	WIND,
	HOLY,
	SHADOW,
	EMOTIONAL,
	PURE  ## Ignores all modifiers and shields
}

## Inner class to hold damage modifier data.
class DamageModifier:
	var source: Node
	var modifier_type: ModifierType
	var value: float  ## Multiplier (1.0 = 100%) or flat amount
	var damage_types: Array[DamageType]
	var is_percentage: bool
	var priority: int
	
	enum ModifierType {
		FLAT,          ## Flat damage reduction/addition
		MULTIPLIER,    ## Damage multiplier
		RESISTANCE,    ## Percentage reduction
		AMPLIFICATION, ## Percentage increase
		TYPE_SPECIFIC  ## Only affects specific damage types
	}
	
	func _init(
		p_source: Node,
		p_type: ModifierType,
		p_value: float,
		p_types: Array[DamageType] = [],
		p_is_percentage: bool = true,
		p_priority: int = 0
	) -> void:
		source = p_source
		modifier_type = p_type
		value = p_value
		damage_types = p_types
		is_percentage = p_is_percentage
		priority = p_priority

## Represents a shield that can absorb damage.
class Shield:
	var id: String
	var owner: Node
	var current_shield: int
	var max_shield: int
	var damage_types: Array[DamageType]
	var expires_on_turn: int = -1  ## -1 = never expires
	
	func _init(
		p_owner: Node,
		p_max_shield: int,
		p_types: Array[DamageType] = [],
		p_expires_on_turn: int = -1
	) -> void:
		owner = p_owner
		max_shield = p_max_shield
		current_shield = p_max_shield
		damage_types = p_types
		expires_on_turn = p_expires_on_turn
	
	func absorb_damage(amount: int) -> int:
		var absorbed = mini(amount, current_shield)
		current_shield -= absorbed
		return absorbed
	
	func is_broken() -> bool:
		return current_shield <= 0
	
	func is_expired(current_turn: int) -> bool:
		return expires_on_turn > 0 and current_turn >= expires_on_turn
	
	func restore(amount: int) -> void:
		current_shield = mini(current_shield + amount, max_shield)

## Result of a damage calculation/application.
class DamageResult:
	var base_damage: int
	var final_damage: int
	var damage_type: DamageType
	var source: Node
	var target: Node
	var was_critical: bool
	var was_blocked: bool
	var blocked_amount: int
	var shields_destroyed: Array[Shield]
	var modifiers_applied: Array[DamageModifier]
	
	func _init() -> void:
		shields_destroyed = []
		modifiers_applied = []

@export var enable_critical_hits: bool = true
@export var base_critical_chance: float = 0.05  ## 5% base crit chance
@export var base_critical_multiplier: float = 1.5  ## 1.5x damage on crit
@export var minimum_damage: int = 0  ## Minimum damage after all calculations

## Active damage modifiers indexed by target node.
var _modifiers: Dictionary = {}  ## Node -> Array[DamageModifier]
## Active shields indexed by target node.
var _shields: Dictionary = {}  ## Node -> Array[Shield]
## Current turn number for shield expiration.
var current_turn: int = 0

func _ready() -> void:
	pass

## Calculate base damage from a card or ability.
## [code]base_value[/code] - Raw damage value from card/ability
## [code]damage_type[/code] - Type of damage being dealt
## [code]source[/code] - Node dealing the damage
func calculate_base_damage(base_value: int, damage_type: DamageType, source: Node) -> int:
	var damage: float = float(base_value)
	
	## Apply any source-specific modifiers here (future card effects)
	damage = _apply_source_modifiers(damage, damage_type, source)
	
	return maxi(int(damage), minimum_damage)

## Calculate final damage with all modifiers and type interactions.
## [code]base_damage[/code] - Base damage value
## [code]damage_type[/code] - Type of damage
## [code]source[/code] - Node dealing the damage
## [code]target[/code] - Node receiving the damage
func calculate_final_damage(
	base_damage: int,
	damage_type: DamageType,
	source: Node,
	target: Node
) -> DamageResult:
	var result = DamageResult.new()
	result.base_damage = base_damage
	result.damage_type = damage_type
	result.source = source
	result.target = target
	
	## Start with base damage
	var damage: float = float(base_damage)
	
	## Apply target's damage modifiers
	damage = _apply_target_modifiers(damage, damage_type, target, result)
	
	## Handle type effectiveness (future: elemental interactions)
	damage = _apply_type_effectiveness(damage, damage_type, target)
	
	## Check for critical hits
	if enable_critical_hits:
		var crit_chance = _get_critical_chance(source, target)
		if randf() < crit_chance:
			result.was_critical = true
			damage *= base_critical_multiplier
	
	## Apply card-specific damage effects (integration point for future cards)
	damage = _apply_card_effects(damage, damage_type, source, target, result)
	
	result.final_damage = maxi(int(damage), minimum_damage)
	return result

## Apply damage to a target, handling shields and final HP reduction.
## [code]damage_result[/code] - Pre-calculated damage result
## [code]target[/code] - Node to apply damage to
func apply_damage(damage_result: DamageResult, target: Node) -> void:
	if not _is_valid_target(target):
		return
	
	var damage_to_apply = damage_result.final_damage
	var blocked = 0
	
	## Check for shields first
	if _shields.has(target) and not _shields[target].is_empty():
		var target_shields: Array[Shield] = _shields[target]
		
		## Sort shields by priority (if we add priority later)
		for shield: Shield in target_shields:
			if shield.is_expired(current_turn):
				continue
			
			## Check if shield applies to this damage type
			if shield.damage_types.is_empty() or damage_result.damage_type in shield.damage_types:
				var absorbed = shield.absorb_damage(damage_to_apply)
				blocked += absorbed
				damage_to_apply -= absorbed
				
				if shield.is_broken():
					damage_result.shields_destroyed.append(shield)
					shield_broken.emit(target, shield, damage_result)
				
				if damage_to_apply <= 0:
					break
	
	damage_result.blocked_amount = blocked
	damage_result.was_blocked = blocked > 0
	
	if blocked > 0:
		damage_blocked.emit(target, blocked)
	
	## Apply remaining damage to target's HP
	if damage_to_apply > 0:
		_apply_hp_reduction(target, damage_to_apply)
	
	damage_dealt.emit(damage_result.source, target, damage_result)

## Add a damage modifier to a target.
## [code]target[/code] - Node to receive the modifier
## [code]modifier[/code] - DamageModifier to add
func add_modifier(target: Node, modifier: DamageModifier) -> void:
	if not _modifiers.has(target):
		_modifiers[target] = []
	_modifiers[target].append(modifier)

## Remove a specific modifier from a target.
## [code]target[/code] - Node to remove modifier from
## [code]modifier[/code] - Modifier to remove
func remove_modifier(target: Node, modifier: DamageModifier) -> void:
	if _modifiers.has(target):
		_modifiers[target].erase(modifier)

## Remove all modifiers from a target.
## [code]target[/code] - Node to clear modifiers from
func clear_modifiers(target: Node) -> void:
	_modifiers.erase(target)

## Add a shield to a target.
## [code]shield[/code] - Shield to add
func add_shield(shield: Shield) -> void:
	var owner = shield.owner
	if not _shields.has(owner):
		_shields[owner] = []
	_shields[owner].append(shield)

## Remove a specific shield from a target.
## [code]shield[/code] - Shield to remove
func remove_shield(shield: Shield) -> void:
	var owner = shield.owner
	if _shields.has(owner):
		_shields[owner].erase(shield)

## Get all shields on a target.
## [code]target[/code] - Node to get shields from
func get_shields(target: Node) -> Array[Shield]:
	if _shields.has(target):
		return _shields[target].duplicate()
	return []

## Get total shield amount on a target.
## [code]target[/code] - Node to calculate total shield
func get_total_shield(target: Node) -> int:
	var total = 0
	var shields = get_shields(target)
	for shield in shields:
		if not shield.is_expired(current_turn):
			total += shield.current_shield
	return total

## Advance to the next turn, handling shield expiration.
func advance_turn() -> void:
	current_turn += 1
	_clean_expired_shields()

## Get current turn number.
func get_current_turn() -> int:
	return current_turn

## Reset the damage engine state.
func reset() -> void:
	_modifiers.clear()
	_shields.clear()
	current_turn = 0

## ============================================================
## INTERNAL METHODS
## ============================================================

func _apply_source_modifiers(damage: float, damage_type: DamageType, source: Node) -> float:
	## Future: Apply source-specific bonuses from cards/abilities
	return damage

func _apply_target_modifiers(
	damage: float,
	damage_type: DamageType,
	target: Node,
	result: DamageResult
) -> float:
	if not _modifiers.has(target):
		return damage
	
	var modified_damage = damage
	var modifiers: Array[DamageModifier] = _modifiers[target]
	
	## Sort by priority (higher first)
	modifiers.sort_custom(func(a, b): return a.priority > b.priority)
	
	for mod: DamageModifier in modifiers:
		## Check if modifier applies to this damage type
		if not mod.damage_types.is_empty() and damage_type not in mod.damage_types:
			continue
		
		var old_damage = modified_damage
		
		match mod.modifier_type:
			DamageModifier.ModifierType.FLAT:
				if mod.is_percentage:
					modified_damage *= mod.value
				else:
					modified_damage += mod.value
			
			DamageModifier.ModifierType.MULTIPLIER:
				modified_damage *= mod.value
			
			DamageModifier.ModifierType.RESISTANCE:
				## Reduce damage by percentage
				modified_damage *= (1.0 - mod.value)
			
			DamageModifier.ModifierType.AMPLIFICATION:
				## Increase damage by percentage
				modified_damage *= (1.0 + mod.value)
			
			DamageModifier.ModifierType.TYPE_SPECIFIC:
				modified_damage *= mod.value
		
		result.modifiers_applied.append(mod)
	
	return modified_damage

func _apply_type_effectiveness(damage: float, damage_type: DamageType, target: Node) -> float:
	## Future: Add elemental weakness/resistance system
	## For now, returns damage unchanged
	return damage

func _get_critical_chance(source: Node, target: Node) -> float:
	## Future: Add crit chance modifiers from cards/abilities
	var chance = base_critical_chance
	if source.has_method("get_critical_chance"):
		chance += source.get_critical_chance()
	return clampf(chance, 0.0, 1.0)

func _apply_card_effects(
	damage: float,
	damage_type: DamageType,
	source: Node,
	target: Node,
	result: DamageResult
) -> float:
	## Integration point for card-specific damage modifiers
	## Future: Hook into card system to apply card effects
	
	## Example of how this would work:
	## if source.has_method("get_active_card_effects"):
	##     var effects = source.get_active_card_effects()
	##     for effect in effects:
	##         damage = effect.apply_damage_modifier(damage, damage_type, target)
	
	return damage

func _is_valid_target(target: Node) -> bool:
	return is_instance_valid(target) and target.has_method("take_damage")

func _apply_hp_reduction(target: Node, damage: int) -> void:
	if target.has_method("take_damage"):
		target.take_damage(damage)

func _clean_expired_shields() -> void:
	for owner in _shields.keys():
		var shields: Array[Shield] = _shields[owner]
		shields = shields.filter(func(s): return not s.is_expired(current_turn))
		_shields[owner] = shields

## ============================================================
## CONVENIENCE METHODS FOR COMMON OPERATIONS
## ============================================================

## Quick helper to deal damage with defaults.
## [code]base_damage[/code] - Raw damage value
## [code]target[/code] - Node to damage
## [code]source_node[/code] - Node dealing damage (optional, for tracking)
func deal_damage(base_damage: int, target: Node, source_node: Node = null, damage_type: DamageType = DamageType.PHYSICAL) -> DamageResult:
	var calculated = calculate_base_damage(base_damage, damage_type, source_node if source_node else self)
	var result = calculate_final_damage(calculated, damage_type, source_node if source_node else self, target)
	apply_damage(result, target)
	return result

## Create a shield on a target.
## [code]target[/code] - Node to add shield to
## [code]shield_amount[/code] - Max shield value
## [code]types[/code] - Damage types shield applies to (empty = all)
## [code]turns[/code] - Number of turns until expiration (-1 = never)
func create_shield(
	target: Node,
	shield_amount: int,
	types: Array[DamageType] = [],
	turns: int = -1
) -> Shield:
	var expires = -1 if turns < 0 else current_turn + turns
	var shield = Shield.new(target, shield_amount, types, expires)
	add_shield(shield)
	return shield
