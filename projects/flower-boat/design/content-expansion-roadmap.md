# Flower Boat — Content Expansion Roadmap

## Project
Flower Boat

## Purpose
Map out the full content expansion scope. This is what "more content" looks like beyond the core prototype. Each layer can be implemented independently once art direction is locked.

---

## Current State (v0.1 Prototype)
- 4 flowers (Sunflower, Lavender, Wildflower, White Lily)
- 4 customers (Hurry, Griever, Stuck, Present)
- 2 weather states (Sunshine, Rain) with affinity system
- 1 route (Morning Run)
- 3-slot stock selection

---

## Content Layers (Priority Order)

### Layer 1 — Flower Pool Expansion (FB-P009, already specced)
**Scope:** 4 → 7 flowers
**New flowers:** Rose, Chrysanthemum, Freesia
**Status:** Spec complete, waiting for John to implement
**Dependencies:** None — can ship anytime

---

### Layer 2 — Route Expansion
**Scope:** 1 → 3 routes

**Afternoon Route** (already in data, not active)
- Stops: Market Dock → Garden Gate → Old Bridge → Café Dock
- Customer profile: Busier, more variety, less intimate
- Mood: Urban, active, social energy

**Evening Cruise** (already in data, not active)
- Stops: Garden Gate → Quiet Pier → Old Bridge → Corner House
- Customer profile: Reflective, quieter, end-of-day weight
- Mood: Dusk, contemplative, winding down

**New: Market Morning** (design needed)
- Concept: The rush of morning commerce — vendors, early customers
- Different from Morning Run (which is canal-focused) — this is canal + market

**Design notes:**
- Each route has different customer distributions per weather
- Route choice becomes a planning variable: which route for which weather?

---

### Layer 3 — Customer Expansion
**Scope:** 6 → ~10 customer types

**New customers to add:**

**1. The Wanderer** (either weather)
- What they say: "I'm just passing through. I won't be here long."
- Subtext: They're not committed to anything. The flower is a way to mark a fleeting moment.
- Cue: Moving, not settled. Looking at everything.
- Right answer (sunshine): Wildflower Mix — freedom, impermanence
- Right answer (rain): Lavender — softening a brief stop

**2. The Regular** (either weather)
- What they say: "Back again. You always know what I need."
- Subtext: This is ritual. The flower is habit and comfort.
- Cue: Relaxed, familiar posture. Already knows the boat.
- Right answer: Whatever they had last time — continuity matters more than "rightness"

**3. The Newcomer** (sunshine only)
- What they say: "I just moved here. I don't know anyone yet."
- Subtext: Lonely but hopeful. Wants to belong.
- Cue: Standing slightly apart. Looking around.
- Right answer: Freesia — new beginnings, innocence

**4. The Tired** (rain only)
- What they say: "I can't remember the last time I did something just for me."
- Subtext: Exhausted, running on empty. Needs permission to rest.
- Cue: Heavy posture, slow movements, eyes unfocused.
- Right answer: Chrysanthemum — longevity, recovery, rest

---

### Layer 4 — Weather Variants
**Scope:** 2 → 4 weather states

**Fog** (new)
- Mood: Muted, dreamy, isolated
- Who shows up: Griever, Wanderer, Tired
- Flower affinity: Lavender ★★★, Chrysanthemum ★★, Lily ★
- Mechanical effect: Route visibility reduced (some stops feel ambiguous)

**Golden Hour** (new — late afternoon sunshine)
- Mood: Warm, nostalgic, gentle
- Who shows up: Regular, Present, Celebrator
- Flower affinity: Sunflower ★★★, Rose ★★, Freesia ★★
- Mechanical effect: All affinities slightly boosted — everything feels more "right"

---

### Layer 5 — Seasonal Content (Post-Polish)
**Scope:** 4 seasons, each with unique flowers and customer moods

**Spring:**
- New flowers: Tulip (Passion, new love), Hyacinth (Playfulness)
- Customer mood: Rebirth, anticipation, starting over

**Summer:**
- New flowers: Dahlia (Commitment, staying), Sunflower (existing, peak season)
- Customer mood: Full bloom, celebration, abundance

**Fall:**
- New flowers: Aster (Wisdom, letting go), Marigold (Comfort of routine)
- Customer mood: Reflection, nostalgia, preparation for rest

**Winter:**
- New flowers: Poinsettia (Hope in darkness), Hellebore (Survival, endurance)
- Customer mood: Endurance, quiet hope, getting through

---

## Content Expansion Sequence

```
Current → FB-P009 (flower pool) → Route expansion → Customer expansion → Weather variants → Seasons
```

Each layer:
- Can be implemented independently
- Doesn't require re-testing previous layers
- Has a clear spec ready for John to implement

---

## What's NOT in Scope (v1)

- Multi-session progression (deck-building, permanent upgrades)
- Multiple boats
- Day/night cycle beyond weather
- Multiplayer or social features
- Monetization

---

**Canonical file:** `projects/flower-boat/design/content-expansion-roadmap.md`
