# Emotion Cards Four — v1 Quality Bar

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** QA-V1-001
- **Purpose:** Define the v1 quality bar based on what was learned from prototype QA execution
- **Status:** Draft for active production use
- **Reference:** `projects/emotion-cards-four/tests/prototype-validation-plan.md`, `projects/emotion-cards-four/prototype-milestone-wrapup.md`
- **Prototype learnings source:** QA-003 execution findings, Issue #11, Issue #12

---

## 1. What Changed From Prototype to v1

The prototype QA pass taught us concrete lessons that must shape the v1 quality bar:

### Lesson 1 — "it runs" is not the same as "it is playable"
Issue #11 exposed that source presence and even server serving do not mean the prototype is interactive. The play action was hard-disabled for multiple iterations before it was caught. For v1, **playability must be verified through live interaction, not source inspection alone**.

### Lesson 2 — debug visibility does not equal readable UX
Issue #12 showed that rich debug/state output can exist while the player-facing readable surface remains insufficient. For v1, **user-facing readability must be validated separately from developer-visible state dumps**.

### Lesson 3 — the QA pipeline itself was validated
Issue #11 was caught during QA execution, not during code review. This confirms the value of browser-level QA against served builds rather than relying on static analysis or "it looks fine in the source." For v1, **builds must be QA'd against served output, not just reviewed for code correctness**.

### Lesson 4 — non-blocking UX issues compound in v1
Issue #12 started as a minor readability gap and persisted through multiple iteration passes. In v1, where scope and audience are broader, the quality bar must catch these earlier. For v1, **readability and UX clarity gates must be explicit, not deferred**.

---

## 2. v1 Quality Bar Principles

### Principle 1 — Playability is the first gate
Before any feature or content quality is assessed, the build must be demonstrably interactive in a served environment. If the primary actions are not usable, nothing else matters.

### Principle 2 — Readability is a user outcome, not a developer impression
State is not readable just because it is visible in debug output. Readability means a new player can understand the current situation, what happened, and what to do next — without toggling debug views or receiving moderator rescue.

### Principle 3 — Functional correctness and UX quality are separate gates
A feature can be technically correct — the right logic, right data, right transitions — and still fail if the player cannot understand what is happening or what to do. Both must pass independently.

### Principle 4 — Audience-fit validation must be proactive, not retrospective
By the time v1 reaches external audiences, internal validation should already have confirmed that the concept, tone, and usability work for the intended overlap of strategy and narrative players.

### Principle 5 — Issues found in QA must close with evidence, not assumptions
When QA files a finding, the fix must be verified by rerunning the affected QA path, not by developer self-assessment or chat confirmation.

---

## 3. v1 QA Gates

### Gate 0 — Build Readiness
Before any v1 feature is marked ready for QA, it must pass:
- [ ] served build exists and is accessible
- [ ] primary interaction path is demonstrably usable without debug views
- [ ] no hardblocked UI states exist on the main flow
- [ ] git identity and workspace repo are verified before check-in

### Gate 1 — Functional Completeness
Each feature must pass:
- [ ] all planned interactions are implemented and respond to input
- [ ] state transitions work as specified in the design baseline
- [ ] no console errors in normal gameplay flow
- [ ] package legality rules enforce correctly and give clear feedback on rejection
- [ ] result states (breakthrough, partial, stalemate, collapse) are visually distinct and legibly triggered

### Gate 2 — Readability and UX Clarity
Each feature must pass:
- [ ] a new player can identify the current situation without moderator explanation
- [ ] a new player can explain what happened after a play without debug output
- [ ] the "next useful action" is visible in the player-facing surface, not only in debug
- [ ] card roles, text density, and UI hierarchy do not require repeated rereads to act
- [ ] result feedback is legible and causally traceable — players can explain why a result happened

### Gate 3 — Integration and Drift
Each feature must pass:
- [ ] new work does not reintroduce a previously fixed blocker (e.g. play action disabled)
- [ ] new work does not break the existing interaction path
- [ ] new content is compatible with the locked card schema and vocabulary
- [ ] carry-forward between encounters works as designed
- [ ] save/resume does not corrupt state

### Gate 4 — Audience-Fit Validation
Before external-facing milestones:
- [ ] at least 8-10 moderated test sessions have been run with the target audience segments
- [ ] comprehension score meets the v1 bar (see Section 4)
- [ ] replay intent score meets the v1 bar
- [ ] tone acceptance score meets the v1 bar
- [ ] no segment shows a dominant pattern of "this is not for me because the concept is unclear"
- [ ] Issue #12 (next useful action visibility) has been rerun and cleared before external release

