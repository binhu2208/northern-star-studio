# DES-V1-005 — Starter Deck Opening Hand Fix

## Task ID
DES-V1-005 (deferred to v1.1)

## Source
Live walkthrough with Bin — Bin tested the prototype directly and encountered a reproducible dead-hand scenario in Encounter 1 (Missed Signal) across multiple runs. Confirmed by Shig: the starter deck composition can produce opening hands with 0 valid primary-slot cards.

## Problem

The 12-card starter deck contains:
- **3 Emotions** (all primary-slot)
- **3 Memories** (all support-only)
- **4 Reactions** (all primary-slot)
- **2 Shifts** (all support-only)

In a 4-card draw, it's statistically common to draw 2 Memories + 2 other cards. Since Memories are always support-only, this produces a hand with **0 valid primary cards for the current open windows**.

In Encounter 1 (Missed Signal), the open windows are Connect and Reveal. The only cards that can primary those windows are Emotions with `connect` or `reveal` intent, or Reactions with those intents. A hand of Missing Signal + Quiet Support + Hope + De-escalate is a real possibility — and in that hand, neither Hope (recover) nor De-escalate (stabilize) fits Connect or Reveal.

This is not "bad luck" — it's a deck composition problem.

## Impact
- First-run players can encounter a dead hand on Encounter 1
- The game teaches "your choices matter" but the hand was rng-selected, not chosen
- Poor first impression during the critical first session
- Undermines the pitch that the game is about meaningful emotional choices

## Fix Options

### Option A — First Draw Mulligan Rule
**Change:** On the first draw of each run, if the opening hand contains 0 valid primary cards for the current open windows, the player may discard and redraw once.

**Implementation:** Add a `firstDrawRedraw` flag to `run` state. On `DRAW_PREPARE` for encounter 1, if no legal primary exists for the open windows, enable a "Redraw" button. One redraw allowed per run.

**Pros:** Simple rule, preserves deck size, adds a small strategic decision
**Cons:** Adds UI element and state tracking

### Option B — Adjust Starter Deck Composition
**Change:** Add 1 additional Emotion or Reaction to the starter, and remove 1 Memory or Shift, to increase the probability of having 2 primary-slot cards in every 4-card hand.

**Analysis:** The current 12-card deck has 7 primary-slot cards (3E + 4R) and 5 support-slot cards (3M + 2S). The probability of drawing 2 or fewer primary-slot cards in a 4-card hand with 7 primaries and 5 supports is meaningful.

Increasing to 8 primaries / 4 supports (swap 1 Memory for 1 Emotion or Reaction) improves the probability significantly without expanding the starter deck.

**Pros:** No new rules, no UI, purely deck composition
**Cons:** Requires changing CARD_DEFINITIONS in data.js

## Recommendation
Implement **Option A** (first draw mulligan) as the cleaner fix. It's a simple rule that players understand, adds a feeling of agency rather than rng, and doesn't require changing the card pool.

Option B as a fallback if Option A proves too complex to implement cleanly in the time window.

## Status
Deferred to v1.1. Not blocking v1 release.

---

**Canonical file:** `projects/emotion-cards-four/gdd/des-v1-005-starter-deck-mulligan-rule.md`
