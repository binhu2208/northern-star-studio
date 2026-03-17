## Ember Character Class (Fire)
## 
## Fire character with Heat mechanics and phase progression.
## Phases: Ignition → Blaze → Scorched Earth → Smoldering → Controlled Burn → Ember

class_name EmberCharacter
extends Character

## Fire-specific enums
enum FirePhase {
	IGNITION,        ## Phase 1: Building heat
	BLAZE,           ## Phase 2: Full power
	SCORCHED_EARTH,  ## Phase 3: Overwhelming force
	SMOLDERING,      ## Phase 4: Low heat, recovery
	CONTROLLED_BURN, ## Phase 5: Efficient power
	EMBER            ## Phase 6: Final form
}

enum HeatStatus {
	NORMAL,    ## No heat bonus
	WARM,      ## 10% fire damage bonus
	HOT,       ## 20% fire damage bonus
	INCINERATING ## 30% fire damage bonus + burn effects
}

## Fire Phase progression
var current_fire_phase: FirePhase = FirePhase.IGNITION
var heat_level: int = 0  ## 0-100
var burn_damage: int = 0  ## Damage per turn from burns
var burn_turns: int = 0  ## Turns remaining for burn

## Fire-specific modifiers
var heat_bonus_damage: float = 0.0  ## Percentage bonus from heat
var burn_applies_on_hit: bool = true

## Phase thresholds
const HEAT_THRESHOLD_WARM = 25
const HEAT_THRESHOLD_HOT = 50
const HEAT_THRESHOLD_INCINERATING = 75
const MAX_HEAT = 100

## Phase progression thresholds
const PHASE_HEAT_THRESHOLDS: Dictionary = {
	FirePhase.IGNITION: 0,
	FirePhase.BLAZE: 30,
	FirePhase.SCORCHED_EARTH: 55,
	FirePhase.SMOLDERING: 40,     ## Drops from Scorched Earth
	FirePhase.CONTROLLED_BURN: 20,  ## Drops from Smoldering
	FirePhase.EMBER: 10             ## Final phase, low heat
}

## Signals
signal heat_changed(old_heat: int, new_heat: int)
signal phase_changed(from_phase: FirePhase, to_phase: FirePhase)
signal burn_applied(target: Node, damage: int, turns: int)
signal burn_damage_dealt(target: Node, damage: int)

func _init() -> void:
	character_id = "ember"
	character_name = "Ember"
	emotion_type = Card.EmotionType.ANGER  ## Fire aligns with Anger
	max_hp = 100
	max_energy = 3

## Get current heat level
func get_heat() -> int:
	return heat_level

## Get heat status for UI
func get_heat_status() -> HeatStatus:
	if heat_level >= HEAT_THRESHOLD_INCINERATING:
		return HeatStatus.INCINERATING
	elif heat_level >= HEAT_THRESHOLD_HOT:
		return HeatStatus.HOT
	elif heat_level >= HEAT_THRESHOLD_WARM:
		return HeatStatus.WARM
	return HeatStatus.NORMAL

## Get heat damage bonus percentage
func get_heat_damage_bonus() -> float:
	match get_heat_status():
		HeatStatus.INCINERATING:
			return 0.30
		HeatStatus.HOT:
			return 0.20
		HeatStatus.WARM:
			return 0.10
	return 0.0

## Add heat
func add_heat(amount: int) -> void:
	var old_heat = heat_level
	heat_level = mini(heat_level + amount, MAX_HEAT)
	heat_changed.emit(old_heat, heat_level)
	_update_fire_phase()

## Remove heat
func remove_heat(amount: int) -> void:
	var old_heat = heat_level
	heat_level = maxi(heat_level - amount, 0)
	heat_changed.emit(old_heat, heat_level)
	_update_fire_phase()

## Set heat directly
func set_heat(amount: int) -> void:
	var old_heat = heat_level
	heat_level = clampi(amount, 0, MAX_HEAT)
	heat_changed.emit(old_heat, heat_level)
	_update_fire_phase()

