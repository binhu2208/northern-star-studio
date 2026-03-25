# ART-001 — Early Visual Readability Guide

## Purpose
Create a **prototype-first visual readability standard** for Emotion Cards Three so players can understand card function, emotional state, and battle screenshots in seconds.

This guide is intentionally early and practical.
It is not final art direction.
It is a **legibility framework** that supports fast iteration across UI, card mockups, screenshots, and future asset production.

Reference system: `projects/emotion-cards-three/gdd/emotional-state-model.md`

---

## 1. Readability Goals
The prototype art/UI should answer four questions at a glance:

1. **What kind of card is this?**
2. **What emotional state is active right now?**
3. **Is the current state stable, risky, or dangerous?**
4. **Can a screenshot communicate the moment without explanation?**

### Success criteria
- players can identify state tier in under 1–2 seconds
- cards remain readable in static screenshots and compressed Discord previews
- state cues work even when color is partially lost or viewed on poor displays
- the system still reads if icon art is temporary or unfinished

### Prototype principle
**Function before flourish.**
If a visual idea is stylish but slows comprehension, cut or simplify it.

---

## 2. Card Readability Rules
The card frame and content hierarchy should make the primary action obvious before flavor or polish.

### 2.1 Information priority
From most important to least important:

1. **Card intent** — attack / defend / setup / state shift
2. **Cost or play requirement**
3. **State interaction** — shift, escalate, stabilize, conditional bonus
4. **Effect value** — damage, block, draw, discard, etc.
5. **Flavor / secondary texture**

### 2.2 Layout rules
Use a clean top-to-bottom structure:
- **Top band:** card name + cost
- **Upper center:** main icon or action badge
- **Center body:** short effect text
- **Lower body:** state shift callout / conditional rule
- **Bottom strip:** tags (Attack, Guard, Shift, Burst, Recover)

### 2.3 Text rules
- keep effect text to **1–3 short lines** when possible
- avoid dense paragraph wording
- start with the action verb: **Gain**, **Deal**, **Shift**, **Draw**, **Discard**
- state movement language must be consistent every time
- preferred syntax:
  - `Shift 1 toward Calm`
  - `Shift 1 toward Focused`
  - `Shift 1 toward Agitated`
  - `If already Agitated, become Overwhelmed`

### 2.4 Numeric emphasis
- numbers should be visually heavier than body text
- cost, damage, and block values need the strongest contrast on the card
- do not hide important values inside decorative illustrations

### 2.5 Frame behavior
The frame should help classify the card, but should not overpower the state UI.
Recommended split:
- **card role** = frame accent / tag treatment
- **active emotional state** = separate HUD or state badge system

This avoids confusion between “what the card does” and “what state the unit is currently in.”

---

## 3. Card Rule Categories for Early Mockups
For prototype mockups, cards should visually sort into a few obvious buckets.

### A. Strike / pressure cards
Use for proactive offense.
Visual traits:
- sharper angles
- forward motion lines
- stronger contrast accents
- icon emphasis on impact / slash / burst

### B. Guard / stabilize cards
Use for recovery, control, and de-escalation.
Visual traits:
- wider, calmer shapes
- shield, breath, ring, or barrier motifs
- lower visual noise
- more even spacing

### C. Setup / combo cards
Use for Focused play and sequencing.
Visual traits:
- precise geometry
- directional guides
- target marks, linked nodes, layered steps

### D. Crisis / all-in cards
Use for Agitated → Overwhelmed behavior.
Visual traits:
- broken edges, flare, distortion, overglow
- larger warning accent area
- should look risky, not merely stronger

---

## 4. Icon Draft System
The first icon pass should be **simple, bold, and testable in grayscale**.
Do not start with painterly mini-illustrations.

### Icon design rules
- build on a **24x24 or 32x32 grid**
- aim for **single-silhouette readability** first
- keep interior detail minimal
- prefer one dominant shape + one support shape
- test at very small size before approving

### Recommended early icons
| Function | Draft icon direction | Readability note |
|---|---|---|
| Attack | slash / sword arc / impact burst | should imply forward force immediately |
| Guard | shield / rounded barrier / palm stop | avoid looking like a badge or coin |
| Draw / planning | eye / card fan / spark above card | keep distinct from targeting |
| Shift toward Calm | downward ripple / ring settling | should feel grounded, not weak |
| Shift toward Focused | reticle / centered diamond / aligned bars | should read as precision |
| Shift toward Agitated | rising jag / pulse spike / flame shard | must read as unstable energy |
| Overwhelmed | fractured star / overloaded crown / burst halo | should feel dangerous and unsustainable |

### Icon usage rule
If the icon cannot be recognized:
- at small size
- in grayscale
- in a screenshot thumbnail

then it is not ready.

---

## 5. Emotional State Color + Shape System
Because color alone is unreliable, each state needs a **paired color and shape language**.

## 5.1 State ladder
The state system follows:

