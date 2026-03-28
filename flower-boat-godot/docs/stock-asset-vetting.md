# Stock Asset Vetting Report
# John — Godot technical compatibility check

## Top Candidates Reviewed

### 1. Kenney Garden Assets (kenney.nl) — RECOMMENDED ✅
**URL:** https://kenney.nl/assets/series/Garden
**License:** CC0 (public domain) — no restrictions
**Format:** PNG, RGBA, clean pixel art
**Godot:** 100% compatible — just drop into `res://sprites/`
**Status:** Best option. Quality, licensing, and format all clean.
**Action:** Can download immediately.

### 2. OpenGameArt — Garden Assets (mixed quality)
**URL:** https://opengameart.org/content/garden-assets
**License:** Unknown — need to verify per-author
**Format:** Mixed — some RGBA, some indexed PNG
**Godot:** Partial compatibility — indexed PNG won't import correctly
**Status:** Usable with conversion. Licensing needs verification.
**Action:** Vet licensing before use.

### 3. Pixel Farm (OpenGameArt)
**URL:** https://opengameart.org/content/pixel-farm
**License:** CC-BY 3.0 — requires attribution
**Format:** PNG, check per-file
**Godot:** Probably compatible, need to download to verify
**Status:** Worth checking if Kenney doesn't cover enough.

## Recommendation
Use **Kenney Garden Assets** — they're:
- Public domain (no licensing concerns)
- PNG/RGBA format (Godot native)
- Consistent style
- Already organized by category

## Missing from Kenney
- Customer/character silhouettes (none in the packs found)
- Weather-specific sky panels

For characters: would need to find silhouette-style packs or commission.

## What Kenney Garden covers
- Flowers ✅ (several packs)
- Plants ✅
- Trees ✅
- Water/pond ✅
- Fences, paths ✅

## What still needs custom art
- 8 customer silhouettes (per art-pipeline.md)
- Boat sprite
- Weather sky backgrounds