## Update fire phase based on heat level
func _update_fire_phase() -> void:
	var old_phase = current_fire_phase
	
	## Determine new phase based on heat
	var new_phase: FirePhase
	
	if heat_level >= PHASE_HEAT_THRESHOLDS[FirePhase.SCORCHED_EARTH]:
		new_phase = FirePhase.SCORCHED_EARTH
	elif heat_level >= PHASE_HEAT_THRESHOLDS[FirePhase.BLAZE]:
		new_phase = FirePhase.BLAZE
	elif heat_level >= PHASE_HEAT_THRESHOLDS[FirePhase.CONTROLLED_BURN]:
		new_phase = FirePhase.CONTROLLED_BURN
	elif heat_level >= PHASE_HEAT_THRESHOLDS[FirePhase.SMOLDERING]:
		new_phase = FirePhase.SMOLDERING
	else:
		new_phase = FirePhase.IGNITION
	
	## Special case: Ember is the final form
	if heat_level <= PHASE_HEAT_THRESHOLDS[FirePhase.EMBER] and heat_level > 0:
		new_phase = FirePhase.EMBER
	
	if new_phase != old_phase:
		current_fire_phase = new_phase
		phase_changed.emit(old_phase, new_phase)

## Get current fire phase
func get_fire_phase() -> FirePhase:
	return current_fire_phase

## Get phase name for UI
func get_phase_name() -> String:
	return FirePhase.keys()[current_fire_phase]

## Apply burn to target
## Note: This is called on the target, so target needs to handle burn
func apply_burn_to_target(target: Node, damage: int, turns: int) -> void:
	if target.has_method("apply_status"):
		target.apply_status("burn", turns)
		burn_applied.emit(target, damage, turns)

## Deal burn damage (call this at start of turn for affected targets)
func deal_burn_damage(target: Node) -> void:
	if target.has_method("get_status_turns") and target.get_status_turns("burn") > 0:
		var damage = get_burn_damage()
		if target.has_method("take_damage"):
			target.take_damage(damage)
			burn_damage_dealt.emit(target, damage)

## Get current burn damage per turn
func get_burn_damage() -> int:
	return burn_damage

## Set burn damage
func set_burn_damage(damage: int) -> void:
	burn_damage = damage

## Calculate fire damage with heat bonus
func calculate_fire_damage(base_damage: int) -> int:
	var bonus = get_heat_damage_bonus()
	return int(base_damage * (1.0 + bonus))

## Override on_turn_start for fire-specific behavior
override func on_turn_start() -> void:
	super.on_turn_start()
	## Fire characters gain heat at turn start
	add_heat(5)
	## Clear defending state at start of turn
	set_defending(false)

## Override on_turn_end for fire-specific behavior
override func on_turn_end() -> void:
	super.on_turn_end()
	## At end of turn, lose some heat if not in Scorched Earth
	if current_fire_phase != FirePhase.SCORCHED_EARTH:
		remove_heat(3)

## Override reset_combat
override func reset_combat() -> void:
	super.reset_combat()
	heat_level = 0
	burn_damage = 0
	burn_turns = 0
	current_fire_phase = FirePhase.IGNITION

## Get phase-specific bonuses
func get_phase_bonus() -> Dictionary:
	var bonus: Dictionary = {
		"damage_mult": 1.0,
		"energy_discount": 0,
		"special_ability": ""
	}
	
	match current_fire_phase:
		FirePhase.IGNITION:
			bonus.damage_mult = 1.0
			bonus.special_ability = "ignition_boost"
		FirePhase.BLAZE:
			bonus.damage_mult = 1.2
			bonus.special_ability = "blaze_boost"
		FirePhase.SCORCHED_EARTH:
			bonus.damage_mult = 1.5
			bonus.special_ability = "scorched_earth"
		FirePhase.SMOLDERING:
			bonus.damage_mult = 0.9
			bonus.special_ability = "smoldering_recovery"
		FirePhase.CONTROLLED_BURN:
			bonus.damage_mult = 1.1
			bonus.energy_discount = 1
			bonus.special_ability = "controlled_efficiency"
		FirePhase.EMBER:
			bonus.damage_mult = 1.3
			bonus.special_ability = "ember_final"
	
	return bonus
