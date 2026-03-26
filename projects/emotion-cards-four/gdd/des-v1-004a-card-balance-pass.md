# DES-V1-004a — v1 Card Balance Pass (Design Doc)

## Task ID
DES-V1-004a

## Purpose
Review the current v1 card pool (15 cards in data.js) against the 3 implemented encounters for balance, coverage gaps, synergy viability, and breakthrough distribution. Runs against the design doc, not implementation — no dependency on DEV-V1-005.

## Scope
- CARD_DEFINITIONS in `src/data.js` — 15 cards (3 Emotion, 3 Memory, 4 Reaction, 2 Shift, 3 Breakthrough)
- 3 implemented encounters: Missed Signal, Public Embarrassment, Quiet Repair

---

## Part 1 — Current Card Pool by Intent

| Intent | Cards | Notes |
|---|---|---|
| connect (emotion) | E-001 Concern | Primary |
| recover (emotion) | E-005 Hope | Primary |
| reveal (emotion) | E-003 Shame | Primary |
| protect (reaction) | R-002 Deflect | Primary |
| stabilize (reaction) | R-003 De-escalate | Primary |
| reframe (reaction) | R-007 Reframe Gently | Primary |
| reveal (reaction) | R-001 Guarded Honesty | Primary |
| shift/reframe | S-001 Change of Lens | Support |
| shift/stabilize | S-002 Slow the Room | Support |
| connect (memory) | M-001 Old Promise | Support |
| protect (memory) | M-004 Quiet Support | Support |
| reveal (memory) | M-006 Missed Signal | Support |
| breakthrough | B-001 Mutual Recognition | Breakthrough |
| breakthrough | B-002 Stable Repair | Breakthrough |
| breakthrough | B-003 Hard Truth, Open Door | Breakthrough |

---

## Part 2 — Encounter Coverage Analysis

### Missed Signal — Coverage: ✅ Good

**Starting windows:** connect, reveal

**Strong lines:**
- E-001 Concern → connect opens repair, synergy with memory gives clarity
- R-001 Guarded Honesty → reveal gives clarity + tension drop
- M-001 Old Promise + E-001 → synergy for clarity
- M-006 Missed Signal → clears misread, synergy with E-001 opens repair

**Assessment:** The connect and reveal windows are well-covered. Concern and Guarded Honesty are both strong primary options with memory synergy. No issues at the encounter level.

---

### Public Embarrassment — Coverage: ⚠️ Adequate but Uncomfortable

**Starting windows:** stabilize, protect

**Available:**
- R-003 De-escalate → stabilize + tension drop (strong in heated/fragile)
- R-002 Deflect → protect (but punished if repeated)
- M-004 Quiet Support → protect (collapse guard)
- M-001 Old Promise → warm memory (fails in high tension — correct penalty)

**Assessment:** Stabilize is covered by De-escalate. Protect is covered by Deflect and Quiet Support. However:
- Deflect is the only `protect` reaction card, and it's risky (repeated use = clarity penalty)
- Quiet Support is the only warm-protect memory, and it has `WEAK_IF_TENSION_HIGH` risk
- There is no dedicated high-tension protect card that performs reliably in `public` + `heated` + `fragile` simultaneously

**Design concern:** In Public Embarrassment, the player needs both stabilize and protect, but the available protect options are fragile under repeated use or high tension. This is correct design tension, but it means the encounter can feel luck-dependent if the player draws only Deflect repeatedly.

**No blocking issue** — the encounter is playable and winnable. The tension is intentional.

---

### Quiet Repair — Coverage: ✅ Good

**Starting windows:** connect, recover, reframe

**Available:**
- E-001 Concern → connect
- E-005 Hope → recover (intent: recover)
- R-007 Reframe Gently → reframe + clarity + momentum
- S-001 Change of Lens → reframe + keyword removal
- M-001 Old Promise → warm connect memory

**Assessment:** All three windows are covered. Hope is the dedicated recover card. Reframe Gently and Change of Lens both handle reframe. Concern handles connect. Strong coverage.

