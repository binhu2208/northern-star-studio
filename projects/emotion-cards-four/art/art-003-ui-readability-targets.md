# Emotion Cards Four — ART-003 UI Readability Targets

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-003
- **Purpose:** Define prototype UI readability targets for safe areas, HUD hierarchy, result/explanation visibility, and overall screen composition
- **Status:** Draft for active prototype production use
- **Based on:**
  - `projects/emotion-cards-four/art/art-scope-sheet.md`
  - `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
  - `projects/emotion-cards-four/gdd/prototype-card-taxonomy.md`
  - `projects/emotion-cards-four/src/prototype-architecture-baseline.md`

---

## 1. Core Readability Goal

The prototype succeeds if a first-session player or spectator can answer, at a glance:
- what the encounter situation is,
- what card(s) the player chose,
- what changed,
- why the encounter reacted that way,
- whether the outcome is moving toward **Breakthrough, Partial Resolution, Stalemate, or Collapse**.

If the UI hides that under corners, dense text, or invisible math, the prototype fails even if the underlying rules are good.

---

## 2. Safe Area Targets

Use a conservative **title-safe layout** for all critical gameplay information.

### Required safe-area rule
Keep all critical readable elements inside roughly the **inner 80% width / 80% height** of the play view.

Critical elements:
- encounter prompt,
- current turn/active play area,
- Tension / Trust / Clarity / Momentum labels,
- response-window state,
- result banner,
- reaction/explanation text,
- breakthrough state hint.

### Edge policy
Do **not** place gameplay-critical text or icons flush to:
- top corners,
- bottom corners,
- extreme left/right screen edges.

This prototype must remain readable on:
- smaller monitors,
- laptop captures,
- Discord streams,
- recorded footage with overlays,
- UI-scaled builds.

### Prototype target
At 1080p, no critical text block should feel like it needs edge-to-edge placement. Leave visible breathing room around all core HUD clusters.

---

## 3. HUD Layout Priorities

The encounter HUD should read in this order:

1. **Encounter prompt / situation**
2. **Current playable focus** (hand + active selection)
3. **Current state** (Tension / Trust / Clarity / Momentum)
4. **Response windows** (open / closed / blocked)
5. **Turn result / what changed**
6. **Reaction explanation / why it happened**
7. **Breakthrough availability**

### Required HUD blocks

#### A. Situation header
Must show:
- encounter name or short label,
- current prompt,
- optional tone cue if needed.

Keep this short and stable. The player should not hunt for the core situation.

#### B. State strip
Must always show readable labels for:
- Tension
- Trust
- Clarity
- Momentum

Numbers may be hidden or abstracted, but the state strip must visibly communicate direction and relative condition.

#### C. Response-window block
Must clearly show:
- what lines are currently open,
- what is blocked,
- when a window changes after resolution.

This should not be buried in body text.

#### D. Resolution summary block
After play, the UI must surface:
- what the player played,
- what stats changed,
- what the encounter did in response,
- whether a breakthrough route opened or closed.

#### E. Reaction explanation block
Must provide plain-language causal text.
Example structure:
- **You played:** Concern + Old Promise
- **Result:** Trust up, Clarity up
- **Reaction:** The encounter softens because shared history matched the moment

That level of explanation matters more than flashy animation.

---

## 4. Result / Explanation Visibility Rules

The prototype architecture already assumes explainable results. The UI has to make that visible.

### Minimum post-resolution visibility
Every resolved turn should show, in one obvious area:
- before/after change cues,
- the encounter reaction,
- the reason or rule-facing explanation,
- the current result direction.

### Result-state visibility
When the encounter state meaningfully shifts, announce it with a clear readable label:
- **Breakthrough Opening**
- **Breakthrough Blocked**
- **Partial Resolution Likely**
- **Stalemate Risk**
- **Collapse Warning**

These labels do not need to be final wording, but the state must be legible.

### Plain-language requirement
The player and spectator should never have to infer major outcomes solely from tiny stat nudges.

If a bad play closed a route, say so.
If a good combo opened a route, say so.
If the encounter pushed back because trust was low or clarity was weak, say so.

---

## 5. Screen Composition Targets

### Primary composition rule
Reserve the **center read zone** for the live decision loop:
- encounter prompt,
- active card play,
- immediate result feedback.

This is the heart of the prototype and should dominate composition.

### Recommended screen zoning
- **Top / upper-center:** encounter prompt + state strip
- **Center:** active encounter focus + play/resolve feedback
- **Bottom-center:** hand and card selection
- **Side support zones:** secondary context only

### Peripheral rule
Side panels can hold supporting detail, but no critical explanation should exist only in a side lane.

### Spectator rule
A stream viewer should be able to understand the turn by looking mostly at the center and upper-center of the screen.

---

## 6. Card and Text Density Targets

These targets are prototype-oriented, not final production locks.

### Card readability targets
Each card should emphasize, in order:
1. Name
2. Category identity
3. Primary effect
4. Risk / condition
5. Illustration slot

### Copy density rules
- One main effect per card
- At most one conditional bonus
- Minimal keyword count
- Reused keyword language across the set
- No dense paragraph blocks

### Prototype target
A player should understand a card’s rough purpose in under a few seconds without opening a separate rules layer.

### Body text target
Keep card text visually short enough that enlarged card view remains instantly scannable. If a card reads like a mini design doc, it is too dense.

---

## 7. Practical Prototype Targets

These are the targets worth proving in wireframe and first playable UI.

### Target 1 — One-glance state read
Without opening debug tools, a viewer should be able to spot:
- whether tension is rising or falling,
- whether trust is healthy or fragile,
- whether clarity improved,
- whether momentum is helping or hurting.

### Target 2 — One-turn causality read
After each turn, the player should be able to say:
- “I played this,”
- “it changed these values,”
- “the encounter reacted because of that.”

### Target 3 — Breakthrough legibility
The UI must visibly communicate whether breakthrough is:
- not available,
- opening,
- ready,
- blocked.

Do not hide this entirely in backend state.

### Target 4 — Misplay legibility
If a play fails because of low trust, low clarity, a closed response window, or wrong tone, the UI should make the failure readable instead of mysterious.

### Target 5 — Stream-safe composition
At prototype capture size, the encounter loop should still read without requiring viewers to zoom into corners or pause the video to parse tiny explanation text.

---

## 8. Do / Don’t Rules

### Do
- Keep critical gameplay text inside conservative safe areas
- Make the prompt, state, play, and reaction readable in a stable visual order
- Show what changed this turn in one obvious location
- Use labels and icon/color support together
- Make open/closed/blocked response states unmistakable
- Give breakthrough and collapse conditions visible cues
- Prefer fewer, stronger UI regions over many competing panels
- Keep explanation text plain and short
- Use motion/VFX to reinforce state changes, not replace them

### Don’t
- Don’t put essential explanation only in corners or sidebars
- Don’t rely on hidden math with no readable causal layer
- Don’t overload the center with too many simultaneous messages
- Don’t make card text carry the full burden of explaining the system
- Don’t let VFX obscure stat changes or result labels
- Don’t make response windows feel invisible
- Don’t bury the encounter reaction after the player’s play resolves
- Don’t force spectators to read tiny subtitles to understand why a turn worked
- Don’t treat result states as flavor; they are core UI information

---

## 9. Wireframe Validation Checklist

Use this checklist during ART-002 / prototype UI review:
- Can a first-time viewer identify the encounter prompt in under 2 seconds?
- Can they locate Tension / Trust / Clarity / Momentum immediately?
- Can they tell which card is primary and which is support?
- Can they see whether a response window is open, closed, or blocked?
- Can they tell what changed after the turn resolves?
- Can they read why the encounter reacted?
- Can they tell whether breakthrough is opening or collapse is looming?
- Does the layout still read when scaled down or viewed in capture?

If several answers are “no,” the layout is not ready for prototype implementation.

---

## 10. Bottom Line

ART-003 should push the prototype toward a UI that is:
- **centered on the live decision loop,**
- **safe-area disciplined,**
- **clear about cause and effect,**
- **stream-readable,**
- **light on text clutter,**
- **and honest about result-state direction.**

The right prototype screen is not the prettiest one. It is the one that lets players and spectators immediately understand what is happening and why.
