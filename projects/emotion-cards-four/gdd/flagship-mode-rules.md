# Emotion Cards Four - Flagship Mode Rules

## Document Overview
- **Project:** Emotion Cards Four
- **Task ID:** DES-001
- **Purpose:** Define the flagship mode, turn structure, scoring / resolution states, and a sample session flow for prototype implementation and cross-discipline planning
- **Status:** Draft for active production use
- **Canonical proposal reference:** `docs/proposals/emotion-cards-four-project-proposal.md`

---

## 1. Flagship Mode Summary

### Working mode name
**Emotion Encounter**

### One-line mode pitch
Players respond to emotionally charged encounters by playing emotion, memory, reaction, and shift cards to change the state of the situation and push it toward breakthrough, partial resolution, stalemate, or collapse.

### Design intent
This mode is the core proof-of-concept for Emotion Cards Four. It should validate that:
- the game is readable on a first session,
- emotional choices feel meaningfully different,
- the play loop is socially watchable,
- outcomes feel varied enough to support replay.

### Prototype promise
The prototype is not trying to prove full campaign breadth. It is trying to prove that one encounter-based social-empathy mode is understandable, compelling, and structurally expandable.

---

## 2. Core Player Fantasy
Players should feel like they are:
- reading the emotional temperature of a situation,
- choosing how to respond rather than simply attacking or defending,
- combining emotional stance with personal context,
- changing what becomes possible in the encounter,
- living with the consequences of the tone they set.

The mode should reward interpretation, timing, and emotional framing more than raw complexity.

---

## 3. Win / Loss / Resolution Model

An encounter ends in one of four result states:

### Breakthrough
A strong positive outcome. The player reaches clarity, trust, understanding, or earned progress.

### Partial Resolution
The encounter moves forward but leaves tension, ambiguity, or tradeoffs unresolved.

### Stalemate
The situation stops progressing. No one meaningfully advances, and the player exits with limited benefit.

### Collapse
The emotional state destabilizes or hardens against the player. The best outcome is no longer reachable, and the next state becomes more difficult or costly.

### Prototype success target
The first playable slice should make these outcomes legible enough that a player can explain why the result happened.

---

## 4. Core Encounter Model

Each encounter tracks five gameplay values:

### 4.1 Tension
How volatile or emotionally charged the situation is.
- Low tension supports safer, more open responses.
- High tension makes escalation and collapse more likely.

### 4.2 Trust
How willing the encounter state is to accept vulnerable, connective, or constructive play.
- High trust opens breakthrough paths.
- Low trust makes memory and honesty plays riskier.

### 4.3 Clarity
How well the underlying emotional reality is understood.
- High clarity improves card readability and outcome predictability.
- Low clarity increases misreads and partial outcomes.

### 4.4 Momentum
The current directional pull of the encounter.
- Positive momentum favors resolution.
- Negative momentum favors deflection, stalemate, or collapse.

### 4.5 Response Window
The set of card types or actions that are currently effective.
- Some states reward calm/repair tools.
- Some states demand boundary-setting, reframing, or pressure release.

These values do not all need to be fully exposed numerically in the UI for the first prototype, but engineering and QA should treat them as the hidden logic model for state transitions.

---

## 5. Card Categories and Intended Use

### Emotion Cards
Represent the emotional stance a player is bringing into the moment.
Examples: Joy, Fear, Anger, Sadness, Hope, Shame, Relief.

**Primary function:** set tone and direction.

### Memory Cards
Represent past context, relationship history, promises, patterns, or emotional baggage.

**Primary function:** explain why a response lands differently in this situation.

### Reaction Cards
Represent immediate coping or response patterns: de-escalation, confrontation, reframing, withdrawal, humor, defense.

**Primary function:** alter tension, protect against collapse, or redirect the exchange.

### Shift Cards
Change the active emotional interpretation or reframe the encounter.

**Primary function:** open new response windows or rescue bad momentum.

### Breakthrough Cards
High-value outcome cards unlocked by conditions rather than freely played from hand in most cases.

**Primary function:** reward aligned setup and strong reading of the encounter.

---

## 6. Turn Structure

