# DES-V1-003a — v1 Card Pool Review

## Task ID
DES-V1-003a

## Purpose
Verify that the 16-card v1 starter deck provides adequate coverage across all 5 encounter templates. Flag gaps or imbalances before the full balance pass.

## Starter Deck (16 cards)
**Emotions (5):** Concern, Hope, Shame, Determination, Relief
**Memories (4):** Old Promise, Quiet Support, Missed Signal, Shared Victory
**Reactions (4):** Guarded Honesty, De-escalate, Stand Ground, Reframe Gently
**Shifts (3):** Change of Lens, Slow the Room, Fresh Start

---

## Encounter Coverage Analysis

### Encounter 1 — Missed Signal
**Keywords:** misread, repairable | **Windows:** connect, reveal

| Window / Need | Cards in Deck | Coverage |
|---|---|---|
| connect | Concern, Old Promise, Shared Victory | ✅ Strong (3 cards) |
| reveal | Guarded Honesty, Shame, Doubt | ✅ Solid (3 cards) |
| recover | Hope, Determination, Relief | ✅ Good (3 cards) |
| reframe | Reframe Gently, Change of Lens | ✅ Good (2 cards) |
| misread clear | Missed Signal, Change of Lens | ✅ Both available |

**Assessment:** Fully covered. Multiple viable lines from turn 1.

---

### Encounter 2 — Public Embarrassment
**Keywords:** public, heated, fragile | **Windows:** stabilize, protect

| Window / Need | Cards in Deck | Coverage |
|---|---|---|
| stabilize | De-escalate, Shared Joke, Slow the Room, Yield Ground | ✅ Very strong (4 cards) |
| protect | Stand Ground, Quiet Support | ✅ Solid (2 cards) |
| shame (public volatile) | Shame | ⚠️ Usable but risky — right call, high risk |
| deflection penalty | R-002 Deflect (in prototype) not in starter | ✅ Starter avoids Deflect trap |
| recover | Hope, Determination, Relief | ✅ Good recovery after stabilize |

**Assessment:** Well-covered. The starter deck notably excludes Deflect (which is a trap card in this encounter) and includes Stand Ground as the safer protect option. Minor concern: Shared Joke is in the expanded memory set (M-002) — if it's not in the 16-card starter, the stabilize count drops to 3. Verified: M-002 is NOT in the 16-card starter, but De-escalate + Slow the Room + Yield Ground cover stabilize adequately.

---

### Encounter 3 — Quiet Repair
**Keywords:** private, repairable, guarded | **Windows:** connect, recover, reframe

| Window / Need | Cards in Deck | Coverage |
|---|---|---|
| connect | Concern, Old Promise, Shared Victory | ✅ Strong |
| recover | Hope, Determination, Relief | ✅ Good |
| reframe | Reframe Gently, Fresh Start, Change of Lens | ✅ Strong (3 cards) |
| protect (boundary) | Stand Ground | ✅ Available |
| guarded penalty | Stand Ground (assertive) may trigger guarded penalty | ⚠️ Risk — Stand Ground is assertive, not warm |
| clarity | Shame, Guarded Honesty | ✅ Available via reveal line |

**Assessment:** Covered. Recovery and reframe are strong. One flag: Stand Ground is the only protect card in the starter and it's assertive — in a guarded encounter it may trigger a penalty. This is correct design (not every card fits every encounter), but it means the player has no warm/protect option in this encounter.

---

### Encounter 4 — Old Grudge
**Keywords:** misread, guarded, defensive | **Windows:** reveal, protect

| Window / Need | Cards in Deck | Coverage |
|---|---|---|
| reveal | Guarded Honesty, Shame, Hidden Cost (not in starter), Doubt | ✅ Guarded Honesty + Shame |
| memory + reveal synergy | Old Promise, Quiet Support, Missed Signal, Shared Victory | ✅ Good memory options |
| protect | Stand Ground | ✅ Available |
| misread clear | Missed Signal, Change of Lens | ✅ Both available |
| reframe (recovery) | Fresh Start (clears defensive/guarded), Reframe Gently | ✅ Fresh Start is strong here |
| pressure risk | Anger not in starter | ✅ Correct — pressure is punished here |

