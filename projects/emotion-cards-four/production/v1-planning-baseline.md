# Emotion Cards Four — v1 Planning Consolidation

## Document Overview
- **Project:** Emotion Cards Four
- **Task IDs:** PROD-001, DES-V1-001, ART-V1-001, DEV-V1-001, QA-V1-001, MKT-V1-001 (pending)
- **Status:** Active v1 production baseline
- **Date:** 2026-03-25
- **Supersedes:** `production/v1-planning-baseline.md` (PROD-001)

---

## Consolidated v1 Inputs

This document merges the original v1 planning baseline with the fresh v1 planning pass completed after prototype validation:

### Original baseline inputs (still valid)
- `production/market-brief.md`
- `production/prototype-validation-messaging-plan.md`
- `gdd/flagship-mode-rules.md`
- `gdd/prototype-card-taxonomy.md`
- `art/art-scope-sheet.md`
- `art/style-exploration-pass.md`
- `art/ui-readability-targets.md`
- `art/ui-component-system-requirements.md`
- `src/prototype-architecture-baseline.md`
- `src/card-schema-and-content-integration.md`
- `src/README-prototype-slice.md`
- `tests/prototype-validation-plan.md`
- `tests/prototype-test-cases.md`

### New v1 pass inputs
- `gdd/v1-flagship-mode-rules.md` — DES-V1-001 ✅
- `production/art-v1-scope-update.md` — ART-V1-001 ✅
- `src/dev-v1-architecture-next-items.md` — DEV-V1-001 ✅
- `tests/v1-quality-bar.md` — QA-V1-001 ✅
- `production/market-v1-update.md` — MKT-V1-001 ⏳ (pending)

---

## Prototype Milestone Summary

**Prototype is functionally complete.** Core interaction works. Known issues tracked:
- **Issue #11** (play action blocker) — fixed ✅
- **Issue #12** (UX next-action guidance gap) — tracked as v1 requirement, not prototype polish ✅

**Prototype validation results:**
- `tests/prototype-validation-results.md` — commit `4d0eb10`
- `prototype-milestone-wrapup.md` — commit `f7bc353`

---

## What Changed From Prototype Baseline to v1

### Design (DES-V1-001 — @Hideo)
The v1 flagship mode rules lock explicit behavior that was ambiguous in the prototype:
- Encounter template schema — field-by-field lock
- Outcome evaluation — explicit condition logic (breakthrough/partial/stalemate/collapse/continue)
- Phase model — behavioral rules clarified for `read_situation` and `play_response`
- Turn pressure — standing rule locked (tension +1 after turn 4)
- Collapse armed — explicit definition as visible warning state
- Max turns — 6 as default with rationale
- Breakthrough surfacing — explicit trigger condition locked
- Failed play tracking — new addition
- Encounter keyword canonical list — now part of rules doc

**5 open questions still needing resolution before v1 lock:**
1. Encounter count per run — 3 as default or configurable?
2. Breakthrough card play timing — same turn or next turn after surfacing?
3. Hand size — keep at 4 or increase?
4. Difficulty scaling — per-encounter variants or uniform?
5. Encounter template count — how many needed for meaningful v1 content review?

These are tracked as **v1 design decisions pending** — must be resolved in DES-V1-002 or by producer decision.

### Art (ART-V1-001 — @Yoshi)
Issue #12 UX requirement formally added to v1 art scope:
- **Next-Action Cue (NAC)** component — dedicated visual treatment required
- Run-state surface refresh to accommodate NAC without crowding
- Expanded card frame variant set for v1 content beyond prototype
- Portrait/emotion overlay system rollout
- Expanded icon library for new keywords and encounter states
- v1 HUD shell with NAC slot
- Introduction/tutorial UI for first-session on-ramp

### Engineering (DEV-V1-001 — @John)
5 concrete architectural next items identified:
1. **Breakthrough unlock flow** — real condition evaluation, not static map (High)
2. **Canonical tag vocabulary + startup validation** — prevent freeform string chaos (High)
3. **Encounter-specific carry-forward** — implement `carry_forward` effect type (Medium-High)
4. **Run summary / aggregate metrics export** — structured report for validation teams (Medium)
5. **Engine/UI separation** — testable headless, swappable UI (High)

**Top 3 for earliest v1 scoping:** Engine/UI separation → Breakthrough unlock → Canonical vocabulary

### QA (QA-V1-001 — @Sakura)
v1 quality bar defined with 4 lessons from prototype:
1. "It runs" ≠ "it's playable" — must verify through live interaction
2. Debug visibility ≠ readable UX — player-facing surface must be validated separately
3. QA pipeline validated — browser-level execution catches what source inspection misses
4. Non-blocking UX issues compound in v1 — readability gates must be explicit, not deferred

**5 v1 QA gates:**
1. Build Readiness
2. Functional Completeness
3. Readability and UX Clarity
4. Integration and Drift
5. Release Readiness

**5 v1 success criteria:** comprehension 85%+, replay intent 65%+, audience fit, readability 85%+, tone acceptance 75%+

**Prototype vs v1 QA:** v1 is broader audience scope, higher playability bar, separate UX gates, evidence-based issue closure required.

### Marketing (MKT-V1-001 — @Gabe) ⏳
Pending. Will update market brief with v1 audience-fit validation path based on prototype learnings.

---

## v1 Product Positioning

