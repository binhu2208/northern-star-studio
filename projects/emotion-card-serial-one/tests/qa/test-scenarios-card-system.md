# Test Scenarios: Card System (DEV-001A)

**Test Suite:** Emotion Cards Core System  
**Date:** March 17, 2026  
**Tester:** Sakura 🌸  
**Status:** Ready for Execution

---

## Overview

These test scenarios cover the card system implementation in `/src/card-system/`. The system consists of:
- `Card.gd` — Card resource with types and emotions
- `CardDeck.gd` — Deck management (shuffle, draw)
- `CardHand.gd` — Hand management (max 10 cards)
- `CardManager.gd` — Game flow (draw pile, discard pile, reshuffle)

---

## Test Category 1: Card Creation & Properties

### TC-001: Card Creation with All Properties

**Objective:** Verify Card resource accepts all defined properties  
**Input:** Create card with id, name, description, type, emotion, cost, value  
**Expected Output:** Card object has all properties correctly set  
**Pass Criteria:** 
- [ ] `card.id == "test_001"`
- [ ] `card.name == "Twinge of Hope"`
- [ ] `card.description == "A small moment of brightness"`
- [ ] `card.card_type == Card.CardType.EMOTION`
- [ ] `card.emotion_type == Card.EmotionType.JOY`
- [ ] `card.cost == 1`
- [ ] `card.value == 2`

---

### TC-002: Card Type Enum Validation

**Objective:** Verify all card types are accessible and correct  
**Expected Output:** All CardType enum values exist  
**Pass Criteria:**
- [ ] `Card.CardType.ATTACK` exists
- [ ] `Card.CardType.DEFENSE` exists  
- [ ] `Card.CardType.EMOTION` exists

---

### TC-003: Emotion Type Enum Validation

**Objective:** Verify all emotion types are accessible  
**Expected Output:** All EmotionType enum values exist (6 types)  
**Pass Criteria:**
- [ ] `Card.EmotionType.JOY` exists
- [ ] `Card.EmotionType.SADNESS` exists
- [ ] `Card.EmotionType.ANGER` exists
- [ ] `Card.EmotionType.FEAR` exists
- [ ] `Card.EmotionType.LOVE` exists
- [ ] `Card.EmotionType.CONFUSION` exists

---

## Test Category 2: Deck Operations

### TC-101: Add Card to Deck

**Objective:** Verify cards can be added to a deck  
**Input:** Create deck, add 5 cards  
**Expected Output:** Deck size equals 5  
**Pass Criteria:**
- [ ] `deck.size() == 5` after adding 5 cards
- [ ] All cards are present in `deck.cards` array

---

### TC-102: Remove Card from Deck

**Objective:** Verify cards can be removed from deck  
**Input:** Deck with 5 cards, remove 1  
**Expected Output:** Deck size equals 4  
**Pass Criteria:**
- [ ] `deck.size() == 4` after removal
- [ ] Removed card no longer in `deck.cards`

---

### TC-103: Shuffle Deck

**Objective:** Verify deck shuffles without losing cards  
**Input:** Deck with 10 known cards, shuffle  
**Expected Output:** All 10 cards still present (order may vary)  
**Pass Criteria:**
- [ ] `deck.size() == 10` after shuffle
- [ ] All original cards present (compare ids)

---

### TC-104: Draw from Non-Empty Deck

**Objective:** Verify drawing removes top card and returns it  
**Input:** Deck with 5 cards, draw 1  
**Expected Output:** Drawn card returned, deck size = 4  
**Pass Criteria:**
- [ ] `drawn_card != null`
- [ ] `deck.size() == 4`

---

### TC-105: Draw from Empty Deck

**Objective:** Verify drawing from empty deck returns null  
**Input:** Empty deck, draw 1  
**Expected Output:** null returned, no error  
**Pass Criteria:**
- [ ] `drawn_card == null`
- [ ] No exception thrown

---

### TC-106: Check Deck Empty Status

**Objective:** Verify is_empty() correctly reports deck state  
**Input:** Empty deck, then add card  
**Expected Output:** True when empty, false when has cards  
**Pass Criteria:**
- [ ] `deck.is_empty() == true` for empty deck
- [ ] `deck.is_empty() == false` after adding card

---

## Test Category 3: Hand Management

### TC-201: Add Card to Hand (Under Limit)

**Objective:** Verify cards can be added to hand when under limit  
**Input:** Empty hand, add 5 cards (max = 10)  
**Expected Output:** All 5 cards in hand  
**Pass Criteria:**
- [ ] `hand.get_hand_size() == 5`
- [ ] All cards retrievable via `hand.get_card(index)`

---

### TC-202: Add Card to Hand (At Limit)

**Objective:** Verify hand rejects cards when at max capacity  
**Input:** Hand with 10 cards (max), try to add 11th  
**Expected Output:** 11th card rejected, hand size stays 10  
**Pass Criteria:**
- [ ] `hand.add_card(extra_card) == false`
- [ ] `hand.get_hand_size() == 10`

---

### TC-203: Play Card from Hand

