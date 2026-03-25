# Emotion Cards Four — v1 Test Cases

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** QA-V1-002
- **Purpose:** Update prototype test cases with v1 quality bar criteria, Gate 1–5 framework, locked design constants, and issue severity classification for v1 production
- **Status:** Active v1 test baseline
- **Supersedes:** `projects/emotion-cards-four/tests/prototype-test-cases.md`
- **References:**
  - `projects/emotion-cards-four/tests/v1-quality-bar.md` — v1 quality bar, gates, severity
  - `projects/emotion-cards-four/gdd/v1-flagship-mode-rules.md` — locked v1 design rules
  - `projects/emotion-cards-four/src/dev-v1-architecture-next-items.md` — engine/UI separation scope

---

## 1. How to Use This Document

Each test case includes:
- **Case ID** — unique identifier
- **Gate** — which v1 QA gate this case belongs to (Gate 0–5)
- **Purpose** — what is being verified and why
- **Setup** — preconditions for the test
- **Steps** — exact actions to take
- **Expected Results** — what a passing result looks like
- **Failure Classification** — which severity level this failure maps to if it fails

Severity mapping:
- **P1** — hard blocker; must fix before any further QA or release
- **P2** — significant UX failure; must address before external release
- **P3** — moderate friction; should fix before release, tracked if deferred
- **P4** — minor polish; does not block release

---

## 2. Gate 0 — Build Readiness

Before any v1 feature enters QA, these must all pass. Any Gate 0 failure is P1.

### V1-TC-G0-01 — Served build is accessible
**Gate:** 0
**Purpose:** Confirm the v1 build is actually servable and reachable via HTTP.

**Steps:**
1. Serve the build via the standard local server command
2. Attempt to reach `http://127.0.0.1:PORT/index.html`
3. Confirm HTTP 200 response within 5 seconds

**Expected Results:**
- build serves without error
- page loads in browser

**Failure Classification:** P1 if build cannot be served or reached

---

### V1-TC-G0-02 — Primary interaction path is usable without debug views
**Gate:** 0
**Purpose:** Confirm the core play action is enabled and usable in the player-facing UI, not only in debug state.

**Steps:**
1. Load the served build
2. Start a new run
3. Attempt to click the primary action control using the player-visible label (e.g. "Play Selected Cards")
4. Do NOT use debug views, state dumps, or browser devtools to determine pass/fail

**Expected Results:**
- primary action control is enabled and responds to click
- no moderator rescue or devtools needed

**Failure Classification:** P1 — hard blocker if primary action stays disabled in player-facing UI

---

### V1-TC-G0-03 — No hardblocked UI states on main flow
**Gate:** 0
**Purpose:** Ensure no permanently disabled controls exist on the primary gameplay path.

**Steps:**
1. Walk through the main gameplay loop: start run → play cards → advance through encounters
2. Observe all interactive controls during each phase
3. Confirm no control required for normal play is permanently disabled

**Expected Results:**
- every control needed for normal play is enabled at the appropriate phase
- no controls required for the happy path are stuck in a disabled state

**Failure Classification:** P1 for primary flow controls; P3 for non-essential UI

---

### V1-TC-G0-04 — Git identity verified before check-in
**Gate:** 0
**Purpose:** Confirm the correct owner identity is configured in the workspace repo before any check-in.

**Steps:**
1. Run `git config user.name` and `git config user.email` in the workspace repo
2. Confirm the output matches the expected owner identity

**Expected Results:**
- git identity is set to the correct owner name and email for this workspace

**Failure Classification:** P3 — process violation if identity is wrong at check-in time

---

## 3. Gate 1 — Functional Completeness

Each feature must pass all Gate 1 cases before advancing to Gate 2.

### V1-TC-G1-01 — All planned interactions respond to input
**Gate:** 1
**Purpose:** Confirm every specified interaction in the v1 design baseline is implemented and interactive.

