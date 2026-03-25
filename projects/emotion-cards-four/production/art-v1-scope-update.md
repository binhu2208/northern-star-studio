# Emotion Cards Four — ART-V1-001: Next-Action Guidance Layer + v1 Art Scope Update

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-V1-001
- **Purpose:** Fold Issue #12 UX requirements into the v1 art scope and define the visual treatment for a next-action guidance layer in the run-state surface
- **Status:** Draft for v1 planning consolidation
- **Related docs:**
  - `projects/emotion-cards-four/production/v1-planning-baseline.md`
  - `projects/emotion-cards-four/art/ui-component-system-requirements.md`
  - `projects/emotion-cards-four/art/ui-readability-targets.md`
  - `projects/emotion-cards-four/art/style-exploration-pass.md`
  - GitHub Issue #12

---

## 1. Issue #12 — What Needs to Be Added

Issue #12 identifies a bounded UX defect:

**Current gap:** The readable run-state surface does not clearly expose the player's next useful action during live runtime. Encounter, phase, response windows, and general run-state summary are visible — but "what to do next" is not surfaced as a readable visual element.

**What needs to be added:** A clearly visible **next-action guidance layer** in the run-state surface. This is a visual design requirement, not just a dev copy/prompt requirement.

**Scope rule:** This is a v1 UX requirement, not a prototype polish item. The guidance layer must be present in the v1 build, not deferred indefinitely.

---

## 2. Next-Action Guidance Component — Visual Design Treatment

### Component name
**Next-Action Cue** (NAC)

### Purpose
Shows the player their most useful next action based on current encounter state, open response windows, and hand composition — in a readable, glanceable format.

### What it must communicate
The NAC should signal, in priority order:
1. **What to do now** — the most immediately useful action given current state
2. **Why it matters** — short causal label linking the suggestion to current state
3. **What card type / play pattern is recommended** — e.g. "try a Memory + Reaction combo" or "open a trust window"

### What it must NOT do
- Do not make the game feel guided or scripted
- Do not remove player agency or decision-making
- Do not expose hidden engine logic or raw stat values
- Do not dominate the HUD or crowd out the encounter view

### Design principle
The NAC should feel like **readable context**, not **instruction**. The player should think "I see why that makes sense" rather than "the game is telling me what to play."

---

## 3. NAC Visual Treatment Requirements

### Position
The NAC belongs in the **run-state surface panel** — not as a floating overlay, not as a modal, but as a persistent, clearly labeled guidance strip that is always visible during active play.

### Readability targets
- must be readable at a glance from the main game view
- must survive stream/capture at reduced scale
- must not require extra navigation, hover, or click to see
- must remain readable when it recommends no action (e.g., "encounter resolving — wait")

### Hierarchy
The NAC sits below the core state meters and above the card play area in visual priority. It should be:
- noticeable when it has a strong recommendation
- quietly persistent when the situation is clear
- visually suppressed when there is no useful next-action signal

### Text / label style
- short, plain-language phrasing
- e.g., "try connecting first" / "memory support helps here" / "reframe could open a window"
- paired with a simple icon cue where possible
- never raw engine language like "flag open_window=true" or "synergy_check"

### State variants for the NAC
- **active recommendation** — clear, highlighted, readable
- **neutral / situation clear** — subdued but still present
- **no signal** — suppressed, not cluttering
- **locked / encounter resolving** — "wait" or equivalent, not interactive

### Color / treatment
Follow the established **Calm Diagnostic** style lane:
- restrained accent color for the active recommendation state
- do not use aggressive color pops
- support the guidance with icon + short text, not color alone

---

## 4. NAC Placement in the HUD Hierarchy

Recommended full HUD reading order:
1. encounter prompt
2. state meters (Tension / Trust / Clarity / Momentum)
3. response window indicators
4. **Next-Action Cue (NAC)**
5. focused-card panel
6. hand cards
7. turn summary strip

The NAC is a **priority layer** but not the dominant UI element. It should never push the encounter prompt or state meters off-screen.

---

## 5. v1 Art Scope Additions from Issue #12

The following art deliverables are required for v1 beyond the prototype baseline:

### 5.1 Next-Action Cue component design
- dedicated visual treatment for the NAC in all its states
- icon + label pairing system
- readable at glance size
- stream-safe

### 5.2 Run-state surface visual refresh
The existing run-state surface needs a visual design pass to accommodate the NAC cleanly without overcrowding. This may involve:
- tighter state meter layout
- a dedicated NAC slot
- adjusted safe-area allocation

### 5.3 v1 asset additions beyond prototype baseline
Based on Issue #12 and v1 planning, v1 art scope additions should include:
- **NAC component treatment** (new)
- **expanded card frame variant set** for v1 card content beyond the 27-card prototype
- **portrait/emotion overlay system rollout** — prototype specified the approach, v1 needs it built out
- **expanded icon library** for new keywords, encounter states, and result types beyond prototype scope
- **v1 HUD shell** — a more polished encounter HUD that can host the NAC cleanly
- **introduction/tutorial UI** for first-session on-ramp states

---

## 6. v1 Art Scope — Consolidated Additions

### Prototype art scope (already delivered)
- ART-001 through ART-004 deliverables
- card frame families, icon system, UI component requirements, readability targets

### v1 additions from Issue #12
| Item | Description | Status |
|------|-------------|--------|
| NAC component design | Next-Action Cue visual treatment | **new — required for v1** |
| Run-state surface refresh | Visual layout pass to accommodate NAC cleanly | **new — required for v1** |
| Portrait/emotion overlay system | Build out the prototype-specified approach | **carried from prototype baseline** |
| Expanded icon library | New keywords, encounter states, result types | **new — required for v1** |
| v1 HUD shell | Polished encounter HUD with NAC slot | **new — required for v1** |
| Introduction/tutorial UI | First-session on-ramp states | **new — required for v1** |

---

## 7. NAC Implementation Guidance for Engineering

The NAC is an art + design + engineering joint deliverable. For engineering planning:

### Input signals for NAC logic
The NAC should be driven by readable state signals already present in the run model:
- current encounter phase
- open/closed/blocked response windows
- current Tension / Trust / Clarity / Momentum values
- hand composition (categories present)
- whether a breakthrough path is available or blocked

### NAC text rules
- write guidance as plain language that a first-session player would recognize
- never expose raw stat thresholds or engine flags
- when in doubt, show the state signal ("trust is building") rather than the prescription ("play a Memory card")

### Fallback behavior
If the encounter state cannot generate a useful signal, the NAC should show a neutral/navigating state ("your turn — choose a card"), not be suppressed entirely.

---

## 8. Acceptance Criteria for ART-V1-001

The NAC and v1 art scope additions are complete when:
- a clearly readable NAC is visible in the run-state surface during active play
- a first-session player can tell their most useful next action from the NAC without opening debug or extra navigation
- the NAC follows the Calm Diagnostic visual lane (restrained, readable, not melodramatic)
- the run-state surface layout accommodates the NAC without crowding core state meters or encounter prompts
- QA-002-TC-21 can be cleared against the new run-state surface
- all NAC states (active recommendation, neutral, no signal, locked) are visually distinct

---

## 9. Bottom Line

Issue #12 identified one specific, bounded v1 UX requirement: the **next-action guidance layer must be visually designed and present in the run-state surface**.

The fix is not just dev copy — it is an art + design treatment for a **Next-Action Cue component** that:
- is readable at a glance
- feels like helpful context, not game-scripting
- follows the Calm Diagnostic style lane
- is a mandatory v1 deliverable, not prototype polish

This folds directly into the v1 art scope as an addition to the component system requirements already established in ART-004.
