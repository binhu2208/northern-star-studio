# Flower Boat — Godot Art Pipeline

## Overview
Art production guide for the Flower Boat Godot build. Based on `docs/architecture.md` specs. All sprites must meet the quality bar: **flowers look genuinely good, boat has character**.

---

## Resolution & Scaling

| Property | Value | Notes |
|----------|-------|-------|
| Export resolution | 1280×720 | Primary target |
| Sprite art resolution | 2560×1440 | 2x for retina/HD |
| Environment tile size | 32×32 px (64×64 @2x) | Canal, sky, weather panels |
| Character sprite size | 64×64 px (128×128 @2x) | Customer silhouettes |
| Flower card size | 64×64 px (128×128 @2x) | Stock selection, inventory |

**Export format:** PNG with alpha channel  
**Color space:** sRGB  
**Spritesheet layout:** Horizontal strip (Godot default), left-to-right frame order

---

## Sprite Directory Structure

```
flower-boat-godot/sprites/
├── characters/
│   ├── customer_hurry.png      # 4 frames (walk cycle or state variants)
│   ├── customer_griever.png
│   ├── customer_stuck.png
│   ├── customer_present.png
│   ├── customer_wanderer.png
│   ├── customer_regular.png
│   ├── customer_newcomer.png
│   └── customer_tired.png
├── flowers/
│   ├── flower_sunflower.png    # 64×64 portrait, single flower
│   ├── flower_lavender.png
│   ├── flower_wildflower.png
│   ├── flower_lily.png
│   ├── flower_rose.png
│   ├── flower_chrysanthemum.png
│   └── flower_freesia.png
├── boat/
│   ├── boat_body.png          # Base boat sprite (worn wood, character)
│   ├── boat_counter.png        # Shop counter overlay
│   └── boat_sign.png           # Hand-painted flower shop sign
├── environment/
│   ├── canal_water.png         # Tiled water background
│   ├── canal_water_rain.png    # Rain variant
│   ├── canal_water_fog.png     # Fog variant
│   ├── canal_water_golden.png  # Golden hour variant
│   ├── sky_sunny.png           # Full-screen sky panel
│   ├── sky_rain.png
│   ├── sky_fog.png
│   ├── sky_golden.png
│   └── dock_marker.png         # Stop/dock indicator
├── weather/
│   ├── overlay_rain.png        # Rain effect layer (transparent)
│   ├── overlay_fog.png         # Fog effect layer
│   └── overlay_golden.png      # Golden hour color grade layer
└── ui/
    ├── card_frame.png          # Reusable flower card background
    ├── card_frame_selected.png # Highlighted state
    ├── button_default.png
    ├── button_hover.png
    └── icon_flower_slot.png    # Empty inventory slot
```

---

## Character Sprites — Customer Silhouettes

