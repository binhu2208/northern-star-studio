## Maya's Card Data - All Emotion Cards for the Warmth path character.
## Cards are organized by emotion family and unlock progression.
## Reference: DES-001B Character Arc Design

class_name MayaCards
extends RefCounted

## Card definitions organized by family and unlock status

## ============================================================
## SHADOW FAMILY CARDS (Starting - Always Available)
## ============================================================

static func get_shadow_cards() -> Array[Card]:
	var cards: Array[Card] = []
	
	## Unfair Burden - Basic Shadow attack
	cards.append(_create_card(
		"unfair_burden", 
		"Unfair Burden", 
		"Carry the weight of what should have been shared.\n\nDeal 2 emotional damage.",
		Card.CardType.EMOTION,
		Card.EmotionType.SADNESS,
		2,  ## cost
		3   ## value
	))
	
	## What He Said - Grief (replaying argument)
	cards.append(_create_card(
		"what_he_said",
		"What He Said",
		"The words echo in your mind, over and over.\n\nDeal 4 emotional damage.",
		Card.CardType.EMOTION,
		Card.EmotionType.SADNESS,
		2,
		4
	))
	
	## Should Have Been Different - Longing
	cards.append(_create_card(
		"should_have_been_different",
		"Should Have Been Different",
		"Remembering how things used to be.\n\nDraw 1 card. Setup for combos.",
		Card.CardType.EMOTION,
		Card.EmotionType.SADNESS,
		1,
		3
	))
	
	## Empty Studio - Melancholy
	cards.append(_create_card(
		"empty_studio",
		"Empty Studio",
		"The kiln sits cold. The wheel turns no more.\n\nGain 2 shield. Deal 1 damage to yourself.",
		Card.CardType.EMOTION,
		Card.EmotionType.SADNESS,
		1,
		2
	))
	
	## Bitter Memory
	cards.append(_create_card(
		"bitter_memory",
		"Bitter Memory",
		"A flash of the argument. Sharp and clear.\n\nDeal 3 damage. If you have 3+ Shadow cards, deal 2 more.",
		Card.CardType.EMOTION,
		Card.EmotionType.SADNESS,
		2,
		3
	))
	
	## Lost Connection
	cards.append(_create_card(
		"lost_connection",
		"Lost Connection",
		"The phone call that never came. The letter that was never sent.\n\nDeal 2 damage. Draw 1 card.",
		Card.CardType.EMOTION,
		Card.EmotionType.SADNESS,
		2,
		2
	))
	
	return cards

## ============================================================
## FIRE FAMILY CARDS (Unlock through Conflict)
## ============================================================

static func get_fire_cards() -> Array[Card]:
	var cards: Array[Card] = []
	
	## I Was Right - Stubbornness (starting)
	cards.append(_create_card(
		"i_was_right",
		"I Was Right",
		"Certainty in being wronged. A heavy comfort.\n\nDeal 4 fire damage.",
		Card.CardType.EMOTION,
		Card.EmotionType.ANGER,
		2,
		4
	))
	
	## Burning Resentment
	cards.append(_create_card(
		"burning_resentment",
		"Burning Resentment",
		"The anger that keeps you warm at night.\n\nDeal 3 damage. Gain 1 energy.",
		Card.CardType.EMOTION,
		Card.EmotionType.ANGER,
		2,
		3
	))
	
	## Burst of Frustration
	cards.append(_create_card(
		"burst_of_frustration",
		"Burst of Frustration",
		"When you can barely hold it in.\n\nDeal 5 damage. Discard 1 random card.",
		Card.CardType.EMOTION,
		Card.EmotionType.ANGER,
		3,
		5
	))
	
	## Righteous Fire
	cards.append(_create_card(
		"righteous_fire",
		"Righteous Fire",
		"The certainty that you were treated unfairly.\n\nDeal 4 damage. If below 50% health, deal 2 more.",
		Card.CardType.EMOTION,
		Card.EmotionType.ANGER,
		2,
		4
	))
	
	## Burning Certainty - Fire resonance card
	cards.append(_create_card(
		"burning_certainty",
		"Burning Certainty",
		"You know what you know. Nothing will change that.\n\nDeal 6 damage. -10% to all healing received.",
		Card.CardType.EMOTION,
		Card.EmotionType.ANGER,
		3,
		6
	))
	
	return cards