Each turn should be readable in the same order.

### Step 1 - Encounter State Refresh
The game updates the current encounter state.
- Ongoing effects apply.
- New pressure, cues, or reaction prompts are revealed.
- Current tension / trust / clarity / momentum shifts are shown.

### Step 2 - Draw / Prepare
The active player refreshes hand options.
- Draw to hand size or draw a fixed number.
- Resolve any start-of-turn card effects.

### Step 3 - Read the Situation
The player reviews:
- current encounter state,
- available response windows,
- hand composition,
- possible risk of escalation or collapse.

### Step 4 - Play Response
The player plays a response package:
- **required:** 1 primary card
- **optional:** 1 support card
- **optional:** 1 modifier if enabled by state or card text

The most common prototype combination is:
- 1 Emotion or Reaction card
- optionally paired with 1 Memory or Shift card

### Step 5 - Resolve Effects
The system processes:
- card text,
- card synergy,
- encounter-state modifiers,
- opposition / scenario behavior,
- result on tension, trust, clarity, and momentum.

### Step 6 - Encounter Reaction
The encounter pushes back.
This may:
- raise tension,
- close a response window,
- introduce a misunderstanding,
- create a vulnerability opening,
- unlock or deny a breakthrough route.

### Step 7 - Check Outcome State
After both player response and encounter reaction, the game checks whether the encounter has reached:
- Breakthrough,
- Partial Resolution,
- Stalemate,
- Collapse,
- or continues to next turn.

### Step 8 - Cleanup
- discard played cards unless retained by effect,
- process end-of-turn effects,
- advance encounter turn count,
- save session state if prototype instrumentation requires it.

---

## 7. Scoring and Progress Evaluation

The flagship mode should not use arcade-style points as the main signal. It should use **resolution quality** and **carry-forward state**.

### Resolution quality tiers
- **Breakthrough:** best result, strongest reward
- **Partial Resolution:** acceptable result, modest reward
- **Stalemate:** low reward, low progress
- **Collapse:** penalty, complication, or harder future state

### Internal scoring values for prototype use
To support tuning and analytics, each result can map to a hidden score:
- Breakthrough = 3
- Partial Resolution = 2
- Stalemate = 1
- Collapse = 0

### Session-level success indicators
A play session should track:
- number of encounters resolved,
- distribution of result states,
- average turns per encounter,
- collapse frequency,
- whether players voluntarily want another run.

### Why this matters
Marketing, QA, and design all need a prototype that can test emotional readability and replay intent. Hidden scoring supports that without making the game feel like a blunt points race.

---

## 8. Opposition / Encounter Behavior

The encounter is not passive. It acts like emotional opposition rather than a traditional enemy.

### Opposition goals
Depending on the encounter, the opposition may:
- resist vulnerability,
- misinterpret intent,
- deflect with humor or avoidance,
- escalate conflict,
- test consistency,
- punish contradictory emotional play.

### Opposition behavior rules for prototype
Each encounter should define:
- a starting state,
- 1-2 likely escalation triggers,
- 1-2 trust-building triggers,
- one breakthrough condition,
- one collapse condition,
- one reaction pattern when the player chooses a poor-fit response.

### Example escalation trigger
If the player uses aggressive confrontation while trust is low and clarity is low, tension spikes and the response window narrows.

### Example trust trigger
If the player combines a vulnerable emotion card with a context-appropriate memory card while tension is medium or lower, trust increases and a safer line opens.

---

## 9. Resource Model for Prototype

### Hand
- Target starting hand: 4-5 cards
- Target end-of-turn hand refresh: draw back to 4 or draw 2

### Deck / discard
- standard draw / discard loop
- reshuffle discard when deck is empty for prototype simplicity

### Encounter turn pressure
To prevent endless looping, each encounter should accumulate pressure over time.

Example:
- after turn 4, tension increases automatically each turn
- after repeated failed plays, clarity drops or a collapse threshold lowers

### Optional future resource
A later version may add a reflection / energy / composure resource, but it should not be required in the first playable slice unless implementation reveals a strong need.

---

## 10. Sample Session Flow

