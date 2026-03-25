# Emotion Cards Four — Prototype Architecture Baseline

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** DEV-001A
- **Purpose:** Define the minimum technical architecture needed to implement the flagship prototype loop described in `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
- **Primary audience:** John / downstream implementation, QA, and design handoff
- **Scope:** Prototype-only baseline for a playable vertical slice, not a final production architecture
- **Related docs:**
  - `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
  - `projects/emotion-cards-four/project-plan.md`
  - `projects/emotion-cards-four/production/market-brief.md`

---

## 1. Implementation Goal

The first engineering target is a **small, deterministic encounter runner** that proves these things cleanly:
- the turn loop is readable,
- card play changes encounter state in understandable ways,
- opposition behavior feels reactive rather than random,
- the four result states are explainable,
- carry-forward state between encounters works,
- the prototype emits enough data to tune readability and replay intent.

This architecture should optimize for **clarity, debuggability, and tuning speed** over flexibility. If a choice helps designers and QA explain "why that result happened," it is the right choice for this phase.

---

## 2. Prototype Boundaries

### In scope for DEV-002
- Single-player encounter flow against system-driven emotional opposition
- Run structure of **3 sequential encounters**
- Turn steps matching DES-001
- Draw / play / discard loop
- Hidden numeric encounter state backing readable UI labels
- Simple opposition rule evaluation
- Carry-forward state between encounters
- Minimal save/resume for an in-progress run
- Instrumentation/event logging for tuning and validation

### Explicitly out of scope for first playable slice
- Multiplayer turns or simultaneous social play
- Branching narrative campaign structure
- Complex card scripting language
- Procedural encounter generation
- Fully content-driven AI planner
- Network features, accounts, cloud saves, meta-progression
- Heavy animation/VFX pipelines
- Dynamic localization pipeline beyond content-safe string boundaries

### Why these boundaries matter
The project brief is trying to validate a **social-empathy card game** pitch, not to prove a general-purpose narrative engine. The prototype should stay narrow enough that a failed result is informative instead of noisy.

---

## 3. Recommended Technical Shape

Use a **data-driven state machine with deterministic rule resolution**.

That means:
- encounter state is plain serializable data,
- cards are content records plus a small set of supported effect primitives,
- opposition behavior is rule tables / condition checks, not bespoke hand-authored code per encounter,
- turn flow is a finite state machine,
- result calculation happens in a predictable order every time,
- logs record both inputs and resolved outputs.

### Recommended layers
1. **Run layer**
   - owns overall session/run progression across 3 encounters
   - stores carry-forward modifiers, encounter index, rewards/penalties, and save payload

2. **Encounter layer**
   - owns tension/trust/clarity/momentum/response windows, turn count, thresholds, and active modifiers

3. **Turn flow layer**
   - owns phase transitions: refresh → draw → read → play → resolve → reaction → outcome check → cleanup

4. **Card resolution layer**
   - converts played card package + current state into state deltas and tags for opposition evaluation

5. **Opposition layer**
   - applies encounter-specific reaction rules after player resolution

6. **Instrumentation layer**
   - emits structured events for every important state transition and outcome

This separation is enough to keep implementation sane without overengineering.

---

## 4. Core Runtime Model

## 4.1 Run State

Suggested prototype shape:

```ts
interface RunState {
  runId: string
  seed: number
  status: 'active' | 'completed' | 'abandoned'
  encounterIndex: number
  encounters: EncounterInstance[]
  deckState: DeckState
  carryForward: CarryForwardState
  resultHistory: EncounterResultSummary[]
  metrics: RunMetrics
  createdAt: string
  updatedAt: string
}
```

### Responsibilities
- track which encounter is active
- hold deck/hand/discard state across encounters
- apply rewards/penalties between encounters
- provide one save root for prototype resume
- accumulate session-level metrics used by QA/market validation

## 4.2 Encounter State

```ts
interface EncounterState {
  encounterId: string
  templateId: string
  turn: number
  phase: TurnPhase
  status: 'active' | 'resolved'
  result: 'breakthrough' | 'partial' | 'stalemate' | 'collapse' | null

  stats: {
    tension: number
    trust: number
    clarity: number
    momentum: number
  }

  responseWindows: ResponseWindow[]
  visibleCues: string[]
  activeModifiers: ModifierInstance[]
  pressureLevel: number
  failedPlayCount: number
  breakthroughReady: boolean
  collapseArmed: boolean

  lastPlayerAction?: ResolvedPlay
  lastOppositionAction?: ResolvedOppositionReaction
}
```

