# Emotion Cards — Card Art Batch Pipeline

**Task:** ART-003-1  
**Phase:** Phase 3 Illustration Production  
**Owner:** Yoshi 🎨  
**Status:** Ready for Production

---

## Purpose

This pipeline is the production system for creating **150+ card illustrations** without losing consistency, file hygiene, or review control. It is designed for a small team shipping fast: one approved visual recipe, repeated in disciplined batches.

The goal is not to finish every card one-by-one in isolation. The goal is to move cards through a repeatable flow so the full set stays coherent across:

- character identity
- emotion family language
- composition rules
- export specs
- approval checkpoints
- implementation-ready file names

---

## Production Principles

1. **Batch similar work together.** Do not jump randomly between characters and moods.
2. **Approve roughs before polish.** Expensive rendering starts only after silhouette/composition approval.
3. **Lock specs early.** Resolution, framing, naming, and export targets must not drift mid-batch.
4. **Reuse structure, not imagery.** Cards can share lighting logic, camera rules, and palette families without feeling duplicated.
5. **Keep source files editable.** Final PNGs are not the working archive.
6. **Review at batch gates.** Catch problems when 10 cards are affected, not after 80 are painted.

---

## Recommended End-to-End Workflow

Each card moves through the same 7-stage pipeline.

### Stage 1 — Card Intake & Batch Assignment

For every card in the production queue, define:

- card name
- card ID
- character owner
- emotion family
- narrative beat / phase
- gameplay role
- illustration brief (1-2 lines)
- assigned batch code

Do this in the tracker before art starts. No "mystery cards" should enter production.

**Output:** card is logged in the batch tracker and assigned to a production batch.

### Stage 2 — Brief Consolidation

Before painting, convert design notes into a short art brief:

- **What is happening?**
- **Who or what is the focal point?**
- **What emotional read should land in 1 second?**
- **What family palette and lighting language applies?**
- **Is this symbolic, character-driven, or environmental?**

Keep briefs compact. If a brief is longer than a short paragraph, it is probably still design, not art direction.

**Output:** one approved brief per card.

### Stage 3 — Thumbnail Batch

Create rough thumbnails in groups of **9-16 cards** from the same family or character arc. Each thumbnail should establish:

- silhouette
- focal point
- camera angle
- light direction
- value grouping
- emotional read

Do not render. Stay fast.

**Target speed:** 5-10 minutes per thumbnail.

**Output:** contact sheet / board for review.

### Stage 4 — Selected Roughs

After thumbnail approval, develop the chosen thumbnail into a rough color comp:

- block major forms
- establish palette
- place background vs foreground
- confirm readability at card size
- test within the card frame

This is the main approval checkpoint before detailed painting.

**Output:** rough color comps ready for signoff.

### Stage 5 — Final Illustration Batch

Paint finals in grouped sessions using shared setup:

- same brush set
- same palette anchors
- same lighting family
- same export action/template

Work in small batches of **6-12 finals** max before a quality check. Larger runs increase drift.

**Output:** approved final source art.

### Stage 6 — Card Crop & Export

Place finished art into the standard card art crop and export required formats.

Verify:

- focal point survives crop
- values remain readable under UI overlays
- no key detail falls into the card safe zone conflict areas
- naming matches implementation spec exactly

**Output:** production PNGs and implementation-ready variants.

### Stage 7 — QA & Archive

Before handoff, confirm:

- files are in correct folder
- names are exact
- source files are archived
- export sizes are correct
- placeholder or temp files are removed from handoff set

**Output:** batch marked complete and ready for integration.

---

## Batching Strategy

For a 150+ card set, the safest production structure is:

1. **Primary batch by character**
2. **Secondary grouping by emotion family**
3. **Tertiary grouping by narrative/theme phase**

This preserves both visual identity and production efficiency.

### 1) Character Batches

Use character as the top-level planning bucket because repeated motifs, costume language, and emotional arc are easier to maintain this way.

Recommended folders / planning groups:

- `maya`
- `ember`
- `wren`
- `tide`
- `shared` (generic emotion, memory, symbol, environment cards)

### 2) Family Batches

Inside each character batch, group by emotion family for lighting and color consistency.

- **Warmth:** hopeful, safe, nurturing, glow-forward
- **Shadow:** muted, reflective, grief-laden, softer contrast
- **Fire:** kinetic, sharp, aggressive, high-contrast heat
- **Storm:** unstable, electric, pressure-filled, directional energy
- **Neutral** (if used): calm, transitional, low-intensity bridge imagery

### 3) Theme / Phase Batches

Use narrative phase to avoid tonal whiplash inside a production run.

Examples:

- Ember: `ignition`, `blaze`, `scorched-earth`, `controlled-burn`
- Wren: `denial`, `weight`, `haunting`, `acceptance`
- Tide: `storm-front`, `thunder`, `downpour`, `aftermath`, `tide`
- Maya / Warmth: can follow reconciliation or healing beats already defined in design docs

### Recommended Batch Size

- **Thumbnail batch:** 9-16 cards
- **Rough approval batch:** 6-12 cards
- **Final paint batch:** 6-10 cards
- **QA/export batch:** 10-20 cards

If a batch exceeds 16 roughs or 10 finals, split it.

### Example Production Order

Best practice is to start with one anchor batch per family:

1. Warmth anchor batch
2. Shadow anchor batch
3. Fire anchor batch
4. Storm anchor batch
5. Shared/generic support batch

After anchor approval, expand each family into character-specific production waves.

This creates a reference library early and reduces later revision cost.

---

## Naming Convention

File names must be predictable enough for both artists and implementation.

### Core Rule

Use lowercase kebab-case only. No spaces. No version names like `final-final2`.

### Final Export Naming

```text
card-art-{character}-{family}-{card-slug}-v{nn}.png
```

**Examples:**

- `card-art-maya-warmth-safe-harbor-v01.png`
- `card-art-ember-fire-spark-strike-v01.png`
- `card-art-wren-shadow-photo-album-v02.png`
- `card-art-tide-storm-ripple-v01.png`
- `card-art-shared-neutral-fading-memory-v01.png`

### Source File Naming

```text
src-card-art-{character}-{family}-{card-slug}-v{nn}.{psd|kra|clip}
```

### Thumbnail / Rough Naming

```text
thumb-{batch-code}-{card-slug}-v{nn}.png
rough-{batch-code}-{card-slug}-v{nn}.png
```

### Batch Code Format

```text
{character}-{family}-{theme}
```

**Examples:**

- `ember-fire-ignition`
- `wren-shadow-haunting`
- `tide-storm-downpour`
- `maya-warmth-reconnection`

### Versioning Rules

- `v01` = first exported approved candidate
- increment only when a real revision is made
- do not overwrite old finals if they were already reviewed
- working autosaves stay outside handoff folders

---

## Folder Structure

Recommended production structure inside `assets/ui/card-art/`:

```text
assets/ui/card-art/
├── README.md
├── card-art-batch-tracker-template.csv
├── card-art-review-checklist.md
├── card-art-export-spec.txt
├── finals/
│   ├── maya/
│   ├── ember/
│   ├── wren/
│   ├── tide/
│   └── shared/
└── source/
    ├── maya/
    ├── ember/
    ├── wren/
    ├── tide/
    └── shared/
```

If source files are too large for git, keep the same naming/folder logic in external storage.

---

## Required Resolutions & Export Targets

The current card art window is defined as **600 × 400 px** inside the card template, while the full card template is **750 × 1050 px**.

To avoid repainting when UI scale shifts, create art at a higher working size and export down.

### Master Working Resolution

Use one of these for source art:

- **Primary recommendation:** `1800 × 1200 px` RGB
- **High-detail option:** `2400 × 1600 px` RGB

This keeps the 3:2 ratio aligned with the card art area.

### Required Export Targets

#### A. Implementation Crop
Primary in-game art crop.