---

## Part 3 — Balance Findings

### Finding 1 (Low) — No Primary Recover Emotion Card

E-005 Hope has `intentTag: recover` and is the only card with recover as its primary intent. This is correct — Hope is the recover anchor. No issue.

**However:** There is no second recover option. If the player doesn't draw Hope in Quiet Repair, they rely on Reframe Gently (reframe, not recover) or Change of Lens (reframe). This is acceptable for v1 but worth noting for expansion.

### Finding 2 (Low) — Stand Ground (R-005) Not in data.js

DES-V1-002 defines Stand Ground as a protect/stabilize reaction card with the following design:
- Intent: protect, Tone: assertive
- Effect: Prevent collapse this turn regardless of tension or failed play count. If trust ≥ 5, gain 1 momentum.

Stand Ground does not exist in data.js. This is a card that should exist for Public Embarrassment specifically — it's the "hold the line without collapsing" card that doesn't punish repeated use like Deflect does.

**Recommendation:** Add Stand Ground (R-005) to CARD_DEFINITIONS. It fills the gap in Public Embarrassment and provides a meaningful protect option that doesn't rely on repeated Deflect.

### Finding 3 (Low) — Deflect Is the Only Protect Reaction

R-002 Deflect is the only reaction card with `intentTag: protect`. It has `PUNISHED_IF_REPEATED` risk. Combined with the lack of Stand Ground, protect coverage is thin.

**This is a deliberate design constraint**, not a bug. The game should push players toward choosing between Deflect (short-term protection, long-term cost) and other approaches. However, without Stand Ground, the protect option set is very small.

**Recommendation:** Add Stand Ground to expand the protect option set.

### Finding 4 (Low) — Breakthrough Distribution Is Uneven for Future Encounters

Current breakthrough assignments:
- B-001 Mutual Recognition → Missed Signal (default)
- B-002 Stable Repair → Quiet Repair (default)
- B-003 Hard Truth, Open Door → Public Embarrassment (default)

The 3 breakthroughs map to the 3 encounters. Old Grudge and Breakthrough Moment (not yet implemented) would need breakthrough coverage — B-001, B-002, B-003 can serve as defaults via `_breakthroughDefaults`, but ideally each encounter has specific unlock rules.

**This is not a blocking issue for current 3-encounter v1.** It's a note for when Old Grudge and Breakthrough Moment are added.

### Finding 5 (Info) — `stalled` Keyword Exists in Vocabulary but No Cards Reference It

`ENCOUNTER_KEYWORDS.STALLED` is defined in vocabulary.js but no cards in data.js have conditions that check for `stalled`. This is not a bug — it's a vocabulary entry waiting for content. No action required for v1.

### Finding 6 (Medium) — CONDITION_KEYS Validator Gap (from DES-V1-003)

The `validateVocabulary` function does not recognize `statGte`, `statLte`, `statEq`, `encounterId`, or `result` inside unlock rule condition blocks. These are used in `BreakthroughManager._evaluateUnlockRules` / `matchesUnlockCondition` but the validator throws false-positive warnings for them.

**Fix:** Add these keys to the `CONDITION_KEYS` Set in engine.js. One-line fix, should be done before any future breakthrough card with stat-based unlock conditions is added.

### Finding 7 (Medium) — Fresh Start "player_choice" Window Still Unresolved

Fresh Start (S-005 in DES-V1-002, not yet in data.js) opens a `player_choice` response window. This window type does not exist in `RESPONSE_WINDOWS` in vocabulary.js. The engine would not recognize it.

**Options:**
- A: Add `PLAYER_CHOICE: 'player_choice'` to `RESPONSE_WINDOWS` and `RESPONSE_WINDOW_LIST`
- B: Replace "player_choice" with a defined window type (e.g., `stabilize` or `recover`) in Fresh Start's design

**Recommendation:** Option B is cleaner for v1 — `player_choice` as a window type is ambiguous and adds engine complexity. Replace with `stabilize` or `reframe` depending on the card's actual intent.