### Numeric assumptions
Use bounded numeric ranges in prototype code, even if UI hides exact values.

Recommended default range:
- tension: `0..10`
- trust: `0..10`
- clarity: `0..10`
- momentum: `-5..5`

This is narrow enough for tuning and readable thresholds, but not so tiny that every play causes whiplash.

## 4.3 Deck State

```ts
interface DeckState {
  drawPile: CardInstance[]
  hand: CardInstance[]
  discardPile: CardInstance[]
  exhaustPile?: CardInstance[]
  maxHandSize: number
}
```

### Prototype deck assumptions
- starting hand target: 4-5 cards
- draw back to hand size at the start of turn
- reshuffle discard into draw when empty
- no separate mana/energy resource in v1 unless forced by testing

## 4.4 Carry-Forward State

```ts
interface CarryForwardState {
  trustModifier: number
  tensionModifier: number
  clarityModifier: number
  momentumModifier: number
  blockedResponseTags: string[]
  unlockedBreakthroughCards: string[]
  rewardChoicesRemaining: number
}
```

This handles DES-001’s requirement that prior encounter outcomes affect future encounters without needing a campaign framework.

---

## 5. Turn Flow State Machine

The turn flow should be implemented as an explicit finite state machine. Do not bury phase changes in UI callbacks.

### Phase enum
```ts
type TurnPhase =
  | 'state_refresh'
  | 'draw_prepare'
  | 'read_situation'
  | 'play_response'
  | 'resolve_effects'
  | 'encounter_reaction'
  | 'check_outcome'
  | 'cleanup'
```

### Phase rules

#### 1. `state_refresh`
System-only phase.
- Apply ongoing modifiers
- Increase automatic pressure if turn threshold reached
- Update response windows from current state
- Emit current-state snapshot event

#### 2. `draw_prepare`
System-only phase.
- Draw to hand size or apply fixed draw rule
- Resolve start-of-turn effects
- Lock available hand for current turn snapshot

#### 3. `read_situation`
Player review phase.
- No hidden resolution occurs here
- UI should expose: state labels, response windows, recent changes, likely risk cues
- Player transitions manually into response selection

#### 4. `play_response`
Player input phase.
- Require exactly 1 primary card
- Allow 0-1 support card
- Allow optional modifier slot only if rule/card enables it
- Validate package legality before any resolution begins

#### 5. `resolve_effects`
System-only phase.
Resolution order should be fixed:
1. primary card base effect
2. support card effect
3. synergy/tag bonuses
4. active encounter modifiers
5. carry-forward modifiers that affect this turn
6. clamp stats to valid ranges
7. recalculate response windows and breakthrough/collapse flags

#### 6. `encounter_reaction`
System-only phase.
- Evaluate encounter reaction rules against post-play state
- Select highest-priority matching rule
- Apply reaction effects
- Update visible cues and response windows

#### 7. `check_outcome`
System-only phase.
Evaluate terminal conditions in a strict order:
1. collapse
2. breakthrough
3. stalemate
4. partial resolution
5. continue

**Why this order:** collapse must win when the player oversteps a hard failure threshold; breakthrough should only happen if collapse did not already occur; stalemate should be checked before generic partial completion so stalled states do not get mislabeled.

#### 8. `cleanup`
System-only phase.
- discard played cards unless retained
- clear one-turn transient modifiers
- increment turn counter if encounter continues
- write autosave snapshot if save support is enabled
- transition either to next turn `state_refresh` or encounter end

---

## 6. Card Resolution Baseline

The prototype should avoid a freeform card scripting system. Use a limited set of effect primitives and tags.

## 6.1 Card data expectations
Each card record should eventually support at least:

```ts
interface CardDefinition {
  id: string
  name: string
  category: 'emotion' | 'memory' | 'reaction' | 'shift' | 'breakthrough'
  tags: string[]
  primaryIntent: string
  targeting: 'self' | 'encounter' | 'state'
  effects: EffectPrimitive[]
  synergyRules?: SynergyRule[]
  playRequirements?: Requirement[]
  uiText: string
}
```

