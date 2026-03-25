# Emotional State Model

## Purpose
Define a **prototype-scale emotional-state system** that gives Emotion Cards Three a clear tactical hook without requiring a large content pool.

This model is built to answer one question:
**Does changing an emotional state meaningfully alter combat decisions in a way players can read quickly?**

## Design Goals
- keep the state system readable at a glance
- make emotion matter every turn, not only as a passive buff/debuff
- support one starter deck and one combat scenario first
- leave room to expand later without needing that expansion now
- avoid simulation-heavy mood systems for the prototype

## Prototype Pillar
For the prototype, an emotional state is:
- a **current stance** that changes how cards behave
- a **risk/reward curve** that can escalate or calm down
- a **visible battle condition** shared by the player, enemies, or both depending on encounter design

The prototype should use **one active state at a time per unit**.
No layered emotions, hidden meters, or personality traits are required yet.

---

## 1. Core State Categories / Archetypes
The prototype-friendly version uses **four readable archetypes**. These are broad enough to feel emotionally expressive, but limited enough to implement fast.

### 1. Calm
**Role:** stable, defensive, efficient setup state

**Play pattern**
- supports planning, card draw smoothing, shielding, and precise effects
- lowers volatility
- rewards patience and sequencing

**Player read**
- "I am in control"
- good for recovery, setup turns, and safe resource conversion

**Typical mechanical expression**
- improve block/guard values
- improve card selection / retain / draw filtering
- reduce self-risk from stronger cards

### 2. Focused
**Role:** tactical pressure, precision, combo-building state

**Play pattern**
- rewards chaining, targeting, and efficient use of small cards
- sits between Calm and more volatile states
- ideal "default proactive" state for the starter deck

**Player read**
- "I can execute a plan now"
- good for combo turns and exploiting enemy windows

**Typical mechanical expression**
- bonus on the second/third card played
- extra value when targeting weak or marked enemies
- improved consistency instead of raw burst

### 3. Agitated
**Role:** unstable offense, momentum, risky tempo spike

**Play pattern**
- increases attack pressure and emotional volatility
- rewards pushing advantage before the state becomes dangerous
- creates tension between damage now and stability later

**Player read**
- "I can hit harder, but I may lose control"
- good for burst turns, racing, and turning defense into aggression

**Typical mechanical expression**
- stronger attack values
- bonus from repeated attacks or taking small risks
- reduced defense efficiency or increased escalation chance

### 4. Overwhelmed
**Role:** crisis state, temporary payoff with clear downside

**Play pattern**
- acts as the top-end failure/peak state of escalation
- can create a dramatic power turn or a dangerous stumble
- should be strong enough to feel exciting, but costly enough that players do not want to stay there

**Player read**
- "This is powerful or urgent, but unsustainable"
- good for high drama and easy screenshot readability

**Typical mechanical expression**
- attack spikes, forced card behavior, or reduced hand control
- defense/card quality suffers
- if not stabilized, player loses tempo next turn

### Why these four
These four states create a simple and readable loop:

**Calm → Focused → Agitated → Overwhelmed → back toward Calm/Focused**

That gives the prototype:
- a low-intensity state
- a skill-expression state
- a high-pressure state
- a danger state

This is enough to prove the concept without creating a giant taxonomy.

---

## 2. State Flow: Trigger, Escalation, Stabilization, Decay

## 2.1 Trigger Types
State changes should come from a **small number of obvious sources**.

### A. Card-driven triggers
Cards are the clearest and most teachable source.
Examples:
- defensive cards move toward Calm
- setup/precision cards move toward Focused
- aggressive cards move toward Agitated
- certain explosive cards force or accelerate Overwhelmed

**Prototype recommendation:**
Use card text with explicit state movement, such as:
- `Shift 1 toward Calm`
- `Shift 1 toward Agitated`
- `If already Agitated, become Overwhelmed`

### B. Encounter-driven triggers
Enemies and encounter rules can push state from outside.
Examples:
- enemy taunts or pressure effects push the player toward Agitated
- heavy incoming damage pushes toward Overwhelmed
- breathing windows or recovery turns support Calm/Focused

This helps prove emotion is not just self-authored deck math.

### C. Outcome-driven triggers
Recent events can nudge state.
Examples:
- taking a large hit escalates instability
- perfectly blocking or finishing a combo can stabilize into Focused
- ending turn with unspent defensive resources can drift toward Calm

**Prototype recommendation:**
Keep these limited. One or two global rules is enough.

---

## 2.2 Escalation Rules
Escalation is what makes the system tactically meaningful.

### Base escalation model
Each unit has one current state.
Effects can move that unit by **one step** along the emotional track:

