# QA-006A Risk List — Emotion Cards Phase 5 / v0.6.0

**Date:** 2026-03-19  
**Tester:** Sakura 🌸  
**Branch:** `release/v0.5.0`  
**Status:** Draft for Review

---

## Overview

This document identifies known risk areas, potential failure points, and areas needing extra validation for the upcoming Phase 5 (Controlled Burn) and Phase 6 (Ember) milestone. Risks are derived from Phase 3-4 QA findings, design doc review, and system-level concerns.

> **Note:** If Phase 3-4 design/code mismatches haven't been resolved, they will propagate to Phase 5-6 implementation.

---

## Risk Categories

### 🔴 High Priority

#### R-001: Phase 3-4 Design/Code Divergence Carries Forward

**Source:** QA-004 Bug Sweep  
**Likelihood:** High  
**Impact:** Critical

The Phase 3-4 bug sweep found that implemented Ember cards do not match the design doc (`ember-phase3-4-cards.md`). If this isn't fixed before Phase 5-6 work begins, the same pattern will repeat.

**Risk:** Phase 5-6 cards (Bonfire, Forge, Phoenix Rise, etc.) may be implemented without reference to the actual design doc, creating another source-of-truth mismatch.

**Mitigation:** 
- Verify all Phase 5-6 cards against `docs/gdd/ember-phase5-6-cards.md` before implementation
- Require design sign-off on each card before code review

---

#### R-002: Complex Heat Mechanics Not Validated

**Source:** Phase 5-6 Design Doc  
**Likelihood:** High  
**Impact:** Critical

Phase 5-6 introduces sophisticated heat mechanics:
- Heat as resource (Tempered Steel: spend heat for shield)
- Heat-to-shield conversion (Phoenix Rise: 1 Heat = 1 Shield)
- Heat thresholds (3+/5+/8+ give different bonuses)
- Passive heat generation (Inner Flame: +1/turn)
- Set-heat-to-value (Steady Heat: set Heat = 4)

**Risk:** These mechanics interact in complex ways that haven't been tested:
- What happens if heat goes negative?
- Does Phoenix Rise respect max heat cap?
- Does Inner Flame trigger before or after turn-start effects?
- Does Steady Heat's "set to 4" override or add to existing heat?

**Mitigation:** Create explicit test cases for each heat interaction.

---

#### R-003: Card Effect Execution Path Duplication

