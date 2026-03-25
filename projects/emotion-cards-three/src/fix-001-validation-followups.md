# FIX-001 — Validation Follow-Ups and Scope/Handoff Tightening

## Purpose
Resolve the most important prototype validation findings and close the handoff gaps between:
- QA-002 prototype validation
- DEV-001 prototype combat scenario
- DEV-002 prototype state UI/readability support
- DES-002 vertical-slice scope

This document exists because the current package is **good enough to move forward**, but it is **not fully aligned**.
The biggest issue is not basic readability anymore.
The biggest issue is that the project currently has **two overlapping but different product directions**:

1. a **combat prototype** built around a four-state emotional combat loop
2. a **vertical-slice narrative run** built around Maya, emotion families, resonance, and reconciliation gating

If left unresolved, that split will create confused implementation, noisy QA expectations, and a weak greenlight review.

---

## 1. Executive Summary
### Current status
- **QA-002:** Pass with focused risk notes
- **Combat prototype package:** readable, testable, and implementation-ready
- **Vertical-slice scope:** has a clear narrative archetype path, but it is not yet cleanly connected to the combat prototype package

### Primary fix recommendation
Before greenlight review, the team should lock a single answer to this question:

**Is Emotion Cards Three moving forward as an emotional combat prototype first, or as a narrative resonance-run slice first?**

Right now DES-002 reads like a broader design pivot, while QA-002 and DEV-001/DEV-002 validate the combat prototype path.
That mismatch is the main blocker to a clean downstream handoff.

### Working recommendation
For the next milestone, the team should treat the **combat prototype as the baseline proof case** and the **Maya reconciliation slice as a later expansion path**, unless design explicitly re-baselines the full package.

That is the smaller, safer path.

---

## 2. What QA-002 Actually Validated
QA-002 did **not** validate the whole DES-002 vertical-slice concept.
It validated the current prototype package built around:
- readable emotional states
- visible enemy intent
- explicit card/state interactions
- one-fight tactical clarity
- first-session onboarding/readability

### Validated package
- `projects/emotion-cards-three/src/prototype-combat-scenario.md`
- `projects/emotion-cards-three/src/prototype-state-ui-readability.md`
- `projects/emotion-cards-three/art/readability-guide.md`
- `projects/emotion-cards-three/tests/qa-001-usability-and-readability-checks.md`

### Important consequence
The current **Pass** verdict means:
- the combat prototype direction is viable enough to implement/test
- the readability hierarchy is strong enough to continue
- the main remaining risk is execution clutter

It does **not** mean:
- the narrative resonance-run structure is already validated
- Maya's vertical-slice path is fully supported by current dev/UI docs
- downstream work can safely assume the combat and slice docs already describe the same system

That distinction matters.

---

## 3. Main Findings to Address
## Finding A — Scope drift between prototype and vertical slice
### Problem
DES-002 introduces a new center of gravity:
- Maya-specific character arc
- emotion families
- resonance trigger
- multi-beat narrative run structure
- emotional/deck-state gated reconciliation ending

That is meaningfully broader and structurally different from the one-fight combat prototype validated in QA-002.

### Impact
If unaddressed:
- engineering may build against one system while design talks about another
- QA may measure the wrong success gates
- marketing may describe a hook broader than what the prototype really proves
- greenlight review may compare apples to oranges

### Fix
Establish a formal milestone split:
- **Prototype Validation Baseline:** four-state combat scenario
- **Vertical Slice Expansion Layer:** Maya path, resonance, narrative gating

Do not treat them as the same implementation package until the bridge is explicitly documented.

---

## Finding B — Missing bridge from combat states to vertical-slice emotion model
### Problem
The combat prototype uses:
- Calm
- Focused
- Agitated
- Overwhelmed

DES-002 uses:
- emotion families
- Maya progression states like Resentment, Curiosity, Conflict, Vulnerability, Understanding, Resolution
- resonance and narrative flags

These are not yet mapped to each other.

### Impact
Without a bridge, no one can answer:
- Are Calm/Focused/Agitated/Overwhelmed still the battle layer?
- Are Resentment/Curiosity/etc. narrative-only progression states?
- Does resonance replace the four-state combat track?
- Does Maya's run state modify combat state, or sit above it?

### Fix
Create a follow-up alignment spec before implementation expands further.

Required output:
**System Bridge Note** defining:
1. battle-state layer
2. run/narrative-state layer
3. card taxonomy
4. how one layer influences the other
5. what remains out of scope for the next milestone

Until that note exists, downstream teams should not assume these systems are already unified.

---

## Finding C — QA gates need milestone-specific wording
### Problem
QA-002 currently validates readability/tactical clarity for the combat prototype.
DES-002 adds new goals around:
- character-run completion
- ending unlock logic
- resonance
- narrative clarity

Those require different QA gates than the current prototype validation.

### Impact
Without separation, QA could produce a pass/fail judgment against mixed goals that were never all present in the same implementation target.

### Fix
Split QA expectations into two layers:

### Layer 1 — prototype combat QA
Focus on:
- state recognition
- enemy intent readability
- card/state consequence understanding
- onboarding clarity
- screenshot/clip readability

### Layer 2 — vertical-slice QA
Focus on:
- run completion
- narrative flag reliability
- resonance clarity
- emotional path legibility
- ending unlock logic

This protects review quality and avoids fake failure caused by moving targets.

---

## Finding D — Handoff language is still too broad in places
### Problem
Some current docs are strong at describing goals, but not always strict enough about what must happen next and what should wait.

### Impact
That encourages scope creep, especially when multiple disciplines start interpreting “emotion system” differently.

### Fix
Adopt these handoff rules immediately:
- one milestone = one primary proof objective
- every system must declare whether it is:
  - **required now**
  - **allowed if cheap**
  - **deferred**