**Objective:** Verify playing a card removes it from hand  
**Input:** Hand with 3 cards, play card at index 1  
**Expected Output:** Card returned, hand size = 2  
**Pass Criteria:**
- [ ] `played_card != null`
- [ ] `played_card == original_card_at_index_1`
- [ ] `hand.get_hand_size() == 2`

---

### TC-204: Play Card from Invalid Index

**Objective:** Verify playing from invalid index returns null  
**Input:** Hand with 3 cards, play at index 99  
**Expected Output:** null returned, no error  
**Pass Criteria:**
- [ ] `hand.play_card(99) == null`
- [ ] `hand.get_hand_size() == 3` (unchanged)

---

### TC-205: Discard Card from Hand

**Objective:** Verify discarding removes card from hand  
**Input:** Hand with 3 cards, discard at index 0  
**Expected Output:** Card removed, hand size = 2  
**Pass Criteria:**
- [ ] `discarded_card != null`
- [ ] `hand.get_hand_size() == 2`

---

### TC-206: Clear Hand

**Objective:** Verify clear_hand() removes all cards  
**Input:** Hand with 5 cards, call clear_hand()  
**Expected Output:** Hand empty  
**Pass Criteria:**
- [ ] `hand.get_hand_size() == 0`
- [ ] `hand.hand == []` (empty array)

---

### TC-207: Get Card at Valid Index

**Objective:** Verify retrieving card by index works  
**Input:** Hand with cards, get card at index 2  
**Expected Output:** Correct card returned  
**Pass Criteria:**
- [ ] `hand.get_card(2) == expected_card`

---

### TC-208: Get Card at Invalid Index

**Objective:** Verify retrieving card at invalid index returns null  
**Input:** Hand with 3 cards, get card at index 10  
**Expected Output:** null returned  
**Pass Criteria:**
- [ ] `hand.get_card(10) == null`

---

## Test Category 4: CardManager & Game Flow

### TC-301: Initialize Deck

**Objective:** Verify CardManager initializes deck correctly  
**Input:** Array of 20 cards, call initialize_deck()  
**Expected Output:** Draw pile has 20 shuffled cards  
**Pass Criteria:**
- [ ] `draw_pile.size() == 20`
- [ ] `discard_pile.size() == 0`
- [ ] Signal `deck_shuffled` emitted

---

### TC-302: Draw Cards (Normal)

**Objective:** Verify draw_cards() draws correct number  
**Input:** Deck with 10 cards, draw 3  
**Expected Output:** 3 cards in hand, 7 in draw pile  
**Pass Criteria:**
- [ ] `drawn == 3`
- [ ] `hand.get_hand_size() == 3`
- [ ] `draw_pile.size() == 7`

---

### TC-303: Draw Cards (Exceeds Hand Limit)

**Objective:** Verify drawing stops when hand is full  
**Input:** Hand at 10 (max), draw 5 more  
**Expected Output:** Only 0 drawn (or partial), hand stays at 10  
**Pass Criteria:**
- [ ] `hand.get_hand_size() == 10`
- [ ] Signal `hand_full` emitted

---

### TC-304: Draw Cards (Reshuffle Discard)

**Objective:** Verify discard pile reshuffles when draw empty  
**Input:** Draw pile empty, discard pile has 5 cards, draw 3  
**Expected Output:** 3 cards drawn, discard empty, draw has 2  
**Pass Criteria:**
- [ ] `drawn == 3`
- [ ] `discard_pile.size() == 2`
- [ ] Signal `deck_shuffled` emitted (from reshuffle)

---

### TC-305: Draw Cards (Both Piles Empty)

**Objective:** Verify graceful handling when no cards available  
**Input:** Both piles empty, draw 1  
**Expected Output:** 0 cards drawn, no error  
**Pass Criteria:**
- [ ] `drawn == 0`
- [ ] No exception thrown

---

### TC-306: Play Card via Manager

**Objective:** Verify play_card_from_hand() works  
**Input:** Hand with cards, play at index 0 via manager  
**Expected Output:** Card returned, signal emitted  
**Pass Criteria:**
- [ ] `played_card != null`
- [ ] Signal `card_played` emitted from hand

---

### TC-307: Discard Card via Manager

**Objective:** Verify discard_from_hand() moves card to discard pile  
**Input:** Hand with card, discard at index 0 via manager  
**Expected Output:** Card in discard pile, not in hand  
**Pass Criteria:**
- [ ] `hand.get_hand_size() == 0`
- [ ] `discard_pile.size() == 1`

---

### TC-308: Multiple Draw Sequence

**Objective:** Verify multiple sequential draws work correctly  
**Input:** Deck with 10 cards, draw 3, draw 2  
**Expected Output:** 5 cards total drawn, correct pile states  
**Pass Criteria:**
- [ ] After first: hand=3, draw=7
- [ ] After second: hand=5, draw=5

---

## Test Category 5: Card Effects & Interactions

### TC-401: Emotion Type Assignment

