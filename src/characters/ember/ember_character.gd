## Ember Character Class (Fire)
##
## Ember represents Anger & Passion from the Fire emotion family.
## His arc progresses through 6 phases: Ignition → Blaze → Scorched Earth → Smoldering → Controlled Burn → Ember
##
## Special Mechanics:
## - Heat: Builds up as Ember plays fire cards, increasing damage
## - Burn Effects: Persistent damage over time applied to enemies
## - Phase Progression: Cards unlock as Ember progresses through his emotional journey

class_name EmberCharacter
extends Character

## Character constants
const CHARACTER_ID := "ember"
const CHARACTER_NAME := "Ember"

## Fire Phase enumeration - emotional journey stages
enum FirePhase {
	IGNITION,        ## Building heat (Cards 1-4)
	BLAZE,           ## Full power (Cards 5-8)
	SCORCHED_EARTH,  ## Overwhelming force (Cards 9-12)
	SMOLDERING,      ## Low heat, recovery (Cards 13-14)
	CONTROLLED_BURN, ## Efficient power (Cards 15-17)
	EMBER            ## Final form (Cards 18-20)
}

## Heat status for UI
enum HeatStatus {
	NORMAL,    ## No heat bonus
	WARM,      ## 10% fire damage bonus
	HOT,       ## 20% fire damage bonus
	INCINERATING ## 30% fire damage bonus + burn effects
}

## Fire-specific damage type
enum FireEffect {
	NONE,
	BURN,         ## Apply burn to target
	AOE_BURN,     ## Area effect with burn
	HEAT_GAIN,    ## Gain heat from card
	HEAT_SCALE,   ## Damage scales with heat
	HEAT_IMMUNE   ## Immune to heat loss
}

## Current phase in emotional journey
var current_fire_phase: FirePhase = FirePhase.IGNITION
var phase_index: int = 0

## Heat system - 0 to 100
var heat_level: int = 0
var max_heat: int = 100
var burn_damage_per_turn: int = 0

## Phase progression thresholds (cards needed to advance)
var phase_thresholds: Array[int] = [4, 8, 12, 14, 17, 20]

## Cards played this combat - for phase progression
var cards_played_this_combat: int = 0

## Track active burn on enemies
var active_burns: Dictionary = {}  ## target_node_id -> {damage, turns}

## Phase change signal
signal phase_changed(new_phase: FirePhase)
signal heat_changed(old_heat: int, new_heat: int)
signal burn_applied(target: Node, damage: int, turns: int)

## Heat thresholds
const HEAT_THRESHOLD_WARM := 25
const HEAT_THRESHOLD_HOT := 50
const HEAT_THRESHOLD_INCINERATING := 75

func _init() -> void:
	character_id = CHARACTER_ID
	character_name = CHARACTER_NAME
	description = "A flame that burns with righteous fury — fire is never neutral."
	max_health = 100
	current_health = max_health
	emotional_capacity = 3
	max_energy = 3
	attack_power = 12
	defense_power = 6
	speed = 9
	current_fire_phase = FirePhase.IGNITION
	phase_index = 0

## Get current phase name
func get_phase_name() -> String:
	return FirePhase.keys()[current_fire_phase]

## Get phase progress (0.0 to 1.0)
func get_phase_progress() -> float:
	if phase_index >= phase_thresholds.size() - 1:
		return 1.0
	var current_threshold = phase_thresholds[phase_index]
	var next_threshold = phase_thresholds[phase_index + 1]
	var progress = float(cards_played_this_combat - current_threshold) / float(next_threshold - current_threshold)
	return clampf(progress, 0.0, 1.0)

## Advance phase if threshold met
func check_phase_advance() -> bool:
	if phase_index < phase_thresholds.size() - 1:
		var next_threshold = phase_thresholds[phase_index + 1]
		if cards_played_this_combat >= next_threshold:
			_phase_advance()
			return true
	return false

## Internal phase advancement
func _phase_advance() -> void:
	if phase_index < FirePhase.size() - 1:
		phase_index += 1
		current_fire_phase = phase_index
		phase_changed.emit(current_fire_phase)

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
	heat_level = mini(heat_level + amount, max_heat)
	heat_changed.emit(old_heat, heat_level)
	_check_phase_advance_on_heat()