**Steps:**
1. Review the v1 design baseline for the full list of expected interactions
2. Attempt each interaction in the served build
3. Record pass/fail for each

**Expected Results:**
- all specified interactions respond to input
- no interaction silently does nothing

**Failure Classification:** P1 for primary interactions; P3 for secondary

---

### V1-TC-G1-02 — State transitions work as specified
**Gate:** 1
**Purpose:** Verify the eight-step turn structure and phase transitions operate as locked in v1-flagship-mode-rules.md.

**Reference:** v1-flagship-mode-rules.md Section 2.3 — Phase Model

**Steps:**
1. Begin a run and advance through each phase in order
2. Confirm each phase transition occurs when expected
3. Confirm phase state updates (e.g. tension increase after turn 4, as per Section 2.4)

**Expected Results:**
- `read_situation` → `play_response` transition works
- `play_response` requires legal primary selection before submission is enabled
- `state_refresh` applies turn-pressure rule after turn 4
- phase order matches the locked eight-step model

**Failure Classification:** P1 for phase model violations; P2 for minor sequencing issues

---

### V1-TC-G1-03 — No console errors in normal gameplay
**Gate:** 1
**Purpose:** Confirm the build is free of JavaScript errors during normal play.

**Steps:**
1. Open browser devtools console
2. Walk through: start run → play 3 encounters → complete or collapse
3. Count and record any console errors

**Expected Results:**
- zero console errors in normal gameplay flow

**Failure Classification:** P1 for errors that prevent gameplay; P2 for non-blocking errors

---

### V1-TC-G1-04 — Package legality rules enforce correctly
**Gate:** 1
**Purpose:** Verify the locked package rules from v1-flagship-mode-rules.md are enforced with clear feedback.

**Reference:** v1-flagship-mode-rules.md Section 2.3 — Package Rules

**Steps:**
1. Attempt empty submission — no cards selected
2. Attempt Memory-only or Shift-only submission
3. Attempt double-primary submission
4. Attempt to play a breakthrough card that has not been surfaced

**Expected Results:**
- each illegal submission is rejected before state mutation
- clear validation message identifies the rule violated
- no game state changes from rejected attempts

**Failure Classification:** P1 if illegal package is accepted; P2 if rejection message is unclear

---

### V1-TC-G1-05 — Result states are visually distinct
**Gate:** 1
**Purpose:** Confirm the four result states (breakthrough, partial, stalemate, collapse) are each visually and textually distinct.

**Reference:** v1-flagship-mode-rules.md Section 2.2 — Outcome Evaluation

**Steps:**
1. Engineer each of the four result conditions in separate test runs:
   - **Breakthrough:** trust ≥ threshold AND clarity ≥ threshold AND momentum ≥ threshold AND breakthroughReady = true
   - **Partial Resolution:** at least 4 turns, trust ≥ 4 OR clarity ≥ 5, neither breakthrough nor collapse
   - **Stalemate:** 4+ turns, trust below threshold, no significant progress in 2 turns
   - **Collapse:** tension = 10 AND trust ≤ 2, OR failed plays ≥ 3 while tension ≥ 8
2. Observe the result display for each

**Expected Results:**
- each result displays with a distinct label, color, and explanation
- players can tell which result occurred without debug output

**Failure Classification:** P1 if results are indistinguishable; P2 if distinction exists but labeling is unclear

---

## 4. Gate 2 — Readability and UX Clarity

These cases verify the player-facing surface, not debug output. A build that passes Gate 1 but fails Gate 2 is NOT ready.

### V1-TC-G2-01 — New player can identify current situation without explanation
**Gate:** 2
**Purpose:** Confirm the player-facing UI communicates encounter state clearly on first load.

**Steps:**
1. Clear any prior session state
2. Load the build with no prior explanation or guidance
3. Without using debug views, answer:
   - What encounter am I in?
   - What is my current state (trust, tension, clarity, momentum)?
   - What response windows are open?

