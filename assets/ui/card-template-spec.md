# Emotion Cards — UI Template Specification

**Task:** ART-001A  
**Date:** March 14, 2026  
**Artist:** Yoshi 🎨

---

## Card Dimensions

- **Aspect Ratio:** 2.5 × 3.5 inches (standard poker card)
- **Resolution:** 750 × 1050 px (300 DPI for print quality)
- **Safe Zone:** 50px margin on all sides
- **Bleed:** 25px additional (if needed for print)

---

## Layout Structure

```
┌─────────────────────────┐
│  [EMOTION FAMILY ICON]  │  ← 60px height
│                         │
│      [CARD ART]         │  ← 400px height
│       600×400 px        │
│                         │
├─────────────────────────┤
│  [CARD NAME]            │  ← 80px height
│  Bold, 36pt             │
├─────────────────────────┤
│  [EMOTION FAMILY]       │  ← 40px height
│  Warmth/Shadow/Fire/    │
│  Storm                  │
├─────────────────────────┤
│  [EFFECT TEXT]          │  ← 200px height
│  Regular, 24pt          │
│  +2 Joy. Draw 1 card.   │
│                         │
├─────────────────────────┤
│  [CARD TYPE]            │  ← 40px height
│  Primary/Complex/       │
│  Memory/Reaction        │
└─────────────────────────┘
```

---

## Color Palette — Emotion Families

| Family | Primary | Secondary | Accent |
|--------|---------|-----------|--------|
| **Warmth** | `#E8A87C` (Peach) | `#F4D03F` (Gold) | `#FFF8E7` (Cream) |
| **Shadow** | `#6C5B7B` (Dusty Purple) | `#355C7D` (Deep Blue) | `#C8B8DB` (Lavender) |
| **Fire** | `#C06C47` (Terracotta) | `#E74C3C` (Crimson) | `#FAD7A0` (Amber) |
| **Storm** | `#5D6D7E` (Slate) | `#2C3E50` (Navy) | `#AEB6BF` (Silver) |

---

## Typography

| Element | Font | Weight | Size | Color |
|---------|------|--------|------|-------|
| Card Name | Serif (Playfair Display) | Bold | 36pt | `#2C3E50` (Dark Navy) |
| Emotion Family | Sans-serif (Inter) | Medium | 18pt | Family Primary |
| Effect Text | Sans-serif (Inter) | Regular | 20pt | `#34495E` (Charcoal) |
| Card Type | Sans-serif (Inter) | Light | 14pt | `#7F8C8D` (Gray) |

---

## Visual Style

### Frame Design
- **Border:** 4px solid, color = family primary
- **Corner Radius:** 16px (soft, approachable)
- **Background:** Subtle paper texture (#FDFBF7)
- **Shadow:** Soft drop shadow (0 4px 12px rgba(0,0,0,0.1))

### Art Area
- **Mask:** Rounded top corners (16px radius)
- **Overlay:** Gradient from transparent to white at bottom (for text readability)
- **Placeholder:** "[Card Art — 600×400px]"

### Iconography
- **Family Icons:** Simple, geometric symbols
  - Warmth: ☀️ Sun/heart
  - Shadow: 🌙 Moon/droplet
  - Fire: 🔥 Flame/spark
  - Storm: ⚡ Lightning/cloud

---

## Card States

### Normal State
- Full color, standard shadow

### Hovered State (UI interaction)
- Scale: 1.05
- Shadow: Enhanced (0 8px 24px rgba(0,0,0,0.15))
- Border: 6px (thicker)

### Disabled State
- Grayscale filter
- Opacity: 0.6

### Selected State
- Glow effect: 0 0 20px family primary color
- Border: 6px dashed

---

## Deliverables

1. **card-template-warmth.png** — Warmth family template
2. **card-template-shadow.png** — Shadow family template
3. **card-template-fire.png** — Fire family template
4. **card-template-storm.png** — Storm family template
5. **card-template-master.psd** — Layered source file (if applicable)

---

## Next Steps

- [ ] Create base template in design tool
- [ ] Apply color variations for 4 families
- [ ] Export PNGs for each family
- [ ] Push to `assets/ui/`
- [ ] Hand off to John for implementation

---

*Yoshi 🎨 — March 14, 2026*