## Remove heat
func remove_heat(amount: int) -> void:
	var old_heat = heat_level
	heat_level = maxi(heat_level - amount, 0)
	heat_changed.emit(old_heat, heat_level)

## Set heat directly
func set_heat(amount: int) -> void:
	var old_heat = heat_level
	heat_level = clampi(amount, 0, max_heat)
	heat_changed.emit(old_heat, heat_level)
	_check_phase_advance_on_heat()

## Check for phase advance based on heat
func _check_phase_advance_on_heat() -> void:
	## Phase advances based on cards played, not just heat
	## But certain heat thresholds can provide bonuses
	pass

## Calculate fire damage with heat bonus
func calculate_fire_damage(base_damage: int) -> int:
	var bonus = get_heat_damage_bonus()
	var phase_mult = get_phase_damage_multiplier()
	return int(base_damage * (1.0 + bonus) * phase_mult)

## Get phase-specific damage multiplier
func get_phase_damage_multiplier() -> float:
	match current_fire_phase:
		FirePhase.IGNITION:
			return 1.0
		FirePhase.BLAZE:
			return 1.15
		FirePhase.SCORCHED_EARTH:
			return 1.35
		FirePhase.SMOLDERING:
			return 0.9
		FirePhase.CONTROLLED_BURN:
			return 1.1
		FirePhase.EMBER:
			return 1.25
	return 1.0

## Get phase-specific energy discount
func get_phase_energy_discount() -> int:
	if current_fire_phase == FirePhase.CONTROLLED_BURN and heat_level >= 40:
		return 1
	return 0

## Apply burn to target
func apply_burn(target: Node, damage: int, turns: int) -> void:
	var target_id = target.get_instance_id()
	active_burns[target_id] = {"damage": damage, "turns": turns, "target": target}
	burn_applied.emit(target, damage, turns)
	
	## Apply status to target
	if target.has_method("add_status"):
		target.add_status("burn", turns, damage)

## Process burns at start of turn
func process_burns() -> void:
	var targets_to_remove: Array[int] = []
	
	for target_id in active_burns.keys():
		var burn_data = active_burns[target_id]
		var target = burn_data.get("target")
		var damage = burn_data.get("damage", 0)
		var turns = burn_data.get("turns", 0)
		
		if is_instance_valid(target) and target.has_method("take_damage"):
			target.take_damage(damage)
		
		if turns <= 1:
			targets_to_remove.append(target_id)
		else:
			burn_data["turns"] = turns - 1
	
	for target_id in targets_to_remove:
		active_burns.erase(target_id)

## Clear all burns
func clear_burns() -> void:
	active_burns.clear()

## Get phase bonuses dictionary
func get_phase_bonus() -> Dictionary:
	return {
		"damage_mult": get_phase_damage_multiplier(),
		"energy_discount": get_phase_energy_discount(),
		"special_ability": _get_phase_ability_name()
	}

func _get_phase_ability_name() -> String:
	match current_fire_phase:
		FirePhase.IGNITION:
			return "ignition_boost"
		FirePhase.BLAZE:
			return "blaze_boost"
		FirePhase.SCORCHED_EARTH:
			return "scorched_earth"
		FirePhase.SMOLDERING:
			return "smoldering_recovery"
		FirePhase.CONTROLLED_BURN:
			return "controlled_efficiency"
		FirePhase.EMBER:
			return "ember_final"
	return ""

## Override turn start
override func _on_turn_start() -> void:
	super._on_turn_start()
	## Fire gains heat at turn start
	add_heat(5)

## Override turn end
override func _on_turn_end() -> void:
	super._on_turn_end()
	## Process burns
	process_burns()
	## Lose some heat at end of turn (unless in Scorched Earth)
	if current_fire_phase != FirePhase.SCORCHED_EARTH:
		remove_heat(3)

## Reset for new combat
func reset_combat() -> void:
	super.reset_combat()
	heat_level = 0
	burn_damage_per_turn = 0
	cards_played_this_combat = 0
	current_fire_phase = FirePhase.IGNITION
	phase_index = 0
	active_burns.clear()

## Record card played
func record_card_played() -> void:
	cards_played_this_combat += 1
	check_phase_advance()