**Expected Results:**
- all three questions are answerable from the player-facing UI alone

**Failure Classification:** P2 — new player cannot complete the first session without rescue

---

### V1-TC-G2-02 — New player can explain what happened after a play without debug output
**Gate:** 2
**Purpose:** Confirm result feedback is legible from the player-facing surface, not only from debug/state dumps.

**Steps:**
1. Make a play in a known encounter state
2. Observe the player-facing feedback area (NOT the debug/state dump)
3. Ask: what changed and why?

**Expected Results:**
- player-facing feedback area shows what changed
- player can explain the outcome without opening debug views

**Failure Classification:** P2 if debug-only; P3 if feedback is present but hard to parse

---

### V1-TC-G2-03 — "Next useful action" is visible in player-facing surface
**Gate:** 2
**Purpose:** Confirm Issue #12's root requirement is addressed: players can see what to do next without debug context.

**Reference:** Issue #12, v1-quality-bar.md Gate 2

**Steps:**
1. Load the build at any mid-run state
2. Without debug views, identify: what should I do next?
3. Confirm the answer is visible in the main UI, not buried in a debug panel

**Expected Results:**
- a clear "what to do next" cue is visible in the player-facing surface
- cue is present during `read_situation` phase

**Failure Classification:** P2 — this was the root issue behind Issue #12

---

### V1-TC-G2-04 — Card roles and text density do not require repeated rereads
**Gate:** 2
**Purpose:** Confirm card hierarchy and wording support quick decision-making.

**Steps:**
1. Present a mixed hand of 4 cards from different categories
2. Ask a new player to sort by role (primary, support, shift) and choose the best play
3. Time the decision
4. Note any cards that required rereading or caused confusion

**Expected Results:**
- most players can sort and choose within a reasonable time
- no card requires more than one full re-read to understand its role

**Failure Classification:** P3 for consistent hesitation; P2 if players are consistently blocked

---

### V1-TC-G2-05 — Failed play feedback is legible and causally traceable
**Gate:** 2
**Purpose:** Confirm players understand why a play failed or produced a bad outcome.

**Reference:** v1-flagship-mode-rules.md Section 3.3 — Failed Play Tracking

**Steps:**
1. Make a play that triggers a risk rule (e.g. play `Concern` when tension ≥ 8)
2. Observe whether the risk consequence is explained in the player-facing feedback
3. Confirm the player can trace the bad outcome to the triggering play

**Expected Results:**
- risk consequences are visible in player-facing feedback
- cause-and-effect is traceable without debug output

**Failure Classification:** P3 if unclear; P2 if player cannot trace cause at all

---

## 5. Gate 3 — Integration and Drift

These verify that new work does not break what was already working.

### V1-TC-G3-01 — Previously fixed blocker does not reoccur
**Gate:** 3
**Purpose:** Confirm Issue #11's fix (play action enabled after legal primary selection) is not reintroduced.

**Steps:**
1. Start a new run
2. Select a legal primary card
3. Attempt to submit

**Expected Results:**
- `Play Selected Cards` is enabled after legal primary selection

**Failure Classification:** P1 — hard blocker reintroduction

---

### V1-TC-G3-02 — New work does not break existing interaction path
**Gate:** 3
**Purpose:** Confirm the core play loop from QA-002 still functions after engine/UI separation.

**Steps:**
1. Execute QA-002-TC-01 through QA-002-TC-04 against the v1 build
2. Compare results to the prototype baseline

**Expected Results:**
- primary-only play still works
- primary + support play still works
- illegal packages still rejected with clear feedback

**Failure Classification:** P1 for interaction path breakage; P2 for regression in edge cases

---

### V1-TC-G3-03 — Carry-forward between encounters works as designed
**Gate:** 3
**Purpose:** Confirm the carry-forward system from v1-flagship-mode-rules.md Section 1.5 operates correctly.

