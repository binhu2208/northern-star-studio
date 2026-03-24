# Maya Character Balance Test — Emotion Cards

**Test ID:** QA-003  
**Character:** Maya Chen (The Estranged Sibling)  
**Emotional Arc:** Warmth  
**Date:** 2026-03-17  
**Tester:** Sakura 🌸  
**Status:** DRAFT — Pending Card Data Finalization

---

## 1. Overview

This document analyzes Maya's card deck for balance issues. Maya is the main character with a Warmth emotional arc, starting from a position of Resentment (Shadow family) and progressing toward reconciliation.

**Current State:**
- Card system implemented in `/src/card-system/`
- Maya's card roster (~30 cards across 6 phases) marked as "to be added later"
- No numerical card data file exists yet

---

## 2. Starting Deck Analysis

Based on `docs/gdd/character-arc.md`, Maya's starting deck (15 cards):

| Card Name | Count | Emotion Family | Card Type | Est. Cost | Est. Value | Notes |
|-----------|-------|-----------------|-----------|-----------|------------|-------|
| Unfair Burden | 4x | Shadow | EMOTION | 1 | 3 | Basic Shadow - likely deal damage or add Resentment |
| What He Said | 3x | Shadow | EMOTION | 1 | 2 | Grief - possibly draw cards or replay |
| Should Have Been Different | 3x | Shadow | EMOTION | 1 | 3 | Longing - idealized past, high potential |
| I Was Right | 2x | Fire/Shadow | EMOTION | 2 | 4 | Stubbornness - blend, stronger effect |
| Empty Studio | 2x | Shadow | EMOTION | 1 | 2 | Melancholy - loneliness, defensive |
| Grandmother's Hands | 1x | Warmth | EMOTION | 1 | 2 | Gratitude - Warmth anchor, rare |

**Starting Emotional Capacity:** 3 plays per turn (limited by inner turmoil)

---

## 3. Identified Balance Issues

### 3.1 Overpowered Cards 🔴

| Card | Issue | Recommendation |
|------|-------|-----------------|
| **Unfair Burden** (4x) | Too many copies of basic Shadow card. At 4x, it's 27% of starting deck. | Reduce to 3x. Consider adding variety with "Unfair Burden II" |
| **Should Have Been Different** (3x) | Longing cards in deckbuilder typically enable powerful combos. With 3 copies, consistency is too high. | Either reduce to 2x OR increase cost to 2 |

### 3.2 Underpowered Cards 🟡

| Card | Issue | Recommendation |
|------|-------|-----------------|
| **Empty Studio** (2x) | Melancholy typically offers defense or heal. At cost 1 / value 2, too weak compared to alternatives. | Increase value to 3 OR add secondary effect (heal 1) |
| **Grandmother's Hands** (1x) | Only 1 Warmth card in starting deck. Starting with 3 capacity but only 1 Warmth card makes early Warmth choices nearly impossible. | Increase to 2x OR add second Warmth card like "Fond Memory" |

### 3.3 Structural Issues 🟠

| Issue | Impact | Recommendation |
|-------|--------|----------------|
| **No defensive options** | Starting deck is 100% offensive (Shadow/Emotion types). No DEFENSE cards means no mitigation. | Add 1-2 DEFENSE cards (e.g., "Wall of Grief" - block 3) |
| **Shadow-dominant (11/15 = 73%)** | With 73% Shadow cards, players have almost no choice but Shadow paths early. | Rebalance: Shadow 60%, Fire 13%, Warmth 7%, neutral 20% |
| **No draw/filter cards** | Starting deck has no card draw. Players rely entirely on initial hand. | Add 1 card draw card (e.g., "Flashback" - draw 1) |

---

## 4. Recommended Starting Deck

