# DES-V1-006b: Card Resolution Language Audit

**Purpose:** Rewrite `rulesText` and add resolution cues to make card outcomes feel visceral, not just mechanical.

**Scope:** Emotion cards (E-series) are the emotional core — focus here. Reaction (R-series) and Breakthrough (B-series) get targeted rewrites where the mechanical text feels like a spec sheet instead of a moment. Memory cards stay more mechanical since they're context/support.

---

## Card Rewrite: E-001 — Concern

**Current rulesText:**
> "Gain 1 trust. If paired with Memory, gain 1 clarity. In high tension, lose 1 momentum."

**New rulesText:**
> "You reach out carefully — not fixing, just present. They don't pull away. That's something. (+1 trust. Memory support adds clarity; high tension costs momentum.)"

**Resolution cue:**
> "Something opens. Not a bridge, but a door left unlocked."

---

## Card Rewrite: E-003 — Shame

**Current rulesText:**
> "Gain 1 clarity and lose 1 momentum. If paired with Quiet Support, gain 1 trust. At low trust, tension rises."

**New rulesText:**
> "You say it out loud. The weight doesn't lift — but they move closer to understanding. Clarity costs something. (+1 clarity, -1 momentum. Quiet Support softens the fall; low trust heats the air.)"

**Resolution cue:**
> "Hard to say, but the air changed. They're still listening."

---

## Card Rewrite: E-004 — Anger

**Current rulesText:**
> "Force immediate encounter reaction. If tension is 7 or higher, also gain 1 tension and lose 1 trust."

**New rulesText:**
> "You push. Hard. The room reacts before anyone can think. (+1 tension, -1 trust at tension 7+. Use sparingly — the cost is real.)"

**Resolution cue:**
> "Something broke loose. You're not sure what yet."

---

## Card Rewrite: E-005 — Hope

**Current rulesText:**
> "Gain 1 momentum. If clarity is 5+, gain 1 trust. If clarity is 2 or less, lose 1 trust."

**New rulesText:**
> "You let yourself believe it could be different. The needle moves. (+1 momentum. High clarity means the hope lands; low clarity means it rings hollow.)"

**Resolution cue:**
> "The room feels lighter. For the first time in a while, forward is possible."

---

## Card Rewrite: E-006 — Fear

**Current rulesText:**
> "Cancel the next negative encounter reaction. Reduce momentum loss from that reaction by 1. If paired with Memory, gain 1 clarity."

**New rulesText:**
> "You brace before it lands. The blow still comes — but it glances off instead of hitting. (+1 clarity with Memory. The momentum still costs something, just less.)"

**Resolution cue:**
> "You flinched. But you stayed standing."

---

## Card Rewrite: E-007 — Determination

**Current rulesText:**
> "If momentum is -1 or lower, move it to 0. If momentum is 0 or higher, gain 1 momentum. If paired with Memory, gain 1 trust."

**New rulesText:**
> "You plant your feet. Enough is enough — you're not sliding anymore. (+1 momentum, or snap to 0 if you're underwater. Memory adds trust.)"

**Resolution cue:**
> "You're not losing anymore. Now you push."

---

## Card Rewrite: R-001 — Guarded Honesty

**Current rulesText:**
> "Gain 1 clarity and reduce tension by 1. If paired with Memory, open repair."

**New rulesText:**
> "You answer — but not all the way. Enough to stay in the room, not enough to hand over the knife. (+1 clarity, -1 tension. Memory support opens a repair window.)"

**Resolution cue:**
> "The air clears just enough to see each other's shape."

---

## Card Rewrite: R-003 — De-escalate

**Current rulesText:**
> "Reduce tension by 1, or by 2 if the encounter is heated or fragile. If momentum is negative, move it toward neutral."

**New rulesText:**
> "The air shifts. Not fixed — but lighter. You can breathe again. (+1 tension drop, or +2 in heated/fragile moments. Negative momentum drifts back toward zero.)"

**Resolution cue:**
> "The room exhales. For a moment, nobody's the enemy."

---

## Card Rewrite: R-007 — Reframe Gently

**Current rulesText:**
> "Gain 1 clarity. If momentum is negative, gain 1 momentum. In misread encounters, open connect."

**New rulesText:**
> "You find another angle. Suddenly the wall isn't so solid. (+1 clarity, +1 momentum if negative. Misread encounters get a connect window.)"

**Resolution cue:**
> "Same room. Different story. You can see a way through now."

---

## Card Rewrite: B-001 — Mutual Recognition

**Current rulesText:**
> "If trust and clarity are both high and breakthrough is open, this seals the encounter."

**New rulesText:**
> "They see you. You see them. Both things, at once — not as an exchange, but as a fact. (Breakthrough only: seals when trust and clarity are high.)"

**Resolution cue:**
> "The wall came down. Both of you are on the same side now."

---

## Card Rewrite: B-002 — Stable Repair

**Current rulesText:**
> "If tension is low and momentum is positive, promote partial to breakthrough and grant next-encounter trust."

**New rulesText:**
> "This is what it looks like when something actually heals. No drama, no collapse — just a thing made solid again. (Breakthrough only: promotes partial to breakthrough; carries trust forward.)"

**Resolution cue:**
> "You fixed it. Not perfectly — but durably. That's the hard one."

---

## Card Rewrite: B-003 — Hard Truth, Open Door

**Current rulesText:**
> "If clarity is high and trust did not collapse, convert the encounter to breakthrough."

**New rulesText:**
> "You say the thing that could end this — and it doesn't. The door stays open. (Breakthrough only: high clarity + intact trust converts to breakthrough.)"

**Resolution cue:**
> "You said the worst thing and the room held. Now something new can start."

---

## Encounter Outcome Language

When an encounter resolves, the game should display one visceral line alongside the stat readout.

### Breakthrough
> "You broke through. The wall came down."

### Partial
> "Something shifted — but not all the way."

### Stalemate
> "Nothing moves. You're both still standing in the same place."

### Collapse
> "It went wrong. The gap is wider now."

---

## State Change Feedback

Brief visceral lines to display when stats change.

| Stat | Change | Feedback Line |
|---|---|---|
| Trust | +1 | "Something unlocked between you." |
| Trust | -1 | "Something shuts down between you." |
| Tension | +1 | "The air thickens." |
| Tension | -1 | "The pressure eases." |
| Clarity | +1 | "You see it clearly for the first time." |
| Clarity | -1 | "The picture blurs." |
| Momentum | +1 | "You're gaining ground." |
| Momentum | -1 | "You're sliding backward." |
| Momentum | → 0 (from negative) | "You hit bottom and stopped digging." |
| Trust Guard | activated | "A wall goes up — for now." |
| Reaction Shield | activated | "You duck the blow. Barely." |
| Collapse Guard | activated | "You hold. Somehow." |