## 6.2 Effect primitive types
Recommended initial primitive list:
- `modify_stat(stat, amount)`
- `modify_stat_if(condition, amount)`
- `add_tag(tag)`
- `remove_tag(tag)`
- `open_response_window(windowId)`
- `close_response_window(windowId)`
- `add_modifier(modifierId, duration)`
- `unlock_breakthrough(conditionRef)`
- `protect_from_collapse(amount or flag)`
- `draw_cards(n)`
- `retain_card(selector)`

Anything outside this list should be treated as suspect until the prototype proves it is needed.

## 6.3 Response package rules
Prototype default package:
- Primary: Emotion **or** Reaction
- Optional support: Memory **or** Shift
- Breakthrough cards are not normally drawn-and-played freely; they are unlocked or surfaced only after meeting a condition

### Illegal package examples
- two primary cards
- support card without primary card
- breakthrough card from normal hand without unlock flag
- same-slot duplicate play when not explicitly allowed

## 6.4 Synergy model
Synergy should be tag-based and simple.

Example:
- card A adds tags: `vulnerable`, `honest`
- card B checks for `vulnerable`
- if trust >= 4 and tension <= 6, grant +2 trust and open repair response window

This is more maintainable than hardcoding specific named-card pairings everywhere.

---

## 7. Encounter / Opposition Architecture

The encounter should be modeled as a reactive system, not as a deck-based enemy.

## 7.1 Encounter template shape

```ts
interface EncounterTemplate {
  id: string
  name: string
  prompt: string
  startingStats: {
    tension: number
    trust: number
    clarity: number
    momentum: number
  }
  startingWindows: ResponseWindow[]
  escalationTriggers: TriggerRule[]
  trustTriggers: TriggerRule[]
  reactionRules: ReactionRule[]
  breakthroughCondition: OutcomeRule
  collapseCondition: OutcomeRule
  stalemateCondition?: OutcomeRule
  partialResolutionCondition?: OutcomeRule
  turnPressureRules: PressureRule[]
}
```

## 7.2 Opposition behavior principles
Each encounter should define behavior in terms of:
- **what it resists**,
- **what it rewards**,
- **how it punishes poor fit**,
- **what opens breakthrough**,
- **what causes collapse**.

This matches DES-001 and keeps encounter identity visible to both design and implementation.

## 7.3 Recommended reaction rule priority
When multiple reaction rules match, resolve by priority:
1. hard failure / collapse accelerators
2. response window closures
3. misunderstanding / clarity penalties
4. trust openings / vulnerability rewards
5. flavor/state cue updates

This avoids soft reactions masking more important consequences.

## 7.4 Prototype opposition algorithm
Per turn, after player resolution:
1. collect post-play state snapshot
2. evaluate matching reaction rules
3. choose highest-priority rule
4. apply stat changes/modifiers/window changes
5. emit explanation text and instrumentation payload

Do **not** use random reaction selection unless tied to a seeded, logged rule set. Unexplained randomness will wreck readability testing.

## 7.5 Example prototype rule expression
Human-readable format is enough for now:

```ts
if (
  playedTags includes 'aggressive' &&
  stats.trust <= 3 &&
  stats.clarity <= 3
) {
  tension += 2
  momentum -= 1
  closeWindow('repair')
  addModifier('misunderstood', 1)
}
```

This directly maps to the flagship-mode example and is simple to debug.

---

## 8. Outcome and Result-State Logic

The four result states must be generated by explicit rules, not vibes.

## 8.1 Breakthrough baseline
A breakthrough should usually require:
- trust at or above threshold,
- clarity at or above threshold,
- momentum non-negative or positive,
- breakthrough condition flag or matching line open,
- no collapse condition currently true.

Suggested default threshold starting point:
- trust >= 7
- clarity >= 6
- momentum >= 1
- breakthroughReady = true

## 8.2 Collapse baseline
Collapse should happen if any encounter-specific hard fail condition is met.
Default prototype patterns:
- tension >= 10 and trust <= 2
- repeated poor-fit responses past allowed count
- explicit encounter collapse trigger activated

## 8.3 Stalemate baseline
Stalemate is useful when:
- turn limit reached without major progress,
- momentum is non-positive,
- no breakthrough path is open,
- collapse is not triggered,
- trust/clarity remain below resolution threshold.

Suggested default trigger:
- turn >= 6 and momentum <= 0 and trust < 6

## 8.4 Partial Resolution baseline
Partial resolution is the fallback positive-ish terminal state when:
- the encounter is no longer actively hostile,
- some progress occurred,
- but breakthrough requirements were not met.