### Gate 5 — Release Readiness
Each release candidate must pass:
- [ ] all Gate 1-4 criteria are met or explicitly waived with documented rationale
- [ ] no open priority-1 or priority-2 issues remain unaddressed
- [ ] build has been tested in a clean environment, not just the developer's local setup
- [ ] QA has signed off with actual execution evidence, not just build verification

---

## 4. v1 Success Criteria

### Comprehension
- **85%+** can correctly identify the game as a card-driven emotional strategy experience
- **75%+** can explain the turn loop in plain language without moderator rescue
- **75%+** recognize that emotions and context influence gameplay outcomes

### Replay Intent
- **65%+** say they would play another run or session
- **80%+** can name at least one specific thing they want to explore next

### Audience Fit
- both primary segments (strategy-familiar and narrative/reflective) produce at least **moderately positive** reception
- neither segment shows a dominant "the concept is unclear" rejection pattern
- the game is not primarily read as therapy, education, or generic card combat

### Readability
- no more than **1 recurring severe readability blocker** per release candidate
- **85%+** can identify the purpose of core cards without explanation
- **80%+** can tell what changed after a play without debug output
- Issue #12 (next-action guidance) is cleared before external release

### Tone Acceptance
- **75%+** react positively or neutrally to the emotional framing
- fewer than **25%** describe the tone as preachy, confusing, or mismatched with the gameplay

### Functional Stability
- no hardblocked primary actions in the main gameplay loop
- no data loss or state corruption in save/resume
- no console errors in normal flow

---

## 5. Issue Severity Classification for v1

Issues found in v1 QA must be classified by severity and treated accordingly:

### Priority 1 — Hard Blocker
- primary action is unusable (e.g. play button stays disabled)
- data loss or state corruption
- crash or hard error preventing gameplay
- **Action:** must be fixed before any further QA or release

### Priority 2 — Significant UX Failure
- new player cannot complete the first session without moderator rescue
- result state is invisible or indistinguishable from other states
- tone is consistently read as therapy/education by target audience
- **Action:** must be addressed before external release

### Priority 3 — Moderate UX Friction
- readability requires repeated rereads or explanation
- "next useful action" is not visible without debug views
- card text or UI causes consistent hesitation but does not fully block progress
- **Action:** should be fixed before external release; tracked for v1 patch if deferred

### Priority 4 — Minor Polish
- cosmetic inconsistency
- non-critical wording improvements
- optimization not affecting playability
- **Action:** tracked for future polish pass; does not block release

---

## 6. QA Execution Changes for v1

### Browser-level validation is mandatory
Source inspection and static analysis are not sufficient gates. Every QA pass must include live browser interaction against a served build.

### Debug state and player-facing surface must both be verified
QA must check both the debug/state output and the player-visible surface. A build that passes one but fails the other is not ready.

### Issues must be verified with evidence before closing
When an issue is filed and a fix is claimed, the fix must be verified by rerunning the affected QA path and posting the actual execution result — not by chat confirmation or self-assessment.

### Narrow iteration discipline must hold
When a fix is needed, it should be scoped precisely to the identified gap. Scope expansion during iteration is a drift risk, not QA discipline.

---

## 7. Key Differences: Prototype QA vs v1 QA

| Dimension | Prototype QA | v1 QA |
|---|---|---|
| Primary goal | Is the concept runnable and testable? | Is v1 ready for its intended audience? |
| Playability gate | Basic interactive path works | Every primary action is reliably usable |
| Readability standard | Usable if debug surface is clear | Readable from player-facing surface only |
| Audience scope | Internal team + trusted peers | Broader target audience segments |
| Blocker threshold | Issues that stop testing | Issues that stop a new player from completing a session |
| Issue close standard | Fix verified by developer | Fix verified by QA rerun |
| Scope for iteration | Narrow functional fixes | Narrow UX and integration fixes only |

---

## 8. Relationship to Other v1 Deliverables

This document sets the **quality bar** for v1. It must be read alongside:
- `projects/emotion-cards-four/gdd/flagship-mode-rules.md` — v1 design expectations
- `projects/emotion-cards-four/art/art-scope-sheet.md` — v1 art and UX targets
- `projects/emotion-cards-four/src/card-schema-and-content-integration.md` — v1 technical/schema expectations
- `projects/emotion-cards-four/tests/prototype-test-cases.md` — executable v1 test cases (to be updated from prototype learnings)
- `projects/emotion-cards-four/production/v1-planning-baseline.md` — v1 planning context

---

**Canonical file:** `projects/emotion-cards-four/tests/v1-quality-bar.md`
