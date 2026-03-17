# Emotion Cards — UI Polish Pass Plan

**Phase:** Phase 3  
**Owner:** Yoshi 🎨  
**Branch:** `release/v0.4.0`  
**Status:** Ready for implementation

---

## 1. Why this pass matters

The current UI foundation is solid enough to prototype with, but it is not visually unified yet.

Right now the repo has **four different UI languages competing with each other**:

- `docs/style-guide.md` defines the strongest overall design system and emotion-family palette
- `assets/ui/card-template-spec.md` uses an older card palette, typography stack, and border treatment
- `assets/ui/elements/button-spec.md` uses a third button color set and different corner/weight choices
- `assets/ui/hud/hud-template-spec.md` uses a more generic combat HUD look that does not fully inherit the emotion-family visual language

That means the next polish pass should not start with new decoration. It should start with **consistency, hierarchy, and feedback clarity**.

---

## 2. Remaining UI polish targets

### A. Design system alignment
- Choose **`docs/style-guide.md` as the source of truth** for colors, typography, spacing, motion, and accessibility rules
- Update card, button, HUD, and indicator specs so they inherit the same token set
- Replace one-off hex values with shared family + neutral tokens
- Standardize border radius, stroke weight, shadow softness, and glow behavior across all UI classes

### B. Card frame polish
- Tighten frame hierarchy so card art, title, family badge, rules text, and type line read in a predictable order
- Reduce any clash between family color identity and readability of text areas
- Unify hover, selected, disabled, and exhausted states across all four families
- Confirm safe zones for card art so portraits and effects do not collide with frame ornaments or rules text

### C. HUD polish
- Bring health, energy, turn, and status presentation into the same emotional visual language as the cards
- Make player and enemy info blocks feel like part of the same interface family instead of separate widgets
- Improve top-center turn banner styling so it feels less placeholder and more integrated with the card frame language
- Add clearer spacing, grouping, and overflow rules for status icons, counters, and turn count

### D. Button polish
- Unify action, menu, and dialog buttons under one construction system
- Keep role-based color coding, but standardize padding, typography, borders, icon treatment, and shadow depth
- Ensure hover, pressed, disabled, and focus states follow the same logic everywhere
- Differentiate primary / secondary / destructive / neutral actions more clearly

### E. Indicators and micro-UI polish
- Standardize visual treatment for:
  - selected card state
  - targetable enemies
  - active buffs/debuffs
  - energy spend feedback
  - turn ownership
  - card family badges
  - stack counts / durations / counters
- Make sure indicators communicate through **shape, icon, motion, and contrast**, not color alone

### F. Motion and feedback polish
- Add a small set of reusable motion patterns for card hover, card play, turn transition, button press, status gain/loss, and reward moments
- Tune animation timing so the game feels responsive without becoming noisy
- Create emotional “temperature” differences between families without breaking UX consistency

---

## 3. Priority order for polish work

## Priority 1 — Lock the shared UI language
**Goal:** stop visual drift before more assets are produced.

Deliverables:
- one reconciled token sheet for color, radius, stroke, shadow, spacing, and type
- spec updates for card frames, buttons, and HUD to match the shared system
- state naming cleanup: `normal`, `hover`, `pressed`, `selected`, `disabled`, `focus`, `enemy-turn`, `player-turn`, etc.

Why first:
- every later polish task depends on this
- avoids redoing buttons, HUD, and frame exports multiple times
- reduces implementation ambiguity for John

## Priority 2 — Card readability and frame consistency
**Goal:** make the card itself feel finished, since it is the core play surface.

Focus areas:
- title/rules/type hierarchy
- family badge placement and consistency
- selected / hovered / disabled state treatment
- readability under different art values and color families
- consistency between the four current template exports

Why second:
- the card is the most frequently viewed object
- frame quality sets the visual bar for the rest of the UI

## Priority 3 — HUD integration pass
**Goal:** make combat information read as one cohesive interface.

Focus areas:
- health and energy bar styling
- turn banner redesign using the established UI token set
- icon spacing, label clarity, and overflow behavior
- stronger information grouping between player hand, player vitals, and enemy state

Why third:
- HUD polish matters a lot, but it should inherit the rules already settled by priorities 1 and 2

## Priority 4 — Button and interaction feedback pass
**Goal:** make moment-to-moment interactions feel intentional and satisfying.

Focus areas:
- normalize all button families and roles
- pressed / hover / disabled / focus states
- icon and label alignment
- confirmation dialog affordances
- keyboard/controller focus visibility

Why fourth:
- buttons are easier to finalize once the global token system is stable

## Priority 5 — Motion / juice pass
**Goal:** add feel without compromising clarity.

Focus areas:
- card hover lift
- card play settle
- energy spend tick
- status icon pop-in/out
- turn banner entrance
- reward / heal / damage reaction accents

Why fifth:
- motion should reinforce a stable visual system, not compensate for a weak one

---

## 4. Consistency fixes needed across HUD, buttons, frames, and indicators

## 4.1 Color system inconsistencies
Current issue:
- the style guide palette differs from card template colors
- buttons use a separate emotional palette again
- HUD bars use generic game UI colors that mostly ignore family identity

Fix:
- adopt **style-guide tokens as canonical**
- allow HUD semantic colors for health/warning/danger where needed, but harmonize them with the overall palette temperature and shadow treatment
- create a simple rule:
  - **family colors** = identity, card category, emphasis
  - **semantic colors** = health, damage, warning, disabled, success
  - **neutrals** = body text, panels, dividers, overlays

