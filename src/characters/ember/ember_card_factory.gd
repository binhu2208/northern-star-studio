## Ember Character Factory
## 
## Utility class to create Ember card instances from card data.

class_name EmberCardFactory
extends Node

## Create a Card resource from Ember card data
static func create_card(card_info: Dictionary) -> Card:
	var card = Card.new()
	
	card.id = card_info.get("id", "")
	card.name = card_info.get("name", "")
	card.description = card_info.get("description", "")
	card.cost = card_info.get("cost", 1)
	card.value = card_info.get("value", 0)
	card.emotion_type = Card.EmotionType.ANGER  ## Fire = Anger
	
	## Set card type
	var type_str = card_info.get("type", "ATTACK")
	match type_str:
		"ATTACK":
			card.card_type = Card.CardType.ATTACK
		"DEFENSE":
			card.card_type = Card.CardType.DEFENSE
		"SKILL":
			card.card_type = Card.CardType.EMOTION
		_:
			card.card_type = Card.CardType.ATTACK
	
	## Set art path (placeholder for now)
	card.art_path = "res://assets/cards/ember/" + card.id + ".png"
	
	return card

## Create all Ember cards as Card resources
static func create_all_cards() -> Array[Card]:
	var cards: Array[Card] = []
	var card_data = EmberCardData.new()
	
	for card_info in card_data.get_all_cards():
		cards.append(create_card(card_info))
	
	return cards

## Create cards for a specific phase
static func create_phase_cards(phase: int) -> Array[Card]:
	var cards: Array[Card] = []
	var card_data = EmberCardData.new()
	
	for card_info in card_data.get_cards_by_phase(phase):
		cards.append(create_card(card_info))
	
	return cards

## Get deck configuration for Ember
## Returns array of card IDs that make up the Ember deck
static func get_deck_configuration() -> Array[String]:
	var deck_ids: Array[String] = []
	var card_data = EmberCardData.new()
	
	## Add cards from all phases
	## Phase 1: 4 cards (2 copies each = 8)
	var phase1 = card_data.get_cards_by_phase(1)
	for i in range(2):
		for card_info in phase1:
			deck_ids.append(card_info["id"])
	
	## Phase 2: 4 cards (2 copies each = 8)
	var phase2 = card_data.get_cards_by_phase(2)
	for i in range(2):
		for card_info in phase2:
			deck_ids.append(card_info["id"])
	
	## Phase 3: 4 cards (2 copies each = 8)
	var phase3 = card_data.get_cards_by_phase(3)
	for i in range(2):
		for card_info in phase3:
			deck_ids.append(card_info["id"])
	
	## Phase 4: 2 cards (2 copies each = 4)
	var phase4 = card_data.get_cards_by_phase(4)
	for i in range(2):
		for card_info in phase4:
			deck_ids.append(card_info["id"])
	
	## Phase 5: 3 cards (2 copies each = 6)
	var phase5 = card_data.get_cards_by_phase(5)
	for i in range(2):
		for card_info in phase5:
			deck_ids.append(card_info["id"])
	
	## Phase 6: 3 cards (2 copies each = 6)
	var phase6 = card_data.get_cards_by_phase(6)
	for i in range(2):
		for card_info in phase6:
			deck_ids.append(card_info["id"])
	
	return deck_ids
	## Total: 8 + 8 + 8 + 4 + 6 + 6 = 40 cards in deck