---

## Part 4 — Synergy Analysis

### Strong Synergies Verified
- E-001 Concern + any Memory → +1 clarity (concern_memory)
- E-003 Shame + M-004 Quiet Support → +1 trust (shame_support)
- M-006 Missed Signal + E-001 Concern → open repair + clarity (missed_signal_concern)
- R-001 Guarded Honesty + any Memory → open repair (guarded_honesty_memory)
- R-007 Reframe Gently in misread → open connect (conditional)
- S-001 Change of Lens + any Memory → clarity +1 (change_of_lens_memory)

### Risk Patterns Verified
- E-001 Concern → -1 momentum if tension ≥ 8 (concern_high_tension)
- E-003 Shame → +1 tension if trust ≤ 3 (shame_low_trust)
- E-005 Hope → -1 trust if clarity ≤ 2 (hope_low_clarity)
- R-002 Deflect → clarity penalty on repeated use (deflected_last_turn)
- R-003 De-escalate → -2 tension in heated/fragile (conditional)

### Missing Synergies
- No card currently has a synergy rule that fires on `primaryToneTagIn: ['playful']` — Shared Joke (if added) would use this
- No card has a synergy rule for `INTENT_TAGS.PRESSURE` combining with `CATEGORIES.MEMORY` to reward careful pressure — relevant for Old Grudge when implemented

---

## Part 5 — Starter Deck Balance (12 Cards)

Current starter: E-001, E-003, E-005, M-001, M-004, M-006, R-001, R-002, R-003, R-007, S-001, S-002

**Assessments by encounter:**

| Encounter | Strong cards | Risky cards | Verdict |
|---|---|---|---|
| Missed Signal | Concern, Old Promise, Guarded Honesty, Missed Signal | Shame (misread vulnerable) | ✅ Strong |
| Public Embarrassment | De-escalate, Quiet Support | Deflect (repeated), Shame (low trust) | ⚠️ Thin protect, acceptable |
| Quiet Repair | Hope, Reframe Gently, Concern | — | ✅ Strong |

**No changes recommended to the 12-card starter for current 3-encounter v1.** The deck is lean and purposeful.

---

## Part 6 — Vocabulary Fixes Needed

### Fix 1: Add missing condition keys to engine.js
```javascript
// In CONDITION_KEYS Set, add:
'statGte'
'statLte'
'statEq'
'encounterId'
'result'
```

### Fix 2: Resolve Fresh Start "player_choice" window
Replace with a defined `RESPONSE_WINDOWS` value, or add `PLAYER_CHOICE` as a valid window type if the open design intent is preserved.

---

## Part 7 — Summary of Recommendations

| # | Finding | Severity | Action |
|---|---|---|---|
| 1 | No primary Recover card issue | Low | Accept — Hope is sufficient for v1 |
| 2 | Stand Ground not in data.js | Low | Add R-005 Stand Ground before v1 QA |
| 3 | Protect coverage thin (Deflect only reaction) | Low | Acceptable — add Stand Ground for relief |
| 4 | Breakthrough uneven for future 5-encounter v1 | Info | Address when Old Grudge / BM are built |
| 5 | `stalled` keyword unused | Info | No action needed |
| 6 | CONDITION_KEYS validator gap | Medium | Fix before v1 QA |
| 7 | Fresh Start "player_choice" unresolved | Medium | Resolve before S-005 is added |

---

## Action Items for DES-V1-004b

DES-V1-004b (post-implementation confirmation) should verify:
1. Stand Ground (R-005) has been added to data.js
2. CONDITION_KEYS gap has been fixed in engine.js
3. Fresh Start window decision is resolved
4. Old Grudge and Breakthrough Moment, if implemented, have breakthrough coverage
5. The 35-card pool from DES-V1-002 has been fully added to data.js

---

**Canonical file:** `projects/emotion-cards-four/gdd/des-v1-004a-card-balance-pass.md`
