# DES-V1-003 — v1 Encounter Template Verification

## Task ID
DES-V1-003

## Purpose
Verify that the engine implementation correctly reflects the v1 flagship mode rules (DES-V1-001) and the encounter templates defined in DES-V1-002. This is a verification pass against what John built, not a re-authoring.

## Sources Verified
- `src/engine.js` — GameEngine, BreakthroughManager, CarryForwardManager, phase machine, outcome evaluation
- `src/data.js` — CARD_DEFINITIONS, ENCOUNTER_TEMPLATES, STARTER_DECK
- `src/vocabulary.js` — VOCAB, condition/effect primitive lists

---

## Part 1 — v1 Flagship Mode Rules Compliance

### ✅ PASS — Breakthrough Timing (next turn rule)
`BreakthroughManager.evaluateAndSurface` sets `breakthroughPlayable = false` on the surface turn and `advanceBreakthroughPlayability` sets it to `true` once `encounter.turn > encounter.breakthroughSurfaceTurn`. The next-turn rule is correctly implemented.

### ✅ PASS — Collapse Armed Definition
`updateEncounterFlags` sets `collapseArmed = true` when `tension >= 8 || failedPlayCount >= 2`. Matches DES-V1-001 locked definition exactly.

### ✅ PASS — Outcome Evaluation Logic
`evaluateOutcome` correctly evaluates in priority order: collapse → breakthrough → stalemate → partial → continue. Conditions match DES-V1-001:
- **Collapse:** `tension >= 10 AND trust <= 2` OR `failedPlayCount >= 3 AND tension >= 8`
- **Stalemate:** `turn >= 6 AND momentum <= 0 AND trust < 6`
- **Partial:** `turn >= 4 AND (trust >= 4 OR clarity >= 5)`
- **Breakthrough:** thresholds met + breakthroughReady

### ✅ PASS — Turn Pressure (standing rule)
`handleStateRefresh` correctly applies tension +1 after turn 4 unless `no_tension_increase` modifier is present. Matches the standing v1 rule.

### ✅ PASS — Phase Model
Eight-step phase order is correctly implemented. Phase transitions are enforced. `submitPlay` is correctly gated — only enabled when at least one legal primary card is selected.

### ✅ PASS — Carry-Forward System
`CarryForwardManager` correctly applies per-encounter modifiers at encounter start (`applyToEncounter`), evaluates carry-forward rules at encounter end, and supports reward choices with `claimReward`. Matches DES-V1-001.

### ✅ PASS — Encounter-as-Opposition Model
`resolveOpposition` correctly evaluates priority-sorted reaction rules and applies encounter pushback. Matches DES-V1-001.

---

## Part 2 — Encounter Template Verification

### ✅ PASS — Missed Signal (encounter 1)
All reaction rules, thresholds, starting stats, keywords, and windows match DES-V1-002 template. Carry-forward default rules in `CarryForwardManager.getEncounterRules` correctly reference `missed_signal`. Breakthrough default `B-001` is correct.

### ✅ PASS — Public Embarrassment (encounter 2)
All reaction rules, thresholds, starting stats, keywords, and windows match DES-V1-002 template. High-tension starting state (7) and `heated`/`fragile`/`public` keywords correctly implemented. Breakthrough default `B-003` is correct.

### ✅ PASS — Quiet Repair (encounter 3)
All reaction rules, thresholds, starting stats, keywords, and windows match DES-V1-002 template. Carry-forward default rules correctly reference `quiet_repair`. Breakthrough default `B-002` is correct.

---

## Part 3 — Design Gaps Found

### ⚠️ GAP 1 (High) — 2 of 5 Encounter Templates Not Implemented

**What DES-V1-002 specifies:** 5 encounter templates — Missed Signal, Public Embarrassment, Quiet Repair, Old Grudge, Breakthrough Moment

**What data.js contains:** Only 3 encounters — Missed Signal, Public Embarrassment, Quiet Repair

**Missing:**
- **Old Grudge** — history-heavy encounter with `misread`/`guarded`/`defensive` keywords, high-dependency reveal plays, collapse risk from pressure in guarded state
- **Breakthrough Moment** — run-position-aware encounter with carry-forward state modifiers, net-positive/negative run detection, climactic resolution

**Impact:** The v1 build has 2 fewer encounters than the design doc specifies. Runs are shorter than the v1 scope intended. Old Grudge provides a meaningfully different challenge type (history/reveal focus) that the current 3 encounters don't cover.

**Recommendation:** Either:
- Implement Old Grudge and Breakthrough Moment before v1 QA gate, OR
- Explicitly scope v1 to 3 encounters and update the plan to reflect this reduction

### ⚠️ GAP 2 (Medium) — Starter Deck Is 12 Cards, Not 16

**What DES-V1-002 specifies:** 16-card starter deck (5 Emotions, 4 Memories, 4 Reactions, 3 Shifts)

**What data.js STARTER_DECK contains:** 12 cards — 3 Emotions, 3 Memories, 4 Reactions, 2 Shifts

**Current starter:**
- Emotions: Concern (E-001), Shame (E-003), Hope (E-005)
- Memories: Old Promise (M-001), Quiet Support (M-004), Missed Signal (M-006)
- Reactions: Guarded Honesty (R-001), Deflect (R-002), De-escalate (R-003), Reframe Gently (R-007)
- Shifts: Change of Lens (S-001), Slow the Room (S-002)

