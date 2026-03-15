extends Node2D

@onready var card_manager: CardManager = $CardManager
@onready var hand_display: Control = $HandDisplay

func _ready():
	_setup_test_deck()
	card_manager.draw_cards(5)

func _setup_test_deck():
	var test_cards: Array[Card] = []
	
	for i in range(20):
		var card = Card.new()
		card.id = "card_%d" % i
		card.name = "Card %d" % i
		card.description = "Test card number %d" % i
		card.cost = 1
		card.value = randi() % 10 + 1
		test_cards.append(card)
	
	card_manager.initialize_deck(test_cards)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		card_manager.draw_cards(1)
	elif event.is_action_pressed("ui_cancel"):
		if card_manager.hand.get_hand_size() > 0:
			card_manager.discard_from_hand(0)
