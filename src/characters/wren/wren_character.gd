## Wren Character Class
##
## Wren represents Grief & Memory from the Shadow emotion family.
## Her arc progresses through 6 phases: Denial → Weight → Haunting → Bargaining → Shadows → Wren
##
## Special Mechanics:
## - Memory Tokens: Persistent tokens that represent memories Wren has collected
## - Grief Effects: Cards that gain power based on memory tokens and emotional state
## - Phase Progression: Cards unlock as Wren progresses through her emotional journey

class_name WrenCharacter
extends Character

## Character constants
const CHARACTER_ID := "wren"
const CHARACTER_NAME := "Wren"

## Phase enumeration - emotional journey stages
enum Phase {
	DENIAL,     ## Pretending nothing changed (Cards 1-4)
	WEIGHT,     ## The heaviness of absence (Cards 5-10)
	HAUNTING,   ## Memories that won't let go (Cards 11-15)
	BARGAINING, ## "If I just tried harder..." (Cards 16-18)
	SHADOWS,    ## Accepting the loss exists (Card 19)
	WREN        ## Carrying memory forward (Card 20)
}

## Shadow-specific damage type
enum ShadowEffect {
	NONE,
	MEMORY_STRIKE,  ## Damage based on cards played
	PHANTOM_PAIN,   ## Delayed damage
	ECHO,           ## Repeat previous effect
	LEGACY          ## Power from memory tokens
}

## Current phase in emotional journey
var current_phase: Phase = Phase.DENIAL
var phase_index: int = 0

## Memory tokens - persist across encounters
var memory_tokens: int = 0
var max_memory_tokens: int = 10

## Grief counter - tracks cumulative grief for certain cards
var grief_counter: int = 0

## Cards played this combat - for Memory Strike calculations
var cards_played_this_combat: int = 0

## Track previous card effect for Echo mechanic
var last_card_effect: Dictionary = {}

## Phase progression thresholds (cards needed to advance)
var phase_thresholds: Array[int] = [4, 10, 15, 18, 19, 20]

func _init() -> void:
	character_id = CHARACTER_ID
	character_name = CHARACTER_NAME
	description = "Someone who lost someone dear — not through death, but through change."
	max_health = 90  # Slightly lower HP, more complex mechanics
	current_health = max_health
	emotional_capacity = 3
	max_energy = 3
	attack_power = 8
	defense_power = 8
	speed = 7
	current_phase = Phase.DENIAL
	phase_index = 0

## Get current phase name
func get_phase_name() -> String:
	return Phase.keys()[current_phase]

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
	if phase_index < Phase.size() - 1:
		phase_index += 1
		current_phase = phase_index
		phase_changed.emit(current_phase)

## Signal for phase changes
signal phase_changed(new_phase: Phase)

## Add memory token
func add_memory_token(amount: int = 1) -> void:
	memory_tokens = mini(memory_tokens + amount, max_memory_tokens)

## Remove memory token
func remove_memory_token(amount: int = 1) -> void:
	memory_tokens = maxi(memory_tokens - amount, 0)

## Get memory token count
func get_memory_tokens() -> int:
	return memory_tokens

## Add grief (accumulates through combat)
func add_grief(amount: int = 1) -> void:
	grief_counter += amount

## Get grief amount
func get_grief() -> int:
	return grief_counter

## Reset grief at end of combat
func reset_grief() -> void:
	grief_counter = 0
	cards_played_this_combat = 0

## Record card played (for tracking and effects)
func record_card_played(card: Card) -> void:
	cards_played_this_combat += 1
	last_card_effect = {
		"card_id": card.id if card else "",
		"card_type": card.card_type if card else Card.CardType.ATTACK,
		"value": card.value if card else 0,
		"emotion": card.emotion_type if card else Card.EmotionType.SADNESS
	}
	check_phase_advance()

## Get last card effect (for Echo mechanic)
func get_last_card_effect() -> Dictionary:
	return last_card_effect

## Calculate memory-based damage
## Base damage + bonus based on memory tokens
func get_memory_damage(base_damage: int) -> int:
	return base_damage + (memory_tokens * 2)

## Calculate grief-based damage
## Base damage + bonus based on grief counter
func get_grief_damage(base_damage: int) -> int:
	return base_damage + mini(grief_counter, 10)  # Cap at 10 bonus

