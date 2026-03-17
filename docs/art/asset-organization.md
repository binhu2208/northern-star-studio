# Emotion Cards — Asset Organization & Style Consistency

**Task:** ART-003-4  
**Phase:** Phase 3 production support  
**Owner:** Yoshi 🎨  
**Branch target:** `release/v0.4.0`

---

## Purpose

This document defines how production-ready art assets for Emotion Cards Phase 3 should be organized, named, reviewed, and handed off.

It is the missing operations layer between the existing art direction docs and actual repo hygiene.

Use this alongside:

- `docs/art/card-art-batch-pipeline.md`
- `docs/art/character-portrait-batches.md`
- `docs/style-guide.md`
- per-folder specs inside `assets/`

The rule is simple: **if an asset is meant to survive past a draft review, it needs a predictable home, predictable name, and a clear review state.**

---

## 1. Production asset folder structure

The current repo already separates character and UI work. Keep that split.

```text
assets/
├── README.md
├── characters/
│   ├── README.md
│   ├── {character}/
│   │   ├── README.md or SPEC.md
│   │   ├── batch-01-base/
│   │   ├── batch-02-expressions/
│   │   ├── batch-03-finish/
│   │   ├── review/
│   │   ├── exports/
│   │   └── approved hero images / current references
│   └── ...
└── ui/
    ├── README.md
    ├── TASKS.md
    ├── card-art/
    │   ├── README.md
    │   ├── card-art-batch-tracker-template.csv
    │   ├── card-art-review-checklist.md
    │   ├── card-art-export-spec.txt
    │   ├── placeholders/
    │   ├── source/
    │   ├── finals/
    │   └── review/
    ├── elements/
    │   ├── README.md
    │   └── production exports / specs / scripts
    └── hud/
        ├── README.md
        └── production exports / specs
```

### Folder intent

#### `assets/characters/`
Use for portrait-driven character production.

Each character folder should contain:
- batch folders for progressive work
- `review/` for sheets, markups, and approval notes
- `exports/` for implementation-ready PNGs
- one short spec/readme describing the character's role, palette lane, and current status

#### `assets/ui/card-art/`
Use for card illustration assets and their production support files.

Recommended subfolders:
- `source/` — layered masters or links/placeholders that mirror off-repo source storage
- `finals/` — approved implementation-ready exports grouped by character or shared category
- `review/` — thumbnail sheets, rough boards, and approval comps
- `placeholders/` — temporary art used only until final illustrations replace it

#### `assets/ui/elements/`
Use for reusable UI pieces such as buttons, icons, and supporting utility scripts.

#### `assets/ui/hud/`
Use for persistent gameplay UI assets such as bars, turn indicators, and status icon sets.

---

## 2. What belongs in git vs. external source storage

Keep the repo focused on assets needed for collaboration, implementation, review, or light iteration.

### Commit to git
- approved PNG exports
- lightweight review sheets
- specs, checklists, trackers, and naming references
- placeholder images needed by the game build
- small editable files if they are practical to diff/store

### Prefer external source storage, mirrored by folder name
- large layered masters (`.psd`, `.kra`, `.clip`, large `.blend` exports)
- autosaves and iterative backup files
- oversized texture/source packs
- experimental dead-end variations that are not part of a review decision

If large source files live outside git, mirror the same folder structure and naming there so handoff is still unambiguous.

---

## 3. Naming and versioning rules

### Core rules

- use **lowercase kebab-case** only
- no spaces, no camelCase, no vague names like `final`, `new`, `use-this-one`
- names must tell dev/QA what the file is without opening it
- version numbers increment only when an export is reviewable or handoff-worthy

### Version format

Use two-digit versions:

```text
v01, v02, v03
```

Do not use:
- `final`
- `final2`
- `final-final`
- `latest`
- `fixed`

### Character portrait naming

#### Final exports
```text
portrait-{character}-{state}-v{nn}.png
```

Examples:
- `portrait-maya-neutral-v01.png`
- `portrait-ember-intense-v02.png`
- `portrait-wren-breakthrough-v01.png`

