class_name CardDeck
extends Resource

@export var cards: Array[Card] = []

func _init():
	cards = []

func add_card(card: Card) -> void:
	cards.append(card)

func remove_card(card: Card) -> void:
	cards.erase(card)

func shuffle() -> void:
	cards.shuffle()

func draw() -> Card:
	if cards.is_empty():
		return null
	return cards.pop_front()

func is_empty() -> bool:
	return cards.is_empty()

func size() -> int:
	return cards.size()
