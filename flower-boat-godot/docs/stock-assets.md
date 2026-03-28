# Flower Boat — Stock Asset Candidates

## Overview
Curated stock asset sources for Flower Boat. Based on the art pipeline spec — warm cozy aesthetic, flat illustration style, specific color palette.

**Reality check:** Finding stock assets that precisely match Flower Boat's warm, hand-crafted aesthetic will be difficult. Most stock assets are either too generic, too pixel-art, or too high-contrast. These candidates are the best matches found — Bin should evaluate each against the quality bar.

---

## Flower Assets

### 1. Pale Tale — Flower Assets Pack
- **URL:** https://pale-tale.itch.io/flower-assets-pack
- **Style:** Pixel art, small but vibrant collection
- **Fit:** Flowers specifically — could work for some varieties
- **License:** Check itch.io page
- **Evaluation needed:** Do the styles match our warm palette? Are sizes compatible with 64×64 requirement?

### 2. Pixel Plants & Crops – 2D Asset Pack
- **URL:** https://forums.unrealengine.com/t/psycho-bundle-plants-flowers-top-down-pixel-art-sprites/2451772
- **Style:** Pixel art, top-down
- **Fit:** Has flowers and plants, but top-down orientation may not suit side-view
- **Evaluation needed:** Would need to see if side-view frames can be extracted

---

## Character / People Assets

### 3. LimeZu Asset Packs (itch.io)
- **URL:** https://limezu.itch.io/
- **Style:** Warm pixel art, characters with personality
- **Fit:** Known for cozy game aesthetics — could work for customer silhouettes
- **Evaluation needed:** Check if silhouette-style characters available, warm color tones

### 4. Top Down Sprite Maker
- **URL:** https://jord点.itch.io/top-down-sprite-maker (search "Top Down Sprite Maker" on itch.io)
- **Style:** Customizable pixel characters, multiple styles
- **Fit:** Could generate character silhouettes with warm colors
- **Note:** This is a tool, not ready-made sprites — requires setup

---

## Environment / Tiles

### 5. Cozy Pixel Bathroom Pack
- **URL:** https://itch.io/t/4767026/-cozy-pixel-bathroom-pack-new-asset-pack-for-top-down-2d-games
- **Style:** Warm, hand-crafted pixel art, cozy aesthetic
- **Fit:** Demonstrates warm cozy style — might have compatible tiles
- **Evaluation needed:** Check if water/canal elements available

### 6. Pixel Bedroom Pack
- **URL:** https://itch.io/t/4776240/-pixel-bedroom-pack-handcrafted-cozy-furniture-decor-set-for-2d-games
- **Style:** Hand-crafted cozy pixel art
- **Fit:** Warm aesthetic matches, but bedroom-focused — limited direct use
- **Evaluation needed:** Style reference only

---

## Specific Asset Sources (from John)

### itch.io
- `https://itch.io/game-assets/tag-gardening` — "FREE Pixel Art Flower Pack" + garden packs
- `https://itch.io/game-assets/tag-flower` — "Garden & Flower Icons" (290+ sprites)
- `https://itch.io/game-assets/free/tag-plants` — Tiny Ranch Asset Pack, flower sprites

### OpenGameArt
- `https://opengameart.org/content/cozy-asset-pack-10` — **COZY ASSET PACK 1.0** — 16×16 top-down tiles, 130+ tiles, cozy warm colors, cute characters. **Free for personal/commercial, credit appreciated.** By IshtarPixels.
- `https://opengameart.org/content/flowers` — 78 pixel art plants, modular, db32 palette

**Evaluation checklist for all candidates:**
- [ ] Flower sprites identifiable at 64×64?
- [ ] Warm, natural colors matching palette (canal blues, honey wood, sage greens)?
- [ ] Customer/character sprites silhouette-friendly (no facial detail)?

---

## Asset Store Giants (broader search)

### 7. itch.io — Free 2D Game Assets Thread
- **URL:** https://forum.godotengine.org/t/free-2d-and-3d-game-assets/110123
- **Style:** Mixed — kits, GUI, backgrounds, tilesets, character sprites
- **Fit:** Aggregated list, requires digging
- **Evaluation needed:** Active Godot forum thread with ongoing asset sharing

### 8. OpenGameArt
- **URL:** https://opengameart.org
- **Style:** Mixed — wide variety of 2D assets
- **Fit:** Large database, search "flower", "boat", "cozy"
- **Evaluation needed:** Quality varies significantly

---

## Commission Option

If stock assets don't meet the quality bar, commissioning an illustrator is the most reliable path:

**Options:**
- **Fiverr** — search "2D illustrator cozy game flowers" — varied quality and price
- **DeviantArt** — find artists matching the warm aesthetic
- **Twitter/X** — reach out to indie game illustrators directly
- **r/INAT (I Need A Artist)** — Reddit thread for game collaboration

**Estimated cost for full asset set:**
- 7 flowers + 8 customer silhouettes + boat + environment: $500-$2000+ depending on artist
- Per-item: $20-$100 per sprite sheet

---

## Updated Assessment (2026-03-28)

**Confirmed ready to download:**
- **Kenney Garden Assets** — CC0, Godot-compatible, covers flowers/plants/environment. John recommends, Bin approved. Download immediately.

**Still needs sourcing:**

### Customer Silhouettes
- LPC (Liberated Pixel Cup) character sprites on OpenGameArt — CC-BY-SA — could be recolored/reworked into silhouettes
- Alternatively: commission a single sprite sheet (8 silhouettes, 4 frames each = relatively small job)
- **Recommended:** Try LPC base sprites first, if quality doesn't match bar, commission

### Boat Sprite
- Harder to find as stock — boat designs are specific
- **Recommended:** Commission single illustration — boat_body.png is one sprite

### Weather Sky Panels
- Just gradient backgrounds — could be made from hex values or found in any sky/background pack
- **Recommended:** Produce in-house using gradient tools — no illustration needed

---

## Recommendation

**Priority order:**
1. Download Kenney Garden Assets NOW — covers flowers and environment
2. Search LPC sprites for customer base — evaluate against silhouette spec
3. Commission boat sprite and remaining customer silhouettes if LPC doesn't fit

**Quality bar reminder:** Flowers must look genuinely good (not generic), boat must have character. Most stock assets will fail this bar — don't force a fit just to have something.

---

**Canonical file:** `flower-boat-godot/docs/stock-assets.md`