### Session setup
- Player starts a short prototype run with a small starter deck.
- The run contains 3 encounters.
- Between encounters, the player may add or swap a card.

### Encounter 1: Missed Signal
**Starting state:**
- Tension: Medium
- Trust: Medium
- Clarity: Low
- Momentum: Neutral

**Prompt:** Someone important thinks they were ignored on purpose.

**Turn 1:**
- Player plays **Concern** (Emotion) + **Old Promise** (Memory)
- Effect: trust rises, clarity improves, tension does not spike
- Encounter reaction: resistance remains, but a dialogue window opens

**Turn 2:**
- Player plays **Guarded Honesty** (Reaction)
- Effect: tension lowers, a misunderstanding is exposed
- Encounter reaction: a breakthrough condition becomes available

**Turn 3:**
- Player plays **Relief** (Emotion)
- Result: **Breakthrough**
- Reward: gain a card choice and positive momentum into the next encounter

### Encounter 2: Public Embarrassment
**Starting state:**
- Tension: High
- Trust: Low
- Clarity: Medium
- Momentum: Negative

**Turn 1:**
- Player plays **Deflect** (Reaction)
- Effect: avoids immediate damage but lowers clarity
- Encounter reaction: response window narrows

**Turn 2:**
- Player plays **Shame** (Emotion) + **Shared Joke** (Memory)
- Effect: partial de-escalation, but trust remains fragile

**Turn 3:**
- Player misreads the state and plays **Pressure Back**
- Effect: tension spikes, collapse threshold reached
- Result: **Collapse**

### Encounter 3: Quiet Repair
State carries forward from previous results.
If prior encounter collapsed, this encounter starts with reduced trust and one blocked response line.
The player still has a path to **Partial Resolution** or **Breakthrough** depending on card draw and prior rewards.

This carry-forward structure helps prove replayability and emotional consequence without requiring a large narrative campaign.

---

## 11. Prototype Content Requirements for DES-002
DES-002 should define enough content to make this mode testable.

Minimum output needed next:
- card categories locked,
- 20-30 prototype cards,
- tags or metadata for synergy,
- encounter keywords or state modifiers,
- at least 3 sample encounters,
- clear wording for breakthrough and collapse triggers.

---

## 12. UX / Readability Rules
To support first-session comprehension:
- each card should communicate one main intent clearly,
- keywords must be limited and reused consistently,
- outcome states must be named in plain language,
- the encounter state should show what changed after a play,
- players should understand why a combination worked or failed.

If the game requires players to infer too much hidden logic, it will fail the proposal’s readability goals.

---

## 13. Validation Hooks
This mode should support the project’s approved validation criteria.

### First-round comprehension
Can a new player understand what to do on turn one?

### Replay intent
After one short run, does the player want another attempt with a different emotional style?

### Creator / stream readability
Can an observer understand the stakes, the play, and the consequence?

### Audience fit
Does the mode feel more like social play, reflective play, or a workable blend?

### Emotional clarity
Can players explain why a card succeeded or failed?

### Tone acceptance
Does the experience feel emotionally engaging without feeling preachy or awkward?

---

## 14. Open Questions
These are not blockers for implementation framing, but they must be answered during DES-002 / DEV-001A.
- Are encounters single-player interpreted systems, multiplayer social turns, or a prototype-friendly hybrid?
- How much of encounter state is visible numerically versus represented through labels/UI cues?
- Should breakthrough cards be drawn, earned, or event-triggered?
- How persistent are deck changes across a short run?
- What is the minimum number of encounter templates needed for a fair readability test?

---

## 15. Recommendation to Downstream Roles

### For Development
Treat encounter behavior as central logic, not flavor text. Build around state transitions and response windows first.

### For Art
Assume the first prototype prioritizes readable card hierarchy, state feedback, and emotional legibility over high asset count.

### For QA
Build tests around whether players can predict outcomes well enough to learn, not whether every encounter resolves positively.

### For Production
Use this document as the design baseline for DES-002, DEV-001A, QA-001, and art scope estimation.

---

**Canonical file:** `projects/emotion-cards-four/gdd/flagship-mode-rules.md`
