# Sample Card Mockups — Flower Boat

## Purpose
These are design targets for John to build toward. Each card type described below represents a deliverable once art direction is locked. Actual assets would be produced next.

---

## Flower Cards

### Design: Flower Icon Card
**Used for:** Stock selection, inventory display, affinity reference

```
┌─────────────────────────┐
│                         │
│         🌻              │  ← Flower illustration (flat, soft gradient)
│      Sunflower          │  ← Name: Playfair Display, warm grey
│                         │
│  ☀ 4 / ☁ 2              │  ← Affinity stars (sunshine / rain)
│                         │
└─────────────────────────┘

Specifications:
- Size: 120×160px (portrait card ratio)
- Background: #FAF6F0 (warm white)
- Border: 1px #E8E0D4 (pale sand), radius 8px
- Flower illustration: centered, 60% of card height
- Subtle drop shadow: 0 2px 8px rgba(58,48,40,0.12)
- Text: Deep Warm Charcoal #3A3028
```

### Flower Color Assignments
| Flower | Dominant Color | Shape Character |
|--------|---------------|-----------------|
| Sunflower | `#E8B830` golden | Large round face, tall stem |
| Lavender | `#B890C0` purple | Vertical cluster, slim |
| Wildflower Mix | `#D8A8C8` pink | Scattered small blooms |
| White Lily | `#F0E8E0` cream | Elegant open petal |
| Rose | `#D87880` rose-red | Cupped bloom, thorned stem |
| Chrysanthemum | `#E0A830` gold | Layered dense petals |
| Freesia | `#F0D040` yellow | Arching stem, bell clusters |

---

## Customer Cards

### Design: Customer Silhouette Card
**Used for:** Customer display during encounter, turn summary

```
┌─────────────────────────┐
│                         │
│       ╭───────╮         │  ← Color silhouette (no face detail)
│       │       │         │
│       ╰───────╯         │
│                         │
│   "I'm in a hurry."     │  ← Quote: Atkinson Hyperlegible, italic
│                         │
│      [ Sunflower ]      │  ← Right flower: small card icon
│                         │
└─────────────────────────┘

Specifications:
- Size: 200×140px (landscape)
- Background: gradient from #FAF6F0 (top) to #F0EDE8 (bottom)
- Silhouette: solid fill, color from customer palette
  - Warm customers: amber, tan, honey tones
  - Cool customers: blue-grey, sage, slate tones
- Posture cues: use shape language (hunched = tired, shifting = stuck)
- Quote box: light cream panel, 80% card width, centered
- Face: NO detail — temperature and posture carry all emotion
```

### Customer Silhouette Assignments
| Customer | Silhouette Color | Posture | Shape Language |
|----------|-----------------|---------|----------------|
| Hurry | `#E8A060` amber | Leaning forward | Energetic, pointing |
| Griever | `#8090A8` blue-grey | Shoulders down | Heavy, settled |
| Stuck | `#A09080` brown-grey | Slight crouch | Uncertain, static |
| Present | `#C8A880` tan | Upright, open | Grounded, available |
| Wanderer | `#90A8B0` sage-blue | Shifted weight | Looking around |
| Regular | `#D4B898` honey | Relaxed lean | Familiar, easy |
| Newcomer | `#C8D0D8` pale blue | Apart from group | Isolated, curious |
| Tired | `#888898` grey-purple | Heavy slump | Depleted, slow |

---

## Weather State Mockups

### Sunshine State
```
┌──────────────────────────────────────────────┐
│  🌤  Morning Run — Sunshine                  │  ← Weather icon + route + state
│                                              │
│  ┌──────┐  ┌──────┐  ┌──────┐               │
│  │ 🌻   │  │ 💐   │  │ 🌸   │               │  ← Stock: 3 flower cards
│  │ Sun  │  │ Wild │  │ Lily │               │
│  └──────┘  └──────┘  └──────┘               │
│                                              │
│  Water: calm grey-green #8FA8A8              │
│  Sky: warm cream #F5EDE0                     │
│  Light: soft golden #E8C890                  │
└──────────────────────────────────────────────┘
```

### Rain State
```
┌──────────────────────────────────────────────┐
│  🌧  Morning Run — Rain                      │
│                                              │
│  ┌──────┐  ┌──────┐  ┌──────┐               │
│  │ 💐   │  │ 🌿   │  │ 🌸   │               │  ← Stock: Lavender-forward
│  │ Wild │  │ Lav  │  │ Lily │               │
│  └──────┘  └──────┘  └──────┘               │
│                                              │
│  Water: slate #708090                        │
│  Sky: cool grey #C0C8D0                      │
│  Atmosphere: muted, desaturated              │
└──────────────────────────────────────────────┘
```

### Fog State
```
┌──────────────────────────────────────────────┐
│  🌫  Morning Run — Fog                       │
│                                              │
│  [ Stops feel ambiguous — some faded out ]  │
│                                              │
│  Water: flat #B0B8B8                         │
│  Atmosphere: pale grey #D8DCDD              │
│  Visibility: reduced, soft                  │
└──────────────────────────────────────────────┘
```

### Golden Hour State
```
┌──────────────────────────────────────────────┐
│  ✨  Afternoon — Golden Hour                 │
│                                              │
│  Water: warm amber #C8A860                  │
│  Sky: rich honey #F0D898                    │
│  Everything: +15% affinity boost            │
│  Mood: nostalgic, warm, gentle              │
└──────────────────────────────────────────────┘
```

---

## Encounter Flow Mockup

```
[1. Customer arrives — silhouette fades in, 500ms]
         ↓
[2. Quote appears — text types in, Atkinson Hyperlegible italic, 400ms]
         ↓
[3. Right flower highlighted — card scales up slightly, glow]
         ↓
[4. Player selects — chosen flower pulses once, 300ms]
         ↓
[5. Resolution — fade to result state, 600ms]
```

---

## Typography Spec

| Element | Font | Weight | Size | Color |
|---------|------|--------|------|-------|
| Flower name | Playfair Display | 600 | 16px | #3A3028 |
| Customer quote | Atkinson Hyperlegible | 400 italic | 14px | #3A3028 |
| Route label | Inter | 500 | 13px | #5C5048 |
| Affinity stars | — | — | 12px | #E8B830 (filled) / #D0C8B8 (empty) |
| Weather label | Inter | 500 | 12px | #5C5048 |

---

## Asset Priority

1. **Flower illustrations (7 total)** — most visible, needs color accuracy
2. **Customer silhouettes (8 types)** — posture + color carries everything
3. **Weather background panels (4 states)** — atmosphere setters
4. **Card frame template** — reusable for all flower cards
5. **Boat counter background** — establishes the shop frame

---

**Canonical file:** `projects/flower-boat/art/sample-card-mockups.md`
