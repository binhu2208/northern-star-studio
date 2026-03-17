# Emotion Cards — Character Portrait Batches

**Task:** ART-003-2 Character portrait production plan  
**Phase:** Production / Phase 3  
**Version:** v0.4.0 draft  
**Owner:** Yoshi 🎨

---

## 1. Purpose

This document turns the current character design material into a portrait production plan for Emotion Cards Phase 3.

Goals:
- lock a portrait roster for the current 6-character production target
- batch expressions and poses efficiently
- keep a shared visual language across the cast
- preserve strong silhouette, palette, and emotional differentiation per character
- define a repeatable deliverable checklist per character

---

## 2. Portrait roster for Phase 3

The repo currently defines five concrete character directions plus one open roster slot needed to satisfy the Phase 3 goal of six characters. That sixth slot stays intentionally reserved until design finalizes DES-003 / final roster naming.

| Slot | Character | Status | Emotion Family | Core Theme | Portrait Priority |
|------|-----------|--------|----------------|------------|-------------------|
| 01 | Maya Chen | Existing spec + assets | Warmth / Shadow bridge | Reconciliation, resentment, family grief | High |
| 02 | Ember | Existing spec + asset | Fire | Anger, guilt, controlled power | High |
| 03 | Wren | Existing spec + assets | Shadow | Grief, memory, acceptance | High |
| 04 | Tide | GDD exists, portrait production needed | Storm | Trust, vulnerability, emotional overload | High |
| 05 | Frost | GDD exists, portrait production needed | Ice | Fear, freezing, courage | High |
| 06 | TBD-06 | Reserved for final sixth character | TBD | TBD | Planned / blocked by design |

### Recommended portrait naming

Use a consistent asset pattern for all character portrait exports:

- `{character}-portrait-neutral.png`
- `{character}-portrait-intense.png`
- `{character}-portrait-soft.png`
- `{character}-portrait-breakthrough.png`
- `{character}-portrait-sheet.png` (contact sheet or review board export)

If character-specific emotional labels are more useful in implementation, keep the same count and map them like this:

- Maya: neutral / guarded / concerned / hopeful
- Ember: ignition / blaze / scorched / controlled
- Wren: denial / weight / haunting / acceptance
- Tide: storm-front / downpour / electric / tide
- Frost: freeze / shatter / cold-shoulder / thaw
- TBD-06: placeholder until design lock

---

## 3. Batch strategy: expressions and poses

The fastest way to produce six coherent portrait sets is to separate work into reusable batch passes instead of finishing one character at a time from scratch.

### Batch A — Base portrait lock

**Goal:** Approve one clean base portrait for each character before expression painting.

Per character:
- head-and-shoulders or mid-bust framing
- neutral expression
- final costume block-in
- family color palette lock
- silhouette approval
- key accessory approval
- background treatment placeholder

**Output:**
- 1 approved neutral base per character
- 1 lineup sheet showing all six together at the same scale

### Batch B — Shared pose set

Use a limited pose kit to reduce redraw overhead.

#### Standard pose library
1. **Front 3/4 neutral** — default profile/select portrait
2. **Tension pose** — shoulders tighter, head tilt reduced, eye focus sharpened
3. **Soft/open pose** — chest and neck open slightly, gaze more direct or receptive
4. **Breakthrough pose** — strongest emotional culmination pose, still UI-safe

Not every character needs a radically different body angle. The real efficiency comes from:
- reusing framing
- reusing shoulder/chest structure
- swapping hand visibility only when it adds character value
- making expression and lighting do most of the emotional work

### Batch C — Expression family pass

Paint all characters in the same emotional intensity tier together.

#### Pass order
1. **Neutral / entry-state pass**
   - lowest rendering risk
   - validates likeness
2. **Strain / conflict pass**
   - concern, anger, overload, grief pressure
3. **Soft / vulnerable pass**
   - warmth, openness, reflection, relief
4. **Breakthrough / final-form pass**
   - culmination state for each character