| Card Name | Count | Family | Cost | Value | Effect (Draft) |
|-----------|-------|--------|------|-------|----------------|
| Unfair Burden | 3x | Shadow | 1 | 3 | Deal 3 damage. +1 Resentment |
| What He Said | 3x | Shadow | 1 | 2 | Deal 2 damage. Look at top 2 cards |
| Should Have Been Different | 2x | Shadow | 1 | 3 | Deal 3 damage. If played after Shadow, +2 damage |
| I Was Right | 2x | Fire/Shadow | 2 | 5 | Deal 5 damage. +1 Anger |
| Empty Studio | 2x | Shadow | 1 | 3 | Gain 3 block. Add Melancholy token |
| Grandmother's Hands | 2x | Warmth | 1 | 2 | Heal 2. +1 Gratitude |
| Wall of Grief | 1x | Shadow | 1 | 4 | Gain 4 block |

**Total:** 15 cards | Avg cost: 1.13 | Block ratio: 1/15 (7%)

---

## 5. Phase Progression Balance

Based on the 6 emotional phases in character-arc.md:

| Phase | Cards | Focus | Balance Risk |
|-------|-------|-------|--------------|
| Resentment (Start) | 15 | Shadow | ✅ See Section 4 |
| Curiosity | +3 | Shadow→Warmth blend | Need to ensure Warmth becomes accessible |
| Conflict | +3 | Fire/Shadow blend | Fire cards may become too strong if not costed carefully |
| Vulnerability | +3 | Warmth emerges | Warmth cards need meaningful utility |
| Understanding | +3 | Warmth/Shadow blend | Hybrid cards need clear identity |
| Resolution | +3 | Player choice | Final deck should feel complete |

**Key Concern:** Mid-game transition from Shadow-dominant to Warmth-accessible must be smooth. Consider adding "Curiosity" as free reward card after first encounter.

---

## 6. Resonance & Synergy Analysis

### 6.1 Resonance Triggers

Per GDD, resonance = 3+ cards from same family. With current deck:
- **Shadow Resonance:** 11 Shadow cards → Very easy to trigger (broken)
- **Fire Resonance:** 2 Fire/Shadow cards → Difficult (only 2 copies)
- **Warmth Resonance:** 1-2 Warmth cards → Nearly impossible (too weak)

### 6.2 Recommended Fixes

1. **Shadow:** Reduce total Shadow to 8-9 cards (prevents automatic resonance)
2. **Fire:** Add 1-2 more Fire cards in Conflict phase
3. **Warmth:** Ensure at least 3-4 Warmth cards before Vulnerability phase

---

## 7. Energy System Concerns

Per GDD: "Emotional Capacity: 3 plays per turn"

**Balance Issues:**
- Starting deck has 15 cards, 3 capacity = 5 turns through deck
- With no draw/filters, players see ~30% of deck per encounter
- **Recommendation:** Add card draw OR increase capacity to 4 early

---

## 8. Test Recommendations

| Priority | Test | Pass Criteria |
|----------|------|---------------|
| P0 | Starting deck 3-turn survival | Can survive 3 encounters without losing |
| P0 | Warmth path accessibility | Can reach Warmth-dominant (40%+) by encounter 4 |
| P1 | Resonance balance | Shadow resonance not automatic; others achievable |
| P1 | End-game deck viability | Final deck (15-20 cards) can achieve any ending |
| P2 | Card draw dependency | Deck functions with/without draw cards |

---

## 9. Summary

| Category | Count | Assessment |
|----------|-------|------------|
| 🔴 Overpowered | 2 | Unfair Burden (too many), Should Have Been Different (too consistent) |
| 🟡 Underpowered | 2 | Empty Studio (too weak), Grandmother's Hands (too rare) |
| 🟠 Structural | 3 | No defense, Shadow-dominant, no card draw |

**Overall Assessment:** Starting deck needs rebalancing before playable. Primary fix is reducing Shadow count and adding defensive options.

---

## 10. Next Steps

- [ ] Hideo to finalize card statistics (cost, value, effects)
- [ ] John to create card data JSON/YAML file
- [ ] Re-run balance test with actual numbers
- [ ] Playtest with final card data

---

*Balance is iterative. This document should be updated as card data is finalized.*
