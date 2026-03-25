# Emotion Cards Four — Prototype Slice

## What this is
A self-contained browser prototype for the DEV-002 minimum playable slice.

## Files
- `index.html` — entry page
- `styles.css` — lightweight prototype UI styling
- `data.js` — card/encounter content records and vocab-backed content
- `app.js` — deterministic run/encounter/turn flow, resolution, opposition, save/load, instrumentation

## How to open
Open `projects/emotion-cards-four/src/index.html` in a browser.

If the browser blocks ES module loading from `file://`, serve the repo with a basic local static server and open the file through `http://`.

## Current implemented scope
- 3-encounter run
- draw / play / discard loop
- explicit encounter phase flow
- primary + optional support package validation
- deterministic player effect resolution
- deterministic opposition reaction rules with priority order
- outcome classification: breakthrough / partial / stalemate / collapse
- carry-forward modifiers between encounters
- localStorage autosave/resume
- structured event log + raw state dump

## Intentional prototype limits
- no production build tooling
- no art pipeline integration
- no narrative shell between encounters
- no generalized scripting language
- no browser automation / test harness yet
