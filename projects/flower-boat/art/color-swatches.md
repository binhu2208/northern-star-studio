# Color Swatches — Flower Boat

## Core Palette

Designed for: social media thumbnail legibility, warm cozy atmosphere, canal/water setting, flower color vibrancy without overwhelming the UI.

---

## Primary Palette

### Canal Water
| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Morning Canal | `#8FA8A8` | 143, 168, 168 | Base water tone — muted, calm, grey-green |
| Shallow Reflection | `#A8BDBD` | 168, 189, 189 | Lighter water highlights |
| Deep Canal | `#6B8484` | 107, 132, 132 | Shadowed water, depth |

### Warm Sky / Atmosphere
| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Soft Cream Sky | `#F5EDE0` | 245, 237, 224 | Background wash, morning warmth |
| Pale Honey | `#F0DFC0` | 240, 223, 192 | Light direction, warm highlights |
| Golden Hour | `#E8C890` | 232, 200, 144 | Late afternoon glow, warmth peak |

### Worn Wood / Boat
| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Old Wood | `#A88B70` | 168, 139, 112 | Boat counter, frame elements |
| Weathered Dark | `#7A6350` | 122, 99, 80 | Wood shadows, depth |
| Pale Plank | `#D4C4A8` | 212, 196, 168 | Light wood surfaces |

### UI / Neutral
| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Deep Warm Charcoal | `#3A3028` | 58, 48, 40 | Primary text — NOT pure black |
| Soft Charcoal | `#5C5048` | 92, 80, 72 | Secondary text, subtle borders |
| Warm White | `#FAF6F0` | 250, 246, 240 | Card backgrounds, contrast surfaces |
| Pale Sand | `#E8E0D4` | 232, 224, 212 | Dividers, inactive states |

---

## Flower Colors

### Primary Flowers (existing v1)
| Flower | Hex | RGB | Notes |
|--------|-----|-----|-------|
| Sunflower | `#E8B830` | 232, 184, 48 | Warm golden — sunshine affinity |
| Lavender | `#B890C0` | 184, 144, 192 | Cool purple — rain/fog affinity |
| Wildflower Mix | `#D8A8C8` | 216, 168, 200 | Soft pink-purple — impermanence |
| White Lily | `#F0E8E0` | 240, 232, 224 | Near-white — grief/presence |

### Expanded Pool (FB-P009)
| Flower | Hex | RGB | Notes |
|--------|-----|-----|-------|
| Rose | `#D87880` | 216, 120, 128 | Warm red-pink — love, care |
| Chrysanthemum | `#E0A830` | 224, 168, 48 | Golden orange — longevity, rest |
| Freesia | `#F0D040` | 240, 208, 64 | Bright yellow — new beginnings |

---

## Customer Silhouette Palette

Customers are color-temperature silhouettes, not detailed portraits.

| Mood | Hex | RGB | Usage |
|------|-----|-----|-------|
| Hurry — warm | `#E8A060` | 232, 160, 96 | Orange-amber, energetic |
| Griever — cool | `#8090A8` | 128, 144, 168 | Blue-grey, heavy |
| Stuck — muted | `#A09080` | 160, 144, 128 | Brown-grey, static |
| Present — warm | `#C8A880` | 200, 168, 128 | Tan, grounded |
| Wanderer — cool | `#90A8B0` | 144, 168, 176 | Sage blue, transient |
| Regular — warm | `#D4B898` | 212, 184, 152 | Honey tan, familiar |
| Newcomer — hopeful | `#C8D0D8` | 200, 208, 216 | Pale blue, uncertain |
| Tired — heavy | `#888898` | 136, 136, 152 | Grey-purple, depleted |

---

## Weather State Palette

### Sunshine
| Element | Hex | Notes |
|---------|-----|-------|
| Sky wash | `#F5EDE0` | Warm cream |
| Water tint | `#8FA8A8` | Calm grey-green |
| Light accent | `#E8C890` | Golden highlights |
| Flower boost | +10% saturation | Everything reads warmer |

### Rain
| Element | Hex | Notes |
|---------|-----|-------|
| Sky wash | `#C0C8D0` | Cool grey-blue |
| Water tint | `#708090` | Slate, darker |
| Atmosphere | `#D8E0E8` | Muted, flat |
| Flower reduction | -15% saturation | Muted palette |

### Fog (Layer 4)
| Element | Hex | Notes |
|---------|-----|-------|
| Atmosphere | `#D8DCDD` | Pale grey, uniform |
| Water | `#B0B8B8` | Flat, low contrast |
| Visibility | 60% normal | Stops feel ambiguous |

### Golden Hour (Layer 4)
| Element | Hex | Notes |
|---------|-----|-------|
| Sky wash | `#F0D898` | Rich honey gold |
| Water tint | `#C8A860` | Warm amber |
| Light accent | `#F8E0B0` | Pale gold |
| Affinity boost | +15% | Everything feels more "right" |

---

## CSS Variables (ready to paste)

```css
:root {
  /* Canal */
  --color-water-base: #8FA8A8;
  --color-water-light: #A8BDBD;
  --color-water-deep: #6B8484;

  /* Sky / Atmosphere */
  --color-sky-soft: #F5EDE0;
  --color-honey: #F0DFC0;
  --color-golden: #E8C890;

  /* Wood */
  --color-wood: #A88B70;
  --color-wood-dark: #7A6350;
  --color-wood-light: #D4C4A8;

  /* UI / Text */
  --color-text-primary: #3A3028;
  --color-text-secondary: #5C5048;
  --color-surface: #FAF6F0;
  --color-divider: #E8E0D4;

  /* Flowers */
  --color-sunflower: #E8B830;
  --color-lavender: #B890C0;
  --color-wildflower: #D8A8C8;
  --color-lily: #F0E8E0;
  --color-rose: #D87880;
  --color-chrysanthemum: #E0A830;
  --color-freesia: #F0D040;

  /* Weather */
  --color-rain-sky: #C0C8D0;
  --color-fog-sky: #D8DCDD;
  --color-golden-sky: #F0D898;
}
```

---

## Usage Rules

1. **Text never pure black** — always `var(--color-text-primary: #3A3028)` or softer
2. **Backgrounds never pure white** — use `var(--color-surface: #FAF6F0)` or cream
3. **Flower colors are the vibrancy** — UI and background stay muted so flowers read clearly
4. **Rain palette desaturates everything** — but flowers stay slightly more saturated than environment
5. **Social thumbnails** — extract the warm cream sky + a single flower color for maximum legibility

---

**Canonical file:** `projects/flower-boat/art/color-swatches.md`
