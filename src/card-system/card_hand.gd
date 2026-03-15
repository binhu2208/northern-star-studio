class_name CardHand
extends Node

signal card_played(card: Card)
signal card_discarded(card: Card)

@export var max_hand_size: int = 10
var hand: Array[Card] = []

func _ready():
	hand = []

func add_card(card: Card) -> bool:
	if hand.size() >= max_hand_size:
		return false
	hand.append(card)
	return true

func play_card(index: int) -> Card:
	if index < 0 or index >= hand.size():
		return null
	var card = hand[index]
	hand.remove_at(index)
	card_played.emit(card)
	return card

func discard_card(index: int) -> Card:
	if index < 0 or index >= hand.size():
		return null
	var card = hand[index]
	hand.remove_at(index)
	card_discarded.emit(card)
	return card

func get_card(index: int) -> Card:
	if index < 0 or index >= hand.size():
		return null
	return hand[index]

func get_hand_size() -> int:
	return hand.size()

func clear_hand() -> void:
	hand.clear()
