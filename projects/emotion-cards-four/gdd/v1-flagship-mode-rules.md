# Emotion Cards Four — v1 Flagship Mode Rules Update
## Document Overview

- **Project:** Emotion Cards Four
- **Task ID:** DES-V1-001
- **Purpose:** Review flagship mode rules against prototype execution learnings and lock explicit v1 clarifications, changes, and additions
- **Status:** v1 Design Baseline — Supersedes DES-001 for active v1 work
- **Supersedes:** `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
- **Prototype reference:** `projects/emotion-cards-four/src/app.js` (commits `df6429b`, `4561a2b`)
- **QA reference:** `projects/emotion-cards-four/tests/prototype-validation-results.md`

---

## 1. What Prototype Execution Validated

The following elements from DES-001 are confirmed solid and should carry forward without structural change:

### 1.1 Resolution Model ✅
Four result states — breakthrough, partial resolution, stalemate, collapse — are the right abstraction. Players can understand and explain outcomes at all four levels. No changes needed.

### 1.2 Five-State Encounter Model ✅
Tension, Trust, Clarity, Momentum, and Response Windows remain the correct axes. The prototype operationalized these as numeric values with clamp ranges (0–10 for tension/trust/clarity, −5–+5 for momentum), and the system held together through all three encounters without needing additional axes.

### 1.3 Turn Structure ✅
Eight-step turn structure is sound. The prototype implemented it cleanly. One behavioral clarification is needed for v1 (see Section 3.1 below).

### 1.4 Encounter Opposition Model ✅
Reaction rules per encounter with priority sorting worked well. The model of encounter-as-opposition rather than passive system is correct and should be retained.

### 1.5 Carry-Forward System ✅
Encounter-level carry-forward (trust/tension/clarity/momentum modifiers, blocked windows, unlocked breakthroughs) is the right abstraction. It creates meaningful run-level progression without requiring a full progression system.

### 1.6 Breakthrough Surfacing Logic ✅
Breakthrough cards are surfaced when `breakthroughReady` becomes true, not drawn randomly. This is the correct model — it rewards aligned play rather than luck.

---

## 2. What Needs Changes for v1

### 2.1 Encounter Template Schema — Needs Explicit Locking

**Problem:** DES-001 defined encounter structure loosely. The prototype built a concrete schema, but it was never formally documented as the design standard. This caused ambiguity when Yoshi and John both needed to reference encounter structure independently.

**v1 requirement:** Every encounter template must explicitly define:

| Field | Purpose |
|---|---|
| `startingStats` | tension / trust / clarity / momentum at encounter start |
| `startingWindows` | which response windows open at start |
| `keywords` | current encounter context flags |
| `visibleCues` | player-facing prompts shown at encounter open |
| `reactionRules` | ordered list of opposition behavior rules |
| `breakthroughThresholds` | minimum trust / clarity / momentum for breakthrough |
| `collapseCondition` | explicit condition that triggers collapse |
| `turnPressureRules` | turn-count-based escalation if applicable |

**Current status:** The prototype has this structure in `data.js` as `ENCOUNTER_TEMPLATES`. It needs to be extracted into a durable encounter design document as part of DES-V1-002.

### 2.2 Outcome Evaluation — Boundary Conditions Need Explicit Definition

**Problem:** The prototype's `evaluateOutcome` function has overlapping conditions that can cause an encounter to resolve as "partial" even when no clear resolution has occurred, or to continue when the logic technically favors a stalemate. The DES-001 descriptions were too loose to guide implementation precisely.

**v1 requirements:**

**Stalemate definition (locked):**
- Encounter has consumed 4 or more turns without reaching breakthrough or collapse
- Trust is below the breakthrough threshold and momentum is non-positive
- No significant progress was made in the last 2 turns

**Partial Resolution definition (locked):**
- Encounter has consumed at least 4 turns
- Trust OR clarity has reached moderate levels (trust ≥ 4 OR clarity ≥ 5)
- Neither breakthrough nor collapse conditions are met

**Collapse definition (locked):**
- Tension reached 10 AND trust ≤ 2, OR
- Failed play count ≥ 3 while tension ≥ 8

**Breakthrough definition (locked):**
- Trust ≥ breakthrough threshold AND clarity ≥ breakthrough threshold AND momentum ≥ breakthrough threshold AND `breakthroughReady` = true
- OR a surfaced breakthrough card is played when its window is open and conditions are met

**Continue condition (locked):**
- None of the above conditions are met.
- Increment turn counter. Apply state refresh. Continue.

### 2.3 Phase Model — Behavioral Clarification

**Problem:** DES-001 described phases but did not lock the behavioral rule for `play_response`. The prototype requires a legal primary card to be selected before the submit action is enabled. This was not explicit in the original rules doc.

**v1 clarification for `read_situation`:**
- Player reviews current encounter state, open response windows, and available hand.
- Player is expected to select cards before advancing.
- Advancing without a selection is permitted but the system provides a clear nudge.

**v1 clarification for `play_response`:**
- Submit is only enabled when at least one legal primary card is selected.
- A "legal" primary card is an Emotion or Reaction card whose `intentTag` matches an open response window, `repair`, or `protect`.
- Primary-only and primary-plus-support plays are both valid.
- The system rejects empty submissions with a clear message.

### 2.4 Turn Pressure — Explicit Lock

**v1 rule:** After turn 4, tension increases by 1 at each `state_refresh` unless the encounter has the `no_tension_increase` modifier. This is confirmed correct from prototype execution and should be documented as a standing rule, not a one-time note.

### 2.5 Collapse Armed — Explicit Lock

**v1 rule:** An encounter is "collapse armed" when tension ≥ 8 OR failed play count ≥ 2. This flag should be visible to the player as a run-state indicator. It is not automatic collapse — it is a warning that the next misfit play is likely to trigger collapse. Document this distinction clearly.

### 2.6 Max Turns — Explicit Rationale

**v1 rule:** Maximum turns per encounter = 6. Rationale: 6 turns allows enough room for a player to recover from a poor opening without making every encounter feel open-ended. At 6 turns with no resolution, the encounter enters stalemate or partial resolution depending on state. This threshold should be configurable per encounter in v1, with 6 as the default.

---

## 3. New Additions for v1

### 3.1 Encounter Run Structure

**v1 rule:** A run consists of a fixed number of encounters in a fixed order. The prototype uses 3 encounters. v1 should retain 3 as the minimum testable run length and treat encounter count as a per-run configuration value, not a hard constant.

Between encounters, the player receives a carry-forward state and may optionally swap or add one card from a small reward pool if the prior encounter reached breakthrough.

### 3.2 Breakthrough Card Surfacing

**v1 rule:** When `breakthroughReady` becomes true for the first time in an encounter, the system immediately surfaces one `BREAKTHROUGH_SURFACE` card associated with that encounter. This card is added to the player's available options and can be played in subsequent turns when its response window is open. Breakthrough cards are not randomly drawn — they are earned state unlocks.

### 3.3 Failed Play Tracking

**v1 rule:** A "failed play" is any play that:
- uses a card whose `intentTag` does not match any open response window, AND is not `protect` or `repair`, OR
- triggers a risk rule that applies a penalty

Failed play count accumulates within an encounter and resets on encounter resolution. High failed play count contributes to the collapse armed condition and is a useful QA/balance signal.

### 3.4 Encounter Context Keywords — Canonical List

DES-002 listed encounter keywords but they were not formally part of DES-001. For v1, the canonical keyword list is:

| Keyword | Meaning for play |
|---|---|
| `fragile` | Any misfit play causes disproportionate damage. Proceed carefully. |
| `guarded` | Trust-building and repair plays are more effective. Aggressive plays are penalized. |
| `misread` | Clarity-building and reinterpretation are rewarded. Standard plays may underperform. |
| `public` | Emotional exposure carries higher risk. Shame and deflection are more volatile. |
| `private` | Vulnerable plays are safer but breakthrough requires more setup. |
| `heated` | Tension is already elevated. De-escalation tools are strongly rewarded. |
| `stalled` | Momentum is low or negative. Recovery and repair plays are needed. |
| `repairable` | A breakthrough or strong partial is within reach if the player reads the right window. |
| `defensive` | The player is already under pressure. Aggressive plays will likely trigger opposition. |
| `open_window` | A breakthrough path is currently available. This is a high-opportunity state. |

Encounters can hold multiple keywords simultaneously. Keywords affect card synergy, risk triggers, and opposition rule selection.

---

## 4. What Does NOT Change from DES-001

The following elements are confirmed correct and should not be revised:

- The core player fantasy statement
- The four-card-category model (Emotion / Memory / Reaction / Shift) plus Breakthrough
- The session-level success indicators (resolution distribution, collapse frequency, replay intent)
- The UX/readability rules (one-intent cards, limited keywords, outcome legibility)
- The validation hooks (first-round comprehension, replay intent, creator readability, audience fit, tone acceptance)

---

## 5. Open Questions for v1 (Must Be Answered Before Lock)

These were open in DES-001. Prototype execution narrowed some but did not fully close them:

1. **Encounter count per run:** Is 3 the right default, or should v1 support configurable run lengths?
2. **Breakthrough card play timing:** Once surfaced, can a breakthrough card be played in the same turn it is surfaced, or must the player wait for the next turn?
3. **Hand size:** 4 cards works in prototype. Should v1 increase this, or keep it as a readability constraint?
4. **Difficulty scaling:** Should v1 introduce encounter-level difficulty variants, or keep all encounters at the same challenge level?
5. **Encounter template count:** The prototype has 3. How many does v1 need for a meaningful content review?

These should be resolved in DES-V1-002 (v1 content and card taxonomy update) in consultation with the producer.

---

## 6. Relationship to Other v1 Tasks

This document provides the design lock for:
- **DEV-V1-001:** Engineering architecture changes — the clarified phase model, outcome evaluation logic, and encounter schema directly feed engineering scope
- **ART-V1-001:** The collapse armed indicator and run-state surface are UI elements that need art treatment; the clarified response window system supports UI component design
- **DES-V1-002:** The card taxonomy update should be informed by the confirmed operational vocabulary in this document (intent tags, risk tags, synergy conditions)
- **QA-V1-001:** Test case logic should use the explicitly locked outcome definitions from Section 2.2

---

## 7. Summary of Changes from DES-001

| Item | DES-001 | v1 Update |
|---|---|---|
| Encounter template schema | Described loosely | Explicit field-by-field lock required |
| Outcome evaluation | General descriptions | Explicit condition logic locked |
| Phase model | Described structurally | Behavioral rules clarified |
| Turn pressure | One example | Standing rule locked |
| Collapse armed | Not in document | Explicit definition added |
| Max turns | Stated as 6 | Rationale provided |
| Breakthrough surfacing | Described generally | Explicit trigger condition locked |
| Failed play tracking | Not in document | New addition |
| Encounter keywords | Listed in DES-002 only | Canonical list added to rules |
| Run structure | Not defined | Section added |

---

**Canonical file:** `projects/emotion-cards-four/gdd/v1-flagship-mode-rules.md`