**Unchanged from baseline:**
- social-empathy card game
- readable emotional stakes, replayable scenario structure, expressive player choices, socially legible consequences
- Avoid: therapy, education, self-help, hardcore deckbuilder
- Lane: **clean systems, human warmth, no melodrama**

---

## v1 Design Baseline

**Locked elements from DES-V1-001:**
- 4 resolution states (breakthrough, partial, stalemate, collapse)
- 5-state encounter model (Tension, Trust, Clarity, Momentum, Response Windows)
- 8-step turn structure
- Encounter opposition model
- Carry-forward system
- Breakthrough surfacing logic
- 5 card categories: Emotion, Memory, Reaction, Shift, Breakthrough
- 24 core prototype cards + 3 breakthrough cards
- Canonical encounter keyword list (10 keywords)

**New v1 rules additions:**
- Explicit encounter template schema
- Explicit outcome evaluation conditions
- Phase behavioral rules clarified
- Turn pressure standing rule
- Collapse armed definition and visibility
- Max turns = 6 default
- Failed play tracking

**Pending decisions (must resolve before v1 lock):**
- Encounter count per run
- Breakthrough card play timing
- Hand size
- Difficulty scaling
- Encounter template count

---

## v1 Art / UX Baseline

**Prototype baseline still valid** with additions from ART-V1-001:
- template-first card system, 5 reusable frame families, shape-first icon system
- Next-Action Cue (NAC) component — **new v1 requirement**
- Run-state surface refresh pass required
- Expanded card frame variants for v1 content
- Portrait/emotion overlay system rollout
- Expanded icon library for new keywords/states
- v1 HUD shell with NAC accommodation
- Introduction/tutorial UI for first-session

**NAC design principles:**
- readable at a glance, survives stream capture
- feels like readable context, not instruction
- follows Calm Diagnostic style lane
- 4 states: active recommendation, neutral, no signal, locked
- never raw engine language

**NAC placement in HUD hierarchy:**
1. encounter prompt
2. state meters (T/C/C/M)
3. response window indicators
4. **Next-Action Cue (NAC)**
5. focused-card panel
6. hand cards
7. turn summary strip

---

## v1 Engineering Baseline

**Prototype architecture still valid** with additions from DEV-V1-001:

### Immediate v1 architectural needs:
1. **Engine/UI separation** — `GameEngine` class with no DOM dependencies, `UIRenderer` observes and updates DOM, clean boundaries for headless testing
2. **Breakthrough unlock flow** — real `BreakthroughManager` evaluating unlock conditions against live encounter state, not static map
3. **Canonical tag vocabulary** — `vocabulary.ts` with constants for all tags, intent tags, tone tags, risk tags, window IDs, keywords, stat names; startup validation pass

### Medium-term v1 needs:
4. **Encounter-specific carry-forward** — per-encounter rules, narrative flag hooks, reward choice UI support
5. **Run summary export** — `RunSummaryGenerator`, defined metric shapes, structured validation report

---

## v1 QA Baseline

**v1 quality bar from QA-V1-001:**

### 5 Gates:
1. **Build Readiness** — served build accessible, primary path usable, no hardblocked UI
2. **Functional Completeness** — all interactions work, transitions correct, no console errors, package legality enforced, result states distinct
3. **Readability and UX Clarity** — new player can identify situation/action/result without debug or rescue
4. **Integration and Drift** — no regression of fixed issues, no broken existing paths, content schema compatible, carry-forward works, save/resume stable
5. **Release Readiness** — all gates met or explicitly waived, no open P1/P2 issues, clean environment tested, QA sign-off with evidence

### Issue severity:
- **P1 Hard Blocker** — primary action unusable, data loss, crash → fix before any further QA
- **P2 Significant UX Failure** — new player can't complete session, invisible result state, tone rejected → fix before external release
- **P3 Moderate UX Friction** — readability friction, next-action not visible → fix before external release, track if deferred
- **P4 Minor Polish** — cosmetic, wording, optimization → future polish pass

### Key execution rules:
- Browser-level validation mandatory (not just source inspection)
- Debug surface AND player-facing surface both verified
- Issues close with QA rerun evidence, not chat confirmation
- Narrow iteration discipline maintained

---

## v1 Critical Path

**From prototype to v1 active work:**

1. DES-V1-001 ✅ → 5 open questions still pending resolution
2. ART-V1-001 ✅ → NAC and v1 art scope additions required
3. DEV-V1-001 ✅ → Engine/UI separation enables everything else
4. QA-V1-001 ✅ → Quality bar defined
5. MKT-V1-001 ⏳ → Market brief update pending

**Immediate next steps after this consolidation:**
- Resolve the 5 open design questions (producer + designer)
- MKT-V1-001 to complete market brief update
- Begin DEV-V1-002: Engine/UI separation (John, earliest v1 scoping)
- Begin DES-V1-002: Card taxonomy and content update informed by v1 rules lock
- Begin QA-V1-002: Update prototype test cases with v1 quality bar criteria

---

## Open v1 Issues

| Issue | Description | Status |
|-------|-------------|--------|
| #11 | Play action blocker | Fixed ✅ |
| #12 | Next-action guidance UX gap | v1 requirement — tracked in ART-V1-001 ✅ |
| DES-V1-001 open questions (5) | Encounter count, breakthrough timing, hand size, difficulty scaling, template count | Pending resolution |

---

## Baseline Status

**v1 planning baseline is established and active.**

All sections updated from fresh v1 planning pass. MKT-V1-001 pending — market brief update will be folded in upon completion.
