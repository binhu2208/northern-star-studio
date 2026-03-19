# QA-006A — Exit Criteria: Emotion Cards Phase 5 / v0.6.0

**Branch:** `release/v0.5.0` → `release/v0.6.0`  
**Date:** 2026-03-19  
**Tester:** Sakura 🌸  
**Status:** Ready for Implementation

---

## Overview

This document defines the pass conditions, validation checkpoints, and "done" criteria for the Phase 5 (Controlled Burn) and Phase 6 (Ember) milestone — collectively v0.6.0.

**Scope:** Ember character, cards 17–24 (8 new cards), heat mechanic refinements.

---

## What "Done" Looks Like ✅

### Core Deliverables

| # | Deliverable | Description |
|---|-------------|-------------|
| D1 | Phase 5 cards implemented | Cards 17–20 (Bonfire, Forge, Controlled Burn, Tempered Steel) functional |
| D2 | Phase 6 cards implemented | Cards 21–24 (Inner Flame, Phoenix Rise, Steady Heat, Ever Burning) functional |
| D3 | Heat system enhanced | Heat-as-resource, heat-to-shield conversion, max heat cap increase to 10 |
| D4 | Buff system operational | Buff stacking, expiration, and conditional application working |
| D5 | Card art delivered | All 8 Phase 5–6 cards have rendered artwork |
| D6 | Tests pass | Unit tests and integration tests for new mechanics pass |

### Quality Gates

| # | Gate | Criteria |
|---|------|----------|
| G1 | No blocker bugs | Zero P0 bugs in new card mechanics |
| G2 | Design-doc alignment | All 8 cards match `docs/gdd/ember-phase5-6-cards.md` specification |
| G3 | Smoke test passes | Core gameplay loop works with new cards |
| G4 | No regressions | Existing Phase 1–4 cards function as before |

---

## Pass Conditions (Must Pass) 🎯

### 1. Card Implementation Fidelity

- [ ] **Bonfire (C17):** Costs 2 energy, deals 7 damage, conditional +4 damage if 3+ Heat, Heat not consumed
- [ ] **Forge (C18):** Costs 2 energy, gains 3 Heat, next 2 Fire cards deal +3 damage
- [ ] **Controlled Burn (C19):** Costs 1 energy, deals 3 damage, gains 2 Heat, reduces incoming damage by 2 until next turn
- [ ] **Tempered Steel (C20):** Costs 2 energy, gains 5 Shield, loses 3 Heat
- [ ] **Inner Flame (C21):** Passive — at start of each turn, gain 1 Heat, max Heat increased to 10
- [ ] **Phoenix Rise (C22):** Costs 3 energy, heals 8 HP, converts all Heat to Shield (1 Heat = 1 Shield)
- [ ] **Steady Heat (C23):** Costs 1 energy, sets Heat to exactly 4, draws 2 cards
- [ ] **Ever Burning (C24):** Costs 4 energy, deals 10 damage, +5 if Heat 5–7, +8 and +2 Energy if Heat 8+

### 2. Heat Mechanic Validation

- [ ] Heat can be gained, spent, and set explicitly
- [ ] Heat does not go negative
- [ ] Max Heat cap is 10 (after Inner Flame played)
- [ ] Phoenix Rise respects max heat cap during conversion
- [ ] Heat threshold bonuses apply correctly (3+, 5+, 8+)
- [ ] Inner Flame triggers at start of turn (not end)

### 3. Buff System Validation

- [ ] Forge's "next 2 Fire cards" buff stacks correctly
- [ ] Buffs expire after correct number of uses
- [ ] Playing non-Fire cards does not consume Fire buff
- [ ] Multiple Forge effects stack additively
- [ ] Buffs expire on turn end (if applicable)

### 4. First-Turn Behavior

- [ ] Inner Flame does not trigger on the turn it's played (only subsequent turns)
- [ ] Turn counter starts at 1 (not 0) for first player turn
- [ ] Turn-start effects fire in correct order

### 5. UI/UX Validation

- [ ] Heat bar displays correctly with values 0–10
- [ ] Heat threshold markers visible (3, 5, 8)
- [ ] Shield display shows heat-to-shield conversion
- [ ] Buff icons visible and understandable
- [ ] Card art renders for all 8 new cards

