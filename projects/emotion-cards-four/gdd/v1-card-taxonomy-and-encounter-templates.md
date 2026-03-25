# Emotion Cards Four — v1 Card Taxonomy and Encounter Templates

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** DES-V1-002
- **Purpose:** Update the card taxonomy and produce the canonical v1 5-encounter template set, informed by v1 flagship mode rules lock
- **Status:** v1 Design Baseline — Supersedes DES-002 for active v1 work
- **Supersedes:** `projects/emotion-cards-four/gdd/prototype-card-taxonomy.md`
- **v1 rules reference:** `projects/emotion-cards-four/gdd/v1-flagship-mode-rules.md`
- **v1 design constants locked:** 5-encounter minimum, hand size 4, uniform difficulty, breakthrough timing next turn after surfacing, configurable encounter count per run

---

## Part 1 — v1 Card Taxonomy

### 1.1 What Changed from DES-002

The prototype validated the core card model. For v1, the taxonomy is expanded to support 5 meaningfully distinct encounter templates instead of 3.

Changes:
- **Emotion cards:** expanded from 7 to 9 — added `Anger` (already in DES-002 but not in prototype's data.js), added `Fear` and `Determination`
- **Memory cards:** expanded from 6 to 8 — added `Hidden Cost` and `Shared Victory`
- **Reaction cards:** expanded from 7 to 9 — added `Stand Ground` and `Yield Ground`
- **Shift cards:** expanded from 4 to 6 — added `Fresh Start` and `Deep Breath`
- **Breakthrough cards:** retained at 3 — confirmed correct for v1
- **Starter deck:** expanded from 12 to 16 cards to give more meaningful opening choices

The expanded set is still bounded enough for v1 art and engineering scoping while giving enough variety for 5 encounters to feel distinct.

---

### 1.2 Shared Data Model (v1)

Each v1 card must define:

| Field | Description |
|---|---|
| `Card ID` | Stable identifier (E-###, M-###, R-###, S-###, B-###) |
| `Name` | Player-facing name |
| `Category` | emotion / memory / reaction / shift / breakthrough |
| `Deck Role` | primary / support / breakthrough |
| `Intent Tag` | connect / stabilize / reveal / protect / pressure / reframe / recover |
| `Tone Tag` | open / guarded / vulnerable / assertive / uncertain / warm / defensive / playful / heavy |
| `Summary Text` | One sentence describing what the card does at a glance |
| `Rules Text` | Full card effect description |
| `Effects` | Array of effect primitives (modify_stat, open/close_window, add_modifier, etc.) |
| `Conditional Effects` | Array of if/then effect blocks |
| `Synergy Rules` | Array of bonus effect triggers when paired conditions are met |
| `Risk Rules` | Array of penalty effect triggers when conditions are mis-matched |
| `Risk Tag` | One-line description of what goes wrong if misplayed |
| `Readability Note` | Why a first-session player should understand this card intuitively |

---

### 1.3 Canonical Intent and Tone Tags (v1 Lock)

These are locked for v1 and should be used consistently across all cards and encounters.

**Intent tags:** `connect` · `stabilize` · `reveal` · `protect` · `pressure` · `reframe` · `recover`

**Tone tags:** `open` · `guarded` · `vulnerable` · `assertive` · `uncertain` · `warm` · `defensive` · `playful` · `heavy`

**Risk tags (canonical list):**
- `escalates_if_trust_low` — card damage is worse when trust is already low
- `fails_if_clarity_low` — card fails to deliver its main value when clarity is too low
- `weak_if_tension_high` — card effect is reduced or negated in high-tension states
- `punished_if_repeated` — using this card twice in a row without variation triggers penalties
- `requires_memory_support` — card is weaker without a memory pairing
- `requires_open_window` — card needs a matching response window to function well

---

### 1.4 v1 Card List

## Emotion Cards (9)

### E-001 Concern
- **Intent:** connect · **Tone:** open
- **Summary:** +1 Trust. Better with Memory support.
- **Rules:** Gain 1 trust. If paired with Memory, gain 1 clarity. In high tension (≥8), lose 1 momentum.
- **Effects:** `modify_stat: trust +1`
- **Synergy:** If paired with Memory → `modify_stat: clarity +1`
- **Risk:** `weak_if_tension_high`
- **Readability:** A gentle caring response should make emotional sense immediately.

### E-002 Hope
- **Intent:** recover · **Tone:** vulnerable
- **Summary:** +1 Momentum. At decent clarity, also gain trust.
- **Rules:** Gain 1 momentum. If clarity ≥ 5, gain 1 trust. If clarity ≤ 2, lose 1 trust.
- **Effects:** `modify_stat: momentum +1`
- **Conditional:** clarity ≥ 5 → trust +1 | clarity ≤ 2 → trust −1
- **Risk:** `fails_if_clarity_low`
- **Readability:** Hope reads as a future-facing attempt to move forward.

### E-003 Shame
- **Intent:** reveal · **Tone:** heavy
- **Summary:** +1 Clarity, −1 Momentum. Safer with Memory support.
- **Rules:** Gain 1 clarity and lose 1 momentum. If paired with Quiet Support, gain 1 trust. At trust ≤ 3, tension rises by 1.
- **Effects:** `modify_stat: clarity +1`, `modify_stat: momentum −1`
- **Synergy:** Paired with M-004 (Quiet Support) → trust +1
- **Risk:** `escalates_if_trust_low`
- **Readability:** Shame exposes something real but is dangerous in unsafe situations.

### E-004 Anger
- **Intent:** pressure · **Tone:** assertive
- **Summary:** Force the encounter to react. High tension amplifies the effect.
- **Rules:** Force immediate encounter reaction. If tension ≥ 7, tension also rises by 1 and trust drops by 1.
- **Effects:** triggers immediate encounter reaction
- **Conditional:** tension ≥ 7 → tension +1, trust −1
- **Risk:** `escalates_if_trust_low`
- **Readability:** Anger is easy to understand and creates obvious stakes.

### E-005 Fear
- **Intent:** protect · **Tone:** uncertain
- **Summary:** Prevent a negative encounter push and reduce momentum drain.
- **Rules:** Cancel the next negative encounter reaction. Reduce momentum loss by 1. If paired with Memory, gain 1 clarity.
- **Effects:** prevents next negative reaction, `modify_stat: momentum +1`
- **Synergy:** Paired with Memory → clarity +1
- **Risk:** `fails_if_clarity_low`
- **Readability:** Fear can be protective but clouds long-term direction.

### E-006 Determination
- **Intent:** recover · **Tone:** assertive
- **Summary:** Solidify current momentum. Push toward resolution.
- **Rules:** If momentum is negative, move it to neutral. If momentum is already neutral or positive, gain 1 momentum. If paired with Memory, gain 1 trust.
- **Effects:** `modify_stat: momentum` to 0 if negative; +1 if ≥ 0
- **Synergy:** Paired with Memory → trust +1
- **Risk:** `weak_if_tension_high`
- **Readability:** Determination signals intent without being aggressive.

### E-007 Relief
- **Intent:** recover · **Tone:** warm
- **Summary:** Reward calm play. +1 Momentum after tension is reduced.
- **Rules:** If tension dropped this turn, gain 1 momentum. If trust ≥ 5, set breakthroughReady.
- **Effects:** `modify_stat: momentum +1`
- **Conditional:** trust ≥ 5 → `set_breakthrough_ready: true`
- **Risk:** `requires_open_window`
- **Readability:** Relief makes sense as a payoff emotion once pressure has eased.

### E-008 Relief Through Laughter
- **Intent:** stabilize · **Tone:** playful
- **Summary:** −1 Tension in non-heated encounters. Riskier in public.
- **Rules:** If encounter is not heated, reduce tension by 1. If encounter is public, this may trigger a sharper backlash on repetition.
- **Effects:** `modify_stat: tension −1`
- **Conditional:** `public` keyword → no tension reduction
- **Risk:** `punished_if_repeated`
- **Readability:** Lightness can help, but repeated deflection feels fake.

### E-009 Doubt
- **Intent:** reveal · **Tone:** uncertain
- **Summary:** +1 Clarity, but −1 Trust if unsupported.
- **Rules:** Gain 1 clarity. If not paired with a protect Reaction, lose 1 trust.
- **Effects:** `modify_stat: clarity +1`
- **Conditional:** no protect Reaction paired → trust −1
- **Risk:** `requires_memory_support`
- **Readability:** Doubt reveals uncertainty but destabilizes the exchange.

---

## Memory Cards (8)

### M-001 Old Promise
- **Intent:** connect · **Tone:** warm
- **Summary:** Supportive history. Builds trust if the moment is not hostile.
- **Rules:** If tension ≤ 6, gain 1 trust. If paired with Concern or Hope, gain 1 clarity.
- **Effects:** (none base)
- **Conditional:** tension ≤ 6 → trust +1 | paired with E-001 or E-002 → clarity +1
- **Risk:** `fails_if_clarity_low`
- **Readability:** Shared history creates understandable emotional grounding.

### M-002 Shared Joke
- **Intent:** stabilize · **Tone:** playful
- **Summary:** −1 Tension in public or fragile encounters. Pairs well with Shame or Relief.
- **Rules:** If encounter has fragile or public keyword, reduce tension by 1. If paired with Shame or Relief Through Laughter, gain 1 trust.
- **Effects:** `modify_stat: tension −1` (if fragile or public)
- **Synergy:** Paired with E-003 or E-008 → trust +1
- **Risk:** `weak_if_tension_high`
- **Readability:** A shared joke can soften embarrassment if timed well.

### M-003 Unkept Promise
- **Intent:** reveal · **Tone:** heavy
- **Summary:** +2 Clarity. A risky truth that raises the stakes.
- **Rules:** Gain 2 clarity. If paired with Guarded Honesty, open repair and gain 1 momentum. If trust ≤ 3, tension rises by 1.
- **Effects:** `modify_stat: clarity +2`
- **Synergy:** Paired with R-001 (Guarded Honesty) → open repair + momentum +1
- **Risk:** `escalates_if_trust_low`
- **Readability:** Painful history clarifies the real issue but raises stakes.

### M-004 Quiet Support
- **Intent:** protect · **Tone:** warm
- **Summary:** Prevents the first trust loss this turn. Supports vulnerable plays.
- **Rules:** Prevent the first trust loss this turn. If paired with Shame or Doubt, gain 1 trust.
- **Effects:** `add_modifier: trust_guard (duration: turn)`
- **Synergy:** Paired with E-003 or E-009 → trust +1
- **Risk:** `weak_if_tension_high`
- **Readability:** Supportive context makes vulnerability safer.

### M-005 Repeated Pattern
- **Intent:** reveal · **Tone:** guarded
- **Summary:** +1 Clarity. Marks the encounter as defensive. Sets up Shift follow-up.
- **Rules:** Gain 1 clarity and mark encounter as defensive. If followed next turn by a Shift card, gain 1 momentum.
- **Effects:** `modify_stat: clarity +1`, encounter gains `defensive` keyword
- **Conditional:** next turn plays Shift → momentum +1
- **Risk:** `punished_if_repeated`
- **Readability:** Naming a pattern helps understanding but can harden the exchange.

### M-006 Missed Signal
- **Intent:** reveal · **Tone:** uncertain
- **Summary:** Clear a misread penalty and open a safer response line.
- **Rules:** Remove misread keyword from encounter. If paired with Concern, open repair and gain 1 clarity.
- **Effects:** `remove_keyword: misread`
- **Synergy:** Paired with E-001 (Concern) → open repair + clarity +1
- **Risk:** `requires_open_window`
- **Readability:** Reinterpreting a misunderstanding is central to the game's pitch.

### M-007 Hidden Cost
- **Intent:** reveal · **Tone:** heavy
- **Summary:** +2 Clarity and expose the real issue, but tension rises.
- **Rules:** Gain 2 clarity. Tension rises by 1. If paired with a protect Reaction, cancel the tension rise.
- **Effects:** `modify_stat: clarity +2`, `modify_stat: tension +1`
- **Conditional:** paired with protect Reaction → tension rise cancelled
- **Risk:** `escalates_if_trust_low`
- **Readability:** Bringing up buried context clarifies the situation but raises heat.

### M-008 Shared Victory
- **Intent:** connect · **Tone:** warm
- **Summary:** Gain trust and momentum. Most powerful after a positive run.
- **Rules:** Gain 1 trust and 1 momentum. If the run result history has more breakthroughs than collapses, gain 1 additional clarity.
- **Effects:** `modify_stat: trust +1`, `modify_stat: momentum +1`
- **Conditional:** run has net positive results → clarity +1
- **Risk:** none base
- **Readability:** Drawing on positive shared experience reinforces connection.

---

## Reaction Cards (9)

### R-001 Guarded Honesty
- **Intent:** reveal · **Tone:** guarded
- **Summary:** +1 Clarity, −1 Tension. Memory opens repair.
- **Rules:** Gain 1 clarity and reduce tension by 1. If paired with Memory, open repair.
- **Effects:** `modify_stat: clarity +1`, `modify_stat: tension −1`
- **Synergy:** paired with Memory → `open_response_window: repair`
- **Risk:** `fails_if_clarity_low`
- **Readability:** Honest but careful communication is a strong prototype anchor card.

### R-002 Deflect
- **Intent:** protect · **Tone:** defensive
- **Summary:** Prevent immediate pressure, but clarity slips next turn.
- **Rules:** Gain 1 reaction shield this turn and add deflection tracking for next refresh.
- **Effects:** `add_modifier: reaction_shield (duration: turn)`, `add_modifier: deflected_last_turn (duration: encounter)`
- **Risk:** `punished_if_repeated`
- **Readability:** Deflection is intuitive and creates visible tradeoffs.

### R-003 De-escalate
- **Intent:** stabilize · **Tone:** open
- **Summary:** Strong tension control in heated or fragile scenes.
- **Rules:** Reduce tension by 1, or by 2 if encounter is heated or fragile. If momentum is negative, move it toward neutral.
- **Effects:** `modify_stat: tension −1`; `−2` if heated or fragile
- **Conditional:** momentum ≤ −1 → momentum +1
- **Risk:** `weak_if_tension_high`
- **Readability:** Players should instantly understand what this is for.

### R-004 Hold Boundary
- **Intent:** protect · **Tone:** assertive
- **Summary:** Prevent collapse from direct pressure this turn.
- **Rules:** Prevent collapse trigger from direct pressure this turn. If trust ≥ 5, gain 1 momentum.
- **Effects:** prevents collapse from pressure
- **Conditional:** trust ≥ 5 → momentum +1
- **Risk:** `escalates_if_trust_low`
- **Readability:** Boundary-setting adds non-submissive emotional play.

### R-005 Pressure Back
- **Intent:** pressure · **Tone:** assertive
- **Summary:** Force the encounter to react. High clarity improves outcome.
- **Rules:** Force immediate encounter reaction. If clarity ≥ 6, also gain 1 clarity and expose a contradiction.
- **Effects:** triggers immediate encounter reaction
- **Conditional:** clarity ≥ 6 → clarity +1 + contradiction exposed
- **Risk:** `escalates_if_trust_low`
- **Readability:** A risky card that shows aggressive play is possible but costly.

### R-006 Sit With It
- **Intent:** recover · **Tone:** vulnerable
- **Summary:** Skip the encounter's next escalation and gain trust if vulnerable.
- **Rules:** Skip escalation from the encounter's next reaction step. If paired with Shame or Doubt, gain 1 trust.
- **Effects:** prevents next encounter escalation
- **Synergy:** paired with E-003 or E-009 → trust +1
- **Risk:** `requires_open_window`
- **Readability:** Choosing not to react instantly can be emotionally legible and strategic.

### R-007 Reframe Gently
- **Intent:** reframe · **Tone:** open
- **Summary:** +1 Clarity and convert negative momentum. In misread, open connect.
- **Rules:** Gain 1 clarity. If momentum is negative, gain 1 momentum. If encounter is misread, open connect.
- **Effects:** `modify_stat: clarity +1`
- **Conditional:** momentum ≤ −1 → momentum +1 | misread keyword → `open_response_window: connect`
- **Risk:** `fails_if_clarity_low`
- **Readability:** This is one of the clearest "change the interpretation" tools.

### R-008 Stand Ground
- **Intent:** protect · **Tone:** assertive
- **Summary:** Prevent collapse and stabilize trust if the situation turns.
- **Rules:** Prevent collapse this turn regardless of tension or failed play count. If trust ≥ 5, gain 1 trust.
- **Effects:** prevents collapse trigger
- **Conditional:** trust ≥ 5 → trust +1
- **Risk:** none base
- **Readability:** Choosing to hold position instead of collapse is a legible non-escape option.

### R-009 Yield Ground
- **Intent:** stabilize · **Tone:** guarded
- **Summary:** Reduce tension and open a recovery window. Costs momentum.
- **Rules:** Reduce tension by 2. Open recover window. If momentum is positive, lose 1 momentum.
- **Effects:** `modify_stat: tension −2`, `open_response_window: recover`
- **Conditional:** momentum > 0 → momentum −1
- **Risk:** none base
- **Readability:** Sometimes giving ground temporarily prevents collapse.

---

## Shift Cards (6)

### S-001 Change of Lens
- **Intent:** reframe · **Tone:** open
- **Summary:** Remove a misread/defensive penalty and sharpen clarity.
- **Rules:** Remove misread or defensive keyword from encounter. If paired with Memory, gain 1 clarity.
- **Effects:** `remove_keyword_one_of: [misread, defensive]`
- **Synergy:** paired with Memory → clarity +1
- **Risk:** `requires_memory_support`
- **Readability:** Directly supports the project's interpretation-first promise.

### S-002 Slow the Room
- **Intent:** stabilize · **Tone:** guarded
- **Summary:** Lock tension growth for one turn and open stabilize.
- **Rules:** Lock tension from increasing during the next reaction step. Open stabilize window.
- **Effects:** `add_modifier: no_tension_increase (duration: turn)`, `open_response_window: stabilize`
- **Risk:** `weak_if_tension_high`
- **Readability:** A clear pacing control tool for high-volatility scenes.

### S-003 Name the Pattern
- **Intent:** reveal · **Tone:** heavy
- **Summary:** +2 Clarity. Makes the encounter fragile but opens breakthrough.
- **Rules:** Gain 2 clarity. Encounter becomes fragile. If trust ≥ 5, set breakthroughReady.
- **Effects:** `modify_stat: clarity +2`, encounter gains `fragile` keyword
- **Conditional:** trust ≥ 5 → `set_breakthrough_ready: true`
- **Risk:** `escalates_if_trust_low`
- **Readability:** Big clarity spike with obvious emotional danger.

### S-004 Try Again Differently
- **Intent:** recover · **Tone:** warm
- **Summary:** Replay the encounter reaction with one improved state value.
- **Rules:** Re-run the encounter reaction check with one stat of your choice improved by 1. Only usable after a failed or weak turn.
- **Effects:** replays encounter reaction with one stat boosted
- **Risk:** `requires_open_window`
- **Readability:** Strong prototype card for teaching that outcomes can be reshaped.

### S-005 Fresh Start
- **Intent:** reframe · **Tone:** open
- **Summary:** Clear one negative keyword and open a fresh response window.
- **Rules:** Remove one negative keyword (misread, defensive, or stalled). Open the response window of your choice.
- **Effects:** `remove_keyword_one_of: [misread, defensive, stalled]`, `open_response_window: player_choice`
- **Risk:** none base
- **Readability:** A reset button that gives the player agency to steer the encounter.

### S-006 Deep Breath
- **Intent:** stabilize · **Tone:** warm
- **Summary:** −1 Tension and prevent encounter escalation for one turn.
- **Rules:** Reduce tension by 1. Prevent tension increase from the next state refresh.
- **Effects:** `modify_stat: tension −1`, `add_modifier: no_tension_increase (duration: turn)`
- **Risk:** none base
- **Readability:** A grounding tool that is hard to misuse.

---

## Breakthrough Cards (3)

### B-001 Mutual Recognition
- **Intent:** connect · **Tone:** vulnerable
- **Summary:** Resolve as Breakthrough if trust and clarity are both high.
- **Rules:** If trust ≥ 7 and clarity ≥ 6 and breakthrough window is open, seal breakthrough. Stronger reward if paired with Memory.
- **Effects:** `upgrade_outcome: partial → breakthrough`
- **Synergy:** paired with Memory → grant +1 carry-forward trust
- **Risk:** `requires_open_window`
- **Readability:** The most classic "we finally understand each other" payoff.

### B-002 Stable Repair
- **Intent:** recover · **Tone:** warm
- **Summary:** Turn a calm partial into breakthrough. Carry trust forward.
- **Rules:** If tension ≤ 4 and momentum ≥ 0, upgrade partial to breakthrough. Grant +1 carry-forward trust into next encounter.
- **Effects:** `upgrade_outcome: partial → breakthrough`, `carry_forward: trustModifier +1`
- **Risk:** `fails_if_clarity_low`
- **Readability:** Lets calm, sustained play pay off visibly.

### B-003 Hard Truth, Open Door
- **Intent:** reveal · **Tone:** assertive
- **Summary:** Reward a high-clarity, high-risk honesty line.
- **Rules:** If clarity ≥ 7 and trust did not drop below 4 during this encounter, upgrade to breakthrough.
- **Effects:** `upgrade_outcome: partial → breakthrough`
- **Risk:** `escalates_if_trust_low`
- **Readability:** Supports the game's promise that honesty can hurt before it heals.

---

## 1.5 v1 Starter Deck

**16-card starter deck:**

**Emotions (5):** Concern, Hope, Shame, Determination, Relief

**Memories (4):** Old Promise, Quiet Support, Missed Signal, Shared Victory

**Reactions (4):** Guarded Honesty, De-escalate, Stand Ground, Reframe Gently

**Shifts (3):** Change of Lens, Slow the Room, Fresh Start

**Rationale:** This mix gives a new player:
- multiple connect lines (Concern, Shared Victory)
- a recovery arc (Determination, Relief)
- a vulnerability line (Shame + Quiet Support)
- a repair tool (Guarded Honesty + Missed Signal)
- a pacing tool (Slow the Room)
- a reset tool (Fresh Start)

This is enough variety to play all 5 v1 encounters meaningfully without being overwhelming.

---

## 1.6 Synergy Rules for v1

### Primary synergy pairs (locked for v1)
- **Emotion + Memory:** stronger trust / clarity effects, unlocks repair/boundary windows
- **Reaction + Memory:** safer difficult truths, better repair windows, reduced risk penalties
- **Emotion + Shift:** state reinterpretation and keyword removal synergy
- **Reaction + Shift:** rescue / reset plays, momentum recovery
- **Memory + Breakthrough:** enhanced carry-forward rewards

### Synergy design rules
A strong combo should either:
- improve Clarity,
- reduce Tension,
- safely raise Trust,
- open a response window, or
- set breakthroughReady.

Do not require three-card combos. Two-card combos are the v1 ceiling.

---

## Part 2 — v1 Encounter Templates

### 2.1 Template Schema (v1 Lock)

Every v1 encounter template must define:

```yaml
id: unique-slug-id
name: Display name
prompt: Player-facing situation description
keywords: [list of encounter context keywords]
startingStats:
  tension: 0-10
  trust: 0-10
  clarity: 0-10
  momentum: -5 to +5
startingWindows: [list of initially open response windows]
visibleCues: [list of player-facing description lines shown at encounter open]
breakthroughThresholds:
  trust: number
  clarity: number
  momentum: number
collapseConditions:
  - condition description
  - condition description
turnPressureRules:
  description: what happens at turn pressure points
reactionRules:
  - id: rule-id
    priority: 1-100 (higher = checked first)
    if: matching condition
    effects: [list of effect primitives]
    cue: player-facing reaction description
runPosition: first | middle | last | any
```

---

### 2.2 Encounter Keywords — Usage Guide

| Keyword | Effect on card behavior |
|---|---|
| `fragile` | Aggressive or misfit plays cause disproportionate damage. |
| `guarded` | Trust-building and repair are more effective. Pressure plays are penalized. |
| `misread` | Clarity-building and reinterpretation rewarded. Standard plays underperform. |
| `public` | Emotional exposure is higher risk. Shame and deflection more volatile. |
| `private` | Vulnerable plays are safer but breakthrough requires more setup. |
| `heated` | Tension is already elevated. De-escalation and stabilize strongly rewarded. |
| `stalled` | Momentum is low or negative. Recovery and repair needed. |
| `repairable` | A breakthrough or strong partial is within reach if the right window is read. |
| `defensive` | Player is under pressure. Aggressive plays will likely trigger opposition. |
| `open_window` | A breakthrough path is currently available. High-opportunity state. |

---

### 2.3 v1 Encounter Templates

---

### ENCOUNTER 1 — Missed Signal
**v1 position:** First encounter (any run position)
**Design intent:** Teaches the core read-and-respond loop in a forgiving environment.

```yaml
id: missed_signal
name: Missed Signal
prompt: Someone important thinks they were ignored on purpose.
keywords: [misread, repairable]
startingStats:
  tension: 5
  trust: 5
  clarity: 3
  momentum: 0
startingWindows: [connect, reveal]
visibleCues:
  - "The issue feels personal, but still repairable."
  - "A careful honest response is likely to land well here."
breakthroughThresholds:
  trust: 7
  clarity: 6
  momentum: 1
collapseConditions:
  - "Tension reaches 10 and trust drops to 2 or below"
  - "Three failed plays with tension at 8 or above"
turnPressureRules:
  description: "After turn 4, tension increases by 1 each state refresh per the standing v1 rule."
reactionRules:
  - id: ms_pressure_low_fit
    priority: 90
    if: { packageHasTag: pressure }
    effects:
      - { type: modify_stat, stat: tension, amount: 2 }
      - { type: modify_stat, stat: momentum, amount: -1 }
      - { type: close_response_window, windowId: repair }
    cue: "Pushing too hard confirms the hurt and narrows the repair line."
  - id: ms_connect_memory
    priority: 60
    if: { packageHasTag: connect, packageHasCategory: memory }
    effects:
      - { type: modify_stat, stat: trust, amount: 1 }
      - { type: open_response_window, windowId: repair }
      - { type: set_breakthrough_ready, value: true }
    cue: "The shared context lands. A real repair opening appears."
  - id: ms_reveal_careful
    priority: 50
    if: { packageHasTag: reveal }
    effects:
      - { type: modify_stat, stat: clarity, amount: 1 }
    cue: "Careful honesty exposes what actually went wrong."
  - id: ms_default
    priority: 10
    if: {}
    effects:
      - { type: modify_stat, stat: momentum, amount: -1 }
    cue: "The exchange drifts without fully connecting."
runPosition: first
```

---

### ENCOUNTER 2 — Public Embarrassment
**v1 position:** First or middle encounter
**Design intent:** High-tension, high-volatility encounter that punishes aggressive misreads and rewards stabilization.

```yaml
id: public_embarrassment
name: Public Embarrassment
prompt: A painful moment happened in front of other people, and everyone remembers it differently.
keywords: [public, heated, fragile]
startingStats:
  tension: 7
  trust: 2
  clarity: 5
  momentum: -1
startingWindows: [stabilize, protect]
visibleCues:
  - "The room is hot. Safety matters more than winning the point."
  - "Deflection and stabilization are strong here. Aggression will backfire."
breakthroughThresholds:
  trust: 6
  clarity: 7
  momentum: 1
collapseConditions:
  - "Tension reaches 10 and trust is 2 or below"
  - "Three failed plays with tension at 8 or above"
  - "Pressure play when trust is 3 or below"
turnPressureRules:
  description: "High starting tension means turn-pressure escalation arrives earlier here. After turn 3, tension increases by 1 each state refresh."
reactionRules:
  - id: pe_pressure_backfire
    priority: 90
    if: { packageHasTag: pressure }
    effects:
      - { type: modify_stat, stat: tension, amount: 2 }
      - { type: modify_stat, stat: trust, amount: -1 }
    cue: "Public pressure hardens everyone immediately."
  - id: pe_deflect_cost
    priority: 70
    if: { primaryCardId: R-002 }
    effects:
      - { type: modify_stat, stat: clarity, amount: -1 }
      - { type: close_response_window, windowId: reveal }
    cue: "Deflection buys a moment, but the real issue blurs further."
  - id: pe_stabilize_reward
    priority: 55
    if: { packageHasTag: stabilize }
    effects:
      - { type: modify_stat, stat: tension, amount: -1 }
      - { type: open_response_window, windowId: recover }
    cue: "Slowing things down creates room for recovery."
  - id: pe_shame_memory_reward
    priority: 50
    if: { primaryCardId: E-003, packageHasCategory: memory }
    effects:
      - { type: modify_stat, stat: trust, amount: 1 }
      - { type: set_breakthrough_ready, value: true }
    cue: "Owning the hurt in context makes the moment less performative."
  - id: pe_default
    priority: 10
    if: {}
    effects:
      - { type: modify_stat, stat: tension, amount: 1 }
    cue: "The room stays volatile."
runPosition: first
```

---

### ENCOUNTER 3 — Quiet Repair
**v1 position:** Middle or last encounter
**Design intent:** A quieter encounter that rewards patience, repair reads, and trust-building over flash.

```yaml
id: quiet_repair
name: Quiet Repair
prompt: After the damage, there is one private chance to see whether anything can still be rebuilt.
keywords: [private, repairable, guarded]
startingStats:
  tension: 4
  trust: 4
  clarity: 4
  momentum: 0
startingWindows: [connect, recover, reframe]
visibleCues:
  - "This is quieter, but not automatically safe."
  - "Pressure will backfire here. Patience is rewarded."
breakthroughThresholds:
  trust: 7
  clarity: 6
  momentum: 1
collapseConditions:
  - "Trust drops to 2 or below"
  - "Three failed plays"
  - "Pressure play when encounter is guarded and trust is below 5"
turnPressureRules:
  description: "Standard v1 turn pressure applies (tension +1 after turn 4)."
reactionRules:
  - id: qr_recover_reward
    priority: 70
    if: { packageHasTag: recover }
    effects:
      - { type: modify_stat, stat: momentum, amount: 1 }
      - { type: open_response_window, windowId: breakthrough }
    cue: "Steady repair creates a real path forward."
  - id: qr_reframe_reward
    priority: 60
    if: { packageHasTag: reframe }
    effects:
      - { type: modify_stat, stat: clarity, amount: 1 }
    cue: "A new framing helps both sides see the pattern more clearly."
  - id: qr_guarded_punish_pressure
    priority: 85
    if: { packageHasTag: pressure }
    effects:
      - { type: modify_stat, stat: trust, amount: -2 }
      - { type: modify_stat, stat: tension, amount: 1 }
    cue: "Forcing the issue in a guarded repair moment backfires."
  - id: qr_default
    priority: 10
    if: {}
    effects:
      - { type: modify_stat, stat: momentum, amount: -1 }
    cue: "The conversation stays cautious and slow."
runPosition: middle
```

---

### ENCOUNTER 4 — Old Grudge
**v1 position:** Middle or last encounter
**Design intent:** A history-heavy encounter where unresolved baggage makes the current situation harder to navigate.

```yaml
id: old_grudge
name: Old Grudge
prompt: Something from the past is being used against you in the present, and the old wound is still open.
keywords: [misread, guarded, defensive]
startingStats:
  tension: 6
  trust: 3
  clarity: 3
  momentum: -1
startingWindows: [reveal, protect]
visibleCues:
  - "History is in the room. Be careful what you dig up."
  - "Direct confrontation will likely make things worse. Repair requires trust first."
breakthroughThresholds:
  trust: 7
  clarity: 7
  momentum: 1
collapseConditions:
collapseConditions:
  - "Tension reaches 10 and trust is 2 or below"
  - "Three failed plays"
  - "Pressure play when trust is below 4 and encounter has guarded keyword"
turnPressureRules:
  description: "Standard v1 turn pressure applies. Misread keyword makes failed plays especially costly."
reactionRules:
  - id: og_reveal_memory_reward
    priority: 70
    if: { packageHasTag: reveal, packageHasCategory: memory }
    effects:
      - { type: modify_stat, stat: clarity, amount: 2 }
      - { type: set_breakthrough_ready, value: true }
    cue: "Bringing up the context with care opens a real path forward."
  - id: og_pressure_punish
    priority: 90
    if: { packageHasTag: pressure }
    effects:
      - { type: modify_stat, stat: trust, amount: -2 }
      - { type: modify_stat, stat: tension, amount: 1 }
    cue: "Using old pain as a weapon hardens the wall even more."
  - id: og_protect_stabilize
    priority: 60
    if: { packageHasTag: protect }
    effects:
      - { type: modify_stat, stat: trust, amount: 1 }
      - { type: open_response_window, windowId: recover }
    cue: "Holding a boundary without attacking earns a little ground."
  - id: og_default
    priority: 10
    if: {}
    effects:
      - { type: modify_stat, stat: momentum, amount: -1 }
      - { type: modify_stat, stat: clarity, amount: -1 }
    cue: "Without a clear approach, the old pattern repeats."
runPosition: middle
```

---

### ENCOUNTER 5 — Breakthrough Moment
**v1 position:** Last encounter (optimized for run-position: last)
**Design intent:** A high-stakes encounter designed to feel like the climax of a run. Easier to reach breakthrough than other encounters if the run has gone well; harder if carry-forward state is negative.

```yaml
id: breakthrough_moment
name: Breakthrough Moment
prompt: Everything has been leading here. The real question is finally on the table, and how you got here matters.
keywords: [repairable, open_window]
startingStats:
  tension: 5
  trust: 5
  clarity: 4
  momentum: 0
startingWindows: [connect, recover, reframe]
visibleCues:
  - "This is the encounter where it all comes together."
  - "Previous run history affects how this one plays out."
  - "A breakthrough is possible if you've built trust and clarity across the run."
breakthroughThresholds:
  trust: 6
  clarity: 6
  momentum: 0
collapseConditions:
  - "Tension reaches 10 and trust is 2 or below"
  - "Three failed plays with tension at 7 or above"
turnPressureRules:
  description: "Standard v1 turn pressure. If run has net-positive carry-forward, encounter starts with +1 trust and +1 clarity. If run has net-negative carry-forward, encounter starts with -1 trust and encounter gains guarded keyword."
reactionRules:
  - id: bm_positive_run
    priority: 80
    if: { runHasPositiveCarryForward: true }
    effects:
      - { type: modify_stat, stat: trust, amount: 1 }
      - { type: open_response_window, windowId: breakthrough }
    cue: "The positive momentum from earlier encounters carries forward."
  - id: bm_negative_run
    priority: 80
    if: { runHasNegativeCarryForward: true }
    effects:
      - { type: modify_stat, stat: tension, amount: 1 }
      - { type: modify_stat, stat: trust, amount: -1 }
    cue: "The weight of earlier collapses makes this harder."
  - id: bm_connect_memory
    priority: 65
    if: { packageHasTag: connect, packageHasCategory: memory }
    effects:
      - { type: modify_stat, stat: trust, amount: 1 }
      - { type: set_breakthrough_ready, value: true }
    cue: "Drawing on real context here seals the arc."
  - id: bm_recover_earn
    priority: 55
    if: { packageHasTag: recover }
    effects:
      - { type: modify_stat, stat: momentum, amount: 1 }
      - { type: open_response_window, windowId: breakthrough }
    cue: "Steady recovery earns a real chance at resolution."
  - id: bm_default
    priority: 10
    if: {}
    effects:
      - { type: modify_stat, stat: momentum, amount: -1 }
    cue: "The moment passes without full resolution."
runPosition: last
```

---

## Part 3 — v1 Encounter Cross-Reference

### Which cards work best in which encounters

| Encounter | Strong cards | Risky cards | Breakthrough path |
|---|---|---|---|
| Missed Signal | Concern, Hope, Guarded Honesty, Change of Lens, Shared Joke | Anger, Pressure Back | Connect + Memory → breakthrough |
| Public Embarrassment | De-escalate, Shared Joke, Stand Ground, Slow the Room | Anger, Pressure Back, Deflect (repeated) | Stabilize → Shame + Memory → breakthrough |
| Quiet Repair | Reframe Gently, Hope, Quiet Support, Fresh Start, Determination | Anger, Pressure Back | Recover → Reframe → breakthrough |
| Old Grudge | Hidden Cost, Guarded Honesty, Stand Ground, Name the Pattern, Fresh Start | Anger (repeated), Pressure Back | Reveal + Memory carefully → breakthrough |
| Breakthrough Moment | Any strong connect/recover combination from prior run state | Misfit plays that waste good carry-forward | Draw on run carry-forward + aligned play |

---

## Part 4 — Engineering and QA Reference

### 4.1 Effect Primitives (Canonical List for v1)

These are the only effect primitives that should be used in v1 card and encounter definitions. Adding new primitives requires a design review.

| Primitive | Parameters | Description |
|---|---|---|
| `modify_stat` | `stat`, `amount` | Add amount to stat. Negative amount for decrease. |
| `open_response_window` | `windowId` | Open the named response window. |
| `close_response_window` | `windowId` | Close the named response window. |
| `add_modifier` | `modifierId`, `duration` | Add a duration-bound modifier to the encounter. |
| `remove_keyword` | `keyword` | Remove one keyword from the encounter. |
| `remove_keyword_one_of` | `keywords[]` | Remove the first matching keyword from the list. |
| `set_breakthrough_ready` | `value: true/false` | Set the breakthrough armed flag. |
| `upgrade_outcome` | `from`, `to` | Promote the current outcome state if it matches from. |
| `carry_forward` | `stat`, `amount` | Mark a stat modifier to apply at encounter end. |

### 4.2 Condition Primitives (Canonical List for v1)

| Primitive | Parameters | Description |
|---|---|---|
| `packageHasCategory` | category name | True if the card package contains this category. |
| `packageHasTag` | tag name | True if the card package contains this tag. |
| `primaryCardId` | card ID | True if primary card matches this ID. |
| `supportCardId` | card ID | True if support card matches this ID. |
| `primaryIntentTagIn` | [tags] | True if primary card's intent tag is in list. |
| `primaryToneTagIn` | [tags] | True if primary card's tone tag is in list. |
| `statGte` | `stat`, `value` | True if named stat ≥ value. |
| `statLte` | `stat`, `value` | True if named stat ≤ value. |
| `encounterHasKeyword` | keyword | True if encounter has this keyword. |
| `encounterHasKeywordIn` | [keywords] | True if encounter has any keyword from list. |
| `breakthroughReady` | boolean | True if encounter breakthrough is armed. |
| `runHasPositiveCarryForward` | none | True if run carry-forward net is positive. |
| `runHasNegativeCarryForward` | none | True if run carry-forward net is negative. |

### 4.3 Encounter Schema Validation Rules

For QA and engineering, each v1 encounter template must pass these checks:

1. At least one reaction rule with `priority: 10 (default catchall)` must exist.
2. At least one reaction rule must trigger on `packageHasTag: recover`.
3. Breakthrough thresholds must satisfy: `trust ≤ 8`, `clarity ≤ 8`, `momentum ≤ 3`.
4. Starting tension must be between 3 and 8 inclusive.
5. At least 2 and no more than 4 starting windows must be open.
6. Collapse conditions must be explicitly defined.
7. Each reaction rule must have a non-empty `cue` string.
8. Each encounter must define its `runPosition` as first/middle/last/any.

---

## Part 5 — What DES-V1-002 Resolves from DES-V1-001 Open Questions

DES-V1-001 left 5 open questions. This deliverable resolves them:

1. **Encounter count:** 5 templates defined, configurable per run (run-level config)
2. **Breakthrough timing:** breakthrough cards are surfaced when `breakthroughReady` fires; they can be played in the next subsequent turn when their window is open. Not the same turn as surfacing. (See breakthrough_moment encounter: the player earns the right to play it, then plays it.)
3. **Hand size:** confirmed at 4 (from v1 design constants lock)
4. **Difficulty scaling:** uniform across v1 templates; difficulty is expressed through keyword complexity and starting stat configuration, not through separate difficulty modes
5. **Template count:** 5 minimum met (Missed Signal, Public Embarrassment, Quiet Repair, Old Grudge, Breakthrough Moment)

---

**Canonical file:** `projects/emotion-cards-four/gdd/v1-card-taxonomy-and-encounter-templates.md`
