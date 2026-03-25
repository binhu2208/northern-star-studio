# DEV-001 — Prototype Combat Scenario

## Purpose
Define one playable combat scenario that proves the emotional-state system creates readable, meaningful decisions in a short prototype fight.

This scenario is the playable core for concept validation.
It is intentionally small:
- one player deck
- one enemy encounter
- one combat loop
- one clear escalation moment
- one clear recovery moment

The goal is not content volume.
The goal is to prove **prepare → execute → overextend → recover** in a way players can understand quickly.

---

## 1. Prototype Goal
The scenario should let a first-session player experience all four emotional states in one fight:

**Calm → Focused → Agitated → Overwhelmed → stabilize back down**

By the end of the encounter, the player should understand:
- emotional state changes combat choices
- aggressive turns create stronger output but greater risk
- recovery tools are part of the strategy, not dead turns
- the emotional mechanic is the main hook, not a cosmetic modifier

---

## 2. Scenario Summary
### Encounter name
**Pressure Test: Hallway Confrontation**

### Fantasy
The player faces a single hostile rival who ramps pressure if ignored, punishes reckless overextension, and briefly exposes a weakness that rewards timing.

### Why this encounter
This one fight covers the three pressure patterns needed for the prototype:
1. **punishes passivity**
2. **punishes overextension**
3. **rewards precision timing**

That makes it the cleanest possible validation fight for the emotion system.

---

## 3. Win / Loss Conditions
### Player win
Reduce the enemy to **0 HP**.

### Player loss
The player reaches **0 HP**.

### Soft validation win
Even before full balance is final, the scenario succeeds if a tester can:
- identify their current emotional state
- explain at least one state-based decision
- notice one high-risk burst moment
- notice one recovery decision that matters

---

## 4. Core Combat Rules
### Player values
- **Player HP:** 30
- **Starting state:** Focused
- **Hand size per turn:** 5
- **Energy per turn:** 3
- **Deck size:** 12 cards

### Enemy values
- **Enemy HP:** 36

### State track
**Calm → Focused → Agitated → Overwhelmed**

### State effects for this prototype
- **Calm:** guard cards gain +2 block
- **Focused:** the second card played each turn gains a bonus effect
- **Agitated:** attack cards gain +2 damage, guard cards lose 1 block
- **Overwhelmed:** attack cards gain +4 damage; at the start of next turn discard 1 random card, then shift down to Agitated

### End-of-turn drift
- Calm stays Calm
- Focused stays Focused for the prototype unless changed by cards/enemy effects
- Agitated shifts down to Focused if not pushed further that turn
- Overwhelmed applies its downside next turn, then shifts to Agitated

This keeps the rules readable and prevents too much hidden state.

---

## 5. Player Starter Deck
The starter deck should visibly support build, burst, and recovery.

## Deck list (12 cards)
### Stabilizers
**2x Guarded Breath**
- Cost: 1
- Gain 6 block
- Shift 1 toward Calm

**1x Reset Rhythm**
- Cost: 1
- Gain 4 block
- Draw 1
- If Agitated or Overwhelmed, shift 1 toward Focused

**1x Center Line**
- Cost: 0
- Gain 3 block
- Retain 1 card next turn
- If Calm, gain +2 more block

### Builders
**2x Read Intent**
- Cost: 1
- Deal 4 damage
- Apply Mark to the enemy
- Shift 1 toward Focused

**1x Steady Plan**
- Cost: 1
- Draw 2
- Your second card this turn gains +2 bonus value
- No state change

**1x Measured Step**
- Cost: 0
- Deal 2 damage
- If Focused, draw 1

### Escalators / Payoffs
**2x Press Forward**
- Cost: 1
- Deal 7 damage
- Shift 1 toward Agitated

**1x Sharp Sequence**
- Cost: 1
- Deal 5 damage
- If this is the second card played, deal +4 damage
- Shift 1 toward Agitated

**1x Break Through**
- Cost: 2
- Deal 12 damage
- If already Agitated, become Overwhelmed

### Crisis tool
**1x Last Nerve**
- Cost: 1
- Deal 8 damage
- If Overwhelmed, deal +6 instead
- Lose 2 block at end of turn

## Deck intention
- Stabilizers let the player recover without feeling fully passive
- Builders help the player set up Focused turns
- Escalators create pressure and teach risk
- Break Through and Last Nerve create the screenshot/clip-worthy spike moment

---

## 6. Enemy Design
### Enemy name
**The Needle**

### Role
A readable pressure enemy that teaches timing.

### Enemy behavior goals
- force the player to act
- punish mindless aggression
- create one clear weak-window turn

### Enemy rules
The enemy uses a simple 3-turn intent loop:

