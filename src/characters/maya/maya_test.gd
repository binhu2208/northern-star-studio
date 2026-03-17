## Maya Character Module
## Test scene for Maya character implementation

extends Node

var maya: MayaCharacter
var damage_engine: DamageEngine
var turn_system: TurnSystem
var maya_phase_system: MayaPhaseSystem
var maya_card_effects: MayaCardEffects

func _ready() -> void:
	_setup_test()

func _setup_test() -> void:
	print("=== Maya Character Test ===")
	
	## Create damage engine
	damage_engine = DamageEngine.new()
	add_child(damage_engine)
	
	## Create turn system
	turn_system = TurnSystem.new()
	add_child(turn_system)
	
	## Create Maya
	maya = MayaCharacter.new()
	add_child(maya)
	maya.initialize_maya()
	
	## Create phase system
	maya_phase_system = MayaPhaseSystem.new()
	add_child(maya_phase_system)
	maya_phase_system.initialize(maya, turn_system)
	
	## Create card effects handler
	maya_card_effects = MayaCardEffects.new()
	add_child(maya_card_effects)
	maya_card_effects.initialize(maya, damage_engine, turn_system)
	
	## Test starting state
	_test_starting_state()
	
	## Test drawing cards
	_test_drawing_cards()
	
	## Test phase progression
	_test_phase_progression()
	
	## Test card effects
	_test_card_effects()
	
	print("=== All Tests Complete ===")

func _test_starting_state() -> void:
	print("\n--- Testing Starting State ---")
	
	assert(maya.character_id == "maya_chen", "Character ID should match")
	assert(maya.character_name == "Maya Chen", "Character name should match")
	assert(maya.current_health == 80, "Starting health should be 80")
	assert(maya.max_health == 80, "Max health should be 80")
	assert(maya.emotional_capacity == 3, "Starting capacity should be 3")
	
	## Check starting deck size (15 cards)
	assert(maya.deck.size() == 15, "Starting deck should have 15 cards")
	
	## Check emotional state
	assert(maya.current_emotional_state == MayaCharacter.EmotionalState.RESENTMENT, "Initial state should be RESENTMENT")
	
	print("Starting state tests PASSED")

func _test_drawing_cards() -> void:
	print("\n--- Testing Card Drawing ---")
	
	## Draw initial hand
	var drawn = maya.draw_cards(5)
	assert(drawn.size() == 5, "Should draw 5 cards")
	assert(maya.hand.size() == 5, "Hand should have 5 cards")
	
	print("Drew %d cards" % drawn.size())
	print("Card drawing tests PASSED")

func _test_phase_progression() -> void:
	print("\n--- Testing Phase Progression ---")
	
	## Start game
	maya_phase_system.start_game()
	assert(maya_phase_system.get_phase_name() == "ENCOUNTER", "Should start in ENCOUNTER phase")
	
	## Process a choice
	var result = maya_phase_system.process_choice("curiosity_path", {})
	assert(result["state_change"] == true, "Choice should trigger state change")
	assert("conflicting_memory" in result["cards_added"], "Should add conflicting_memory card")
	
	print("Phase progression tests PASSED")

func _test_card_effects() -> void:
	print("\n--- Testing Card Effects ---")
	
	## Get a card from deck
	var card = null
	if not maya.hand.is_empty():
		card = maya.hand[0]
	
	if card:
		print("Testing card: %s" % card.name)
		
		## Create a dummy target for damage
		var target = Node.new()
		target.set_meta("health", 100)
		target.set_meta("max_health", 100)
		target.take_damage = func(amount: int): 
			target.set_meta("health", target.get_meta("health") - amount)
		add_child(target)
		
		## Execute card effect
		var result = maya_card_effects.execute_card_effect(card, target)
		print("Card effect result: %s" % str(result))
		
		target.queue_free()
	
	print("Card effects tests PASSED")

## Helper to assert conditions
func assert(condition: bool, message: String) -> void:
	if not condition:
		print("ASSERTION FAILED: " + message)
		push_error(message)
	else:
		print("  ✓ " + message)