Suggested default indicator:
- trust >= 4 or clarity >= 5, and encounter exits by progress threshold or end-of-encounter rule without breakthrough.

## 8.5 Hidden scoring map
Keep the rules doc mapping for analytics only:
- breakthrough = 3
- partial = 2
- stalemate = 1
- collapse = 0

Do not present this as player-facing score in v1.

---

## 9. Pressure, Pacing, and Anti-Stall Rules

The encounter model needs pressure so runs do not drag.

## 9.1 Turn pressure
Starting recommendation:
- turns 1-3: no automatic escalation
- turn 4+: `tension +1` each turn
- every second failed poor-fit play: `clarity -1`
- after collapse is armed, any further tension increase should be dangerous by design

## 9.2 Poor-fit play tracking
Add a lightweight `failedPlayCount` on encounter state.
Increment it when:
- played package mismatches current response windows,
- synergy is contradictory,
- encounter-specific bad trigger activates.

This gives QA a concrete way to verify that repeated misreads matter.

## 9.3 Breakthrough opening cadence
A breakthrough should not be available from turn zero in most encounters.
Recommended flow:
- player first creates conditions,
- encounter reaction exposes an opening,
- player then capitalizes.

That two-step cadence is important for emotional legibility.

---

## 10. Save / Resume Assumptions

The prototype only needs **run-level save**, not account/profile save.

## 10.1 What must be saveable
- current run state
- current encounter state
- draw/hand/discard order
- active modifiers
- encounter/result history
- seed
- carry-forward state
- current phase
- current turn number
- instrumentation session id reference

## 10.2 What does not need persistence yet
- per-user settings beyond whatever the host game already handles
- analytics upload queue durability
- cross-device sync
- long-term unlocks
- replay files

## 10.3 Save behavior recommendation
- autosave at encounter start
- autosave at end of cleanup each turn
- autosave immediately on encounter resolution before transition to reward/interstitial

## 10.4 Resume constraints
On load, the system should resume from the start of a stable phase, not from half-completed resolution.

Safe restore points:
- start of `state_refresh`
- start of `read_situation`
- post-encounter resolution/interstitial

Avoid restoring mid-resolution unless implementation is fully transactional.

## 10.5 Save format recommendation
JSON or engine-native serializable data is fine, but it should remain:
- human-inspectable in development,
- versioned with a simple schema version,
- tolerant of missing optional fields during iteration.

---

## 11. Instrumentation Requirements

Instrumentation is mandatory here because the prototype’s success criteria are about comprehension, readability, and replay intent.

## 11.1 Instrumentation goals
Engineering should be able to answer:
- what cards were played,
- what state changed,
- why the system reacted,
- how long encounters lasted,
- where collapses happened,
- whether players were using a variety of lines,
- whether outcomes felt predictable enough to learn.

## 11.2 Event list
Recommended minimum events:
- `run_started`
- `encounter_started`
- `phase_entered`
- `cards_drawn`
- `response_package_submitted`
- `play_validation_failed`
- `player_effects_resolved`
- `opposition_rule_triggered`
- `response_window_changed`
- `breakthrough_unlocked`
- `collapse_armed`
- `encounter_result`
- `carry_forward_applied`
- `run_completed`
- `run_abandoned`
- `save_written`
- `save_loaded`

## 11.3 Required payload fields
Most gameplay events should include:
- runId
- encounterId
- turn
- phase
- card ids played
- card categories played
- key tags played
- pre-state snapshot
- post-state snapshot
- triggered rule id(s)
- resulting response windows
- outcome flag if any
- timestamp

## 11.4 Metrics to aggregate
At minimum track:
- average turns per encounter
- result-state distribution
- collapse frequency per encounter type
- most common played categories and pairings
- poor-fit play rate
- breakthrough unlock rate vs breakthrough conversion rate
- deck exhaustion frequency
- save/resume usage and resume success

## 11.5 Debug visibility
In dev builds, include a debug panel or console dump for:
- raw stat values
- response windows
- last applied player effect
- last opposition rule
- active modifiers
- current outcome thresholds

Without this, tuning will be slow and arguments with design/QA will become subjective.

---

## 12. UI/UX Implications for Engineering

Even though this document is technical, some UI assumptions are non-negotiable because the market brief depends on spectator readability.

Engineering should preserve slots/data for displaying:
- current encounter prompt
- readable labels for tension/trust/clarity/momentum
- what changed this turn
- which response windows are open/closed
- why a reaction happened in plain language
- whether breakthrough is possible, hinted, or blocked

