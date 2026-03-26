# Flower Boat — Weather-Flower Affinity

## Project
Flower Boat

## Purpose
Define how weather affects which flowers feel "right" for a given customer. This is the affinity matrix that powers the weather disruption layer.

---

## Core Concept

Weather changes the emotional context of every encounter. A customer who needs "comfort" in sunshine might want different flowers than the same customer in rain. The weather isn't a cosmetic choice — it's a multiplier on the reading layer.

**The rule:** Every flower has an affinity rating for each weather state (sunshine, rain). The player's stock decisions are informed by which weather they're sailing into.

---

## Weather States

### Sunshine
- **Mood:** Bright, outward-facing, social
- **Emotional register:** Joy, celebration, warmth, gifting
- **Who shows up:** More Hurry and Present types — people out and about, people reaching out to others
- **What feels "right":** Sunflower, Wildflower Mix

### Rain
- **Mood:** Introspective, quiet, inward
- **Emotional register:** Calm, grief, comfort, nostalgia
- **Who shows up:** More Griever and Stuck types — people processing, people needing softness
- **What feels "right":** Lavender, White Lily

---

## Flower Affinity Matrix

| Flower | Sunshine | Rain | Notes |
|---|---|---|---|
| Sunflower | ★★★ Primary | ★ Secondary | Joy in sunshine; overwhelming in rain |
| Lavender | ★ Supportive | ★★★ Primary | Comfort in rain; too subdued for sunshine |
| Wildflower Mix | ★★★ Primary | ★ Supportive | Freedom and surprise in sunshine; chaotic in rain |
| White Lily | ★ Supportive | ★★★ Primary | Renewal/grief in rain; too heavy for sunshine |

**Affinity levels:**
- ★★★ Primary — this is the obvious right choice in this weather
- ★ Supportive — works but not the strongest fit
- ★★ Neutral — equally valid in both weathers (no strong affinity either way)

---

## How It Works in Practice

### Example 1 — The Hurry (sunshine)
- Customer needs warmth + quick gift
- In **sunshine**: Sunflower is ★★★ — bright, warm, uncomplicated. Obvious right answer.
- In **rain**: Sunflower is ★ — works but rain makes the interaction feel heavier. Still correct-ish but not as clean.

### Example 2 — The Griever (rain)
- Customer needs calm + presence
- In **rain**: Lavender is ★★★ — the rain amplifies the need for calm. Perfect fit.
- In **sunshine**: Lavender is ★ — too subdued for the brightness. Customer might take it but it doesn't land as well.

### Example 3 — The Stuck (sunshine)
- Customer needs permission to want something for themselves
- In **sunshine**: Wildflower Mix is ★★★ — surprise and freedom feel right under open sky.
- In **rain**: Wildflower is ★ — too chaotic for introspective rain. Might work but feels off.

---

## Customer Types Per Weather

### Sunshine customers
1. **The Hurry** — needs quick warmth → Sunflower (primary)
2. **The Present** — reaching out to someone → White Lily (supportive) or Sunflower (supportive)
3. **The Stuck** — wanting something for themselves → Wildflower Mix (primary)
4. **The Celebrator** (new) — spontaneous, gifting → Sunflower (primary)

### Rain customers
1. **The Griever** — processing, need calm → Lavender (primary)
2. **The Overstimulated** (new) — too much going on → Lavender (primary)
3. **The Present** — reaching out, heavy heart → White Lily (primary)
4. **The Stuck** — stuck in their head → White Lily (supportive) or Lavender (supportive)

---

## New Customer Types to Add

### The Celebrator (Sunshine only)
**What they say:** "I just found out! I wanted to mark it."
**Subtext:** They want to celebrate with someone. The flower is the gesture, not the gift.
**Cue:** Animated. Can't sit still. Eyes bright.

**Right answer in sunshine:** Sunflower — pure celebration. In rain: Wildflower Mix (secondary).

---

### The Overstimulated (Rain only)
**What they say:** "It's been... a lot today. I just need to breathe."
**Subtext:** They're overwhelmed. The world is too loud. They need quiet.
**Cue:** Shoulders up, eyes scanning, not resting anywhere.

**Right answer in rain:** Lavender — calm. In sunshine: Wildflower Mix (secondary).

---

## Stock Strategy in the Full Game

With weather-flower affinity:
- **Sunshine run:** Stock Sunflower + Wildflower + one flexible (Lily or Lavender)
- **Rain run:** Stock Lavender + White Lily + one flexible (Sunflower or Wildflower)
- **Planning becomes meaningful:** If you pick sunshine but rain customers show up, you're improvising

This is the disruption layer. Weather isn't just backdrop — it changes the betting strategy.

---

## Next Steps

1. Add new customer types (Celebrator, Overstimulated) to data.js
2. Update weather selection to influence which customers appear
3. Implement affinity multiplier in outcome logic
4. Test with Bin — does weather feel like it changes the game, not just the mood?

---

**Canonical file:** `projects/flower-boat/design/weather-flower-affinity.md`