#### Review sheets
```text
review-{character}-{batch-or-state}-v{nn}.png
```

Examples:
- `review-tide-base-lineup-v01.png`
- `review-frost-expressions-v02.png`

#### Source files
```text
src-portrait-{character}-{state}-v{nn}.{psd|kra|clip}
```

### Card illustration naming

#### Final exports
```text
card-art-{character-or-shared}-{family}-{card-slug}-v{nn}.png
```

Examples:
- `card-art-maya-warmth-safe-harbor-v01.png`
- `card-art-ember-fire-spark-strike-v02.png`
- `card-art-shared-neutral-fading-memory-v01.png`

#### Thumbnails and roughs
```text
thumb-{batch-code}-{card-slug}-v{nn}.png
rough-{batch-code}-{card-slug}-v{nn}.png
```

#### Batch code
```text
{character}-{family}-{theme}
```

Examples:
- `maya-warmth-reconnection`
- `wren-shadow-haunting`
- `tide-storm-downpour`

### UI element naming

#### Buttons, HUD pieces, reusable UI
```text
ui-{system}-{asset-name}-v{nn}.png
```

Examples:
- `ui-button-attack-v01.png`
- `ui-hud-health-bar-v01.png`
- `ui-status-poison-v01.png`

For current folders that already use stable names like `button-attack.png` or `health-bar.png`, preserve compatibility unless there is an implementation update scheduled. For future additions, prefer the explicit production naming above in source/review contexts and export aliases only when the code requires fixed filenames.

---

## 4. Review states and gatekeeping

Every production asset should be in one of these states:

1. **draft** — internal work, not ready for shared decision-making
2. **review** — ready for feedback, naming/version locked for that pass
3. **approved** — art direction signoff received
4. **shipped** — integrated and verified in build/marketing/QA context
5. **deprecated** — replaced, kept only for traceability if still useful

### Folder behavior by state

- work-in-progress comps belong in batch folders or `review/`
- implementation-ready approved exports belong in `exports/` or `finals/`
- deprecated files should either be removed before ship or moved out of the active handoff set

Do not mix unapproved roughs into the same folder as approved handoff exports.

---

## 5. Style consistency review gates

The repo already has strong art direction. The failure mode now is drift between batches. These gates are mandatory.

### Gate 1 — Intake / spec alignment
Before art starts, confirm:
- correct character / family / gameplay context
- reference doc exists or brief is attached
- target crop and export size are known
- batch assignment is logged

**Reject at this gate if:** the brief is still design fog or the family assignment is unclear.

### Gate 2 — Composition / silhouette review
Used for thumbnails, base portraits, or shape roughs.

Check:
- focal point reads in under one second
- silhouette is distinct from nearby cards/portraits
- pose/composition is not a repeat of an adjacent batch item
- major forms survive the intended crop

**Reject at this gate if:** the piece needs rendering to become readable.

### Gate 3 — Palette / family language review
Used at rough color stage.

Check against family anchors:
- **Warmth:** inviting glow, soft transitions, organic rounded rhythm
- **Shadow:** muted restraint, gentle contrast, contemplative atmosphere
- **Fire:** sharp value breaks, heat, outward energy, aggressive accents
- **Storm:** directional force, charged atmosphere, unstable motion
- **Neutral/shared:** calm bridge language, low drama, clean readability

Also check:
- values still read in grayscale
- saturation is intentional, not accidental drift
- family identity is visible even at thumbnail size

**Reject at this gate if:** an asset could be mistaken for a different family when seen small.

### Gate 4 — Final polish review
Used before export lock.

Check:
- anatomy, perspective, edge quality, and FX are controlled
- highest contrast stays around the intended focal area
- small-size readability is still strong
- style still matches the approved anchor pieces
- no extra detail has made the image muddy

**Reject at this gate if:** polish has made the asset technically prettier but less legible.

### Gate 5 — Export QA
Used on the actual files entering implementation or wider handoff.

