# Flower Boat — Internal QA Report (Digital Prototype)

**Task:** FB-D001 Internal QA  
**Date:** 2026-03-26  
**Tester:** Sakura (QA)  
**Build:** http://localhost:8766  
**Commit tested:** latest main

---

## Overall: Core Loop Works

The game navigates from start to end without errors. All 4 encounters display with distinct customer dialogue. No crashes, no console errors.

---

## What Works

| Check | Result |
|-------|--------|
| Departure screen (weather + route) | ✅ Clean, selectable |
| Stock selection (3 of 4) | ✅ Functional gating |
| Route map display | ✅ Shows all 4 stops with descriptions |
| Encounter 1 — The Hurry ("I just need something quick") | ✅ Correct dialogue |
| Encounter 2 — The Griever variant ("I don't know what I'm looking for") | ✅ Different customer |
| Encounter 3 — The Stuck ("Is there something for someone who can't decide?") | ✅ Correct pattern |
| Encounter 4 — The Present ("I come here every week. Just to see the river.") | ✅ Fourth archetype present |
| Flower suggestion buttons (Sunflower / Lavender / Wildflower Mix / Let them choose) | ✅ All render and respond |
| End/run summary | ✅ Present after completing route |
| Zero console errors throughout | ✅ Clean |

---

## Weather: Cosmetic Only

**Finding:** Weather selection (Sunshine vs Rain) is tracked in code (30 references) but does not currently affect:
- Customer dialogue
- Flower effectiveness
- Game mechanics
- Any encounter content

Weather is an **atmospheric backdrop** in the current build. It changes the visual tone but not the game state. This is a design decision worth revisiting — if weather is meant to be a meaningful choice (as Bin described: "you pick weather because you thought it would match the mood"), it needs to affect at least one mechanical variable.

**Recommendation:** Flag this for design review. If weather should matter mechanically, it needs a functional hook in the next iteration.

---

## Core Loop Assessment

**Stock constraint** — works as intended. 3 slots forces tradeoffs. The "Let them choose" option exists as a fallback.

**Customer subtext** — present in the UI but only partially readable in automation. A human player reading carefully would catch more cues than a quick scan.

**Suggestion flow** — the four buttons (3 flowers + "Let them choose") are clear and functional. No confusion about what to do.

**Planning step** — not present in the digital prototype UI. The paper prototype has the "write down your expectations" step; the digital build goes straight to selection. Players who played the paper version first might expect the planning step.

---

## Bugs / Issues

1. **Weather has no mechanical function** — cosmetic only (see above)
2. **No planning step in UI** — digital prototype skips the pre-commitment planning step from paper prototype

---

## Bin's Questions

**"Does the core loop work?"**  
Yes. Weather → Stock → Route → Encounters → Summary. All navigable, no errors.

**"Does weather feel meaningful?"**  
Not yet. It's atmospheric but doesn't affect gameplay. Needs a mechanical hook.

**"Any bugs or confusion?"**  
No bugs. One gap: no planning/pre-commitment step in the digital UI (paper has it, digital skips it).

---

## Verdict

**READY for internal review.** The game is playable end-to-end. The main finding is that weather needs a mechanical reason to matter if it's going to be a choice players feel good about making.