- if a document introduces a new major mechanic family, it must say whether it replaces or layers onto the prior system

This is basic, but right now it would prevent a lot of drift.

---

## 4. Concrete Fix Decisions
These are the recommended project decisions to make before greenlight review.

## Decision 1 — Lock the baseline proof case
**Recommended choice:**
Use the four-state combat prototype as the officially validated proof case.

### Why
- it already has a QA-backed pass
- it has clearer implementation boundaries
- it is smaller and cheaper to prove
- it supports screenshot/clip readability directly

### Result
Future documents should refer to it as the current validated baseline unless explicitly superseded.

---

## Decision 2 — Reposition DES-002 as expansion scope, not retroactive prototype definition
**Recommended choice:**
Treat DES-002 as the target for the next layer of scope planning, not as a replacement description of the current validated prototype.

### Why
This preserves the value of the work already completed instead of forcing everyone to pretend the validated prototype already covered a larger narrative-run structure.

### Result
Greenlight review can compare:
- what has been validated now
- what is proposed next
- what new risks the slice introduces

That is much cleaner.

---

## Decision 3 — Add one bridge document before new implementation branches
**Recommended choice:**
Author one short bridge spec that answers how the combat-state prototype evolves into or coexists with the Maya/reconciliation vertical slice.

### Minimum contents
- combat-state layer definition
- narrative/run-state layer definition
- resonance role
- whether emotion families are card tags, progression signals, or both
- migration path from prototype deck to slice deck
- which UI elements carry forward unchanged

### Result
Engineering, QA, and art all work from the same map.

---

## 5. Immediate Follow-Up Work
These are the concrete follow-ups recommended after FIX-001.

## Follow-up 1 — Create alignment bridge note
**Owner:** Design

**Suggested deliverable:**
`projects/emotion-cards-three/gdd/system-bridge-note.md`

**Purpose:**
Define how the validated combat prototype and DES-002 vertical-slice structure connect.

### Required questions
- Is the four-state combat track still canonical in battle?
- Are emotion families card attributes, stance inputs, narrative traits, or all three?
- Is Maya's emotional progression a run-state layer above battle-state?
- Does resonance trigger combat effects, narrative unlocks, or both?
- Which current prototype terms remain unchanged?

---

## Follow-up 2 — Create a milestone-specific QA plan for slice expansion
**Owner:** QA

**Suggested deliverable:**
`projects/emotion-cards-three/tests/qa-003-vertical-slice-gates.md`

**Purpose:**
Define QA gates for the Maya/reconciliation slice separately from the combat-prototype readability gates.

### Required focus areas
- resonance clarity
- story-flag reliability
- ending unlock legibility
- run-state readability
- conflict between narrative and combat cues

---

## Follow-up 3 — Add implementation constraint note for engineering
**Owner:** Development

**Suggested deliverable:**
`projects/emotion-cards-three/src/implementation-constraints.md`

**Purpose:**
Prevent system bloat during the transition from combat prototype to slice planning.

### Recommended constraints
- keep combat-state HUD logic modular
- keep card tags data-driven
- separate battle-state and run-state data cleanly
- avoid hard-coding narrative assumptions into the prototype combat loop
- preserve screenshot/clip readability as a non-negotiable output

---

## 6. Revised Greenlight Review Framing
The greenlight review should not ask a fuzzy question like:
**“Is the whole concept done enough?”**

It should ask three cleaner questions:

### A. Validation question
Did the current combat prototype prove that emotions can function as a readable tactical system?

### B. Expansion question
Does DES-002 define a believable next-step slice that builds on that proof instead of replacing it incoherently?

### C. Risk question
What new risks are introduced by adding resonance, Maya-specific narrative progression, and ending gating?

This framing will lead to a much more honest go / no-go call.

---

## 7. Tightened Handoff Guidance by Discipline
## Design
- stop treating combat prototype and slice scope as implicitly merged
- produce the bridge note before additional system expansion
- declare whether new mechanics replace, layer, or defer

## Development
- keep current prototype implementation anchored to the combat proof case
- do not silently absorb resonance/run-state logic into battle implementation without the bridge note
- preserve UI hierarchy from DEV-002 as a fixed quality bar

## Art
- continue supporting the battle-state readability system as the baseline visual language
- do not overcommit to slice-specific presentation until system layers are clarified
- protect state distinction first, flavor second

## QA
- maintain separate test language for prototype readability vs slice progression validation
- treat mixed-goal test plans as invalid until the bridge is explicit
- continue watching for cue overload as the top readability risk

## Production
- keep milestone language explicit
- refuse documents that quietly broaden scope without saying what gets deferred
- frame greenlight around validated proof + expansion risk, not ambition alone

---

## 8. What Is Fixed by This Document
This document does not solve every design question, but it does fix the immediate coordination problem by making these points explicit:

1. QA-002 passed the **combat prototype package**, not the whole expanded slice.
2. DES-002 currently functions best as **next-step scope**, not as a retroactive rewrite of the validated prototype.
3. The key project risk is now **scope/handoff misalignment**, not lack of initial readability thinking.
4. The next essential move is a **bridge spec**, not more silent expansion.

That is enough to tighten the path into greenlight review.

---

## 9. Final Recommendation
**Recommendation: Proceed, but re-baseline cleanly.**

The team has something real:
- a readable combat proof case
- a promising expansion direction
- a manageable set of follow-up risks

But the next milestone should only move forward if the project clearly separates:
- what has already been validated
- what is newly proposed
- what still needs bridging work

If the team does that, the concept remains in good shape.
If it does not, the project risks failing from internal ambiguity rather than from the game idea itself.