**Steps:**
1. Complete encounter 1 with known state changes
2. Observe the carry-forward state shown before encounter 2
3. Confirm the modifiers are applied correctly to encounter 2's starting stats

**Expected Results:**
- trust/tension/clarity/momentum modifiers carry forward correctly
- blocked windows carry forward correctly
- unlocked breakthroughs carry forward correctly

**Failure Classification:** P1 for incorrect carry-forward; P2 for display issues

---

### V1-TC-G3-04 — Save/resume does not corrupt state
**Gate:** 3
**Purpose:** Confirm the save system preserves complete and correct state.

**Steps:**
1. Play several turns, building up a complex state (mixed modifiers, partial progress)
2. Export save JSON
3. Clear session and resume from the exported save
4. Compare pre-save and post-resume state

**Expected Results:**
- all state values match pre-save exactly
- no fields are dropped or corrupted in resume

**Failure Classification:** P1 for data loss or state corruption

---

### V1-TC-G3-05 — Engine produces deterministic output for identical inputs
**Gate:** 3
**Purpose:** Verify the separated GameEngine (DEV-V1-002) produces identical results for the same input sequence.

**Reference:** dev-v1-architecture-next-items.md

**Steps:**
1. Create a known encounter state with specific inputs
2. Apply the same card play sequence twice
3. Compare state outputs

**Expected Results:**
- identical input sequences produce identical state outputs
- engine has no timing or randomness dependencies

**Failure Classification:** P1 for non-deterministic behavior in engine

---

## 6. Gate 4 — Audience-Fit Validation

These are executed with human participants, not automated. They gate external release.

### V1-TC-G4-01 — Comprehension score meets v1 bar
**Gate:** 4
**Purpose:** Confirm 85%+ of test participants can identify the game as a card-driven emotional strategy experience.

**Reference:** v1-quality-bar.md Section 4 — Comprehension criteria

**Steps:**
1. Run 8–10 moderated sessions with target audience segments
2. Ask: "What kind of game is this?"
3. Count responses that correctly identify it as a card-driven emotional strategy experience

**Expected Results:**
- 85%+ correctly identify the game type
- 75%+ can explain the turn loop without moderator rescue
- 75%+ recognize emotions as gameplay influence

**Failure Classification:** P2 if scores do not meet bar; P3 if scores are marginal

---

### V1-TC-G4-02 — Replay intent score meets v1 bar
**Gate:** 4
**Purpose:** Confirm 65%+ of participants want to play another run.

**Reference:** v1-quality-bar.md Section 4 — Replay Intent criteria

**Steps:**
1. After each session, ask: "Would you play another run?"
2. Count "yes" responses
3. Ask what specifically they would want to try next

**Expected Results:**
- 65%+ say yes
- 80%+ can name a specific thing they want to explore

**Failure Classification:** P2 if score is below bar; P3 if vague "maybe" answers dominate

---

### V1-TC-G4-03 — Tone acceptance score meets v1 bar
**Gate:** 4
**Purpose:** Confirm 75%+ react positively or neutrally to the emotional framing.

**Reference:** v1-quality-bar.md Section 4 — Tone Acceptance criteria

**Steps:**
1. After each session, ask: "How did the emotional framing land?"
2. Tag responses as positive, neutral, or negative (therapy/education/awkward)

**Expected Results:**
- 75%+ positive or neutral
- fewer than 25% describe tone as preachy, confusing, or mismatched

**Failure Classification:** P2 if tone is consistently read as therapy/education

---

### V1-TC-G4-04 — Issue #12 (next-action guidance) is cleared before external release
**Gate:** 4
**Purpose:** Confirm the specific Issue #12 failure mode is resolved in the v1 build.

**Reference:** Issue #12

**Steps:**
1. Perform V1-TC-G2-03 on the v1 build intended for external release
2. Confirm the "next useful action" is visible in the player-facing surface