- **Size:** `600 × 400 px`
- **Format:** PNG
- **Color:** sRGB / RGB
- **Background:** transparent only if needed; otherwise flattened
- **Use:** direct placement into card UI art window

#### B. Hi-Res UI Backup
For future UI scaling, marketing crops, and sharper previews.

- **Size:** `1200 × 800 px`
- **Format:** PNG
- **Color:** sRGB / RGB
- **Use:** archival high-res handoff / flexible future use

#### C. Full Card Presentation Mockup (Optional but recommended)
For reviews and deck presentation.

- **Size:** `750 × 1050 px`
- **Format:** PNG
- **Use:** art dropped into full card template for stakeholder review

#### D. Marketing / Store Feature Selects (Optional)
If a card image is especially strong, export promo-safe versions.

- **Suggested size:** `1600 × 1067 px` or larger at the same 3:2 ratio
- **Use:** promo crops, social posts, press kit fragments

### Export Rules

- Export from approved source only
- Sharpen lightly only on downscaled outputs if needed
- Remove hidden sketch layers
- Strip accidental editor/UI overlays
- Keep file size practical, but not at the expense of visible artifacting

---

## Review & Approval Checkpoints

These checkpoints are mandatory. Skipping them causes rework.

### Checkpoint 1 — Batch Brief Approval
Review before thumbnails begin.

Confirm:

- card list is complete
- narrative intent is clear
- character/family assignment is correct
- references are attached

**Approver:** art lead / project owner

### Checkpoint 2 — Thumbnail Approval
Review after thumbnail sheet is complete.

Confirm:

- silhouette variety
- focal point clarity
- family mood is readable
- no duplicate compositions across the batch

**Pass rule:** no final rendering until thumbnails are selected.

### Checkpoint 3 — Rough Color Approval
Review after rough comps.

Confirm:

- palette fits family
- lighting direction works
- composition reads at small size
- narrative action is understandable quickly

**Pass rule:** rough is approved before detailed paint.

### Checkpoint 4 — Final Art Review
Review after paint, before export set is locked.

Confirm:

- anatomy / perspective / effects are clean
- values still read in grayscale
- card crop preserves focal point
- no obvious style drift from established family anchors

### Checkpoint 5 — Export QA / Integration Review
Review the actual output files.

Confirm:

- names match tracker
- export dimensions are correct
- files open cleanly
- no wrong versions in handoff folder
- art works against the existing card template

---

## Quality Bar for Efficient Production

For a 150+ illustration set, consistency matters more than hyper-rendering every card.

Each illustration should achieve:

- clear emotional read in under 1 second
- one obvious focal point
- strong value grouping
- family-consistent palette
- enough uniqueness to avoid deck repetition
- clean readability at reduced size

Avoid:

- over-detailed backgrounds
- muddy mid-values
- tiny facial details that disappear in card view
- identical pose/composition reuse within the same batch
- rendering before composition is approved

---

## Suggested Weekly Throughput Model

A practical small-team target:

- **Day 1:** intake + briefing + references
- **Day 2:** thumbnails for 12-16 cards
- **Day 3:** rough color comps for approved selects
- **Day 4-5:** finals for 6-10 cards
- **Day 5:** export + QA + review board prep

At that pace, one artist can move **24-40 cards/month** depending on complexity. Multiple artists can share the same pipeline as long as naming, batching, and approvals stay centralized.

---

## Handoff Checklist

Before a batch is marked complete, verify:

- [ ] tracker updated
- [ ] source files archived
- [ ] finals exported at required sizes
- [ ] filenames match convention
- [ ] review notes resolved
- [ ] approved versions separated from deprecated versions
- [ ] placeholder assets not mixed into final handoff

---

## Recommended Immediate Next Step

Build **family anchor batches first** for Phase 3:

1. Ember / Fire / Ignition
2. Wren / Shadow / Haunting
3. Tide / Storm / Storm Front
4. Maya / Warmth / Reconnection

Once those four anchors are approved, use them as the visual calibration set for the remaining 150+ cards.

---

*Prepared by Yoshi 🎨 for Emotion Cards Phase 3 production.*
