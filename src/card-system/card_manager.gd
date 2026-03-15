class_name CardManager
extends Node

signal deck_shuffled
signal card_drawn(card: Card)
signal hand_full

@export var draw_pile: CardDeck
@export var discard_pile: CardDeck
@export var hand: CardHand

var starting_hand_size: int = 5

func _ready():
	draw_pile = CardDeck.new()
	discard_pile = CardDeck.new()
	hand = CardHand.new()
	add_child(hand)

func initialize_deck(cards: Array[Card]) -> void:
	for card in cards:
		draw_pile.add_card(card)
	draw_pile.shuffle()
	deck_shuffled.emit()

func draw_cards(count: int) -> int:
	var drawn = 0
	for i in range(count):
		if hand.get_hand_size() >= hand.max_hand_size:
			hand_full.emit()
			break
		
		if draw_pile.is_empty():
			_reshuffle_discard()
		
		if draw_pile.is_empty():
			break
		
		var card = draw_pile.draw()
		if card:
			hand.add_card(card)
			card_drawn.emit(card)
			drawn += 1
	
	return drawn

func play_card_from_hand(index: int) -> Card:
	return hand.play_card(index)

func discard_from_hand(index: int) -> Card:
	var card = hand.discard_card(index)
	if card:
		discard_pile.add_card(card)
	return card

func discard_card(card: Card) -> void:
	discard_pile.add_card(card)

func _reshuffle_discard() -> void:
	while not discard_pile.is_empty():
		var card = discard_pile.draw()
		if card:
			draw_pile.add_card(card)
	draw_pile.shuffle()
	deck_shuffled.emit()