## Check if can play card from specific phase
func can_access_phase(phase: Phase) -> bool:
	return phase_index >= phase

## Override turn start
override func _on_turn_start() -> void:
	super._on_turn_start()
	# Wren gains memory token on turn start in later phases
	if current_phase >= Phase.HAUNTING:
		add_memory_token(1)

## Override turn end
override func _on_turn_end() -> void:
	super._on_turn_end()
	update_status_effects()
	# Grief accumulates each turn
	if current_phase >= Phase.WEIGHT:
		add_grief(1)

## Get phase description for UI
func get_phase_description() -> String:
	match current_phase:
		Phase.DENIAL:
			return "Pretending nothing changed"
		Phase.WEIGHT:
			return "The heaviness of absence"
		Phase.HAUNTING:
			return "Memories that won't let go"
		Phase.BARGAINING:
			return "\"If I just tried harder...\""
		Phase.SHADOWS:
			return "Accepting the loss exists"
		Phase.WREN:
			return "Carrying memory forward"
		_:
			return ""

## Special ability: Recall Memory
## Convert memory tokens to healing
func recall_memory(tokens_to_use: int) -> int:
	var actual_tokens = mini(tokens_to_use, memory_tokens)
	remove_memory_token(actual_tokens)
	heal(actual_tokens * 3)  # 3 HP per memory token
	return actual_tokens

## Special ability: Embrace Grief
## Convert grief to power (temporary buff)
func embrace_grief() -> int:
	var grief_used = mini(grief_counter, 5)
	var power_boost = grief_used * 2
	attack_power += power_boost
	return power_boost

## Reset after combat
func reset_combat() -> void:
	reset_grief()
	attack_power = 8
	defense_power = 8

## Get available cards based on current phase
## Returns indices of cards that can be played
func get_available_card_indices() -> Array[int]:
	var available: Array[int] = []
	match current_phase:
		Phase.DENIAL:
			# Cards 1-4
			for i in range(4):
				available.append(i)
		Phase.WEIGHT:
			# Cards 1-10
			for i in range(10):
				available.append(i)
		Phase.HAUNTING:
			# Cards 1-15
			for i in range(15):
				available.append(i)
		Phase.BARGAINING:
			# Cards 1-18
			for i in range(18):
				available.append(i)
		Phase.SHADOWS:
			# Cards 1-19
			for i in range(19):
				available.append(i)
		Phase.WREN:
			# All cards
			for i in range(20):
				available.append(i)
	return available

func get_persistent_progression_state() -> Dictionary:
	var state = super.get_persistent_progression_state()
	state["memory_tokens"] = memory_tokens
	state["phase_index"] = phase_index
	state["current_phase"] = int(current_phase)
	return state

func apply_persistent_progression_state(state: Dictionary) -> void:
	super.apply_persistent_progression_state(state)
	memory_tokens = clampi(int(state.get("memory_tokens", memory_tokens)), 0, max_memory_tokens)
	phase_index = clampi(int(state.get("phase_index", phase_index)), 0, Phase.size() - 1)
	current_phase = int(state.get("current_phase", phase_index))

func get_run_progression_state() -> Dictionary:
	var state = super.get_run_progression_state()
	state["memory_tokens"] = memory_tokens
	state["grief_counter"] = grief_counter
	state["cards_played_this_combat"] = cards_played_this_combat
	state["phase_index"] = phase_index
	state["current_phase"] = int(current_phase)
	state["last_card_effect"] = last_card_effect.duplicate(true)
	return state

func apply_run_progression_state(state: Dictionary) -> void:
	super.apply_run_progression_state(state)
	memory_tokens = clampi(int(state.get("memory_tokens", memory_tokens)), 0, max_memory_tokens)
	grief_counter = max(int(state.get("grief_counter", grief_counter)), 0)
	cards_played_this_combat = max(int(state.get("cards_played_this_combat", cards_played_this_combat)), 0)
	phase_index = clampi(int(state.get("phase_index", phase_index)), 0, Phase.size() - 1)
	current_phase = int(state.get("current_phase", phase_index))
	last_card_effect = state.get("last_card_effect", {}).duplicate(true)