**Assessment:** Covered. Hidden Cost (M-007) is the ideal card for this encounter but isn't in the starter — the existing memories still work. Fresh Start is particularly valuable here (clears guarded/defensive keywords). Good encounter-specific challenge without feeling under-resourced.

---

### Encounter 5 — Breakthrough Moment
**Keywords:** repairable, open_window | **Windows:** connect, recover, reframe

| Window / Need | Cards in Deck | Coverage |
|---|---|---|
| connect | Concern, Old Promise, Shared Victory | ✅ Strong |
| recover | Hope, Determination, Relief | ✅ Good |
| reframe | Reframe Gently, Fresh Start, Change of Lens | ✅ Strong |
| carry-forward reward | Shared Victory (M-008) — net positive runs get +1 clarity | ✅ Unique and well-placed |
| breakthrough ready | All three breakthroughs (B-001/002/003) | ✅ Available as earned unlocks |

**Assessment:** Strongly covered. The deck is well-positioned for a climactic encounter. Shared Victory (M-008) is the standout card here — it rewards positive run history, which is exactly the kind of meaningful carry-forward the run structure should create.

---

## Flags

### Flag 1 (Low) — Stand Ground tone mismatch in Quiet Repair
Stand Ground is the only protect card in the starter deck. In Encounter 3 (guarded keyword), assertive-tone protect cards may be penalized. The player has no warm-protect option in that specific encounter. This is intentional design (not every card fits every encounter) but worth noting. No action needed before DES-V1-004a.

### Flag 2 (Info) — Shared Joke not in 16-card starter
Shared Joke (M-002) is excellent in Public Embarrassment (stabilize + trust in fragile/public encounters) but isn't in the 16-card starter. De-escalate and Slow the Room cover stabilize adequately. Low severity — the encounter still works without M-002.

### Flag 3 (Info) — Hidden Cost not in starter
Hidden Cost (M-007) is ideal for Old Grudge (reveal + tension) but isn't in the 16-card starter. Guarded Honesty + Shame cover the reveal line. Low severity — intentional to keep starter bounded.

### Flag 4 (Design) — Fresh Start "player_choice" window not in vocabulary spec
Fresh Start (S-005) opens a "player_choice" response window — the player picks which window to open. This is not in the canonical vocabulary list (connect, stabilize, reveal, protect, pressure, reframe, recover, repair, boundary, breakthrough). Should be either:
- **A:** Replace "player_choice" with one explicit window from the vocabulary, or
- **B:** Add "player_choice" as a valid window type in the vocabulary spec

This is a vocabulary gap, not a pool gap. Needs designer decision before DES-V1-004b.

---

## Summary

| Encounter | Coverage Grade | Notes |
|---|---|---|
| Missed Signal | ✅ Strong | All windows covered, multiple lines |
| Public Embarrassment | ✅ Good | Well-balanced, avoids prototype trap cards |
| Quiet Repair | ✅ Good | One flag on protect tone, acceptable |
| Old Grudge | ✅ Good | Hidden Cost would be ideal, existing cards still work |
| Breakthrough Moment | ✅ Strong | Shared Victory is well-placed for run climax |

**Overall: No blocking gaps found.** The 16-card starter deck provides meaningful coverage across all 5 encounters without any encounter being unresolvable or severely under-resourced. Some encounters would benefit from specific cards (Hidden Cost, Shared Joke) that aren't in the starter, but none are critical failures.

The deck is ready for v1 as-is. Full balance pass in DES-V1-004a can deepen the analysis.

---

## Action Items

1. **DES-V1-004a:** Confirm whether Fresh Start's "player_choice" window needs to be added to vocabulary or replaced with a defined window
2. **DES-V1-004a:** Evaluate whether Quiet Repair needs a warm-protect option added to the starter, or if Stand Ground's assertiveness is intentional trade-off design
3. **No changes to DES-V1-002 card pool required** based on this review

---

**Canonical file:** `projects/emotion-cards-four/gdd/des-v1-003a-card-pool-review.md`