## ============================================================
## WARMTH FAMILY CARDS (Unlock through Vulnerability)
## ============================================================

static func get_warmth_cards() -> Array[Card]:
	var cards: Array[Card] = []
	
	## Grandmother's Hands - Gratitude (starting)
	cards.append(_create_card(
		"grandmothers_hands",
		"Grandmother's Hands",
		"Her hands shaped clay and lives. You carry that legacy.\n\nHeal 5 HP.",
		Card.CardType.EMOTION,
		Card.EmotionType.JOY,
		3,
		5
	))
	
	## Twinge of Hope
	cards.append(_create_card(
		"twinge_of_hope",
		"Twinge of Hope",
		"Maybe things could be different.\n\nHeal 3 HP. Draw 1 card.",
		Card.CardType.EMOTION,
		Card.EmotionType.JOY,
		2,
		3
	))
	
	## Gratitude
	cards.append(_create_card(
		"gratitude",
		"Gratitude",
		"For what was. For what remains.\n\nHeal 4 HP. +1 to all card values this turn.",
		Card.CardType.EMOTION,
		Card.EmotionType.JOY,
		2,
		4
	))
	
	## Warm Embrace
	cards.append(_create_card(
		"warm_embrace",
		"Warm Embrace",
		"The comfort of being understood.\n\nGain 5 shield. Heal 2 HP.",
		Card.CardType.EMOTION,
		Card.EmotionType.LOVE,
		3,
		5
	))
	
	## Family Love - Unlocked through story
	cards.append(_create_card(
		"family_love",
		"Family Love",
		"Blood is thicker than water. Always.\n\nGain 4 shield. All cards cost 1 less this turn.",
		Card.CardType.EMOTION,
		Card.EmotionType.LOVE,
		3,
		4
	))
	
	## Hopeful Heart - Reconciliation ending card
	cards.append(_create_card(
		"hopeful_heart",
		"Hopeful Heart",
		"The door is open. What comes next is up to both of you.\n\nHeal 7 HP. Draw 2 cards.",
		Card.CardType.EMOTION,
		Card.EmotionType.JOY,
		4,
		7
	))
	
	return cards

## ============================================================
## STORM FAMILY CARDS (Anxiety/Doubt)
## ============================================================

static func get_storm_cards() -> Array[Card]:
	var cards: Array[Card] = []
	
	## Uncertain Future
	cards.append(_create_card(
		"uncertain_future",
		"Uncertain Future",
		"What if things get worse? What if they get better?\n\nDeal 2 damage. Draw 1 card.",
		Card.CardType.EMOTION,
		Card.EmotionType.FEAR,
		2,
		2
	))
	
	## Anxiety
	cards.append(_create_card(
		"anxiety",
		"Anxiety",
		"The racing thoughts. The tightness in your chest.\n\nDeal 3 damage. You cannot heal above 50% this turn.",
		Card.CardType.EMOTION,
		Card.EmotionType.FEAR,
		2,
		3
	))
	
	## Doubt
	cards.append(_create_card(
		"doubt",
		"Doubt",
		"Was I wrong? Were they right?\n\nDeal 2 damage. If you have 3+ emotion cards, draw 1.",
		Card.CardType.EMOTION,
		Card.EmotionType.FEAR,
		1,
		2
	))
	
	## Overwhelmed
	cards.append(_create_card(
		"overwhelmed",
		"Overwhelmed",
		"Too much. All at once.\n\nDeal 4 damage to yourself. Deal 6 to opponent.",
		Card.CardType.EMOTION,
		Card.EmotionType.FEAR,
		3,
		6
	))
	
	## Open Question - Balanced path card
	cards.append(_create_card(
		"open_question",
		"Open Question",
		"I don't know the answer. Maybe that's okay.\n\nCan count as any emotion family once per encounter.",
		Card.CardType.EMOTION,
		Card.EmotionType.CONFUSION,
		1,
		0
	))
	
	return cards

## ============================================================
## COMPLEX/SPECIAL CARDS (Story-locked)
## ============================================================