## 4.2 Typography inconsistencies
Current issue:
- card spec uses Playfair Display while style guide calls for Fraunces + Inter + JetBrains Mono
- HUD/button text weights and sizes do not map cleanly to one system

Fix:
- use:
  - **Fraunces** for large headers / featured labels only
  - **Inter** for most UI text, buttons, card names if readability wins in-engine
  - **JetBrains Mono** for counters, energy values, stack counts, turn numbers, debug-like numeric info
- define one approved type scale for:
  - screen titles
  - section headers
  - card title
  - body/rules text
  - labels
  - counters
  - button labels

## 4.3 Shape language inconsistencies
Current issue:
- cards, HUD bars, and buttons use different corner radius logic
- border weights and shadows are not systematized

Fix:
- define a radius ladder and reuse it everywhere:
  - 6px: compact chips / tiny indicators
  - 8px: small buttons / pills
  - 12px: standard buttons / UI panels
  - 16px: cards / major panels
  - 24px: turn banner / large pill banners
- standardize stroke rules:
  - 1px for internal dividers
  - 2px for standard interactive components
  - 4px only for featured frame moments or selected emphasis
- standardize shadow tiers:
  - low: static panels
  - medium: hoverable controls
  - high: selected cards / modals / focus emphasis

## 4.4 State language inconsistencies
Current issue:
- cards define `hovered` and `selected`
- buttons define `hover` and `pressed`
- HUD components mention pulse and hover but not a universal state model

Fix:
- every interactive element should support a shared state vocabulary where applicable:
  - idle
  - hover
  - pressed / engaged
  - selected
  - disabled
  - focus-visible
  - warning / danger / success (semantic overlays only when needed)

## 4.5 Indicator readability inconsistencies
Current issue:
- selection, family identity, and status stacks rely too heavily on color or isolated styling

Fix:
- give each indicator class a distinct combination of:
  - icon/symbol
  - container shape
  - outline / ring treatment
  - motion behavior
  - text/counter treatment
- example rules:
  - **selection** = outer glow + lift + brighter outline
  - **targetable** = pulsing ring + directional pointer
  - **buff** = upward or positive geometry + cool/supportive motion
  - **debuff** = sharper geometry + warning/damage accent
  - **overflow count** = mono numeric chip with high contrast background

---

## 5. Motion and feedback polish opportunities

These should stay subtle. Emotion Cards wants **cozy responsiveness**, not casino noise.

## 5.1 Core motion set

### Card hover
- 120–160ms ease-out
- raise card slightly with a soft shadow increase
- optional tiny tilt correction to make the fan spread feel alive

### Card selected
- glow tighten + 1 step brighter rim light
- no large bounce; selection should feel precise, not flashy

### Card play
- fast lift → travel → soft settle
- impact accent depends on family:
  - Fire: brief flare
  - Storm: crackle shimmer
  - Shadow: quiet drift / desaturating fade edge
  - Warmth: soft bloom

### Button press
- 80–120ms compress + shadow reduction
- audible/visual confirmation should match role importance
- destructive actions should feel deliberate, not juicy

### Turn transition
- banner slide/fade in, short hold, then settle into passive state
- hand and active side indicators should echo whose turn it is

### Status changes
- gained buff: upward pop + short glow
- debuff applied: sharper snap + darkened outline pulse
- expired effect: quick fade/shrink, not a hard vanish

### Resource feedback
- energy spend should tick down per point or with one readable chunk, depending on pacing
- healing and damage numbers should use different motion arcs and dissolve timing

## 5.2 Motion guardrails
- never animate every element at once
- keep idle loops subtle and low-frequency
- use family flavor only as an accent layer on top of shared timings
- respect accessibility: reduced motion mode should disable lift, pulse loops, and non-essential particles

---

## 6. Recommended implementation sequence

### Pass 1 — Documentation cleanup
- update card/button/HUD specs to align with the style guide
- mark deprecated palette values clearly
- add a token reference section to each spec

### Pass 2 — Static visual refresh
- refresh frame, HUD, button, and indicator mockups using the same token set
- export revised comparison sheets for sign-off

### Pass 3 — In-engine state pass
- implement hover, selected, focus, disabled, warning, and turn states consistently
- verify readability at gameplay distance

### Pass 4 — Motion pass
- add core interaction animations
- test pacing for responsiveness and fatigue

### Pass 5 — Accessibility + edge-case pass
- low health readability
- status overflow
- colorblind readability
- controller focus visibility
- lower-resolution HUD scaling

---

## 7. Sign-off checklist

- [ ] One canonical UI token set is documented and used everywhere
- [ ] Card templates visually match the approved family palette and typography system
- [ ] Buttons share one construction system across gameplay, menus, and dialogs
- [ ] HUD panels feel like the same product as the cards
- [ ] Indicators communicate with more than color alone
- [ ] Motion is readable, restrained, and emotionally flavored
- [ ] Reduced-motion fallback is documented
- [ ] Final exports are ready for implementation handoff

---

## 8. Strong recommendation

If we only do one thing in this polish pass, do **system unification first**.

Right now the project does not need extra ornament. It needs a single visual grammar.

Once cards, HUD, buttons, and indicators all speak the same language, the rest of the polish work gets dramatically easier — and the game will immediately feel more intentional.
