# DEV-V1-001 — v1 Architectural Next Items from Prototype Learnings

## Document Overview
- **Task:** DEV-V1-001
- **Owner:** John (Developer)
- **Purpose:** Identify 3-5 concrete architectural changes/additions v1 needs, based on prototype execution learnings
- **Source:** Review of prototype implementation (`app.js`, `data.js`, `index.html`, `styles.css`) and `prototype-architecture-baseline.md`

---

## 1. Breakthrough Unlock Flow is Stubbed

**What the prototype shows:**
`breakthrough` cards are in the normal draw deck and the `BREAKTHROUGH_SURFACES` static map (`data.js`) is a prototype shortcut that bypasses the actual `unlockRules` on those cards. The `unlockRules` field exists on card definitions but is never evaluated.

**What v1 needs:**
- A real `BreakthroughManager` that evaluates unlock conditions against live encounter state
- Breakthrough cards surfaced only when conditions are met, not by static map
- The unlock condition checking must happen during encounter resolution, not at draw time

**Priority:** High — this is a core game loop mechanic that the prototype deliberately stubbed.

---

## 2. No Tag Vocabulary Enforcement

**What the prototype shows:**
Tags and keywords throughout the codebase are freeform strings. The baseline explicitly flagged this as a chaos risk, but no `vocabulary.ts` or centralized constant file was created during prototype development.

**What v1 needs:**
- A `vocabulary.ts` with canonical constants for all tags, intent tags, tone tags, risk tags, response window IDs, encounter keywords, and stat names
- A startup validation pass that checks card definitions and encounter templates against the canonical vocabulary
- All card/encounter data updated to use constants, not raw strings

**Priority:** High — freeform strings will cause scaling and consistency problems as content grows.

---

## 3. Carry-Forward is Too Coarse

**What the prototype shows:**
`applyCarryForward()` is a fixed lookup table mapping result type (`breakthrough`, `partial`, `stalemate`, `collapse`) to modifier deltas. The `carry_forward` effect type in `applyEffects` is a no-op — it literally does nothing.

**What v1 needs:**
- Encounter-specific carry-forward rules, not a single global lookup
- Hooks for narrative flags and content-specific reward/penalty behavior
- The `carry_forward` effect type actually implemented, with access to encounter context
- Support for reward choice UI (card selection between encounters)

**Priority:** Medium-High — the prototype proved the concept works at a coarse level, but v1 needs per-encounter nuance.

---

## 4. Metrics are Logged but Not Aggregated

**What the prototype shows:**
`run.eventLog` and `run.metrics` exist and capture structured events, but there is no `RunSummary` generator, no structured export format for market validation, and no aggregate reporting.

**What v1 needs:**
- A `RunSummaryGenerator` that converts raw event log into a structured report suitable for market/validation teams
- Defined metrics shapes: result distribution, average turns per encounter, collapse frequency, card play frequency, poor-fit play rate
- An export path that doesn't require QA to manually parse debug logs

**Priority:** Medium — the instrumentation is in place, but the prototype leaves it as raw data only.

---

## 5. No Engine/UI Separation

**What the prototype shows:**
All game logic and DOM manipulation are in a single ~450-line `app.js`. The render function directly mutates DOM, game logic calls render() inline, and there is no way to test game logic headlessly or swap the debug UI for a production UI.

**What v1 needs:**
- A `GameEngine` class/module that owns all game state and logic, with no DOM dependencies
- A `UIRenderer` that observes engine state and updates the DOM
- Clean event/method boundaries so engine can be tested in Node and UI can be replaced without touching game logic
- State mutations go through the engine, not direct object manipulation

**Priority:** High — without this separation, QA can't run headless tests and production UI work will require rewriting game logic.

---

## Summary

| # | Item | Priority |
|---|------|----------|
| 1 | Breakthrough unlock flow — real condition evaluation, not static map | High |
| 2 | Canonical tag vocabulary + startup validation | High |
| 3 | Encounter-specific carry-forward with actual effect implementation | Medium-High |
| 4 | Run summary / aggregate metrics export | Medium |
| 5 | Engine/UI separation — testable headless, swappable UI | High |

**Top 3 for earliest v1 scoping:**
1. Engine/UI separation (enables everything else)
2. Breakthrough unlock flow (core mechanic)
3. Canonical vocabulary + validation (content scaling foundation)

---

*Drafted by John based on prototype execution learnings.*
