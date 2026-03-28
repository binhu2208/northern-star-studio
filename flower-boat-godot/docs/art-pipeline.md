# Flower Boat — Art Pipeline Spec
# For Yoshi: what to produce and in what format
# Updated based on: color-swatches.md, sample-card-mockups.md, mood-board.md

---

## Resolution & Export

- **Game resolution:** 1280×720 (16:9)
- **Export scale:** 1x (native) + 2x for retina/high-DPI
- **Sprites stored at:** 2x resolution (2560×1440 source), exported at 1x for use
- **Format:** PNG with alpha channel
- **Color mode:** RGBA (for transparency and effects)

---

## Sprite Sheet Layouts

### Characters — Customer Silhouettes

**Style:** Flat color silhouette, no facial detail. Posture + color temperature = emotional read.
**Size per frame:** 128×128px (at 2x: 256×256)
**Directions:** 4 (up, down, left, right) — or single static pose if 2D top-down/isometric

| Customer | Silhouette Color | Mood | Posture |
|----------|-----------------|------|---------|
| The Hurry | #E8A060 amber | Energetic | Leaning forward, pointing |
| The Griever | #8090A8 blue-grey | Heavy | Shoulders down, settled |
| The Stuck | #A09080 brown-grey | Static | Slight crouch, uncertain |
| The Present | #C8A880 tan | Grounded | Upright, open |
| The Wanderer | #90A8B0 sage-blue | Transient | Shifting weight, looking around |
| The Regular | #D4B898 honey tan | Familiar | Relaxed lean |
| The Newcomer | #C8D0D8 pale blue | Isolated | Apart, curious |
| The Tired | #888898 grey-purple | Depleted | Heavy slump |

**Sprite sheet grid:** 4 cols × 2 rows per character = 8 frames
**Total size (2x):** 512×256px per customer type

### Flowers — Card Illustrations

**Style:** Flat illustration with subtle gradient, centered flower
**Size:** 128×160px portrait card ratio (at 2x: 256×320)

| Flower | Dominant Color | Shape Character |
|--------|--------------|-----------------|
| Sunflower | #E8B830 golden | Large round face, tall stem |
| Lavender | #B890C0 purple | Vertical cluster, slim |
| Wildflower Mix | #D8A8C8 pink | Scattered small blooms |
| White Lily | #F0E8E0 cream | Elegant open petal |
| Rose | #D87880 rose-red | Cupped bloom, thorned stem |
| Chrysanthemum | #E0A830 gold | Layered dense petals |
| Freesia | #F0D040 yellow | Arching stem, bell clusters |

**Sprite sheet grid:** 7 flowers × 1 row = 7 frames
**Total size (2x):** 1792×320px or individual PNGs (128×160 each)

### Boat

**Style:** Side-view canal boat with shop counter
**Size:** 256×128px (at 2x: 512×256)
**Variants:** idle, moving-left, moving-right

### Environment — Canal/Water

**Tile size:** 64×64px (at 2x: 128×128)
**Tiles needed:**
- Water tile (repeating, 2-3 variants)
- Canal edge/bank tile
- Sky gradient (full-screen, 3 weather states)

---

## Weather Background Panels

Full-screen gradient panels, 1280×720 (2x: 2560×1440)

| Weather | Sky Hex | Water Hex | Atmosphere |
|---------|---------|-----------|------------|
| Sunshine | #F5EDE0 | #8FA8A8 | Warm, golden highlights |
| Rain | #C0C8D0 | #708090 | Cool, muted, desaturated |
| Fog | #D8DCDD | #B0B8B8 | Pale grey, low contrast |
| Golden Hour | #F0D898 | #C8A860 | Rich honey, warm glow |

---

## UI Elements

### Card Frame Template
- **Flower cards:** 128×160px, rounded corners (8px), subtle shadow
- **Customer cards:** 200×140px, gradient top-to-bottom (#FAF6F0 → #F0EDE8)
- **Buttons:** Minimum 48px touch target height, rounded corners

### Typography (from Google Fonts)
- **Titles:** Playfair Display, 600 weight
- **Body/UI:** Source Sans Pro, 400/600 weight
- **Quotes:** Atkinson Hyperlegible, italic

---

## File Naming

```
sprites/
├── characters/
│   ├── hurry.png          (sprite sheet, 512×256)
│   ├── griever.png
│   └── ...
├── flowers/
│   ├── sunflower.png      (128×160 each, or sprite sheet)
│   └── ...
├── boat/
│   ├── boat_idle.png
│   ├── boat_left.png
│   └── boat_right.png
├── environment/
│   ├── water_tile.png
│   ├── canal_edge.png
│   ├── sky_sunshine.png
│   ├── sky_rain.png
│   ├── sky_fog.png
│   └── sky_golden.png
└── ui/
    ├── card_frame_flower.png
    ├── card_frame_customer.png
    └── button_normal.png
```

---

## Workflow

1. Yoshi produces sprite sheets + environment panels
2. Assets placed in `flower-boat-godot/sprites/`
3. John imports into Godot editor, assigns to Sprite2D nodes
4. Export to HTML5 for web delivery

---

## Questions for Yoshi

1. **Top-down, side-scrolling, or isometric?** Changes character sprite requirements
2. **Character animation?** Idle only, or walk/transition animations?
3. **Water animation?** Gentle sway keyframes or static tiles?