### Do not do this in the prototype
- expose a wall of invisible math with no explanation
- resolve opposition off-screen with no causal text
- hide whether a played memory/shift card actually mattered
- use purely decorative feedback when state changed materially

The prototype needs enough explanation to teach the loop through play.

---

## 13. Content Integration Assumptions for DEV-001B

This baseline assumes DEV-001B will define content integration around:
- card definitions as data assets/records,
- encounter templates as data assets/records,
- shared tag vocabulary,
- limited primitive effect set,
- readable UI text separate from raw logic tags.

### Required downstream alignment points
DEV-001B should lock:
- canonical tag list
- category-specific field requirements
- valid response window ids
- legal synergy condition vocabulary
- encounter rule schema
- breakthrough card unlock flow

If DEV-001B tries to solve this with freeform text parsing, the project will get slower and worse immediately.

---

## 14. QA-Relevant Test Surface

This baseline creates concrete QA targets.

### State-flow tests
- every phase transitions in legal order only
- illegal plays are rejected without corrupting state
- cleanup always discards/retains correctly
- end-of-turn pressure rules fire on correct turns

### Resolution tests
- same input state + same play package + same seed = same result
- support card effects apply after primary effects
- opposition evaluates after player resolution, never before
- stat clamps prevent invalid ranges

### Outcome tests
- collapse beats breakthrough when both could appear true after reaction
- partial vs stalemate classification matches thresholds
- carry-forward penalties/rewards apply to next encounter only as intended

### Save tests
- load from autosave restores exact hand/deck/encounter state
- no duplicate triggers after resume
- encounter result history survives resume

### Readability tests
- logs explain why a reaction triggered
- UI can surface a reason string for major state changes
- observer/debug output can reconstruct the turn outcome without source diving

---

## 15. Recommended Build Order

Implementation should likely proceed in this order:

1. **Core data models**
   - run state, encounter state, card definitions, rule definitions
2. **Turn state machine**
   - legal phase transitions with stubbed handlers
3. **Deck/hand/discard loop**
4. **Card package validation**
5. **Primitive effect resolver**
6. **Opposition rule resolver**
7. **Outcome classifier**
8. **Carry-forward application between encounters**
9. **Save/load**
10. **Instrumentation hooks**
11. **Debug view / development inspector**

This order gets the loop testable early and keeps content/design iteration unblocked.

---

## 16. Risks and Architecture Guardrails

## Main risks
1. **Overgeneralizing too early**
   - building a content scripting engine before proving the loop
2. **Under-explaining resolution**
   - making the game feel arbitrary
3. **Too much randomness**
   - making player learning impossible
4. **UI-driven state logic**
   - causing hard-to-reproduce bugs and save corruption
5. **Loose tag vocabulary**
   - creating tuning chaos in DEV-001B

## Guardrails
- Keep rule evaluation deterministic
- Keep state serializable
- Prefer small primitive effects over bespoke card code
- Prefer encounter templates over custom one-off logic classes
- Require explanation strings or rule ids for major reactions/outcomes
- Keep prototype metrics from day one, not as a late add-on

---

## 17. Concrete Prototype Defaults

These are recommended starting defaults, not sacred final tuning values.

### Session/run
- encounter count: 3
- starter hand size: 4 or 5
- result score map: 3/2/1/0 hidden

### Encounter
- default turn soft limit: 6
- automatic pressure begins: turn 4
- stat ranges: 0..10 for tension/trust/clarity, -5..5 for momentum

### Outcome thresholds
- breakthrough: trust >= 7, clarity >= 6, momentum >= 1, breakthroughReady = true
- collapse: tension >= 10 plus low-trust or explicit collapse trigger
- stalemate: turn limit reached with non-positive momentum and weak trust
- partial: progress made without breakthrough

These defaults are strong enough to start implementation and playtest tuning.

---

## 18. Final Recommendation

Build the first slice as a **tight deterministic system with inspectable state**, not as a fancy card battler shell. The whole project pitch depends on players and observers being able to say:

- what the situation was,
- what the player tried,
- how the encounter reacted,
- and why the result happened.

If the prototype nails that, the project has a real foundation. If it hides that under abstraction or randomness, it will miss both design validation and market validation.

---

**Deliverable path:** `projects/emotion-cards-four/src/prototype-architecture-baseline.md`
