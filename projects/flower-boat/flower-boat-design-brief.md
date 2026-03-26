# Flower Boat — Design Brief

## Document Overview
- **Project:** Flower Boat
- **Task:** Concept and prototype brief
- **Author:** Hideo (Design)
- **Status:** Draft for review

---

## One-Liner
You run a small flower boat on a network of canals. You stock it, choose your route, read what people need, and help them find the right flower.

---

## Core Gameplay Loop

### The Session
One session = one run on the canals. You depart from your dock, visit 3-5 stops, and return.

### What You Do
1. **Stock the boat** — choose which flowers to carry before departure. Limited space means every choice costs something.
2. **Choose your route** — which stops to visit, in what order
3. **Read customers** — at each stop, a customer has a need. You can suggest, guide, or let them choose
4. **See consequences** — the customer's reaction, and whether what you suggested actually fit

### The Meaningful Choice
The core tension is **stock + reading**: you can't carry everything, and you can't read everyone perfectly. The skill is in noticing what people need before they say it, and having the right thing when they do.

---

## Prototype Scope (One-Session Test)

### What to Build
- **1 canal route** with 4 dock stops
- **1 weather state** (sunshine — keeps scope minimal)
- **4 flower types** with different emotional associations
- **4 customer encounters** with different needs
- **Stock mechanic** — you choose 3 flowers to carry from 4 available
- **Suggestion mechanic** — read the customer, suggest a flower, see their reaction

### Prototype Success Criterion
A player completes one session and can answer: "Did you feel like you were helping people find something they actually needed?"

If yes — the core loop works.
If no — we redesign the reading mechanic before anything else.

---

## Core Mechanics

### 1. Stocking
- Your boat holds exactly 3 flower types (not 3 individual flowers — 3 types)
- You choose from 4 available types before departure
- The constraint forces genuine tradeoffs

### 2. Reading Customers
At each stop, the customer is described briefly. They have:
- What they say they want
- A subtext that hints at what they actually need
- A body language or tone cue

The player must read all three and decide how to respond.

### 3. Responding
Three valid approaches:
- **Suggest the right flower** — based on what they actually need (hardest)
- **Suggest what they asked for** — literal fulfillment
- **Let them choose** — they pick from what's on the boat

Each has different emotional weight and consequence.

### 4. Consequences
After each interaction:
- **Right suggestion** — customer reacts warmly, you feel the satisfaction
- **Literal fulfillment** — they take it, but it's not quite right
- **Wrong suggestion** — they accept it anyway, something feels off
- **Let them choose** — unpredictable, sometimes better, sometimes worse

### 5. Route (Optional for Prototype)
The order you visit stops matters — it affects what stock you have left when you arrive. Prototype keeps stops in fixed order to isolate the reading mechanic.

---

## Flower Types

| Flower | Emotional Association | Best For |
|---|---|---|
| Sunflower | Warmth, joy, celebration | Gifting, loneliness, celebration |
| Lavender | Calm, relaxation, comfort | Anxiety, grief, overstimulation |
| Wildflower mix | Nostalgia, freedom, surprise | Mixed moods, new beginnings |
| White lily | Renewal, sincerity, grief | Loss, fresh starts, apology |

---

## Customer Types

### Customer 1 — The Hurry
What they say: "I just need something quick."
Subtext: They feel guilty for not putting more thought into it.
Cue: Checking their watch.

**Right answer:** Sunflower — warmth without obligation. They're rushing because they feel bad; something bright and uncomplicated helps.

### Customer 2 — The Griever
What they say: "I don't know what I need."
Subtext: They're not ready to talk about it, but they want presence.
Cue: Quiet, looking at the water.

**Right answer:** Lavender — calm without demand. Don't push conversation. Just be there with the right thing.

### Customer 3 — The Stuck
What they say: "I saw these before, I always wanted one."
Subtext: They want permission to want something for themselves.
Cue: Hesitation, not meeting your eyes.

**Right answer:** Wildflower mix — unexpected, personal, not what they expected. It's for them, not for someone else.

### Customer 4 — The Present
What they say: "I need something for my sister."
Subtext: The relationship is strained; they want to reach out.
Cue: Specific but vague — "my sister" not "she likes roses."

**Right answer:** White lily — renewal, sincerity. It's about reconciliation, not apology.

---

## What "Success" Looks Like in the Prototype

The prototype succeeds if:
1. Player stocked based on reading the route and customers
2. Player made suggestions — not just let customers pick
3. Player felt the difference between right and wrong suggestions
4. Player wanted to try again with different stock

If all four, the core loop holds.

---

## What Can Be Thin in Prototype
- Art: flat illustration, warm palette, no animation needed
- Sound: optional ambient (canal sounds, birds)
- Route variety: fixed order, single weather state
- Customer variety: 4 types, no randomization

## What Must Work in Prototype
- Stock constraint must feel real
- Customer reading must be legible but not obvious
- Right/wrong suggestions must feel distinguishable
- Emotional feedback on consequences must land

---

## Next Steps After Prototype
If the prototype succeeds:
- Expand to multiple routes and weather states
- Add season progression
- Add "boat decoration" layer as optional depth
- Test whether the route planning mechanic adds or distracts

If the prototype fails:
- Redesign the reading mechanic (maybe customers say what they need more directly)
- Test whether the stock constraint is the wrong tension source

---

**Canonical file:** `projects/flower-boat/flower-boat-design-brief.md`
