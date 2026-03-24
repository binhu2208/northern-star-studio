# Emotion Cards — Core Mechanics (DES-001A)

**Game:** Emotion Cards  
**Document:** Core Mechanics  
**Version:** 0.1  
**Date:** March 14, 2026  
**Author:** Hideo 🎮

---

## 1. Core Concept

A roguelike deckbuilder where cards represent emotions and memories. Players build emotional states to navigate conversations, heal relationships, and understand themselves.

**Differentiation:** Emotions drive both mechanics AND narrative. Your deck composition unlocks different story paths.

---

## 2. Emotion Card System

### 2.1 Card Types

| Type | Function | Example |
|------|----------|---------|
| **Primary Emotions** | Core feelings — Joy, Sadness, Anger, Fear | "Twinge of Hope" (+2 Joy, draw 1) |
| **Complex Emotions** | Blended states requiring combos | "Bittersweet Memory" (requires Joy + Sadness) |
| **Memories** | Persistent buffs/debuffs | "Childhood Promise" (all Joy cards +1) |
| **Reactions** | Defensive/redirecting | "Bite Tongue" (absorb Anger, gain Patience) |

### 2.2 Emotion Families

**Warmth Family:** Joy, Gratitude, Contentment, Love  
**Shadow Family:** Sadness, Grief, Melancholy, Longing  
**Fire Family:** Anger, Frustration, Passion, Determination  
**Storm Family:** Fear, Anxiety, Doubt, Uncertainty

### 2.3 Card Interactions

- **Resonance:** Playing 3+ cards from same family triggers bonus effect
- **Conflict:** Playing opposing families (Fire + Warmth) causes "emotional turbulence" (card discard)
- **Transmutation:** Certain combinations evolve — Anger + Time = Understanding

---

## 3. Core Loop

### 3.1 Run Structure

1. **Awakening** — Choose starting emotional state (5 cards)
2. **Encounter** — Navigate situation using emotion cards
3. **Reflection** — Add new cards, remove unwanted ones
4. **Repetition** — Continue until emotional breakthrough or breakdown

### 3.2 Encounter Types

| Type | Mechanic | Example |
|------|----------|---------|
| **Conversation** | Card-based dialogue options | Play "Genuine Curiosity" to unlock deeper response |
| **Memory Dive** | Reconstruct past events | Build correct emotional sequence to understand |
| **Confrontation** | Emotional climax with NPC | Both sides play cards, higher emotional authenticity wins |
| **Solitude** | Self-reflection, deck management | No pressure, pure strategy |

---

## 4. Narrative Integration

### 4.1 Choice Architecture

Not "pick A or B" — instead:

- **Available options depend on your deck.** Have 3+ Anger cards? Confrontation option appears.
- **Consequences reshape your deck.** Choosing forgiveness adds Gratitude cards, removes Resentment.
- **Emotional authenticity scoring.** Playing cards that match your true feelings (established through play) gives bonuses.

### 4.2 Character Arcs

Each run follows one character's emotional journey. Multiple runs needed to see full picture.

**Example — The Estranged Sibling:**
- Run 1: Anger deck → Confrontation ending
- Run 2: Sadness deck → Understanding ending  
- Run 3: Balanced deck → Reconciliation ending

---

## 5. Meta-Progression

### 5.1 Between Runs

- **Emotional Insights:** Unlock new starter decks based on previous runs
- **Relationship Map:** See how different emotional paths connect
- **Unfinished Business:** Revisit characters with new emotional tools

### 5.2 True Ending

Requires understanding all major characters through multiple emotional lenses.

---

## 6. Cozy Design Principles

| Principle | Implementation |
|-----------|----------------|
| No failure state | "Emotional breakdown" = new perspective, not game over |
| No time pressure | All encounters turn-based |
| Meaningful without punishing | Suboptimal play still progresses story |
| Beautiful and calm | UI/UX designed for emotional safety |

---

## 7. Open Questions

1. How many cards in a typical deck? (20-30 range?)
2. Energy system or free play? (Leaning toward "emotional capacity" — limited plays per turn)
3. How do we teach the system without heavy tutorial?

---

**Next:** DES-001B — Character Arc Design
