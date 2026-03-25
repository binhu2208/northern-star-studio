# Emotion Cards Four — Style Exploration Pass

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** ART-002
- **Purpose:** Run one prototype-facing style exploration pass with concrete outputs: visual directions, frame roughs, typography pairing, icon language sample, and one sample card mockup
- **Status:** Draft for active production use
- **Related docs:**
  - `projects/emotion-cards-four/art/art-scope-sheet.md`
  - `projects/emotion-cards-four/art/ui-readability-targets.md`
  - `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
  - `projects/emotion-cards-four/gdd/prototype-card-taxonomy.md`
  - `projects/emotion-cards-four/src/prototype-architecture-baseline.md`

---

## 1. Goal of This Pass

This exploration is not trying to prove final art polish. It is trying to choose a direction that supports:
- first-session readability,
- emotional legibility,
- strong category recognition,
- spectator-friendly UI,
- low-risk iteration during prototype tuning.

The style pass should help the team answer:
- what overall visual lane best fits the prototype,
- what should be borrowed from alternate lanes,
- how frame, typography, iconography, and mockup choices support that lane.

---

## 2. Visual Direction Options

### Direction 1 — Calm Diagnostic
**Best fit if the priority is maximum readability and clean spectator UX.**

- **Mood:** thoughtful, restrained, emotionally serious without feeling bleak
- **Palette tendency:** soft desaturated neutrals with category-led accent bands; cool gray/teal base with warmer accents reserved for positive openings and red/orange used carefully for danger/escalation
- **Rendering / detail target:** low-to-medium detail; flat-to-soft painterly spot art; clean frame geometry; minimal texture noise
- **Strengths:**
  - strongest fit for the project’s “readable in one turn” requirement
  - makes category, HUD state change, and response window logic easy to parse
  - safe for iteration because text, icons, and data-driven layout stay dominant
  - avoids melodrama and keeps the prototype honest
- **Risks:**
  - can read a little clinical if pushed too far
  - may undersell warmth or collectible appeal in screenshots
  - needs careful portrait treatment to avoid feeling generic
- **Prototype fit:** directly supports comprehension, emotional legibility, and explainable state change before chasing premium illustration value

### Direction 2 — Soft Intimate Storybook
**Best fit if the priority is emotional warmth and a more human tone.**

- **Mood:** tender, reflective, slightly melancholic, interpersonal rather than abstract
- **Palette tendency:** muted warm-cool harmonies; dusty rose, faded gold, blue-gray, sage, twilight violet; category colors still present but softened
- **Rendering / detail target:** medium detail; painterly portrait slots and vignette motifs; light paper/grain texture; still template-driven underneath
- **Strengths:**
  - better emotional immediacy for cards like Concern, Shame, Hope, Quiet Support
  - supports the empathy / relationship-reading fantasy directly
  - can make encounter portraits and breakthrough moments memorable without huge asset count
- **Risks:**
  - easy to drift into too much softness, reducing system clarity
  - warm painterly handling may blur category separation unless icon/frame logic stays disciplined
  - slightly higher production pressure than the cleanest UI-first route
- **Prototype fit:** good supporting flavor lane if kept subordinate to readability systems

### Direction 3 — Tension Pulse Graphic
**Best fit if the priority is high contrast, stream readability, and visible cause/effect.**

- **Mood:** charged, psychologically tense, modern, graphic, slightly confrontational
- **Palette tendency:** dark neutral base with bold state-driven accents; electric cyan for clarity, magenta/crimson for tension, amber for momentum shifts, bright accent reserved for breakthroughs/open windows
- **Rendering / detail target:** low illustration detail, high graphic-design emphasis; sharp silhouettes, overlays, pulse/glitch motifs, strong icon-driven feedback
- **Strengths:**
  - excellent for showing escalation and state changes clearly on stream
  - makes hidden logic feel more visible through graphic feedback layers
  - strong debugging/readability energy
- **Risks:**
  - can feel harsher than the game’s empathy-forward pitch
  - too much visual aggression could make repair-oriented play feel tonally off
  - risks implying a more antagonistic battler than intended
- **Prototype fit:** useful as contrast reference, but risky as the primary emotional tone

---

## 3. Recommended Direction

### Primary recommendation
**Choose Direction 1 — Calm Diagnostic as the base direction.**

This is the safest and smartest prototype lane because it directly supports:
- category recognition,
- readable state feedback,
- localization-safe layout,
- low-risk iteration,
- spectator readability.

### Borrowed qualities
Borrow selectively from **Direction 2 — Soft Intimate Storybook** for:
- portrait warmth,
- breakthrough moments,
- subtle emotional texture in spot art or vignette motifs.

### What not to borrow heavily
Do **not** let Direction 3 dominate the visual tone. Its contrast logic is useful, but the overall emotional posture is too easy to push into hostility or melodrama.

### Final style read
The strongest lane is:
**clean systems + human warmth + no melodrama**

---

## 4. Frame Roughs — Card Family Directions

The frame families should share one system but feel distinct enough to support instant recognition.

### Emotion — soft rounded / expressive
- softer corners or gentle curvature
- open category banding
- emotionally present but not chaotic
- should feel like the card is setting tone, not issuing a command

### Memory — inset archival / contextual
- slightly framed/inset treatment
- layered or contained visual space suggesting recall/context
- cues can reference note cards, keepsakes, or documentary fragments without getting literal
- should feel grounded and reflective

### Reaction — angular active / tactical
- firmer geometry
- clearer motion/read cues
- immediate-action energy without looking like an attack card from a combat game
- should read as the most active “in the moment” family

### Shift — offset transitional / reframing
- asymmetry or offset structural cues
- visual sense of tilt, transition, or redirection
- should imply perspective change rather than force

### Breakthrough — luminous resolved / payoff
- cleaner, slightly elevated finish
- stronger inner light or payoff treatment
- distinct enough to read as earned outcome, not normal hand filler
- should feel like resolution, not rarity gimmick

### Shared system notes
All five families should still share:
- a common card body structure,
- one title zone,
- one primary rules zone,
- one icon/tag row,
- one focal illustration slot,
- one consistent readability hierarchy.

If the families drift too far apart, the system becomes decorative instead of helpful.

---

## 5. Typography Pairing Exploration

### Pairing A — Inter Tight + Atkinson Hyperlegible
**Best default for the prototype.**

- **Inter Tight** for card titles / major labels
- **Atkinson Hyperlegible** for body text / rules text

**Why it works:**
- high small-size readability
- clean modern structure
- strong support for interface-heavy content
- safer under stream compression and small display capture
- aligns with the Calm Diagnostic base direction

### Pairing B — Fraunces + Inter
**Alternative if the team wants more editorial personality.**

- **Fraunces** for titles / emphasis
- **Inter** for body text

**Why it works:**
- adds more emotional/editorial personality
- helps the project feel less sterile
- could suit a warmer storybook lean

**Why it is riskier:**
- less forgiving at small sizes
- easier to blur category/system clarity
- more dependent on careful spacing and restraint

### Typography recommendation
For the first playable slice, use:
- **Inter Tight** for titles
- **Atkinson Hyperlegible** for body text

That gives strong category separation, modern clarity, and safer small-size readability.

---

## 6. Icon Language Sample

### Icon direction
The icon set should stay:
- shape-first,
- thick-stroked,
- readable small,
- emotionally legible without ornament,
- supportive of scan speed.

### Icon style rules
- simple silhouettes before interior detail
- thick/clean strokes that survive compression
- shape carries meaning before color does
- avoid tiny decorative cuts or filigree
- keep card-category icons visually distinct from state icons
- allow icons to read in monochrome before applying color coding

### Icon groups needed
#### Card categories
- Emotion
- Memory
- Reaction
- Shift
- Breakthrough

#### Core state icons
- Tension
- Trust
- Clarity
- Momentum

#### System/support icons
- response window open / closed / blocked
- risk / warning cue
- delta up / delta down
- breakthrough available
- collapse warning
- selected / illegal / disabled state support

### Emotional shape bias
A useful directional rule:
- **Trust:** open, rounded, receptive shapes
- **Tension:** sharper or compressed shapes
- **Clarity:** cleaner / more symmetrical / lens-like shapes
- **Momentum:** directional / forward-leaning shapes

This lets the icon system carry emotional/system meaning without verbose labels.

---

## 7. Sample Card Mockup

### Sample card chosen
**R-001 Guarded Honesty**

This is the right test card because it represents the project’s core promise:
**emotionally careful truth-telling with visible gameplay consequence**.

### Mockup description
- **Frame family:** Reaction
- **Overall feel:** angular active/tactical frame, but not aggressive; should feel deliberate and emotionally controlled
- **Title treatment:** Inter Tight, compact but strong; title sits high and reads immediately at focus size
- **Category marker:** clear Reaction icon in upper band or top-left anchor zone
- **Illustration metaphor:** restrained portrait or symbolic vignette showing careful openness — e.g. a partially turned face, guarded body language, or a narrow beam of light across a darkened field; avoid melodramatic literalism
- **Primary effect zone:** clean readable text block with the main action first: **+1 Clarity, -1 Tension**
- **Conditional/risk zone:** separated visually from the primary line so it reads as secondary support information
- **Icon row:** clarity, tension, and any supporting synergy cue visible at a glance
- **Color handling:** moderate contrast, readable category banding, no visual clutter
- **One-second readability target:** a player or spectator should be able to tell this is a Reaction card about careful truth and state stabilization before they fully parse the body text

### Why this mockup matters
If this card reads well, the system is probably in the right lane:
- category is clear,
- emotional tone is clear,
- gameplay consequence is clear,
- the card doesn’t need ornate polish to feel useful.

---

## 8. Decision Summary

### What wins
- **Base style:** Calm Diagnostic
- **Borrowed warmth:** Soft Intimate Storybook in portraits/breakthrough accents
- **Typography:** Inter Tight + Atkinson Hyperlegible
- **Frame principle:** one modular system with five family personalities
- **Icon principle:** shape-first, small-size readable, emotionally/systematically meaningful
- **Sample benchmark:** Guarded Honesty should read in one second as controlled truth-telling with visible impact

### Why this wins
This combination best supports the prototype’s actual job:
- prove readability,
- prove emotional legibility,
- prove causal clarity,
- stay cheap enough to iterate.

It does **not** mistake prototype success for premium art volume.

---

## 9. Recommendations for Next Art Steps

### For wireframing / UI integration
Carry this style direction into any next-pass card and HUD wireframes by prioritizing:
- category recognition,
- focused-card readability,
- visible state changes,
- explanation-first hierarchy.

### For asset creation
If time is tight, preserve in this order:
1. frame hierarchy
2. typography clarity
3. icon language
4. mockup readability
5. portrait warmth accents
6. decorative polish

### For team review
If someone pushes for more visual flourish, the question should be:
**does it improve why-this-happened readability, or just make the card prettier?**

If it’s only prettier, it can wait.

---

## 10. Bottom Line

The best prototype style direction for Emotion Cards Four is:
- **clean**,
- **readable**,
- **emotionally human**,
- **systemically honest**,
- **light enough to iterate without regret**.

That is the right art lane for a prototype trying to prove social-empathy card play rather than fake final-product gloss.
