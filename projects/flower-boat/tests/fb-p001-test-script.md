# Flower Boat — FB-P001 Test Script

**Task:** FB-P001 — Paper Prototype Test  
**QA Owner:** Sakura  
**Purpose:** Validate the core loop before any production work begins

---

## What Is Being Tested

The paper prototype tests whether the following create the intended emotional experience:

1. **Stock constraint** — 3 slots from 4 flowers forces meaningful tradeoffs
2. **Customer subtext readability** — are cues clear enough to guide suggestions without being obvious?
3. **Emotional consequence** — does the player feel the difference between right and wrong suggestions?
4. **Replay motivation** — does the player want to try different stock?

---

## Correct Answers (QA Reference Only)

Do NOT show this to the player. Use to evaluate match/mismatch.

| Customer | What They Say | What They Actually Need | Correct Flower |
|---------|--------------|------------------------|---------------|
| The Hurry | "I just need something quick" | Warmth without obligation — they feel guilty | Sunflower |
| The Griever | "I don't know what I need" | Calm without demand — they need softness | Lavender |
| The Stuck | "I always wanted one, I don't know which" | Permission to want something for themselves | Wildflower Mix |
| The Present | "Something for my sister" | Renewal, sincerity — gesture not apology | White Lily |

---

## Test Setup

### Materials Needed
- Printed Customer Cards (4)
- Printed Flower Cards (4)
- Printed Stock Selection Sheet (1)
- Printed Play Log (1)
- Pen/pencil

### Before the Player Arrives
1. Read the customer cards and flower cards yourself so you know the full content
2. Set up the route map and customer cards face-down
3. Have flower cards visible with emotional associations showing
4. Keep your QA reference copy separate — player should not see it

### Explain the Game to the Player
> "You're a flower boat delivery person. You stock your boat with 3 types of flowers from 4 available, then visit 4 customers on your route. Your goal is to help each person find the flower they actually need — not just the one they asked for."

---

## Session Flow

### Phase 1 — Stock Selection (3–5 min)

**Ask:** "Before you meet the customers, look at the flower cards and choose your 3. Why did you pick those 3?"

**Watch for:**
- Does the player read the emotional associations before choosing?
- Do they try to anticipate the customers, or just pick flowers they personally like?
- Do they deliberate or decide quickly?

**Record:** Their stated reasons. Their chosen stock.

---

### Phase 2 — Route and Customer Encounters (15–20 min)

For each stop, read the customer card aloud. Let the player decide. Do not prompt or guide.

**After each decision, ask:**
- "What made you choose that one?"
- "Did you notice anything about what they said or how they acted?"

**Record in the Play Log:**
- Which flower they suggested
- Why they suggested it (in their words)
- How the customer "reacted" (you'll read the "what they actually need" after they decide)

**After all 4 stops**, mark each as:
- ✅ Match — player's suggestion matched the "what they actually need"
- ❌ Mismatch — player's suggestion did not match
- ⏸️ Partial — if borderline

**Do not tell them whether they were right or wrong during the session.** That comes in Phase 3.

---

### Phase 3 — Debrief (10 min)

After the route is complete, go back through each stop and reveal the correct answer.

**For each mismatch, ask:**
- "Now that you know what they actually needed, how do you feel about your choice?"
- "Was there enough information to have gotten it right?"

**Then ask the post-play reflection questions:**
1. Did you feel like you were helping people find something they actually needed? Yes / Somewhat / No
2. What was the hardest choice you made?
3. Did stock constraints affect your suggestions? If yes, how?
4. Would you play again with different stock? Why?

---

## Observable Behaviors to Record

These are the QA criteria — what you're actually evaluating:

| Criterion | How to Measure |
|-----------|----------------|
| Stock constraint forces tradeoffs | Did the player visibly struggle or express reluctance about which flower to leave out? |
| Subtext is readable | Did the player reference specific cues ("they kept checking their watch") in their reasoning, or just guess? |
| Player feels consequence | Does the player's reaction to revealing the correct answer look like genuine surprise, or "I knew it"? |
| Replay motivation | Does the player want to try again WITHOUT being prompted? |

---

## What Counts as a Pass

**The prototype passes if 2 or more of these are true:**

1. Player referenced specific customer cues (not just gut feeling) in at least 3 of 4 decisions
2. Player expressed genuine reaction (surprise, satisfaction, regret) when hearing the correct answers
3. Player wanted to play again without being prompted
4. Player identified a specific stock constraint as affecting their choice

**The prototype fails — meaning the design needs revision — if:**

- Player cannot articulate why they chose any flower (random guessing)
- Stock constraint produced no visible deliberation
- Player shows no emotional response to right/wrong outcomes
- All 4 choices were mismatches AND player shows no awareness of having missed

---

## Output

After the session, complete the Play Log and write a brief findings summary:

- Pass/Fail on each of the 4 criteria above
- Notable quotes from the player
- Whether the design holds (the mechanic works as intended) or needs revision (customer cues too subtle, flower associations unclear, etc.)
- Specific revision recommendations if any criterion failed

**File:** `projects/flower-boat/tests/fb-p001-findings.md`