**Calm ↔ Focused ↔ Agitated ↔ Overwhelmed**

A move can be:
- **upward** toward instability/intensity
- **downward** toward control/stability

### Suggested prototype rules
- most cards shift by 1 step
- a few stronger cards shift by 2 or have conditional jumps
- Overwhelmed should usually require either:
  - two aggressive pushes across turns, or
  - one deliberate all-in card while already Agitated

That keeps Overwhelmed dramatic instead of common.

### Escalation sources by state
- **Calm** escalates when the player pushes tempo, spends emotion aggressively, or is pressured by enemies
- **Focused** escalates when the player chains proactive cards or converts setup into attack
- **Agitated** escalates when the player keeps pressing without stabilizing
- **Overwhelmed** does not escalate further; it instead creates pressure to stabilize or suffer decay consequences

---

## 2.3 Stabilization Rules
Stabilization gives the player agency. Without it, the system becomes a punishment meter.

### Stabilization sources
- guard/block cards
- cards tagged with calm, center, breathe, reflect, or reset functions
- ending a turn without overcommitting
- certain enemy downtime windows

### Prototype recommendation
Include **at least 25–35%** of the starter deck as stabilization tools. Not all should be pure defense.

Good stabilization cards can:
- shift state down by 1
- gain extra block if currently Agitated or Overwhelmed
- convert crisis into a smaller tactical benefit
- reward returning to Focused rather than only to Calm

### Important design note
Stabilization should not always mean "stop having fun."
It should feel like:
- reset for a smarter next turn
- bank momentum safely
- recover hand quality or control

That keeps the emotional loop dynamic instead of binary.

---

## 2.4 Decay Rules
Decay answers: what happens if a state is left unattended?

For the prototype, decay should be **simple and visible**.

### Recommended decay model
At end of turn:
- **Calm** stays Calm unless pushed
- **Focused** may stay Focused for one turn, then drift to Calm if unsupported
- **Agitated** drifts to Focused if no further escalation occurred that turn
- **Overwhelmed** forcibly drops to Agitated or Focused after applying a downside

This gives each state a different feel:
- Calm is sticky
- Focused is maintainable but not permanent
- Agitated is unstable
- Overwhelmed is explosive and temporary

### Overwhelmed downside options
Choose one prototype rule, not many.
Recommended options:
- discard 1 random card next turn
- lose some block at end of turn
- draw fewer cards next turn
- cannot retain cards next turn

The goal is readable consequence, not system complexity.

---

## 3. Mechanical Identity of Each State
This section gives the prototype a clearer gameplay profile.

| State | Strength | Weakness | Best Use | Risk if Ignored |
|---|---|---|---|---|
| Calm | defense, recovery, hand quality | lower burst damage | setup, stabilize, survive pressure | can feel too passive if deck has no payoff |
| Focused | precision, combos, efficiency | less raw damage than Agitated | plan execution, target exploitation | may drift away if not maintained |
| Agitated | burst offense, tempo | worse defense, less control | push advantage, race | can spiral into Overwhelmed |
| Overwhelmed | dramatic peak turn / high emotion | loss of control, post-turn penalty | all-in moments, encounter climax | tempo crash or vulnerability |

---

## 4. Starter Loop Recommendation
To keep the prototype tight, the first deck should be built around this loop:

1. **Open in Calm or Focused**
2. use setup/mark/precision cards to reach **Focused**
3. cash in with attacks that push into **Agitated**
4. optionally cross into **Overwhelmed** for a big turn
5. use reset/guard cards to recover to **Focused** or **Calm**

This gives a concrete emotional arc inside a single fight:
**prepare → execute → overextend → recover**

That loop is easy to explain, easy to test, and good for first-session comprehension.

---

## 5. Interaction with Deckbuilding
The emotional-state system should shape deckbuilding in understandable ways.
For the prototype, it only needs to support **one starter archetype plus a few upgrade choices**.

## 5.1 Deckbuilding Roles
Cards should broadly fall into four buckets:

### A. Stabilizers
- move state downward
- improve defense or hand control
- help exit Agitated/Overwhelmed safely

### B. Builders
- move toward Focused
- create marks, combo pieces, retains, or setup value
- improve later turns rather than immediate output

### C. Escalators
- move toward Agitated
- convert setup into pressure
- reward committing to offense

### D. Breakers
- high-risk cards that exploit Agitated or force Overwhelmed
- strongest burst option in the prototype
- should be few in number

A healthy prototype deck should not be all escalators.
If the player cannot regulate state, the system will feel noisy instead of strategic.

