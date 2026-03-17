# Emotion Cards - HUD Template Specification

## Overview
This document defines the HUD (Heads-Up Display) layout for the Emotion Cards game. All elements are designed for a 1920x1080 canvas with a card-game aesthetic featuring warm, emotional tones.

---

## 1. Health Bar Design

### Player Health Bar
- **Position:** Bottom-left corner, 40px from left edge, 40px from bottom
- **Size:** 320px width × 32px height
- **Style:** Rounded corners (16px radius)
- **Background:** #1A1A2E (dark navy) with 80% opacity
- **Fill Colors:**
  - Full health: #4ADE80 (emerald green)
  - Medium health (50-75%): #FACC15 (golden yellow)
  - Low health (25-50%): #F97316 (warm orange)
  - Critical (<25%): #EF4444 (crimson red)
- **Border:** 2px solid #E2E8F0 (light gray)
- **Label:** "HP" text in #FFFFFF, positioned left of bar, font size 14px

### Enemy Health Bar
- **Position:** Top-right corner, 40px from right edge, 40px from top
- **Size:** 280px width × 28px height (slightly smaller than player)
- **Style:** Rounded corners (14px radius)
- **Background:** #1A1A2E with 80% opacity
- **Fill Colors:** Same gradient logic as player but with red-tinted hues
  - Full: #DC2626 (enemy red)
  - Medium: #B91C1C (dark red)
  - Low: #7F1D1D (blood red)
- **Border:** 2px solid #991B1B (dark red)
- **Label:** "ENEMY" text in #FFFFFF, positioned right of bar

---

## 2. Energy/Mana Bar Design

### Player Energy Bar
- **Position:** Below health bar, 40px from left edge, 80px from bottom
- **Size:** 280px width × 20px height
- **Style:** Rounded corners (10px radius)
- **Background:** #0F172A (deep blue-black)
- **Fill:** Linear gradient from #3B82F6 (blue) to #8B5CF6 (violet)
- **Border:** 1px solid #60A5FA (light blue)
- **Label:** "ENERGY" text in #93C5FD (light blue), font size 12px
- **Max Energy:** 10 units (displayed as segments)

### Energy Segment Markers
- Each segment: 26px wide with 4px gaps
- Empty segments show as #1E293B (dark slate)

---

## 3. Turn Indicator Design

### Turn Banner
- **Position:** Top-center of screen, centered horizontally
- **Size:** 240px width × 48px height
- **Style:** Rounded pill shape (24px radius)
- **Background:**
  - Player turn: Linear gradient #10B981 → #059669 (emerald)
  - Enemy turn: Linear gradient #EF4444 → #DC2626 (red)
- **Text:** "YOUR TURN" or "ENEMY TURN" in #FFFFFF, bold, 18px
- **Animation:** Subtle pulse effect (scale 1.0 → 1.02 → 1.0, 2s loop)
- **Shadow:** 0 4px 12px rgba(0,0,0,0.3)

### Turn Counter
- **Position:** Below turn banner, centered
- **Text:** "Turn 3" format, #94A3B8 (slate gray), 14px

---

## 4. Hand Display Area Layout

### Card Hand Container
- **Position:** Bottom-center of screen
- **Area:** 900px width × 180px height
- **Anchor point:** Centered horizontally, 20px from bottom edge
- **Layout:** Cards arranged in a fan formation with 30° spread

### Individual Card Slots
- **Card size:** 120px × 168px (standard card ratio 5:7)
- **Spacing:** 40px between card centers
- **Overlap:** Cards overlap by 30px when in hand
- **Hover effect:** Card rises 20px and scales to 1.1x
- **Selection indicator:** Golden glow (#FCD34D) around selected card

### Hand Info
- **Card count:** "5 cards" text in #E2E8F0, positioned above hand
- **Energy cost display:** Shown on card hover, bottom-right corner

---

## 5. Status Effects Icons

### Icon Sprite Sheet Layout
- **Grid:** 4 columns × 3 rows
- **Icon size:** 32px × 32px each
- **Total size:** 128px × 96px
- **Background:** Transparent

### Status Effects List

| Row | Column | Icon Name | Color | Description |
|-----|--------|-----------|-------|-------------|
| 1 | 1 | burning | #F97316 | Fire damage over time (orange flame) |
| 1 | 2 | frozen | #38BDF8 | Stunned/can't act (blue ice crystal) |
| 1 | 3 | shielded | #6366F1 | Damage reduction (purple shield) |
| 1 | 4 | poisoned | #84CC16 | Poison damage (green skull) |
| 2 | 1 | energized | #FACC15 | Extra energy (yellow lightning) |
| 2 | 2 | weakened | #6B7280 | Reduced damage (gray down arrow) |
| 2 | 3 | bleeding | #DC2626 | Physical DoT (red drops) |
| 2 | 4 | healed | #10B981 | Healing over time (green heart) |
| 3 | 1 | blinded | #C084FC | Miss chance (white eye with X) |
| 3 | 2 | enraged | #EF4444 | Bonus damage (red angry face) |
| 3 | 3 | calm | #3B82F6 | Energy discount (blue spiral) |
| 3 | 4 | vulnerable | #F59E0B | Take more damage (orange target) |

### Status Icon Display
- **Size in HUD:** 24px × 24px (scaled from 32px source)
- **Position:** Stacked to the right of health bar for player, left of health bar for enemy
- **Stack limit:** Show up to 5 icons, "+N" for overflow
- **Duration:** Small number in corner shows turns remaining

---

## 6. Layout Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │ [Enemy HP Bar]                              ENEMY HP ██ │   │
│  │                                    [Status Icons →→→]    │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                  │
│                         ┌──────────┐                             │
│                         │ YOUR     │  ← Turn Indicator          │
│                         │ TURN     │                             │
│                         └──────────┘                             │
│                                                                  │
│                                                                  │
│                                                                  │
│                                                                  │
│                                                                  │
│            ┌─────────────────────────────────┐                  │
│            │  ♠  ♥  ♦  ♣  🎴                  │  ← Card Hand     │
│            │  [Card] [Card] [Card] [Card]    │                  │
│            └─────────────────────────────────┘                  │
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │ HP █████████████████████      [Status Icons]           │    │
│  │ ENERGY ████████░░░░░                                    │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### Screen Regions
- **Top bar area (0-120px):** Enemy health, turn indicator, enemy status
- **Center area (120-780px):** Main game area (cards in play)
- **Bottom area (780-1080px):** Player hand, player health, player energy

### Responsive Notes
- Minimum supported resolution: 1280×720
- HUD scales proportionally at lower resolutions
- Card hand repositions to prevent overflow at edges

---

## 7. Color Palette Summary

| Element | Color | Hex |
|---------|-------|-----|
| Player Health Full | Emerald | #4ADE80 |
| Player Health Critical | Crimson | #EF4444 |
| Enemy Health | Enemy Red | #DC2626 |
| Energy Bar | Blue-Violet | #3B82F6 → #8B5CF6 |
| Player Turn | Emerald | #10B981 |
| Enemy Turn | Red | #EF4444 |
| UI Background | Dark Navy | #1A1A2E |
| Text Primary | White | #FFFFFF |
| Text Secondary | Slate | #94A3B8 |

---

## 8. Asset Files

Generated PNG assets:
- `health-bar.png` - Player health bar (full and empty variants)
- `energy-bar.png` - Player energy bar with segments
- `turn-indicator.png` - Turn banner sprite
- `status-icons.png` - 12-icon sprite sheet (32×32 each)

---

*Specification version: 1.0*  
*Created for Emotion Cards v0.1.0*