static func get_special_cards() -> Array[Card]:
	var cards: Array[Card] = []
	
	## Conflicting Memory - Unlocked via curiosity path
	cards.append(_create_card(
		"conflicting_memory",
		"Conflicting Memory",
		"Wait... did it happen differently?\n\nTriggered by memory orbs. Enables Complex Emotions.",
		Card.CardType.EMOTION,
		Card.EmotionType.CONFUSION,
		2,
		0
	))
	
	## Unexpected Detail - From memory orbs
	cards.append(_create_card(
		"unexpected_detail",
		"Unexpected Detail",
		"Something you didn't see before.\n\nDraw 2 cards. Reveal a hidden truth.",
		Card.CardType.EMOTION,
		Card.EmotionType.JOY,
		2,
		0
	))
	
	## Gentle Goodbye - Acceptance ending
	cards.append(_create_card(
		"gentle_goodbye",
		"Gentle Goodbye",
		"Some wounds don't heal. They just become scars.\n\nHeal 5. Gain 3 shield. Remove 1 card from deck.",
		Card.CardType.EMOTION,
		Card.EmotionType.SADNESS,
		3,
		5
	))
	
	## Bittersweet Memory - Complex Emotion
	cards.append(_create_card(
		"bittersweet_memory",
		"Bittersweet Memory",
		"Joy and sadness, intertwined.\n\nRequires Joy + Sadness. Heal 3. Deal 2.",
		Card.CardType.EMOTION,
		Card.EmotionType.JOY,
		3,
		3
	))
	
	## Understanding - Complex Emotion
	cards.append(_create_card(
		"understanding",
		"Understanding",
		"When anger meets time, understanding grows.\n\nRequires Anger + Sadness. Deal 4. Draw 2.",
		Card.CardType.EMOTION,
		Card.EmotionType.CONFUSION,
		3,
		4
	))
	
	## Acceptance - Complex Emotion
	cards.append(_create_card(
		"acceptance",
		"Acceptance",
		"Peace comes from letting go.\n\nRequires Joy + Anger. Heal 6. Your max HP increases by 5.",
		Card.CardType.EMOTION,
		Card.EmotionType.JOY,
		4,
		6
	))
	
	return cards

## ============================================================
## UTILITY METHODS
## ============================================================

## Get all starting cards (for initialization)
## Maya starts in Resentment phase with Shadow-dominant deck
## Includes some Fire (conflict) and Warmth (path to healing) cards
static func get_starting_deck() -> Array[Card]:
	var cards: Array[Card] = []
	
	## Add all Shadow cards (6 cards) - the core of Resentment
	cards.append_array(get_shadow_cards())
	
	## Add Fire cards (2 cards) - represents the conflict path
	cards.append(get_fire_cards()[0])  ## I Was Right
	cards.append(get_fire_cards()[1])  ## Burning Resentment
	
	## Add Warmth cards (2 cards) - represents path toward healing
	cards.append(get_warmth_cards()[0])  ## Grandmother's Hands
	cards.append(get_warmth_cards()[1])  ## Twinge of Hope
	
	## Add 5 more Shadow cards (duplicates for deck variety)
	cards.append(get_shadow_cards()[0])  ## Unfair Burden
	cards.append(get_shadow_cards()[0])  ## Unfair Burden
	cards.append(get_shadow_cards()[1])  ## What He Said
	cards.append(get_shadow_cards()[2])  ## Should Have Been Different
	cards.append(get_shadow_cards()[3])  ## Empty Studio
	
	## Total: 6 + 2 + 2 + 5 = 15 cards
	return cards

## Get card by ID
static func get_card_by_id(card_id: String) -> Card:
	var all_cards: Array[Card] = []
	all_cards.append_array(get_shadow_cards())
	all_cards.append_array(get_fire_cards())
	all_cards.append_array(get_warmth_cards())
	all_cards.append_array(get_storm_cards())
	all_cards.append_array(get_special_cards())
	
	for card in all_cards:
		if card.id == card_id:
			return card
	
	return null

## Helper to create cards
static func _create_card(id: String, name: String, desc: String, 
						type: Card.CardType, emotion: Card.EmotionType, 
						cost: int, value: int) -> Card:
	var card = Card.new(id, name, desc)
	card.card_type = type
	card.emotion_type = emotion
	card.cost = cost
	card.value = value
	return card