**Expected Results:**
- V1-TC-G2-03 passes on the release candidate

**Failure Classification:** P2 — blocks external release until resolved

---

## 7. Gate 5 — Release Readiness

Final gate before a release candidate ships.

### V1-TC-G5-01 — All Gate 1–4 criteria are met or explicitly waived
**Gate:** 5
**Purpose:** Confirm no open P1 or P2 issues remain on the release candidate.

**Steps:**
1. Review all issue classifications from the current QA pass
2. Confirm all P1 and P2 issues are either:
   - fixed with verified evidence, OR
   - explicitly waived with documented rationale approved by producer

**Expected Results:**
- zero open P1 issues
- zero open P2 issues without documented waiver

**Failure Classification:** P1 if P1 issues remain; P2 if P2 issues remain without waiver

---

### V1-TC-G5-02 — Build tested in a clean environment
**Gate:** 5
**Purpose:** Confirm the build works in a fresh environment, not only in the developer's local setup.

**Steps:**
1. Test the release candidate in a clean browser environment (no localStorage, no extensions)
2. Confirm all Gate 0–1 checks pass

**Expected Results:**
- build loads and functions correctly in a clean environment

**Failure Classification:** P2 if environment differences cause failures

---

### V1-TC-G5-03 — QA sign-off with execution evidence
**Gate:** 5
**Purpose:** Confirm QA has verified the build with actual execution evidence, not just build existence.

**Steps:**
1. Review the QA log for this release candidate
2. Confirm evidence includes browser-level execution results (not just source inspection)
3. Confirm issue closure records include re-run evidence

**Expected Results:**
- QA log shows live execution evidence for all Gate 0–2 cases
- issue closures show actual re-run results, not chat confirmation

**Failure Classification:** P3 if evidence is missing; P2 if claims contradict actual log

---

## 8. Outcome Evaluation Criteria — Locked for v1

These are the authoritative pass/fail definitions for result states. Use these as reference for V1-TC-G1-05.

### Breakthrough (locked definition)
- Trust ≥ breakthrough threshold AND clarity ≥ breakthrough threshold AND momentum ≥ breakthrough threshold AND `breakthroughReady` = true
- OR a surfaced breakthrough card is played when its window is open and conditions are met

### Partial Resolution (locked definition)
- At least 4 turns consumed
- Trust ≥ 4 OR clarity ≥ 5
- Neither breakthrough nor collapse conditions met

### Stalemate (locked definition)
- 4 or more turns consumed
- Trust below breakthrough threshold
- Momentum non-positive
- No significant progress in the last 2 turns

### Collapse (locked definition)
- Tension = 10 AND trust ≤ 2, OR
- Failed plays ≥ 3 while tension ≥ 8

### Continue (locked definition)
- None of the above conditions are met
- Increment turn counter
- Apply state refresh
- Continue to next turn

---

## 9. Issue Severity Quick Reference

| Severity | Definition | Action |
|---|---|---|
| **P1** | Hard blocker — primary action unusable, data loss, crash | Must fix before any further QA or release |
| **P2** | Significant UX failure — new player cannot complete session, tone consistently read as therapy | Must address before external release |
| **P3** | Moderate UX friction — readability friction, next-action not visible in player surface | Should fix before release; tracked for patch if deferred |
| **P4** | Minor polish — cosmetic, wording, optimization | Future polish pass; does not block release |

---

## 10. Exit Criteria for v1 QA

A v1 release candidate is QA-approved when:
- all Gate 0 cases pass
- all Gate 1 cases pass (P1 or better on every item)
- all Gate 2 cases pass (P2 or better on every item)
- all Gate 3 cases pass (no regressions introduced)
- all Gate 4 cases pass with human participant evidence
- all Gate 5 criteria are satisfied with documented evidence

---

**Canonical file:** `projects/emotion-cards-four/tests/v1-test-cases.md`