This avoids style drift and helps the cast feel like one production wave instead of six unrelated illustration sessions.

### Batch D — FX and background pass

Apply family-specific finishing after portrait acting is approved.

- Fire: ember glow, ash, hot rim light
- Storm: electric edge light, rain texture, charge arcs
- Shadow: soft haze, memory bloom, ghosted forms
- Warmth: diffuse glow, ceramic-earth warmth, sunlit softness
- Ice: crystalline highlights, cold bloom, breath haze
- TBD-06: hold until design family is known

### Batch E — Export and implementation pass

Per approved portrait set:
- clean layered source file
- game export PNGs
- optional transparent and framed variants
- review sheet for naming + scale check

---

## 4. Shared visual language rules

These rules keep the cast cohesive across the game UI.

### Framing
- Portrait crop should stay between bust and upper torso.
- Eyes should land in a consistent upper-third zone for UI readability.
- Character should remain legible at reduced card portrait sizes.
- Avoid extreme foreshortening or full-profile angles for the core batch.

### Rendering style
- Painterly-stylized finish, not hyperreal.
- Clean shapes first, texture second.
- Edge control should stay soft-to-medium; reserve hard edges for focal features.
- Light should support emotion, not become spectacle.

### Background language
- Keep backgrounds abstract and family-coded, not scene-heavy.
- Use soft gradients, atmosphere, and symbolic motifs over detailed environments.
- Background value range must not overpower facial readability.

### Lighting
- One dominant key light direction per portrait.
- Family-specific accent light can vary, but face planes must remain readable.
- Preserve clear eye highlight treatment across all characters.

### Emotional readability
- Expression must read at thumbnail size.
- Brows, eyes, and mouth corners do most of the storytelling.
- Secondary emotion should appear in pose/lighting, not only facial anatomy.

### UI safety
- Leave breathing room around hair shapes and accessories.
- No important story detail should sit on the extreme crop edge.
- Keep highest contrast around the face, not shoulders or FX.

---

## 5. Differentiation rules by character

Shared style is good. Visual sameness is not. Each character needs one clear read from silhouette, color, and emotional posture.

### Maya Chen
**Primary read:** grounded, human, tactile, emotionally guarded but warm underneath

- Use earthy terracotta and cream as the base identity
- Hands/clay traces can appear when crop allows
- Hair should feel practical, studio-worn, not glamorized
- Expression range should move from guarded to genuinely open
- Keep her posture more grounded and less theatrical than the fantasy-coded cast

### Ember
**Primary read:** volatile heat becoming controlled conviction

- Strongest warm contrast in the roster
- Hair and silhouette can imply flame motion
- Use sharper angular rhythms than Maya or Wren
- Early states can feel compressed and explosive; final state becomes stable and centered
- Burn marks / ash cues should stay subtle enough for UI clarity

### Wren
**Primary read:** fragile, haunted, beautiful sadness without horror

- Softest edges in the cast
- Use translucency, memory haze, and bird motifs carefully
- Silhouette should feel light and slightly drifting
- Avoid turning the design into generic ghost-goth
- Final acceptance state should feel clearer, lighter, more grounded

### Tide
**Primary read:** defensive pressure, emotional weather, eventual fluid openness

- Storm palette should use cyan/blue-violet contrast
- Wet hair, charged atmosphere, or rain-shaped marks can reinforce the family
- Strong use of shoulder tension and jaw set in conflict poses
- Final state should look fluid rather than simply calm
- Differentiate from Frost by making Tide feel kinetic and electrically alive

### Frost
**Primary read:** stillness under pressure, fear made visible, courage through motion

- Colder, paler value structure than Tide
- Shapes should feel crystalline, restrained, and held-in
- Default pose can be more closed and locked than Tide
- Thaw state should introduce tiny signs of warmth without losing the ice identity
- Differentiate from Wren by making Frost feel sharp/still rather than soft/ethereal

### TBD-06
**Primary read:** reserved until design lock