**Calm → Focused → Agitated → Overwhelmed**

The visuals should communicate rising intensity and instability.

## 5.2 Recommended prototype palette
These are working directions, not locked brand colors.

### Calm
- **Color direction:** cool teal / muted cyan / soft blue-green
- **Shape language:** rounded, level, symmetrical, low-noise
- **Motion feel:** slow pulse or gentle ring
- **Read:** stable, safe, centered

### Focused
- **Color direction:** clear blue / indigo / clean steel-blue
- **Shape language:** diamond, reticle, straight guides, crisp alignment
- **Motion feel:** tight pulse, subtle targeting lines
- **Read:** precision, planning, control under pressure

### Agitated
- **Color direction:** amber / orange / hot gold
- **Shape language:** tilted slashes, spikes, rising diagonals
- **Motion feel:** jitter, upward flicker, rapid pulse
- **Read:** momentum, risk, unstable offense

### Overwhelmed
- **Color direction:** crimson / magenta-red / warning red-violet
- **Shape language:** fractured crown, broken halo, burst, distortion edge
- **Motion feel:** flare, rupture, overloaded glow
- **Read:** danger, peak intensity, loss of control

## 5.3 Shape-first backup system
If viewed without reliable color, state should still read from silhouette:

| State | Primary shape cue | Secondary cue |
|---|---|---|
| Calm | circle / rounded ring | horizontal balance |
| Focused | diamond / reticle | centered point |
| Agitated | angled spike / zig shape | upward lean |
| Overwhelmed | fractured star / broken burst | irregular outer edge |

## 5.4 Escalation readability rule
Each step up the ladder should visibly increase:
- edge tension
- contrast intensity
- shape instability
- motion aggression

Each step down should visibly reduce those qualities.

That makes state changes feel meaningful even before animation polish exists.

---

## 6. State Badge / HUD Recommendation
Do **not** bury emotional state inside card text only.
The active state should have a dedicated visual marker near the player/enemy portrait or unit frame.

### Prototype recommendation
Each unit gets:
- a **state badge** with icon + color + shape
- a **state label** in plain text on hover or expanded UI
- optional **one-step transition indicator** when the state changes

### Badge rules
- badge should be readable at a glance from mid-screen distance
- badge outline shape must match the state family
- state label text should be short: Calm, Focused, Agitated, Overwhelmed
- avoid abstract naming in prototype UI

---

## 7. Screenshot Legibility Checklist
A prototype screenshot should be understandable even when posted in Discord, embedded in docs, or viewed quickly on mobile.

Use this checklist before sharing screenshots for review.

### Must-read elements
- [ ] active emotional state is visible without zooming
- [ ] current card intent can be inferred from icon/tag/text hierarchy
- [ ] key numbers are readable against the background
- [ ] player and enemy silhouettes are separable
- [ ] the screenshot has one clear focal point

### State clarity
- [ ] each state badge uses both color and shape, not color alone
- [ ] Calm and Focused are distinguishable instantly
- [ ] Agitated and Overwhelmed do not blur into the same “red danger” bucket
- [ ] the current state looks intentional, not like a temporary effect icon pile

### UI cleanliness
- [ ] no decorative texture competes with text
- [ ] background values do not swallow cards or badges
- [ ] glow is used to emphasize, not smear detail
- [ ] small text is still readable in a compressed screenshot

### Composition quality
- [ ] screenshot shows the decision moment, not idle clutter
- [ ] one card, one state, or one consequence is visually dominant
- [ ] nonessential debug overlays are hidden
- [ ] cropped version still communicates the same point

---

## 8. Early Art Direction Do / Don't
### Do
- prioritize fast state recognition
- use strong silhouettes before fine detail
- keep UI text short and explicit
- make risky states feel visually unstable
- test every cue in grayscale and at reduced size

### Don’t
- rely on hue alone to carry meaning
- make Focused and Calm too visually similar
- make Overwhelmed simply “more glow” instead of more fractured
- decorate card frames so much they fight the rules text
- use tiny symbolic differences that disappear in screenshots

---

## 9. First Prototype Asset Targets
To support design reviews quickly, the art side should produce these in order:

1. **state badge sheet**
   - Calm, Focused, Agitated, Overwhelmed
   - icon + shape-only version + color version

2. **card wireframe mockup**
   - name, cost, icon, effect text, state shift line, tag strip

3. **4 sample card role variants**
   - one strike
   - one guard
   - one setup
   - one crisis/all-in

4. **screenshot paintover / annotation example**
   - one battle screenshot with callouts showing why it reads

---

## 10. Review Gate
This guide is successful for prototype use if:
- team members can identify the four emotional states quickly
- screenshots communicate the current emotional condition without explanation
- card mockups stay readable before final illustration exists
- the system supports iteration instead of locking the project into overbuilt UI art too early

If those are not true, revise the readability system before polishing visuals.