### Style
- **Color silhouette** — solid fill with warm/cool temperature, no face detail
- **Posture carries emotion** — shape language is the primary communication tool
- **4 frame variations per character** — idle, slight shift, reacting (positive), reacting (negative)
- **Direction:** facing viewer (Flower Boat doesn't need directional movement)

### Color Assignments
| Customer | Silhouette Color | Hex | Posture Notes |
|----------|-----------------|-----|---------------|
| Hurry | Warm amber | `#E8A060` | Leaning forward, energetic shift |
| Griever | Cool blue-grey | `#8090A8` | Shoulders down, heavy, settled |
| Stuck | Muted brown-grey | `#A09080` | Slight crouch, uncertain, static |
| Present | Warm tan | `#C8A880` | Upright, open, available |
| Wanderer | Sage blue | `#90A8B0` | Shifted weight, looking around |
| Regular | Honey tan | `#D4B898` | Relaxed lean, familiar ease |
| Newcomer | Pale blue | `#C8D0D8` | Apart, isolated, curious posture |
| Tired | Grey-purple | `#888898` | Heavy slump, depleted, slow |

### Frame Layout (per sprite sheet)
```
[Idle] [Shift] [React+] [React-]
```
Each frame: 128×128 px (2x), arranged horizontally.

---

## Flower Sprites

### Style
- Single flower per sprite, centered, 64×64 px (128×128 @2x)
- **Must look identifiable and fresh** — not generic colored blobs
- Subtle gradient fills, soft edges, no hard outlines
- Transparent background (PNG alpha)
- Include visible stem and leaves where appropriate

### Flower Specifications
| Flower | Primary Color | Shape Character |
|--------|--------------|-----------------|
| Sunflower | `#E8B830` golden | Large round face, tall stem |
| Lavender | `#B890C0` purple-lilac | Vertical cluster, slim |
| Wildflower Mix | `#D8A8C8` pink | Scattered small blooms |
| White Lily | `#F0E8E0` cream | Elegant open petals |
| Rose | `#D87880` rose-red | Cupped bloom, thorned stem |
| Chrysanthemum | `#E0A830` gold-orange | Layered dense petals |
| Freesia | `#F0D040` yellow | Arching stem, bell clusters |

---

## Boat Sprites

### Quality Bar
- Worn wood with **visible grain** and paint history
- Signs of use: scuffs, weather marks, maintained but not pristine
- Hand-painted signage aesthetic for the shop name
- Scale should feel real — you could picture standing on it

### Components
| Sprite | Size | Notes |
|--------|------|-------|
| boat_body.png | 512×256 px | Main boat hull, side view |
| boat_counter.png | 256×128 px | Shop counter overlay |
| boat_sign.png | 128×64 px | Hand-painted flower shop sign |

---

## Environment / Tile Sets

### Canal Water
- **Tiled** — seamless 64×64 px tile (128×128 @2x)
- Subtle variation (2-3 tiles for natural look)
- **Variants:** sunny, rain, fog, golden hour
- Water should feel still or gently moving — no choppy effects

### Sky Panels
- **Full-screen backgrounds** — 1280×720 (2560×1440 @2x)
- Soft gradient, not harsh
- Color must match weather palette from `color-swatches.md`

### Weather Overlays
- **Rain** — semi-transparent diagonal streaks, animated or static
- **Fog** — uniform soft grey overlay, 50-60% opacity
- **Golden Hour** — warm color grade overlay, amber tint

---

## UI Elements

### Card Frame
- **Size:** 64×80 px (128×160 @2x)
- **Style:** Rounded corners (8px), warm white background `#FAF6F0`, subtle shadow
- **States:** default, selected (golden border `#E8C890`), empty (dashed border)

### Buttons
- Rounded rectangle, warm tones
- **Default:** `#A88B70` wood tone
- **Hover:** slightly lighter, subtle scale up
- **Active:** slightly darker, pressed in

### Inventory Slot
- Empty: dashed border `#D4C4A8`, flower icon silhouette
- Filled: flower sprite centered
- Max 3 slots per row

---

## Weather State Summary

| State | Sky | Water | Overlay | Atmosphere |
|-------|-----|-------|---------|------------|
| Sunshine | `#F5EDE0` warm cream | `#8FA8A8` grey-green | none | Bright, warm |
| Rain | `#C0C8D0` cool grey | `#708090` slate | rain streaks | Muted, cool |
| Fog | `#D8DCDD` pale grey | `#B0B8B8` flat | fog layer | Dreamy, isolated |
| Golden Hour | `#F0D898` rich honey | `#C8A860` amber | golden tint | Warm, nostalgic |

---

## Animation Notes

- Character frames: 4 per customer (idle, shift, react_positive, react_negative)
- Water: subtle CSS/Godot shimmer (not frame-by-frame animation)
- Weather transitions: 600-800ms ease dissolve between states
- Card selection: gentle pulse + scale to 105%

---

## Quality Checklist

Before any sprite is committed:
- [ ] Flower is identifiable at a glance — not a generic colored shape
- [ ] Boat has visible wood grain and character — not a brown rectangle
- [ ] Customer silhouette reads emotion through posture alone — no face needed
- [ ] Colors match hex values in `color-swatches.md`
- [ ] Background is transparent (PNG alpha) for sprites with no background
- [ ] Resolution is 2x (128px for 64px slots) for retina
- [ ] Spritesheet layout is horizontal strip, left-to-right frame order

---

**Canonical file:** `flower-boat-godot/docs/art-pipeline.md`
