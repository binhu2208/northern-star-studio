# Flower Boat — Commission Specification

**Date:** 2026-03-28  
**For:** Illustrator outreach / Fiverr / DeviantArt / r/INAT  
**Art director:** Yoshi 🎨

---

## Project Overview

**Flower Boat** — a cozy 2D Godot game about delivering flowers by boat through a canal town. Warm, painted flat illustration style. Think Unpacking meets Snufkin.

**Deliverables needed:**
1. Boat sprite (1 image)
2. Customer silhouettes (8 types × 3 reaction states = 24 images)
3. Flower card illustrations (7 images)

**Quality bar:** Identifiable, fresh, characterful. No generic clipart. Boat needs visible wood grain and personality. Customers are silhouettes but readable body language. Flowers must read clearly at card size (300×200px).

---

## 1. Boat Sprite

**Count:** 1 illustration  
**Dimensions:** 512×256px (2x for 1280×720 export), side view, flat illustration  
**Style:** Painted, warm, cozy flat — NOT pixel art  
**Details:**
- Wooden canal boat, side view
- Visible wood grain planks (warm browns: `#A88B70`, `#8B6B50`)
- Worn but maintained — cozy, lived-in feel
- Simple cabin or open design
- Water line at bottom ~20%
- Empty/low detail top (character stands here in-game)

**Palette:**
- Hull wood: `#A88B70`
- Wood shadows: `#8B6B50`
- Wood highlights: `#C4A882`
- Metal/details: `#7A8B8B`
- Water suggestion: `#8FA8A8`

**File:** `boat_sprite.png` (512×256)

---

## 2. Customer Silhouettes

**Count:** 8 types × 3 reaction states = 24 images  
**Dimensions:** 256×256px (2x for 1280×720), side view  
**Style:** Solid color silhouettes — simple, readable, cozy flat  
**Background:** Transparent PNG

### The 8 Customer Types

| # | Type | Silhouette Color | Personality |
|---|------|-----------------|-------------|
| 1 | Hurry | `#E8A060` (warm orange) | Rushed, tapping foot |
| 2 | Griever | `#8090A8` (muted blue) | Slumped shoulders, dragging feet |
| 3 | Stuck | `#A09080` (taupe) | Scratching head, confused posture |
| 4 | Present | `#C8A880` (warm tan) | Standing relaxed, content |
| 5 | Wanderer | `#90A8B0` (soft teal) | Gazing at distance, loose stance |
| 6 | Regular | `#D4B898` (cream tan) | Familiar, easy posture |
| 7 | Newcomer | `#C8D0D8` (light gray) | Upright, alert, slightly stiff |
| 8 | Tired | `#888898` (muted gray) | Heavy shoulders, low energy |

### Reaction States (per customer)

| State | Description |
|-------|-------------|
| **idle** | Neutral standing, waiting — arms relaxed |
| **happy** | Slight lean forward, arms open/raised slightly — pleased |
| **disappointed** | Shoulders up, arms folded or down — let down |

**Naming convention:** `customer_{type}_{reaction}.png`
Examples: `customer_hurry_idle.png`, `customer_griever_happy.png`, `customer_regular_disappointed.png`

**Total files:** 24 PNGs

---

## 3. Flower Card Illustrations

**Count:** 7 illustrations  
**Dimensions:** 300×200px (card-sized), flat illustration  
**Style:** Painted flat, cozy — clear and readable at small card size  
**Background:** Transparent or white PNG  

### The 7 Flowers

| # | Flower | Primary Color | Notes |
|---|--------|--------------|-------|
| 1 | Sunflower | `#E8B830` | Bold, warm yellow, dark center |
| 2 | Lavender | `#B890C0` | Purple spikes, soft |
| 3 | Wildflower | `#D8A8C8` | Pink/purple mix, small cluster |
| 4 | Lily | `#F0E8E0` | White/cream, elegant, spots inside |
| 5 | Rose | `#D87880` | Deep red/pink, layered petals |
| 6 | Chrysanthemum | `#E0A830` | Golden orange, full bloom |
| 7 | Freesia | `#F0D040` | Bright yellow, slender stems |

**Palette notes:** All flowers should feel warm and alive. Avoid desaturated or muddy versions.

**Naming convention:** `flower_{name}.png`
Examples: `flower_sunflower.png`, `flower_lavender.png`

**Total files:** 7 PNGs

---

## Technical Requirements

- **Format:** PNG with transparency where noted
- **Color mode:** RGB or RGBA (8-bit)
- **No embedded text** (text is handled in-game via Godot UI)
- **Cozy flat style:** No outlines, no gradients in final output — solid flat color fills
- **Files delivered via:** Discord attachment, Fiverr delivery, or Google Drive link

---

## Style Reference

- Warm, painted flat illustration
- Think Unpacking / A Short Hike / Snufkin
- Soft edges where forms meet (no harsh black outlines)
- Earthy, golden-hour palette throughout
- Human-scale — nothing hyper-stylized or extreme

**Mood:** Warm afternoon light. Cozy canal town. Gentle and inviting.

---

## Deliverables Checklist

- [ ] `boat_sprite.png` (512×256)
- [ ] `customer_{type}_{reaction}.png` × 24
- [ ] `flower_{name}.png` × 7
- [ ] All files in one shared folder or zip

**Total illustrations:** 32 images  
**Estimated illustrator quote scope:** Moderate commission job

---

## For Illustrator Outreach

When reaching out, include:
1. Project name and brief description (cozy 2D game, canal boat flower delivery)
2. Style reference links (Unpacking, Snufkin)
3. Exact dimensions and file counts per deliverable
4. Color palette hex codes
5. This spec as attachment

**Budget ballpark:** ~$150–400 USD for full set depending on illustrator  
**Timeline:** 1–2 weeks typical

---

*Spec by Yoshi — NorthernStar Studio, 2026-03-28*
