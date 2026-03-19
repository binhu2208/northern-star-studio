# DES-005A — Roster Audit

## Snapshot
Current intended release roster appears to be:
- Maya
- Ember
- Wren
- Tide
- Frost
- Bloom

This is supported most clearly by `docs/gdd/des-003-wrapup.md`, which selects **Bloom** as the sixth slot.

## 1) Characters with dedicated design docs

### Strong dedicated docs
These each have their own character-focused doc with clear arc/mechanics coverage:
- **Maya** — `docs/gdd/character-arc.md`
- **Wren** — `docs/gdd/wren-character.md`
- **Tide** — `docs/gdd/tide-character.md`
- **Frost** — `docs/gdd/frost-character.md`

### Dedicated but not final-package level
These have character-specific docs, but not yet at the same completeness/packaging level as the strongest roster docs:
- **Bloom** — `docs/gdd/character-06-concept-a.md` (selected concept, not full card package)
- **Hearth** — `docs/gdd/character-06-concept-b.md` (alternate/reference concept only; not roster-final)

## 2) Characters only partially defined or referenced indirectly

### Ember
**Status:** partially defined across multiple docs, but missing a single canonical character doc.

Sources:
- `docs/gdd/des-002-character-expansion.md` — high-level arc + rough card list
- `docs/gdd/ember-phase3-4-cards.md` — mid-game details
- `docs/gdd/ember-phase5-6-cards.md` — late-game details
- indirect references in Frost / Tide / Wren docs

Gap summary:
- No standalone `ember-character.md`
- Early phases 1-2 are still outline-level, not fully documented like later phases
- Character background / progression / mechanics are split across files instead of packaged cleanly

### Bloom
**Status:** roster-selected, but still concept-level.

Sources:
- `docs/gdd/character-06-concept-a.md`
- `docs/gdd/des-003-wrapup.md`

Gap summary:
- No full standalone Bloom design doc
- No full card list/card specs
- No phase-by-phase finalized implementation package

### Maya
**Status:** well-defined narratively, but lighter on finalized card-package detail than Wren/Tide/Frost.

Sources:
- `docs/gdd/character-arc.md`
- indirect support from `docs/gdd/des-001c-enemy-types.md`

Gap summary:
- Strong story/choice arc
- Does not yet read like a full packaged character design doc with finalized card set/mechanical summary in one place

### Hearth
**Status:** indirect roster support only; not part of final selected roster.
- Useful as backup/future expansion reference, not a release-roster deliverable

## 3) What is missing for a truly final roster package

### Highest-priority missing pieces
1. **Create a canonical doc for Ember**
   - Merge expansion + phase docs into one `ember-character.md`
   - Fill in phases 1-2 at the same fidelity as phases 3-6

2. **Expand Bloom from selected concept into full character design**
   - Full background
   - 6-phase progression
   - complete card package
   - mechanics, synergy, balancing, and next-step notes

3. **Normalize roster doc format across all six final characters**
   Each final roster member should have one clear standalone file with:
   - premise/background
   - 6-phase emotional arc
   - full card list
   - signature mechanics/resources
   - synergy notes
   - balance/open questions
   - version/status

### Secondary cleanup
4. **Decide whether Maya needs a full card-package companion doc**
   - Current doc is strong on narrative arc
   - May need a more systems-facing character package to match Wren/Tide/Frost

5. **Publish a single roster source-of-truth doc**
   - final six names
   - emotion family for each
   - one-line fantasy / role / design niche
   - links to each canonical character file

## Bottom line
- **Most complete:** Wren, Tide, Frost
- **Narratively strong but package-incomplete:** Maya
- **Split/partial:** Ember
- **Chosen but still concept-only:** Bloom
- **Not final roster, reference only:** Hearth

The roster direction is clear, but the release package is not truly final until **Ember is consolidated** and **Bloom is expanded into a full standalone character design**.