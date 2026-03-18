# Launch-Day Smoke Checklist — Emotion Cards

Run this once on the release candidate build for `release/v0.5.0` before launch goes live.

---

## Scope

Focus on a fast confidence pass for:
- startup / boot
- character selection
- core combat flow
- save / load
- basic UI readability and hookup

Target time: 10-15 minutes.

---

## 1. Startup / Boot
- [ ] Launch from a clean start without crash, hang, or obvious error popup
- [ ] Main menu / first reachable screen loads correctly
- [ ] Menu inputs respond normally (mouse / keyboard / controller if supported)
- [ ] No missing art, placeholder text, or broken layout is visible on first screen

## 2. Character Selection
- [ ] Character select opens successfully from the main flow
- [ ] At least 3 playable characters are visible and selectable
- [ ] Character portrait/name/summary updates correctly when changing selection
- [ ] Selected character starts the run without wrong data carrying over from a previous choice

## 3. Fresh Run / Encounter Start
- [ ] Fresh run starts successfully with the selected character
- [ ] Initial encounter or combat scene loads without softlock
- [ ] Opening hand appears correctly
- [ ] Starting HP / energy / plays / core HUD values look valid

## 4. Core Combat Flow
- [ ] Play at least 2-3 cards without errors
- [ ] Card cost is applied correctly
- [ ] Damage / shield / healing results appear and update correctly
- [ ] End turn works on demand
- [ ] Enemy turn resolves fully and returns control to the player
- [ ] Next player turn starts with refreshed turn resources as expected
- [ ] Win or defeat state resolves cleanly without stuck combat state

## 5. Save / Load
- [ ] Create a valid in-run state worth saving
- [ ] Save completes without visible error
- [ ] Return to menu or relaunch if needed
- [ ] Load resumes the same run / progression state successfully
- [ ] Active character, encounter progress, and deck/hand state look sane after load

## 6. Basic UI Check
- [ ] HP / energy / turn indicators update after gameplay actions
- [ ] Card text, costs, and values are readable in normal play view
- [ ] Character portraits / enemy visuals / card art references are present or fail gracefully
- [ ] No overlapping UI, clipped text, or obviously stale values appear during the smoke pass
- [ ] Buttons for main flow actions (start, confirm, end turn, back/load if present) remain responsive

## 7. Release Blockers to Call Immediately
Mark launch as **hold** if any of the following happens:
- crash on boot or run start
- cannot enter combat from normal flow
- cannot select or start with intended character
- combat turn flow breaks or softlocks
- save/load loses run state or fails consistently
- UI hides critical information needed to play

## 8. Sign-Off
- **Build / Branch:** `release/v0.5.0`
- **Tester:**
- **Date:**
- **Result:** pass / fail / hold
- **Notes / blockers:**
