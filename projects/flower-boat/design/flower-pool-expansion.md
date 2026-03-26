# Flower Boat — Flower Pool Expansion

## Project
Flower Boat

## Task ID
FB-P009

## Purpose
Expand the flower pool from 4 to 7 types. More options = more interesting stock decisions. The expanded pool should create genuine tradeoffs when choosing 3 from 7.

---

## Current Pool (4 flowers)

| Flower | Keyword | Sunshine | Rain | Notes |
|---|---|---|---|---|
| Sunflower | Warmth | ★★★ | ★ | Joy in sunshine; overwhelming in rain |
| Lavender | Calm | ★ | ★★★ | Comfort in rain; too subdued for sunshine |
| Wildflower Mix | Surprise | ★★★ | ★ | Freedom in sunshine; chaotic in rain |
| White Lily | Renewal | ★ | ★★★ | Grief in rain; too heavy for sunshine |

---

## Expanded Pool (7 flowers)

### New Flowers to Add

**1. Rose** (new)
- **Keyword:** Love
- **Emotional association:** Deep affection, gratitude, apology, romance
- **Sunshine affinity:** ★★ (neutral-good in sunshine)
- **Rain affinity:** ★★ (neutral-good in rain)
- **Notes:** Works in both weathers but not primary in either. The "I care about you deeply" flower. Good for Present customers especially.
- **Right for:** The Present (sister relationship), romantic gestures, saying thank you in a significant way

**2. Chrysanthemum** (new)
- **Keyword:** Longevity
- **Emotional association:** Prosperity, rest, recovery, getting better
- **Sunshine affinity:** ★★ (supportive in sunshine)
- **Rain affinity:** ★★ (supportive in rain)
- **Notes:** The "get well soon" flower that isn't sickly. Works across weathers. Good transitional flower for players who want flexibility.
- **Right for:** Someone recovering (emotionally or physically), the Overstimulated, the Stuck in a transitional moment

**3. Freesia** (new)
- **Keyword:** Innocence
- **Emotional association:** New beginnings, purity, trust, childhood warmth
- **Sunshine affinity:** ★★ (supportive in sunshine)
- **Rain affinity:** ★ (secondary in rain)
- **Notes:** Lighter than Lavender, more hopeful. Good for someone who needs gentleness without grief.
- **Right for:** The Celebrator (childlike joy), the Stuck (new chapter), someone who needs softness without heaviness

---

## Revised Affinity Matrix (7 flowers)

| Flower | Keyword | Sunshine | Rain | Notes |
|---|---|---|---|---|
| Sunflower | Warmth | ★★★ | ★ | Joy in sunshine |
| Lavender | Calm | ★ | ★★★ | Comfort in rain |
| Wildflower Mix | Surprise | ★★★ | ★ | Freedom in sunshine |
| White Lily | Renewal | ★ | ★★★ | Grief in rain |
| Rose | Love | ★★ | ★★ | Both weathers, not primary either |
| Chrysanthemum | Longevity | ★★ | ★★ | Both weathers, recovery |
| Freesia | Innocence | ★★ | ★ | Sunshine preferred, new beginnings |

---

## Strategic Implications for Stock

With 7 flowers and 3 slots, the tradeoffs become more interesting:

**Sunshine run strategy:**
- Sunflower + Wildflower are the clear primaries
- Third slot: Rose (love/Present), Chrysanthemum (recovery), or Freesia (innocence)?
- If you skip Sunflower for a sunshine run, you're betting on Rose + Wildflower as your warmth/surprise combo

**Rain run strategy:**
- Lavender + White Lily are the clear primaries
- Third slot: Rose (love), Chrysanthemum (recovery), or skip one for more flexibility?
- Freesia is weaker in rain — not a great rain-run choice unless targeting specific customers

**Mixed/blended strategy:**
- Rose + Chrysanthemum is a flexible "either weather" pair
- Good for players who want to hedge their weather bet

---

## Customer-Flower Fit (Updated)

| Customer | Sunshine Primary | Sunshine Secondary | Rain Primary | Rain Secondary |
|---|---|---|---|---|
| Hurry | Sunflower | Wildflower | Wildflower | Chrysanthemum |
| Griever | — | Freesia | Lavender | White Lily |
| Stuck | Wildflower | Freesia | White Lily | Chrysanthemum |
| Present | Rose | Sunflower | White Lily | Rose |
| Celebrator | Sunflower | Freesia | — | — |
| Overstimulated | Chrysanthemum | Freesia | Lavender | Chrysanthemum |

---

## Stock Selection UX

With 7 flowers, the Stock Selection screen needs to handle more options without overwhelming the player.

**Recommendation:** Show all 7 flowers with their keyword and a small weather-icon hint (☀️/🌧️) indicating primary affinity. Selected flowers still go to the 3 slots at top.

John handles the UI implementation details — this is a design note for implementation.

---

## Data Changes Needed

In `data.js`:
1. Add 3 new flower entries with `affinities` object
2. Update `weather` and `routes` if needed
3. Update customer `rightFlower` references if new flowers change fit

In `app.js`:
1. Stock Selection UI may need adjustment for 7 flowers (scrollable row vs. wrapping)
2. No change to outcome logic — affinity matrix already supports arbitrary flower IDs

---

## Implementation Order

1. Add flower data (3 new entries)
2. Test stock selection with 7 flowers — does the UI still work?
3. Test outcome logic with new flowers — do affinities apply correctly?
4. Verify with Bin

---

**Canonical file:** `projects/flower-boat/design/flower-pool-expansion.md`
