# Button Specification - Emotion Cards Game UI

## Overview
This document defines the button templates for the Emotion Cards game UI, including action buttons, menu buttons, dialog buttons, states, color schemes, and typography specifications.

---

## Button Categories

### 1. Action Buttons
Used during gameplay for player actions.

| Button | Label | Icon Suggestion | Purpose |
|--------|-------|------------------|---------|
| Attack | "Attack" | Sword/swipe | Deal damage to opponent |
| Defend | "Defend" | Shield | Block incoming damage |
| Play Card | "Play Card" | Card/hand | Play a card from hand |
| End Turn | "End Turn" | Checkmark/arrow | End current turn |

### 2. Menu Buttons
Used in main menu and pause screens.

| Button | Label | Purpose |
|--------|-------|---------|
| New Game | "New Game" | Start a new game |
| Continue | "Continue" | Resume saved game |
| Settings | "Settings" | Open settings menu |
| Quit | "Quit" | Exit to desktop |

### 3. Confirmation Dialog Buttons
Used in confirmation dialogs and popups.

| Button | Label | Style |
|--------|-------|-------|
| Yes | "Yes" | Primary/confirm |
| No | "No" | Secondary/destructive |
| Cancel | "Cancel" | Neutral/close |

---

## Button States

| State | Visual Behavior |
|-------|------------------|
| **Normal** | Default appearance, full opacity |
| **Hover** | Slight brightness increase (+10%), subtle scale (1.02x), cursor pointer |
| **Pressed** | Darker shade (-15%), scale down (0.98x), slight inset shadow |
| **Disabled** | 50% opacity, no hover effects, cursor not-allowed |

---

## Color Schemes per Emotion Family

### Warmth (Healing/Support cards)
| Element | Color |
|---------|-------|
| Primary | `#E8A87C` (soft peach) |
| Hover | `#F0C49A` |
| Pressed | `#D4946A` |
| Text | `#4A3728` (warm brown) |
| Border | `#C98B5E` |

### Shadow (Dark/Deception cards)
| Element | Color |
|---------|-------|
| Primary | `#5D5D7A` (muted purple-gray) |
| Hover | `#7878A0` |
| Pressed | `#4A4A62` |
| Text | `#E8E8F0` (off-white) |
| Border | `#45456A` |

### Fire (Aggressive/Damage cards)
| Element | Color |
|---------|-------|
| Primary | `#E85D4C` (vibrant red-orange) |
| Hover | `#F07060` |
| Pressed | `#C94A38` |
| Text | `#FFFFFF` |
| Border | `#C94A38` |

### Storm (Speed/Control cards)
| Element | Color |
|---------|-------|
| Primary | `#5B9BD5` (electric blue) |
| Hover | `#70ABDE` |
| Pressed | `#4A82B8` |
| Text | `#FFFFFF` |
| Border | `#4A82B8` |

### Neutral/Menu (Default)
| Element | Color |
|---------|-------|
| Primary | `#6B6B7A` (gray) |
| Hover | `#80808D` |
| Pressed | `#56565F` |
| Text | `#FFFFFF` |
| Border | `#56565F` |

---

## Typography Specifications

| Element | Font | Size | Weight |
|---------|------|------|--------|
| Action Button Text | Inter / system-ui | 16px | 600 (semibold) |
| Menu Button Text | Inter / system-ui | 20px | 700 (bold) |
| Dialog Button Text | Inter / system-ui | 14px | 600 (semibold) |
| Button Shortcut Key | Monospace | 12px | 400 |

---

## Button Dimensions

| Button Type | Width | Height | Corner Radius |
|-------------|-------|--------|---------------|
| Action Button | 140px | 48px | 8px |
| Menu Button | 200px | 56px | 12px |
| Dialog Button | 100px | 40px | 6px |

---

## File Naming Convention
- Format: `button-{type}.png`
- Example: `button-attack.png`, `button-menu.png`

---

## Implementation Notes
- Buttons should be exported at 2x resolution for retina displays
- Include both normal and hover states as separate files when possible
- Use 9-patch or slice for flexible scaling
- All buttons should have accessible contrast ratios (WCAG AA minimum)