**Source:** QA-004 Bug Sweep (Finding #5)  
**Likelihood:** Medium  
**Impact:** High

Phase 3-4 had two parallel effect execution methods (`execute_card_effect` vs `execute_card`) with different behavior. If this wasn't cleaned up, Phase 5-6 cards will inherit the same problem.

**Risk:** New cards could use the wrong execution path, leading to:
- Double energy spending
- Inconsistent shield creation
- Buffs not applying correctly

**Mitigation:** Verify only one execution path exists; add assertions in code.

---

### 🟠 Medium Priority

#### R-004: Turn Counter Edge Case Still Unfixed

**Source:** QA-004 Bug Sweep (Finding #4)  
**Likelihood:** Medium  
**Impact:** Medium

The first player turn starts with `turn_count == 0` because `CombatStateMachine.reset_combat()` sets state directly to `PLAYER_TURN` without incrementing.

**Risk:** Phase 5-6 cards like Inner Flame that depend on turn number (`start of each turn`) could fire incorrectly in the first turn.

**Mitigation:** Verify first-turn behavior in playtesting; fix turn counter before Phase 5-6.

---

#### R-005: No Test Coverage for Phase 5-6 Cards

**Source:** Test Scenario Doc Gap  
**Likelihood:** High  
**Impact:** Medium

`tests/qa/test-scenarios-card-system.md` has no Ember-specific tests. Phase 5-6 adds:
- Passive abilities (Inner Flame)
- Buff/dot stacking (Forge: next 2 Fire cards get +3)
- Conditional damage (Bonfire: if 3+ Heat)
- Ultimate abilities (Phoenix Rise)
- Set-heat mechanics

**Risk:** New mechanics will ship without explicit test coverage.

**Mitigation:** Add test cases for:
- Passive trigger timing
- Buff stacking/expiration
- Conditional card effects
- Heat boundary conditions (0, max, negative)

---

#### R-006: Card Art Paths Not Created

**Source:** QA-004 Bug Sweep (Finding #3)  
**Likelihood:** Medium  
**Impact:** Medium

Ember card art paths point to `assets/cards/ember/<card_id>.png` which don't exist.

**Risk:** Phase 5-6 cards will render with missing textures if art isn't delivered. UI may crash or show blanks.

**Mitigation:** Verify art asset delivery timeline; add fallback rendering in code.

---

#### R-007: Buff/Debuff Stacking Rules Undefined

**Source:** Phase 5-6 Design  
**Likelihood:** Medium  
**Impact:** Medium

Forge gives "next 2 Fire cards deal +3 damage" — but:
- Does this stack with other buffs?
- Does it expire on turn end?
- Does playing non-Fire cards consume the buff count?
- What happens if you have two Forge effects?

**Risk:** Buff implementation will be inconsistent with player expectations.

**Mitigation:** Document buff stacking rules in GDD; verify in tests.

---

#### R-008: Max Heat Cap Increase Not Validated

**Source:** Phase 5-6 Design (Inner Flame)  
**Likelihood:** Low  
**Impact:** Medium

Inner Flame increases max Heat from default (likely 8) to 10.

**Risk:** UI elements (heat bars, thresholds) may not accommodate the new max. Balance assumptions about high-heat states may break.

**Mitigation:** Test UI with heat=10; verify all threshold checks (3+, 5+, 8+) work correctly.

---

### 🟡 Low Priority

#### R-009: Core Mechanics Doc Conflict Still Unresolved

**Source:** QA-004 Bug Sweep (Finding #7)  
**Likelihood:** Low  
**Impact:** Low

Core mechanics doc says Fire + Warmth causes conflict, but Ember Phase 4 design treats Fire/Warmth hybridization as intended progression.

**Risk:** Rules confusion during implementation; may affect how heat interactions work in Phase 5-6.

**Mitigation:** Clarify the rule; update docs.

---

#### R-010: Deck Configuration for Phase 5-6

**Source:** Design Doc  
**Likelihood:** Low  
**Impact:** Low

Phase 5-6 adds 8 cards (17-24). Deck size increases significantly.

**Risk:** Deck configuration code (`ember_card_factory.gd`) may not handle the new deck size correctly; may affect draw/hand limits.

**Mitigation:** Verify deck builds correctly with all 24 Ember cards.

---

## Areas Needing Extra Validation

| Area | Why | Suggested Approach |
|------|-----|-------------------|
| Heat conversion (Phoenix Rise) | New mechanic, complex interaction | Manual playtest + automated unit test |
| Buff stacking (Forge) | Undefined rules | Trace code paths, document behavior |
| First-turn behavior | Known turn counter bug | Verify with Inner Flame |
| Card art pipeline | Known missing assets | Verify asset delivery schedule |
| Design/doc sync | Phase 3-4 precedent | Require design sign-off per card |
| UI heat bar scaling | Max heat increase | Visual inspection at heat=10 |

---

## Recommended QA Activities Before Release

1. **Design/Code Sync Check** — Verify each Phase 5-6 card matches design doc
2. **Heat Mechanic Test Suite** — Create explicit tests for all heat interactions
3. **First-Turn Validation** — Playtest opening hand with Inner Flame
4. **Buff System Review** — Document and test stacking rules
5. **Art Asset Audit** — Confirm all Phase 5-6 card art exists
6. **Deck Configuration Test** — Verify full 24-card deck builds and draws correctly

---

## Related Documents

- `docs/gdd/ember-phase5-6-cards.md` — Phase 5-6 design
- `tests/qa/qa-004-bug-sweep.md` — Phase 3-4 findings
- `tests/qa/test-scenarios-card-system.md` — Existing test coverage
- `tests/qa/balance-ember.md` — Ember balance notes

---

*End of Risk List*
