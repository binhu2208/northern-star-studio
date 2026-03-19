# QA-006A Test Scope — Emotion Cards Phase 5 / v0.6.0

**Milestone:** Phase 5 (Controlled Burn) & Phase 6 (Ember)  
**Version:** v0.6.0  
**Date:** 2026-03-19  
**Tester:** Sakura 🌸  
**Branch:** `release/v0.5.0` → target `release/v0.6.0`  
**Status:** Draft for Execution

---

## Overview

This document defines the test scope for Emotion Cards Phase 5 (Controlled Burn) and Phase 6 (Ember) — Ember's late-game content. Phase 5-6 introduces 8 new cards with complex heat mechanics, passive abilities, buff stacking, and resource conversion.

**Scope:** 8 new cards (Cards 17-24), new heat mechanics, max heat cap increase

---

## Priority Areas

### P0 — Critical (Must Pass)

1. **Heat Resource Mechanics** — New heat interactions not previously tested
2. **Card Effect Execution Path** — Ensure no duplicate/incorrect paths from Phase 3-4
3. **Turn Counter Behavior** — First-turn edge case affects passive abilities
4. **Heat Conversion (Phoenix Rise)** — Complex: heal + heat-to-shield conversion

### P1 — High

5. **Buff Stacking (Forge)** — "Next 2 Fire cards +3 damage" behavior
6. **Conditional Damage (Bonfire, Ever Burning)** — Heat threshold checks
7. **Set-Heat Mechanics (Steady Heat)** — "Set to exactly 4" vs add/override
8. **Max Heat Cap Increase** — Inner Flame increases max from 8 to 10

### P2 — Medium

9. **Card Art Assets** — Verify all 8 card art files exist
10. **Deck Configuration** — Verify 24-card Ember deck builds correctly
11. **UI Heat Bar Scaling** — Visual validation at heat=10

---

## Key Scenarios to Validate

### Category A: New Heat Mechanics

| ID | Scenario | Cards Affected | Pass Criteria |
|----|----------|-----------------|---------------|
| A-001 | Heat as resource (spend for benefit) | Tempered Steel | Spend 3 Heat → gain 5 Shield |
| A-002 | Heat-to-shield conversion | Phoenix Rise | 1 Heat = 1 Shield (all heat converted) |
| A-003 | Heat threshold: 3+ | Bonfire | If Heat ≥ 3, +4 damage, lose NO heat |
| A-004 | Heat threshold: 5-7 | Ever Burning | If 5 ≤ Heat ≤ 7, +5 damage |
| A-005 | Heat threshold: 8+ | Ever Burning | If Heat ≥ 8, +8 damage + 2 Energy |
| A-006 | Passive heat generation | Inner Flame | +1 Heat at start of each turn |
| A-007 | Set heat to exact value | Steady Heat | Heat = 4 (override, not add) |
| A-008 | Max heat increase | Inner Flame | Max Heat = 10 (not 8) |
| A-009 | Heat gain + damage mitigation | Controlled Burn | Gain 2 Heat, -2 incoming until next turn |

### Category B: Buff System

| ID | Scenario | Cards Affected | Pass Criteria |
|----|----------|-----------------|---------------|
| B-001 | Buff application | Forge | "Next 2 Fire cards +3 damage" applied |
| B-002 | Buff consumption | Any Fire card | Playing Fire card consumes 1 buff charge |
| B-003 | Buff expiration | Forge | After 2 Fire cards, buff expires |
| B-004 | Non-Fire card interaction | Any non-Fire | Playing non-Fire does NOT consume Forge buff |
| B-005 | Buff stacking | Multiple Forge | Two Forge effects = +6 for next 4 Fire cards |

### Category C: Card Interactions

| ID | Scenario | Cards Affected | Pass Criteria |
|----|----------|-----------------|---------------|
| C-001 | Inner Flame + Ever Burning | 21 + 24 | Passive heat fuels finisher (expected) |
| C-002 | Tempered Steel + Phoenix Rise | 20 + 22 | Spending heat enables transformation |
| C-003 | Forge + Bonfire | 18 + 17 | Buffed attacks retain heat |
| C-004 | Steady Heat + Controlled Burn | 23 + 19 | Set to 4 maintains optimal mid-range |
| C-005 | Phoenix Rise + any heat card | 22 + any | Post-Phoenix heat = 0 (all converted) |

### Category D: Edge Cases

| ID | Scenario | Expected Behavior |
|----|----------|-------------------|
| D-001 | Heat goes negative | Clamp to 0; prevent negative |
| D-002 | Phoenix Rise at 0 Heat | Heal 8, gain 0 Shield |
| D-003 | Phoenix Rise at max heat (10) | Heal 8, gain 10 Shield |
| D-004 | First turn with Inner Flame | Should fire at turn 1 (verify fix) |
| D-005 | Draw with 10 cards in hand | Cannot exceed 10; must discard |
| D-006 | Ever Burning at Heat 4 | Base damage only (+0) |
| D-007 | Playing Forge with 7 Heat | Heat becomes 10 (exceeds max?) → clamp to max |

---

## Test Execution Order

### Phase 1: Unit Tests (Card Mechanics)

1. Heat resource operations (add, spend, set, clamp)
2. Threshold checks (3+, 5-7, 8+)
3. Buff application and consumption
4. Max heat enforcement

### Phase 2: Integration Tests (Card Combinations)

5. Forge + Fire card chain
6. Phoenix Rise full conversion
7. Inner Flame turn-start trigger
8. Steady Heat reset behavior

### Phase 3: System Tests (Full Deck)

9. 24-card Ember deck builds correctly
10. Draw pile / discard pile cycle
11. Hand size limit enforcement

### Phase 4: Playtest Validation

12. Manual playtest: Opening hand with Inner Flame
13. Manual playtest: Full arc from Spark Strike → Ever Burning
14. Visual: UI heat bar at max (10)

---

## Known Risks (from QA-006A Risk List)

| Risk ID | Description | Mitigation in Testing |
|---------|-------------|----------------------|
| R-001 | Phase 3-4 design/code divergence | Verify each card against design doc |
| R-002 | Complex heat mechanics | Explicit test for each heat interaction |
| R-003 | Duplicate effect execution paths | Trace code path; ensure single execution |
| R-004 | First-turn counter bug | Test Inner Flame on turn 1 |
| R-005 | No Phase 5-6 test coverage | This document addresses gap |
| R-007 | Buff stacking undefined | Test B-005 (multiple Forge) |

---

## Deliverables

- [ ] `tests/qa/qa-006a-heat-mechanics.md` — Explicit heat mechanic tests
- [ ] `tests/qa/qa-006a-buff-system.md` — Buff stacking and consumption
- [ ] `tests/qa/qa-006a-card-tests.md` — Individual card validation
- [ ] Playtest notes in `tests/qa/playtest-v0.6.0.md`

---

## Related Documents

- `docs/gdd/ember-phase5-6-cards.md` — Phase 5-6 design (source of truth)
- `tests/qa/qa-006a-risk-list.md` — Identified risks
- `tests/qa/qa-004-bug-sweep.md` — Phase 3-4 findings (carry-forward risks)
- `tests/qa/test-scenarios-card-system.md` — Existing test infrastructure

---

*End of Test Scope*