Until the sixth character is defined:
- do not assign final palette
- do not invent family-specific motifs in production exports
- create only folder/template scaffolding
- require design handoff before Batch A begins

---

## 6. Production order recommendation

Recommended order based on dependency and existing material:

1. **Maya** — anchor for overall tone; already has concrete spec and existing portraits
2. **Ember** — strongest visual contrast; useful for calibrating intensity ceiling
3. **Wren** — validates soft/ethereal rendering lane
4. **Tide** — expands roster into Storm family with mid/high-intensity acting
5. **Frost** — establishes Ice family separation from Storm + Shadow
6. **TBD-06** — only after design lock

### Why this order works
- Maya establishes the grounded emotional baseline
- Ember sets the extreme saturation/energy boundary
- Wren proves the melancholy lane without losing readability
- Tide and Frost are easier to separate once Fire/Shadow/Warmth anchors are already fixed
- the sixth slot should not consume render time before design approval

---

## 7. Deliverable checklist per character

Each character batch should ship with the same minimum package.

### Required art deliverables
- [ ] 1 neutral/select portrait
- [ ] 1 conflict/intense portrait
- [ ] 1 soft/vulnerable portrait
- [ ] 1 breakthrough/final-state portrait
- [ ] 1 lineup review sheet with all variants side by side

### Required production files
- [ ] Layered source file (`.psd`, `.kra`, or studio master format)
- [ ] Export folder with final PNGs
- [ ] Thumbnail test sheet at in-game display size
- [ ] Naming conforms to project convention
- [ ] Background and FX separated enough for future edits when possible

### Required review checks
- [ ] Face reads clearly at small size
- [ ] Character silhouette is distinct from rest of cast
- [ ] Palette aligns with assigned emotion family
- [ ] Emotional progression is visible across the set
- [ ] Contrast is concentrated around the face
- [ ] No crop collisions with hair/accessories/UI frame

### Character-specific checklist prompts

#### Maya
- [ ] Clay/studio identity present somewhere in design language
- [ ] Guarded-to-open shift reads cleanly
- [ ] Warmth never becomes overly glossy or heroic

#### Ember
- [ ] Anger states read as powerful, not generic villain rage
- [ ] Final controlled state still feels hot/alive
- [ ] Fire FX do not obscure facial planes

#### Wren
- [ ] Sadness reads as tender, not horror-coded
- [ ] Memory/bird motifs remain subtle and elegant
- [ ] Final state feels lighter without losing history

#### Tide
- [ ] Defensive tension is readable in shoulders/jaw/eye line
- [ ] Storm FX feel energetic, not noisy
- [ ] Final state conveys openness without losing edge

#### Frost
- [ ] Fear/stillness reads immediately in the base pose
- [ ] Ice treatment stays distinct from Tide's storm treatment
- [ ] Thaw state introduces courage, not full warmth-family drift

#### TBD-06
- [ ] Await final design packet
- [ ] Assign family palette after narrative approval
- [ ] Add character-specific checklist once spec exists

---

## 8. Folder structure recommendation

Recommended batch structure under `assets/characters/`:

- one folder per character
- consistent subfolders for source, exports, and review
- keep placeholder structure for characters without final art yet

This supports parallel production, cleaner handoff, and easier review comments.

---

## 9. Risks / blockers

### Current blocker
The sixth Phase 3 character is not defined in the repo yet.

### Impact
- full six-character batch cannot be art-complete
- naming/palette/silhouette rules for slot 06 must remain provisional

### Recommendation
Before portrait rendering starts for slot 06, require:
- final character name
- emotion family
- one-paragraph arc summary
- rough palette direction
- at least one silhouette note or concept prompt

---

## 10. Summary

For Phase 3 portrait production, the best approach is:
- lock six roster slots now
- fully produce five known characters
- keep slot 06 scaffolded but uninvented
- batch work by base portrait, emotional pass, then finish pass
- use shared framing and rendering rules while pushing each character's silhouette, palette, and emotional posture apart

That gives production efficiency without flattening the cast.