#### Turn A — Pressure Jab
- Intent: deal 6 damage
- Passive: if the player ended last turn in Calm, enemy gains +2 armor this turn
- Purpose: discourages endless turtling

#### Turn B — Feint and Open
- Intent: deal 4 damage
- Effect: enemy becomes **Exposed** this turn
- Exposed: first attack against the enemy deals +3 damage
- Purpose: rewards a well-timed Focused turn

#### Turn C — Punish Overreach
- Intent: deal 9 damage
- Reactive effect: if the player ends turn Agitated or Overwhelmed, enemy deals +3 bonus damage
- Purpose: teaches that burst must be managed

Then the loop repeats.

## Why this enemy works
- Turn A pressures the player out of slow defense loops
- Turn B creates a visible payoff window
- Turn C makes emotional recovery strategically necessary

This is enough to validate the system without needing multiple enemies.

---

## 7. Intended Player Experience
The scenario should naturally create this sequence:

### Turn 1: establish control
The player uses builders or light defense to read the board and stay in Focused.

### Turn 2: exploit timing
The player sees the enemy's exposed window and uses a stronger Focused combo turn.

### Turn 3: push too far or choose restraint
The player is tempted to escalate into Agitated for burst damage.
This should feel exciting, not mandatory.

### Turn 4: risk spike
A deliberate all-in turn can enter Overwhelmed for a dramatic damage push.
This should create the prototype's best screenshot/clip candidate.

### Turn 5: stabilize or get punished
The player experiences the downside and uses recovery tools to return toward Focused or Calm.

If the fight works well, the player understands that emotional control is the game.

---

## 8. Example Play Pattern
This example is illustrative, not the only valid path.

### Sample line
**Turn 1**
- Play Read Intent
- Play Measured Step
- Play Guarded Breath
- Result: enemy marked, player stays controlled, state likely Focused/Calm depending on sequencing

**Turn 2 — enemy Exposed**
- Play Steady Plan
- Play Sharp Sequence
- Play Press Forward
- Result: good timed burst, shift into Agitated

**Turn 3**
- Enemy threatens Punish Overreach
- Player chooses between:
  - **safe line:** Guarded Breath + Reset Rhythm to return toward Focused
  - **greedy line:** Break Through to enter Overwhelmed and race damage

**Turn 4**
- If Overwhelmed, player gets a big attack payoff but suffers reduced control next turn
- Player then needs to recover before enemy punishment stacks up

This line teaches both the fantasy and the tactical cost of emotional escalation.

---

## 9. Readability Requirements for Implementation
This scenario only works if the prototype shows state clearly.

Minimum readability support required during implementation:
- current emotional state always visible near player HUD
- cards that shift state must say so explicitly
- state changes should trigger a clear visual update
- enemy intent must be visible before the player acts
- enemy Exposed window must be unmistakable
- entering Overwhelmed must feel dramatic and easy to notice

If these are missing, QA will likely fail comprehension even if the rules are solid.

---

## 10. Implementation Priorities
Build this scenario in the smallest useful order:

### Priority 1 — Must have
- single combat scene
- player HP, enemy HP
- 12-card starter deck
- 4 emotional states
- state shift rules
- enemy 3-turn intent loop
- win/loss conditions

### Priority 2 — Strongly recommended
- visible state label/icon/color
- visible enemy intent
- explicit Exposed marker
- visible Overwhelmed downside prompt next turn

### Priority 3 — Nice to have if cheap
- simple turn log for state changes
- lightweight card keywords for Build / Escalate / Stabilize
- one punchy VFX beat when entering Overwhelmed

This prevents DEV-001 from exploding in scope before DEV-002.

---

## 11. QA Hooks
This combat scenario is ready for QA-002 if testers can answer these after one fight:
- What emotional state were you in most recently?
- Why did you change or keep that state?
- When did aggression feel worth the risk?
- What happened when you overextended?
- Could you tell when the enemy wanted you to defend, burst, or reset?

If testers cannot answer those, the scenario is not proving the hook clearly enough.

---

## 12. Handoff Notes for DEV-002
DEV-002 should build placeholder state UI around this scenario with emphasis on:
- state visibility over visual polish
- explicit state-change feedback
- enemy intent clarity
- screenshot legibility during the Overwhelmed spike turn

The key scene to support visually is:
**player enters Overwhelmed on a visible burst turn against an Exposed enemy, then must stabilize on the following turn.**

That is the clearest single moment for both gameplay validation and marketing capture.

---

## 13. Recommendation
Proceed with this one-fight prototype as the baseline implementation target.

If the team can make this encounter readable and tactically satisfying, Emotion Cards Three has a real validation path.
If this fight is not compelling, scaling the concept further will probably not save it.