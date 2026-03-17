## Wren Card Data
##
## Contains all 20 cards for Wren's deck across 6 phases.
## Each card represents a moment in her grief journey.

class_name WrenCardData
extends RefCounted

## Card ID prefix
const CARD_PREFIX := "wren_"

## Phase mapping for each card (1-indexed for ease)
## Phase 1: Denial (Cards 1-4)
## Phase 2: Weight (Cards 5-10)
## Phase 3: Haunting (Cards 11-15)
## Phase 4: Bargaining (Cards 16-18)
## Phase 5: Shadows (Card 19)
## Phase 6: Wren (Card 20)

## Create all Wren cards
static func create_all_cards() -> Array[Card]:
	var cards: Array[Card] = []
	
	# ============================================================
	# DENIAL PHASE (Cards 1-4)
	# "Pretending nothing changed"
	# ============================================================
	
	# Card 1: Pretend - Ignore damage for a turn
	var pretend = Card.new()
	pretend.id = CARD_PREFIX + "pretend"
	pretend.name = "Pretend"
	pretend.description = "Ignore all damage this turn. The pain isn't real if you don't acknowledge it."
	pretend.card_type = Card.CardType.DEFENSE
	pretend.emotion_type = Card.EmotionType.SADNESS
	pretend.cost = 2
	pretend.value = 8  # Block amount
	cards.append(pretend)
	
	# Card 2: Everything's Fine - Heal, but delay the cost
	var everything_fine = Card.new()
	everything_fine.id = CARD_PREFIX + "everythings_fine"
	everything_fine.name = "Everything's Fine"
	everything_fine.description = "Heal 5 HP. Take 3 damage at end of next turn."
	everything_fine.card_type = Card.CardType.EMOTION
	everything_fine.emotion_type = Card.EmotionType.SADNESS
	everything_fine.cost = 1
	everything_fine.value = 5
	cards.append(everything_fine)
	
	# Card 3: Photo Album - Draw cards, but gain no benefit yet
	var photo_album = Card.new()
	photo_album.id = CARD_PREFIX + "photo_album"
	photo_album.name = "Photo Album"
	photo_album.description = "Draw 2 cards. Memories gathered now, meaning discovered later."
	photo_album.card_type = Card.CardType.EMOTION
	photo_album.emotion_type = Card.EmotionType.LOVE
	photo_album.cost = 1
	photo_album.value = 2
	cards.append(photo_album)
	
	# Card 4: Ghost - Summon a memory (pet token) that fades
	var ghost = Card.new()
	ghost.id = CARD_PREFIX + "ghost"
	ghost.name = "Ghost"
	ghost.description = "Create a Memory Token. It fades at end of combat."
	ghost.card_type = Card.CardType.EMOTION
	ghost.emotion_type = Card.EmotionType.SADNESS
	ghost.cost = 2
	ghost.value = 1  # Memory token
	cards.append(ghost)
	
	# ============================================================
	# WEIGHT PHASE (Cards 5-10)
	# "The heaviness of absence"
	# ============================================================
	
	# Card 5: Heavy Heart - Gain defense, but lose speed
	var heavy_heart = Card.new()
	heavy_heart.id = CARD_PREFIX + "heavy_heart"
	heavy_heart.name = "Heavy Heart"
	heavy_heart.description = "Gain 6 defense. Lose 2 speed until next turn."
	heavy_heart.card_type = Card.CardType.DEFENSE
	heavy_heart.emotion_type = Card.EmotionType.SADNESS
	heavy_heart.cost = 2
	heavy_heart.value = 6
	cards.append(heavy_heart)
	
	# Card 6: Anchor - Prevent movement, protect what's precious
	var anchor = Card.new()
	anchor.id = CARD_PREFIX + "anchor"
	anchor.name = "Anchor"
	anchor.description = "Gain 5 defense. If you have Memory Tokens, gain +3 more."
	anchor.card_type = Card.CardType.DEFENSE
	anchor.emotion_type = Card.EmotionType.SADNESS
	anchor.cost = 2
	anchor.value = 5
	cards.append(anchor)
	
	# Card 7: Sinking - Take damage to remove debuffs
	var sinking = Card.new()
	sinking.id = CARD_PREFIX + "sinking"
	sinking.name = "Sinking"
	sinking.description = "Take 4 damage. Remove 1 debuff."
	sinking.card_type = Card.CardType.EMOTION
	sinking.emotion_type = Card.EmotionType.FEAR
	sinking.cost = 1
	sinking.value = 4
	cards.append(sinking)
	
	# Card 8: Gravity - Pull everything down
	var gravity = Card.new()
	gravity.id = CARD_PREFIX + "gravity"
	gravity.name = "Gravity"
	gravity.description = "Deal 4 damage to target. Both take 2 damage."
	gravity.card_type = Card.CardType.ATTACK
	gravity.emotion_type = Card.EmotionType.SADNESS
	gravity.cost = 2
	gravity.value = 4
	cards.append(gravity)
	
	# Card 9: Burden - Trade HP for card advantage
	var burden = Card.new()
	burden.id = CARD_PREFIX + "burden"
	burden.name = "Burden"
	burden.description = "Take 3 damage. Draw 2 cards."
	burden.card_type = Card.CardType.EMOTION
	burden.emotion_type = Card.EmotionType.SADNESS
	burden.cost = 1
	burden.value = 3
	cards.append(burden)
	
	# Card 10: Stone - Become immovable, but slow
	var stone = Card.new()
	stone.id = CARD_PREFIX + "stone"
	stone.name = "Stone"
	stone.description = "Gain 10 defense. Skip your next turn's draw phase."
	stone.card_type = Card.CardType.DEFENSE
	stone.emotion_type = Card.EmotionType.SADNESS
	stone.cost = 3
	stone.value = 10
	cards.append(stone)
	
	# ============================================================
	# HAUNTING PHASE (Cards 11-15)
	# "Memories that won't let go"
	# ============================================================
	
	# Card 11: Memory Strike - Damage based on cards played this fight
	var memory_strike = Card.new()
	memory_strike.id = CARD_PREFIX + "memory_strike"
	memory_strike.name = "Memory Strike"
	memory_strike.description = "Deal 3 damage. +2 damage for each card played this combat."
	memory_strike.card_type = Card.CardType.ATTACK
	memory_strike.emotion_type = Card.EmotionType.SADNESS
	memory_strike.cost = 2
	memory_strike.value = 3
	cards.append(memory_strike)
	
	# Card 12: Echo - Repeat the previous card effect
	var echo = Card.new()
	echo.id = CARD_PREFIX + "echo"
	echo.name = "Echo"
	echo.description = "Repeat the effect of the last card played."
	echo.card_type = Card.CardType.EMOTION
	echo.emotion_type = Card.EmotionType.CONFUSION
	echo.cost = 1
	echo.value = 0
	cards.append(echo)
	
	# Card 13: Phantom Pain - Delayed damage
	var phantom_pain = Card.new()
	phantom_pain.id = CARD_PREFIX + "phantom_pain"
	phantom_pain.name = "Phantom Pain"
	phantom_pain.description = "Deal 5 damage. Deal additional 3 damage in 2 turns."
	phantom_pain.card_type = Card.CardType.ATTACK
	phantom_pain.emotion_type = Card.EmotionType.SADNESS
	phantom_pain.cost = 2
	phantom_pain.value = 5
	cards.append(phantom_pain)
	
	# Card 14: Reminiscence - Look at top deck, put back
	var reminiscence = Card.new()
	reminiscence.id = CARD_PREFIX + "reminiscence"
	reminiscence.name = "Reminiscence"
	reminiscence.description = "Look at top 3 cards of draw pile. Put back in any order."
	reminiscence.card_type = Card.CardType.EMOTION
	reminiscence.emotion_type = Card.EmotionType.LOVE
	reminiscence.cost = 1
	reminiscence.value = 3
	cards.append(reminiscence)
	
	# Card 15: Hallucination - Random effect, potentially good or bad
	var hallucination = Card.new()
	hallucination.id = CARD_PREFIX + "hallucination"
	hallucination.name = "Hallucination"
	hallucination.description = "Random effect: Heal 5 HP OR Deal 5 damage to self AND draw 2 cards."
	hallucination.card_type = Card.CardType.EMOTION
	hallucination.emotion_type = Card.EmotionType.CONFUSION
	hallucination.cost = 1
	hallucination.value = 5
	cards.append(hallucination)
	
	# ============================================================
	# BARGAINING PHASE (Cards 16-18)
	# "\"If I just tried harder...\""
	# ============================================================
	
	# Card 16: Acceptance - Transform a negative into positive
	var acceptance = Card.new()
	acceptance.id = CARD_PREFIX + "acceptance"
	acceptance.name = "Acceptance"
	acceptance.description = "Remove 1 debuff. Transform it into +3 defense."
	acceptance.card_type = Card.CardType.EMOTION
	acceptance.emotion_type = Card.EmotionType.SADNESS
	acceptance.cost = 2
	acceptance.value = 3
	cards.append(acceptance)
	
	# Card 17: Flight - Escape harm, leave weight behind
	var flight = Card.new()
	flight.id = CARD_PREFIX + "flight"
	flight.name = "Flight"
	flight.description = "Avoid all damage this turn. Lose 1 Memory Token."
	flight.card_type = Card.CardType.DEFENSE
	flight.emotion_type = Card.EmotionType.FEAR
	flight.cost = 2
	flight.value = 0
	cards.append(flight)
	
	# Card 18: What If - "What if I had done differently?"
	var what_if = Card.new()
	what_if.id = CARD_PREFIX + "what_if"
	what_if.name = "What If"
	what_if.description = "Look at opponent's hand. Discard 1 card from it."
	what_if.card_type = Card.CardType.EMOTION
	what_if.emotion_type = Card.EmotionType.CONFUSION
	what_if.cost = 2
	what_if.value = 1
	cards.append(what_if)
	
	# ============================================================
	# SHADOWS PHASE (Card 19)
	# "Accepting the loss exists"
	# ============================================================
	
	# Card 19: Shadows - Embrace the darkness
	var shadows = Card.new()
	shadows.id = CARD_PREFIX + "shadows"
	shadows.name = "Shadows"
	shadows.description = "Gain 8 defense. Gain 2 Memory Tokens. Your grief deepens."
	shadows.card_type = Card.CardType.DEFENSE
	shadows.emotion_type = Card.EmotionType.SADNESS
	shadows.cost = 3
	shadows.value = 8
	cards.append(shadows)
	
	# ============================================================
	# WREN PHASE (Card 20)
	# "Carrying memory forward"
	# ============================================================
	
	# Card 20: Songbird - Small, persistent, meaningful damage
	var songbird = Card.new()
	songbird.id = CARD_PREFIX + "songbird"
	songbird.name = "Songbird"
	songbird.description = "Deal 6 damage. If you have 3+ Memory Tokens, deal 4 more."
	songbird.card_type = Card.CardType.ATTACK
	songbird.emotion_type = Card.EmotionType.LOVE
	songbird.cost = 3
	songbird.value = 6
	cards.append(songbird)
	
	# Card 21: Legacy - Cards that gain power from memory tokens
	var legacy = Card.new()
	legacy.id = CARD_PREFIX + "legacy"
	legacy.name = "Legacy"
	legacy.description = "Deal damage equal to your Memory Tokens × 3."
	legacy.card_type = Card.CardType.ATTACK
	legacy.emotion_type = Card.EmotionType.LOVE
	legacy.cost = 2
	legacy.value = 0  # Dynamic based on memory tokens
	cards.append(legacy)
	
	# Card 22: Carry Forward - Transform grief into strength
	var carry_forward = Card.new()
	carry_forward.id = CARD_PREFIX + "carry_forward"
	carry_forward.name = "Carry Forward"
	carry_forward.description = "Heal HP equal to cards played this combat × 2."
	carry_forward.card_type = Card.CardType.EMOTION
	carry_forward.emotion_type = Card.EmotionType.LOVE
	carry_forward.cost = 3
	carry_forward.value = 0  # Dynamic
	cards.append(carry_forward)
	
	return cards

## Get cards for a specific phase
static func get_cards_for_phase(phase: int) -> Array[Card]:
	var all_cards = create_all_cards()
	var phase_cards: Array[Card] = []
	
	var ranges: Array[Array] = [
		[0, 3],   # Denial (cards 1-4)
		[4, 9],   # Weight (cards 5-10)
		[10, 14], # Haunting (cards 11-15)
		[15, 17], # Bargaining (cards 16-18)
		[18, 18], # Shadows (card 19)
		[19, 21]  # Wren (cards 20-22)
	]
	
	if phase >= 0 and phase < ranges.size():
		var range_arr = ranges[phase]
		for i in range(range_arr[0], range_arr[1] + 1):
			if i < all_cards.size():
				phase_cards.append(all_cards[i])
	
	return phase_cards

## Get starter deck (Denial phase cards)
static func get_starter_deck() -> Array[Card]:
	return get_cards_for_phase(0)
