class_name CardManager
extends Node

signal deck_shuffled
signal card_drawn(card: Card)
signal hand_full

@export var draw_pile: CardDeck
@export var discard_pile: CardDeck
@export var hand: CardHand

## Hotfix-friendly knobs for post-launch deck tuning.
@export var feature_toggles: Dictionary = {}
@export var draw_count_overrides: Dictionary = {}

var starting_hand_size: int = 5

func apply_config(config: GameConfig) -> void:
	starting_hand_size = config.starting_hand_size
	feature_toggles = config.feature_toggles.duplicate(true)
	draw_count_overrides = config.card_overrides.duplicate(true)

func is_feature_enabled(feature_name: String, default_value: bool = true) -> bool:
	return bool(feature_toggles.get(feature_name, default_value))

func get_card_override(card_id: String) -> Dictionary:
	var override_value = draw_count_overrides.get(card_id, {})
	if override_value is Dictionary:
		return override_value
	return {}

func _ready():
	draw_pile = CardDeck.new()
	discard_pile = CardDeck.new()
	hand = CardHand.new()
	add_child(hand)

func initialize_deck(cards: Array[Card]) -> void:
	draw_pile.cards.clear()
	discard_pile.cards.clear()
	hand.clear_hand()
	for card in cards:
		draw_pile.add_card(card)
	draw_pile.shuffle()
	deck_shuffled.emit()

func draw_cards(count: int) -> int:
	var drawn = 0
	var requested_count = maxi(0, count)
	var draw_limit = requested_count
	if not is_feature_enabled("card_draw_enabled", true):
		return 0
	for i in range(draw_limit):
		if hand.get_hand_size() >= hand.max_hand_size:
			hand_full.emit()
			break
		
		if draw_pile.is_empty() and is_feature_enabled("discard_reshuffle_enabled", true):
			_reshuffle_discard()
		
		if draw_pile.is_empty():
			break
		
		var card = draw_pile.draw()
		if card:
			var card_override = get_card_override(card.id)
			if bool(card_override.get("skip_draw", false)):
				discard_pile.add_card(card)
				continue
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

func get_progression_state() -> Dictionary:
	return {
		"draw_pile": _serialize_cards(draw_pile.cards),
		"discard_pile": _serialize_cards(discard_pile.cards),
		"hand": _serialize_cards(hand.hand),
		"starting_hand_size": starting_hand_size
	}

func apply_progression_state(state: Dictionary, available_cards: Array[Card]) -> void:
	if state.is_empty():
		return
	var card_lookup := _build_card_lookup(available_cards)
	draw_pile.cards = _deserialize_cards(state.get("draw_pile", []), card_lookup)
	discard_pile.cards = _deserialize_cards(state.get("discard_pile", []), card_lookup)
	hand.hand = _deserialize_cards(state.get("hand", []), card_lookup)
	starting_hand_size = int(state.get("starting_hand_size", starting_hand_size))

func _serialize_cards(cards: Array) -> Array[Dictionary]:
	var payload: Array[Dictionary] = []
	for card in cards:
		if card is Card:
			payload.append({
				"id": card.id,
				"cost": card.cost,
				"value": card.value
			})
	return payload

func _deserialize_cards(payload: Array, lookup: Dictionary) -> Array[Card]:
	var cards: Array[Card] = []
	for entry in payload:
		if entry is Dictionary:
			var card_id = str(entry.get("id", ""))
			var template: Card = lookup.get(card_id)
			if template:
				var restored := Card.new()
				restored.id = template.id
				restored.name = template.name
				restored.description = template.description
				restored.card_type = template.card_type
				restored.emotion_type = template.emotion_type
				restored.art_path = template.art_path
				restored.cost = int(entry.get("cost", template.cost))
				restored.value = int(entry.get("value", template.value))
				cards.append(restored)
	return cards

func _build_card_lookup(cards: Array[Card]) -> Dictionary:
	var lookup := {}
	for card in cards:
		lookup[card.id] = card
	return lookup
