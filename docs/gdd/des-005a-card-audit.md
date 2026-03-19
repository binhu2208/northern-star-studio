# DES-005A Card Content Audit

## Snapshot
Current GDD card coverage is uneven. Four characters have explicit card packages in hand, but the final six-character roster does not yet have six production-ready 25-card sets.

## 1) Explicitly documented card packages / counts

| Character | Current doc(s) | Explicit card count in docs | Notes |
|---|---|---:|---|
| Ember | `des-002-character-expansion.md`, `ember-phase3-4-cards.md`, `ember-phase5-6-cards.md` | 24 | Most complete Fire package; explicit numbered list reaches cards 1-24. Still 1 short of a 25-card final package. |
| Wren | `des-002-character-expansion.md`, `wren-character.md` | 26 | Most complete package. Over target if final package must be exactly 25; likely needs one cut or one card reclassified (card 26 reads like meta-progression). |
| Tide | `des-002-character-expansion.md`, `tide-character.md` | 23 | Strong full-arc coverage, but 2 short of a 25-card final package. |
| Frost | `frost-character.md` | 20 | Full emotional arc exists, but only a light 20-card concept set; less mechanically detailed than Wren/Tide/Ember. |
| Maya | `character-arc.md` | No full package | Story arc is defined, plus starting deck/end rewards and some named unlock cards, but there is no numbered standalone Maya card package. |
| Bloom | `character-06-concept-a.md` | No full package | Final roster pick is concept-only; no explicit card list/package yet. |
| Hearth (alt) | `character-06-concept-b.md` | No full package | Alternate concept only; not release roster. |

## 2) Characters / sets that appear incomplete

### Clearly incomplete for release
- **Bloom** — selected as the 6th roster character, but no actual card package exists yet.
- **Maya** — has narrative/choice structure, but not a proper designed card set comparable to Ember/Wren/Tide.
- **Frost** — only 20 cards and lighter mechanical definition; needs expansion and likely deeper design pass.
- **Tide** — close, but still short of a 25-card final package.
- **Ember** — close, but still short of a 25-card final package.

### Needs normalization / cleanup
- **Wren** — currently documents 26 cards, which likely conflicts with a strict 25-card-per-character target unless one card is moved out of the core package.

### Structural issue across docs
- Card docs are not standardized yet:
  - some sets are full card designs with stats/effects
  - some are only concept/name lists
  - Maya is mostly narrative-driven rather than package-driven
  - Bloom is roster-approved but still pre-package

## 3) What is missing to reach a 150-card final design package

Assuming the target is **6 roster characters x 25 cards = 150 cards**:

### Missing by character
- **Maya:** missing a full 25-card package
- **Bloom:** missing a full 25-card package
- **Frost:** missing ~5 cards to reach 25
- **Tide:** missing ~2 cards to reach 25
- **Ember:** missing ~1 card to reach 25
- **Wren:** functionally at/over target, but needs normalization to exactly 25 if that is the rule

### Practical gap
The main blocker is **not just card count**; it is **package completeness and consistency**.

Even though Ember/Wren/Tide/Frost already document many cards, the roster still lacks:
- a full **Maya** card package
- a full **Bloom** card package
- exact **25-card normalization** for all six release characters
- consistent formatting / package structure across all character docs

## Recommended next steps
1. **Design Bloom first** — biggest roster hole because Bloom is the chosen 6th character.
2. **Convert Maya into a proper 25-card package** — likely highest design debt after Bloom.
3. **Top off Frost, Tide, and Ember** to 25 cards each.
4. **Trim or reclassify Wren card 26** if the final package must be exactly 25 core cards.
5. **Standardize one package template** for all six characters before Phase 5 closes.

## Bottom line
The GDD currently has strong partial coverage, but **the 150-card final package is not yet represented in docs**. The biggest missing pieces are **Bloom + Maya full packages**, with smaller completion passes needed on **Frost, Tide, and Ember**, and a cleanup pass on **Wren**.