### 6. Regression Checks

- [ ] Phase 1–4 Ember cards still function correctly
- [ ] Heat mechanics for existing cards unchanged
- [ ] No new edge cases introduced to other characters

---

## Validation Checkpoints 🔍

### Checkpoint 1: Design-to-Code Sync

**Who:** QA + Hideo (Design)  
**When:** After initial implementation, before testing

- [ ] Each card matches design doc exactly (cost, damage, effects)
- [ ] No "implementation shortcuts" that diverge from spec
- [ ] Edge case behaviors documented and agreed upon

**Exit signal:** Design sign-off on implementation fidelity

---

### Checkpoint 2: Unit Test Coverage

**Who:** John (Code) + QA  
**When:** After implementation complete

- [ ] Test: Heat gain/loss/spend operations
- [ ] Test: Phoenix Rise heat-to-shield conversion
- [ ] Test: Steady Heat "set to exactly 4"
- [ ] Test: Buff stacking and expiration
- [ ] Test: Inner Flame passive trigger
- [ ] Test: Ever Burning conditional damage

**Exit signal:** All tests pass, ≥80% coverage on new mechanics

---

### Checkpoint 3: Manual Playtest Pass

**Who:** QA + Playtester  
**When:** After unit tests pass

- [ ] Play a full combat encounter using new cards
- [ ] Verify each card feels playable and balanced
- [ ] Test heat management decisions feel strategic
- [ ] Verify "controlled burn" fantasy lands correctly
- [ ] No crashes, freezes, or softlocks

**Exit signal:** Successful 3+ combat runs with new deck

---

### Checkpoint 4: Integration & Regression

**Who:** QA  
**When:** After playtest pass

- [ ] Existing Phase 1–4 Ember deck still works
- [ ] Cross-character balance not negatively impacted
- [ ] Save/load preserves heat, shield, and buff states
- [ ] No console errors or warnings

**Exit signal:** Full regression test completed

---

### Checkpoint 5: Art & UI Final

**Who:** Yoshi (Art) + QA  
**When:** After integration pass

- [ ] All 8 card artworks delivered and rendering
- [ ] UI elements (heat bar, buff icons) functional
- [ ] No missing textures or placeholders
- [ ] Readable at standard play resolution

**Exit signal:** Art assets approved, no visual bugs

---

## Known Risks (From QA-006A Risk List)

| Risk ID | Risk | Mitigation in Exit Criteria |
|---------|------|------------------------------|
| R-001 | Design/Code divergence | Checkpoint 1 requires design sign-off |
| R-002 | Complex heat mechanics | Checkpoint 2 requires unit tests for each heat interaction |
| R-003 | Effect execution duplication | Code review before Checkpoint 2 |
| R-004 | Turn counter edge case | Explicit first-turn test in Pass Conditions |
| R-005 | No test coverage | Checkpoint 2 mandates test coverage |
| R-006 | Missing card art | Checkpoint 5 requires art delivery |
| R-007 | Buff stacking undefined | Buff validation in Pass Conditions |
| R-008 | Max heat cap UI | UI validation in Pass Conditions |

---

## Go / No-Go Criteria

### Go if ✅

- All Pass Conditions marked complete
- All 5 Checkpoints passed
- Zero P0 bugs open
- Design sign-off obtained
- Playtester feedback positive

### Hold if ⚠️

- Any Pass Condition incomplete
- P0 or P1 bugs remain open
- Design-doc mismatch unresolved
- Art assets missing
- Regression failures detected

---

## Related Documents

- `docs/gdd/ember-phase5-6-cards.md` — Phase 5–6 design specification
- `tests/qa/qa-006a-risk-list.md` — Identified risks for this phase
- `tests/qa/test-scenarios-card-system.md` — Test scenario patterns
- `tests/qa/balance-ember.md` — Ember balance context
- `docs/qa/post-launch-patch-workflow.md` — Patch process reference

---

## Sign-Off

| Role | Name | Status |
|------|------|--------|
| QA | Sakura 🌸 | Document Ready |
| Design | Hideo | Pending sign-off |
| Code | John | Pending implementation |
| Art | Yoshi | Pending delivery |

---

*End of Exit Criteria — QA-006A*
