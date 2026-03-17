# Ember Balance Analysis — Emotion Cards

**Character:** Ember  
**Theme:** Anger & Redemption  
**Emotion Family:** Fire  
**Analysis Date:** 2026-03-17  
**Analyst:** Sakura 🌸

---

## Overview

This document analyzes the balance of Ember's 20-card deck based on the card concepts defined in DES-002: Character Expansion. The deck is organized into 4 emotional phases, each representing a stage in Ember's anger/redemption arc.

---

## Card Roster Summary

| Phase | Cards | Focus |
|-------|-------|-------|
| Ignition (1-4) | Spark Strike, Flashpoint, Tinder, Quick Fuse | Early game, setup, card draw |
| Blaze (5-10) | Wildfire, Heat Wave, Backdraft, Inferno, Smoke Screen, Burning Bridges | High damage, self-harm, AOE |
| Scorched Earth (11-15) | Ash Fall, Scars, Regret, Cooling Embers, 废墟 (Ruins) | Defensive, heal, sacrifice |
| Controlled Burn (16-20) | Bonfire, Forge, Controlled Burn, Tempered Steel, Phoenix | Utility, transformation, sustain |

---

## Balance Issues Identified

### 🔴 Critical Issues

#### 1. **Inferno — Costly High Damage**
- **Issue:** Card deals "high damage" but "costs HP"
- **Risk:** Could be broken in late game when HP is abundant, or useless early when HP is scarce
- **Recommendation:** Define precise HP cost (e.g., 30% max HP) and damage ratio. Consider adding a cooldown or limiting uses per encounter.

#### 2. **Burning Bridges — Self-Destructive**
- **Issue:** "Destroys resources, hurts self" with no apparent upside mentioned
- **Risk:** Too weak to be viable unless there's a specific synergy (e.g., triggers on destruction)
- **Recommendation:** Add clear payoff — perhaps triggers "heat" generation or powers up next card. Consider making it optional/sacrificial rather than pure downside.

#### 3. **废墟 (Ruins) — Opaque Effect**
- **Issue:** "Sacrifice for major payoff" — payoff not defined
- **Risk:** Without clear mechanics, either broken or useless
- **Recommendation:** Define exact sacrifice (HP? cards? energy?) and concrete payoff value

### 🟠 High Priority

#### 4. **Wildfire — AOE Without Tradeoff**
- **Issue:** "Damage to all enemies, hard to control" — but what does "hard to control" mean mechanically?
- **Risk:** Either too strong (free AOE) or unplayable (random/uncontrollable)
- **Recommendation:** Clarify mechanic. If it hits allies too, that's a tradeoff. If it scales unpredictably, specify range.

#### 5. **Smoke Screen — Conflicting Effect**
- **Issue:** "Evasion, but obscures vision" — unclear what "obscures vision" means
- **Risk:** Ambiguous penalty may be meaningless or devastating
- **Recommendation:** Define "obscures vision" — reduced accuracy? Can't target specific enemies? Reduced draw quality?

#### 6. **Backdraft — Mirror Damage**
- **Issue:** "Damage returned to attacker" — standard counter mechanic
- **Risk:** Potentially too strong against melee enemies, useless against ranged
- **Recommendation:** Specify return percentage (e.g., 50% of damage) and clarify if it works vs. all attack types

#### 7. **Phoenix — Ultimate Card**
- **Issue:** "Rise from ashes, convert destruction to rebirth" — vague
- **Risk:** Could be the most broken card in the deck or useless depending on implementation
- **Recommendation:** Define exact resurrection conditions (HP restored? full heal? negative status removed?) and trigger (on death? on low HP? on card play?)

### 🟡 Medium Priority

#### 8. **Phase Distribution Imbalance**
- **Ignition (4 cards):** Mostly setup/draw — good for early game
- **Blaze (6 cards):** Heavy on attack/AOE — 60% offensive
- **Scorched Earth (5 cards):** Mixed but heavy on defense/sacrifice
- **Controlled Burn (5 cards):** Utility/transformation focused

**Issue:** Blaze phase has too many offensive cards (6 of 20 = 30%), potentially making early-mid game too aggressive with no defensive options until phase 3.

#### 9. **No Clear Energy System**
- **Issue:** Card costs not defined anywhere (cost: energy? emotion points? HP?)
- **Risk:** Can't assess balance without knowing resource economy
- **Recommendation:** Reference core mechanics (DES-001A) and define energy costs for each card

#### 10. **Card Draw Imbalance**
- **Issue:** Only 1 card draw effect (Quick Fuse) in entire deck
- **Risk:** Deck may become hand-starved, limiting options
- **Recommendation:** Add at least 1-2 more draw effects, especially in mid-game phases

### 🟢 Observations

#### 11. **Strong Combo Potential**
- Tinder → Flashpoint → Spark Strike: Clear setup-combo-payoff chain
- Backdraft + Smoke Screen: Defensive counter synergy
- Cooling Embers + Tempered Steel: Anger-to-defense conversion chain
- **Observation:** These synergies are well-designed and should be preserved

#### 12. **Thematic Consistency**
- Cards appropriately match Ember's arc from anger to redemption
- Early phases feel chaotic (Wildfire, Burning Bridges), late phases feel controlled (Controlled Burn, Tempered Steel)
- **Observation:** Good thematic design, minor balance tweaks needed

---

## Recommended Stat Framework

Based on typical deckbuilder balance patterns, here's a suggested framework:

| Card Type | Energy Cost | Value Range |
|-----------|-------------|-------------|
| Quick Attack | 1 | 3-5 damage |
| Medium Attack | 2 | 6-10 damage |
| Heavy Attack | 3 | 12-15 damage |
| AOE Attack | 2-3 | 4-6 damage to all |
| Draw Card | 1 | Draw 1-2 cards |
| Defense | 1-2 | 4-8 block |
| Hybrid (damage+defense) | 2 | 4 damage + 4 block |
| Ultimate | 4-5 | High impact effect |

---

## Action Items

1. **Define energy costs** for all 20 Ember cards
2. **Clarify ambiguous mechanics** (Smoke Screen, Wildfire, Ruins, Phoenix)
3. **Playtest Inferno** at different HP cost thresholds
4. **Add 1-2 more card draw effects** in Blaze/Scorched Earth phases
5. **Implement and test combo chains** (Tinder→Flashpoint, Cooling Embers→Tempered Steel)
6. **Define Phoenix resurrection** mechanic precisely

---

## Testing Notes

- No actual card data (.json/.tres) exists yet — all analysis based on GDD concepts
- Card system implementation exists in `src/card-system/`
- Test suite ready in `tests/qa/test-scenarios-card-system.md`
- Recommend implementing Ember cards as .tres files after stat framework finalized

---

*Analysis complete. Ready for implementation review.*