Check:
- file names exactly match tracker/spec
- dimensions and color mode are correct
- correct version exported
- no hidden placeholder or temporary layer mistakes
- asset works in the actual card template or UI frame

**Reject at this gate if:** the exported asset differs from the approved review comp.

---

## 6. Style consistency checklist

Use this as a fast pass before approving anything in `/assets/`.

### Character portraits
- [ ] face reads cleanly at reduced UI size
- [ ] silhouette is distinct from the rest of the cast
- [ ] family palette matches the assigned emotional lane
- [ ] eye line and crop feel consistent with the portrait set
- [ ] FX support the acting instead of covering it
- [ ] the character still feels like themselves, not just the family color swatch

### Card illustrations
- [ ] one clear focal point
- [ ] strong read at 50% scale
- [ ] family mood is obvious without explanation
- [ ] background detail does not fight gameplay readability
- [ ] crop-safe composition for the card frame
- [ ] repeated compositions inside the batch are avoided

### UI assets
- [ ] line weight / shape language matches neighboring UI pieces
- [ ] emotion color usage follows the style guide
- [ ] buttons/hud elements remain readable on target backgrounds
- [ ] export dimensions are stable and implementation-safe

---

## 7. Handoff rules by downstream team

### Dev handoff
Provide only implementation-ready files.

Required:
- approved export assets only
- exact filenames expected by implementation
- spec or README if dimensions/crop behavior matter
- note any placeholder that still needs replacement

Do not hand dev a folder full of alternates and expect them to guess.

### Marketing handoff
Marketing needs presentation-safe assets, not raw production clutter.

Provide:
- approved hero exports
- optional full-card mockups or hi-res variants
- note whether the asset is in-game final, review-only, or safe for public use
- family/character labeling for quick campaign sorting

Do not hand off work-in-progress variants unless explicitly labeled as internal-only.

### QA handoff
QA needs clarity, not art theory.

Provide:
- final exported file set
- expected dimensions / filenames
- where the asset should appear in-game
- known limitations or placeholder status
- whether this is a new asset, replacement asset, or regression-risk update

If an asset changed visually but kept the same name, call that out explicitly so QA checks for unintended regressions.

---

## 8. Folder-specific working rules

### Character folders
- keep batch progression intact
- `review/` stores lineup sheets, notes, and approval comps
- `exports/` stores only approved deliverables
- if a character is blocked by design, scaffold the folder but do not invent canon without a spec

### `assets/ui/card-art/`
- placeholders should live under a dedicated `placeholders/` folder
- review boards and rough sheets go in `review/`
- final exports go in `finals/`
- tracker, checklist, and export spec stay at folder root because the whole team needs them fast

### `assets/ui/elements/` and `assets/ui/hud/`
- keep specs close to exports
- group reusable systems clearly
- avoid mixing generated files, scripts, and approved deliverables with no explanation

---

## 9. Recommended approval ownership

Because `/assets/` is code-owned by art, use this approval pattern:

- **Art approval:** Yoshi or designated art owner confirms style consistency
- **Production approval:** Shig confirms scope/status alignment when needed
- **Implementation acceptance:** dev confirms integration feasibility if filenames or dimensions changed
- **QA acceptance:** QA verifies in-context behavior after integration

For any asset touching both look and implementation, art approval should happen before final export lock.

---

## 10. Immediate repo standard for Phase 3

For this branch, use the following practical standard:

1. preserve existing stable asset paths already referenced by the project
2. improve organization with README/index files rather than risky file moves
3. keep placeholders clearly labeled and separated from finals
4. route all new Phase 3 art documentation through `docs/art/`
5. require explicit review before anything in `/assets/` is treated as production-final

That keeps the repo usable now without breaking implementation.

---

## Summary

Good asset organization is not paperwork. It is how we prevent style drift, filename confusion, and broken handoffs.

If a file is hard to place, hard to name, or hard to review, the process is wrong. Fix the structure first, then paint faster.

---

*Prepared by Yoshi 🎨 for Emotion Cards Phase 3.*