**Objective:** Verify cards correctly store emotion types  
**Input:** Create cards with different emotion types  
**Expected Output:** Each card has correct emotion  
**Pass Criteria:**
- [ ] Joy card `emotion_type == JOY`
- [ ] Sadness card `emotion_type == SADNESS`
- [ ] Anger card `emotion_type == ANGER`

---

### TC-402: Card Cost and Value

**Objective:** Verify cost and value properties work  
**Input:** Card with cost=2, value=5  
**Expected Output:** Properties accessible and correct  
**Pass Criteria:**
- [ ] `card.cost == 2`
- [ ] `card.value == 5`

---

### TC-403: Card Type Assignment

**Objective:** Verify all card types assign correctly  
**Input:** Create ATTACK, DEFENSE, EMOTION cards  
**Expected Output:** Each card has correct type  
**Pass Criteria:**
- [ ] Attack card `card_type == ATTACK`
- [ ] Defense card `card_type == DEFENSE`
- [ ] Emotion card `card_type == EMOTION`

---

## Test Category 6: Edge Cases

### TC-501: Draw Single Card from Large Deck

**Objective:** Performance/sanity check with large deck  
**Input:** Deck with 100 cards, draw 1  
**Expected Output:** Single card drawn successfully  
**Pass Criteria:**
- [ ] `drawn == 1`
- [ ] `hand.get_hand_size() == 1`

---

### TC-502: Hand Boundary (Zero Cards)

**Objective:** Verify operations work with empty hand  
**Input:** Empty hand, get size, try to play/discard  
**Expected Output:** Zero size, null returns for operations  
**Pass Criteria:**
- [ ] `hand.get_hand_size() == 0`
- [ ] `hand.play_card(0) == null`
- [ ] `hand.discard_card(0) == null`

---

### TC-503: Deck Boundary (Single Card)

**Objective:** Verify single card deck operations  
**Input:** Deck with 1 card, draw it, try to draw more  
**Expected Output:** First draw succeeds, second returns null  
**Pass Criteria:**
- [ ] First draw returns card
- [ ] Second draw returns null (deck empty)

---

### TC-504: Maximum Hand Size Configuration

**Objective:** Verify max_hand_size is configurable  
**Input:** Create hand with max_hand_size=5, add 6 cards  
**Expected Output:** Only 5 added, 6th rejected  
**Pass Criteria:**
- [ ] `hand.max_hand_size == 5` (if set)
- [ ] Only 5 cards in hand

---

## Test Category 7: Signal Verification

### TC-601: Deck Shuffled Signal

**Objective:** Verify deck_shuffled signal emits on shuffle  
**Input:** Call initialize_deck()  
**Expected Output:** Signal received  
**Pass Criteria:**
- [ ] Signal handler called
- [ ] Can connect and receive signal

---

### TC-602: Card Drawn Signal

**Objective:** Verify card_drawn emits with correct card  
**Input:** Draw a card  
**Expected Output:** Signal emits with the drawn card  
**Pass Criteria:**
- [ ] Signal emits
- [ ] Signal passes correct card data

---

### TC-603: Hand Full Signal

**Objective:** Verify hand_full signal when hand at capacity  
**Input:** Fill hand, try to draw more  
**Expected Output:** Signal emits  
**Pass Criteria:**
- [ ] Signal emits when hand reaches max

---

### TC-604: Card Played Signal

**Objective:** Verify card_played emits when card played  
**Input:** Play a card from hand  
**Expected Output:** Signal emits with played card  
**Pass Criteria:**
- [ ] Signal emits
- [ ] Signal passes correct card data

---

## Test Category 8: Integration Scenarios

### TC-701: Full Encounter Flow

**Objective:** Simulate a complete encounter turn  
**Input:** 
- Initialize deck with 20 emotion cards
- Draw 5 cards (starting hand)
- Play 2 cards
- Discard 1 card
- End turn (draw 2 more)

**Expected Output:** Correct state after each step  
**Pass Criteria:**
- [ ] After draw: hand=5, draw=15
- [ ] After play 2: hand=3, played=2
- [ ] After discard: hand=2, discard=1
- [ ] After end turn draw: hand=4, draw=13

---

### TC-702: Deck Cycle (Draw → Play → Discard → Reshuffle)

**Objective:** Verify complete deck cycling works  
**Input:** 
- Deck with 3 cards
- Draw all 3
- Play 1 (goes to "played" state, conceptually)
- Discard remaining 2
- Draw 2 more

**Expected Output:** All cards cycle correctly  
**Pass Criteria:**
- [ ] Can draw all 3
- [ ] After discard, draw pile empty
- [ ] Reshuffle triggers when attempting to draw from empty

---

## Notes

- **Cozy Design:** Per GDD, there is no failure state. "Emotional breakdown" = new perspective, not game over.
- **No Time Pressure:** All encounters are turn-based
- **Energy System:** Not implemented yet (open question in GDD)
- **Maya's Card Roster:** ~30 cards across 6 emotional phases to be added later

---

## Execution Log

| Date | Tester | TC ID | Result | Notes |
|------|--------|-------|--------|-------|
| 2026-03-17 | Sakura | - | Pending | Ready for execution |