## 5.2 Prototype deckbuilding tension
The deck asks the player:
- how many cards help me climb safely?
- how many cards cash in when I am Agitated?
- how many cards help me come back down?

That creates understandable archetype tension even with a tiny card pool.

### Example upgrade directions
- **Controlled build:** more Calm/Focused tools, reliable combos, lower spikes
- **Momentum build:** more Agitated payoffs, stronger burst, higher instability
- **Recovery build:** exploit entering or leaving Overwhelmed, survive longer fights

These can exist as card reward choices without requiring multiple full classes.

## 5.3 Deckbuilding heuristics for the prototype
Recommended early ratio for a 12–16 card prototype deck:
- 3–5 stabilization cards
- 3–4 setup/focus cards
- 3–5 escalation/payoff attacks
- 1–2 crisis/breaker cards

This should create state movement often enough to feel central.

---

## 6. Interaction with Encounters
Encounters should test emotional control, not only health totals.

## 6.1 Encounter design principles
A good prototype encounter should:
- make state changes matter every 1–2 turns
- create at least one reason to escalate and one reason to stabilize
- visibly telegraph when staying Agitated is dangerous
- offer at least one window where returning to Focused/Calm is rewarded

## 6.2 Encounter pressure types
Use a small set of pressure patterns.

### Pressure type A: Punishes passivity
Example:
- enemy gains strength if left alone
- encourages the player to leave Calm and act

### Pressure type B: Punishes overextension
Example:
- enemy retaliates hard if the player ends turn Agitated or Overwhelmed
- teaches that aggression has timing

### Pressure type C: Rewards precision
Example:
- enemy exposes a weak point for one turn
- encourages being Focused at the right moment

A single encounter can combine two of these.
That is enough for the prototype.

## 6.3 Enemy emotional states
For the prototype, enemy state systems should stay lightweight.
Two viable options:

### Option 1: Player-only state system
- fastest to build
- easiest to teach
- good if the prototype is very tight on implementation time

### Option 2: Simplified enemy states
- enemies use 2–3 readable states instead of the full player model
- for example: Guarded, Provoked, Broken
- these interact with the player's emotion states without mirroring them exactly

**Recommendation:**
Start with **player-only emotional states** unless encounter readability already feels solved.
The player system is the hook that needs proof first.

---

## 7. Readability Rules
Because this project lives or dies on readability, the emotional-state model must stay visible.

### Prototype readability rules
- only one current state shown per unit
- state name should be paired with strong color/icon treatment
- cards that change state should say so explicitly
- the current state's gameplay meaning should be inferable from UI text or shorthand tags
- entering Overwhelmed should be visually dramatic and impossible to miss

### Suggested state shorthand
- Calm = shield / blue / steady outline
- Focused = eye / gold / sharp outline
- Agitated = spark / orange-red / jitter or flare
- Overwhelmed = fracture / crimson-purple / unstable pulse

Art can redefine the final look later. The prototype just needs fast recognition.

---

## 8. Recommended Prototype Ruleset
If the team wants the smallest possible testable version, use this exact ruleset:

### State track
**Calm → Focused → Agitated → Overwhelmed**

### Default rules
- each unit has one current state
- cards can shift state up or down by 1
- some payoffs check current state
- end-of-turn decay applies

### Simple state effects
- **Calm:** +defense value on guard cards
- **Focused:** bonus on second card played each turn
- **Agitated:** attack cards gain bonus power, guard cards lose efficiency
- **Overwhelmed:** attack cards gain major bonus power, then suffer one visible downside next turn

This is enough to build cards, one encounter, and a first-session test.

---

## 9. Out of Scope for This Prototype
To protect schedule and clarity, do **not** require these yet:
- mixed emotion states
- hidden relationship systems
- personality traits per character
- long-term emotional progression across runs
- separate positive vs negative axes
- emotional resistances, immunities, or status stacks
- full enemy emotional simulation
- more than one starter deck identity

These can be expansion paths if the prototype succeeds.

---

## 10. Validation Questions for DES-001
This model is successful if playtests show:
- players notice their current emotional state without prompting
- players can explain why they chose to escalate or stabilize
- Agitated and Overwhelmed feel exciting but not random
- Calm and Focused feel useful, not merely weaker versions of offense
- the starter deck creates a visible emotional arc during one fight
- the state system feels like more than generic stance swapping

## 11. Design Recommendation
For the prototype, the team should commit to:
- **four states only**
- **one-step state shifting** as the default rule
- **player-facing emotional control** as the main tactical hook
- **one encounter** that pressures both escalation and recovery
- **one starter deck** built around prepare → burst → recover

That is the smallest version likely to prove whether "emotions as strategy" is actually working.