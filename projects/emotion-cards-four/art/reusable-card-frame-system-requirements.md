# Emotion Cards Four — Reusable Card Frame System Requirements

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-004
- **Purpose:** Define the reusable card frame system requirements for prototype card presentation
- **Status:** Draft for active production use
- **Based on:** `art/style-exploration-pass.md`, `art/ui-readability-targets.md`, `art/art-scope-sheet.md`

---

## 1. Goal

Build **one modular card frame system** that supports all prototype card categories while preserving:
- instant category recognition,
- one-turn readability,
- controller and spectator clarity,
- data-driven iteration,
- low-cost visual updates during tuning.

This is a **27-card visual system**, not a 27-illustration pipeline.

---

## 2. Required Frame Families

The system must support **5 frame families**:
1. **Emotion**
2. **Memory**
3. **Reaction**
4. **Shift**
5. **Breakthrough**

These families must feel distinct at scan speed, but still read as parts of the same product.

---

## 3. Shared Structure Requirements

All frame families must use the same core structure so card data can populate a common layout.

### Required shared regions
1. **Title zone**
2. **Category marker/icon zone**
3. **Primary rules text zone**
4. **Conditional / risk zone**
5. **Focal illustration slot**
6. **Tag / support icon row**

### Shared system rules
- Keep the reading hierarchy consistent across all families.
- Prioritize **function before flavor**.
- Support both **in-hand scan state** and **focused read state**.
- Preserve space for short, editable design text.
- Keep text separate from frame art.
- Use the same base proportions, alignment logic, and text anchoring across families.

---

## 4. Per-Family Differentiation Rules

Differentiate families through **frame styling, category color banding, icon treatment, and geometry cues**, not through fully different layouts.

### Emotion
- Softer corners or gentler curvature
- More open/expressive band treatment
- Should feel emotionally present, not chaotic
- Must read as tone-setting rather than command-driven

### Memory
- Inset or archival-style framing
- Contained or layered visual space suggesting recall/context
- Can hint at documentary, keepsake, or note-card language
- Must feel grounded and reflective

### Reaction
- Firmer, more angular geometry
- Clear active/read-now energy
- Should feel tactical and immediate without looking like an attack card from a combat game

### Shift
- Offset or asymmetric structural cue
- Should imply redirection, reframing, or transition
- Must feel like perspective change, not raw force

### Breakthrough
- Cleaner, more elevated payoff treatment
- Stronger luminous/resolved accenting
- Must read as an earned outcome state, not just a premium rarity border

---

## 5. Readability Rules

### Focused card requirements
The focused/enlarged card must clearly expose:
- card name,
- category,
- primary effect,
- conditional/risk,
- key icon row.

Recommended focused width target:
- **280–360 px equivalent**

### In-hand requirements
In-hand cards are a **scan state**, not a full reading state.

Recommended in-hand width target:
- **160–220 px equivalent**

At in-hand size, frames must preserve:
- instant category recognition,
- readable title where possible,
- obvious primary vs secondary hierarchy,
- clear selected / illegal / disabled states.

### Text density support
Frame layout must comfortably support:
- **14–28 words ideal** for primary rules text
- **32–36 words max** in exceptional cases
- **1–2 visible keywords ideal**, **3 max**

Do not shrink text to preserve decoration.

---

## 6. State Variant Requirements

The frame system must support functional variants only. No rarity, foil, or alternate-art branches are required.

### Required card-face variants
- **Normal**
- **Focused**
- **Selected**
- **Disabled / Illegal**
- **Resolving / Locked**
- **Compact in-hand**
- **Unlocked Breakthrough presentation**

### State readability rules
State changes must not rely on a single subtle cue.
Use combinations of:
- scale,
- border/frame accent,
- brightness/value lift,
- dimming of non-focused cards,
- clear legal/illegal labeling or icon support.

Best prototype baseline:
- **scale + border + dim-rest-of-row** for focus

---

## 7. Implementation-Facing Requirements

### Modular build requirements
Build frames as reusable layered assets with separate components for:
- base frame,
- category band/accent,
- icon container,
- illustration mask/slot,
- text containers,
- state overlay layer,
- optional result/payoff accents.

### Data-driven layout requirements
- Card faces must be **data-populated layouts**, not flattened composites.
- Category labels, card names, body text, keywords, and state text must remain editable.
- Use flexible text containers with room for expansion.
- Avoid art-dependent text placements that break when wording changes.

### Localization-safe requirements
- Keep gameplay text out of raster art.
- Leave margin for text expansion.
- Support meaning through icon + hierarchy + color, not text alone.
- Avoid frame details that require exact word length to look correct.

### UX dependency requirements
The frame system must work alongside:
- category icons,
- Tension / Trust / Clarity / Momentum icons,
- response-window indicators,
- risk/warning cues,
- breakthrough/collapse/result-state indicators.

### Spectator/controller requirements
Frame differences must remain readable under:
- stream compression,
- smaller displays,
- controller-driven focus flow,
- 4-card default hand and 5-card stress cases.

---

## 8. Visual Direction Constraint

Use **Calm Diagnostic** as the base frame direction:
- clean systems,
- readable geometry,
- restrained texture,
- low-to-medium detail.

Borrow limited warmth from **Soft Intimate Storybook** for portrait/illustration handling and breakthrough accents.

Do not let frame treatment drift into high-aggression or over-graphic combat-card language.

---

## 9. Production Priority Order

If scope tightens, preserve in this order:
1. category readability
2. shared frame consistency
3. typography clarity
4. icon clarity
5. state/gameplay variants
6. illustration warmth accents
7. decorative polish

---

## 10. Acceptance Checklist

The frame system is on target if:
- all 5 families are instantly distinguishable,
- all 5 families still share one recognizable system,
- focused cards are readable without submenu depth,
- in-hand cards scan cleanly at 4–5 visible cards,
- selected / illegal / disabled / breakthrough states are obvious,
- text remains editable and separate from art,
- layout survives wording changes,
- category recognition happens before full rules parsing,
- Breakthrough feels like earned payoff rather than normal hand filler,
- the system supports rapid iteration without redrawing every card.

---

## Bottom Line

ART-004 should deliver **one reusable, modular, implementation-safe frame system** for Emotion, Memory, Reaction, Shift, and Breakthrough cards.

The win condition is not ornate card art. The win condition is a frame system that makes the prototype feel:
- readable,
- emotionally legible,
- spectator-friendly,
- and cheap to update while design is still moving.