**Missing from starter (that exist in CARD_DEFINITIONS):** None — the CARD_DEFINITIONS itself only has 15 total cards (3E, 3M, 4R, 2S, 3B).

**The CARD_DEFINITIONS itself is limited to the prototype card set.** DES-V1-002 added 9 Emotion, 8 Memory, 9 Reaction, and 6 Shift cards for a target of 35 total. The current implementation has 15.

**Impact:** The full v1 card pool is not yet in the codebase. The expanded taxonomy from DES-V1-002 was not carried into implementation. Current v1 is running on the prototype card set.

**Recommendation:** DES-V1-004a (card balance pass) and the v1 card pool expansion should address this. The 12-card starter is functional but narrower than the v1 spec.

### ⚠️ GAP 3 (Low — Engine Bug) — Breakthrough UnlockRules Validation Gap

**Finding:** `validateVocabulary` does not recognize `statGte`/`statLte`/`statEq` inside `unlockRules` condition blocks, but `BreakthroughManager._evaluateUnlockConditions` does evaluate them.

**What happens:** Cards with unlock rules using stat thresholds (like `statGte: { stat: 'clarity', value: 7 }`) pass runtime evaluation but trigger a `warning` from the vocabulary validator. This is a false positive — the validator is missing keys that the engine supports.

**Current affected cards:** B-001, B-002, B-003 all use `breakthroughReady: true` only (no stat thresholds), so they are not currently triggering this bug. But the validator gap would affect any future breakthrough card with stat-based unlock conditions.

**Recommendation:** Add `statGte`, `statLte`, `statEq`, `encounterId`, `result` to `CONDITION_KEYS` in engine.js. This is a one-line fix.

### ⚠️ GAP 4 (Info) — DES-V1-002 Section 2.3 / Encounter 4 Duplicate collapseConditions

**Finding:** In `v1-card-taxonomy-and-encounter-templates.md`, Encounter 4 (Old Grudge) has a duplicate `collapseConditions:` YAML key due to a write error. The first occurrence is empty, the second has the actual conditions. This would not parse correctly as YAML.

**Impact:** If this file were used to auto-generate encounter data, Old Grudge's collapse conditions would be empty. Since data.js has its own hand-written encounter definitions, this is a doc inconsistency, not a runtime bug.

**Recommendation:** Fix the duplicate key in the design doc before it is used as a source of truth.

### ⚠️ GAP 5 (Info) — Fresh Start "player_choice" Window Still Unresolved

**Finding from DES-V1-003a:** Fresh Start (S-005) opens a "player_choice" response window. This was flagged in DES-V1-003a as not in the canonical vocabulary. S-005 is not in data.js at all (only 2 shift cards are implemented), so this gap has not yet reached runtime. But it remains open as a design decision.

**Recommendation:** Resolve whether "player_choice" becomes a vocabulary entry or is replaced with a defined window type.

---

## Part 4 — What Is Working Correctly

The following from DES-V1-001 is correctly implemented:
- Phase machine (8 steps, correct order, correct transitions)
- Outcome evaluation priority order and condition logic
- Turn pressure after turn 4 (standing rule)
- Collapse armed flag (visible to UI via `encounter.collapseArmed`)
- Breakthrough surfacing with next-turn playability rule
- Carry-forward with per-encounter rules and reward choices
- Card validation and vocabulary startup checks
- Encounter-as-opposition with priority-sorted reaction rules
- Injecting surfaced breakthrough into hand on draw_prepare
- Failed play tracking and collapse armed contribution

---

## Summary

| Check | Result | Severity |
|---|---|---|
| Breakthrough timing (next turn rule) | ✅ PASS | — |
| Collapse armed definition | ✅ PASS | — |
| Outcome evaluation logic | ✅ PASS | — |
| Turn pressure (standing rule) | ✅ PASS | — |
| Phase model | ✅ PASS | — |
| Carry-forward system | ✅ PASS | — |
| Encounter 1 — Missed Signal | ✅ PASS | — |
| Encounter 2 — Public Embarrassment | ✅ PASS | — |
| Encounter 3 — Quiet Repair | ✅ PASS | — |
| Encounter 4 — Old Grudge | ❌ NOT IMPLEMENTED | HIGH |
| Encounter 5 — Breakthrough Moment | ❌ NOT IMPLEMENTED | HIGH |
| Starter deck = 16 cards | ❌ 12 cards implemented | MEDIUM |
| Full 35-card v1 pool | ❌ 15 cards in codebase | MEDIUM |
| Breakthrough unlockRules validation | ⚠️ Validator gap | LOW |
| Old Grudge doc duplicate collapseConditions | ⚠️ Doc inconsistency | INFO |
| Fresh Start "player_choice" window | ⚠️ Open design decision | INFO |

---

## Recommendations

1. **Decision needed from Bin:** Does v1 scope 3 encounters (current) or 5 (DES-V1-002 spec)? If 5, Old Grudge and Breakthrough Moment need implementation before QA-V1-003.

2. **DES-V1-004a should expand the card pool** to approach the v1 target. The current 15-card pool is functional but below spec.

3. **Fix the `CONDITION_KEYS` validator gap** — add statGte/statLte/statEq/encounterId/result before more breakthrough cards with stat-based unlocks are added.

4. **Fix Old Grudge duplicate collapseConditions** in the design doc to prevent future confusion.

5. **Resolve Fresh Start "player_choice"** window as a design decision.

---

**Canonical file:** `projects/emotion-cards-four/gdd/des-v1-003-encounter-template-verification.md`
