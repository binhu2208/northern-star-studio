# Flower Boat — Digital Prototype UX Spec

## Project
Flower Boat

## Task ID
FB-D001

## Purpose
Define how the digital prototype feels, flows, and what the player sees at each step. This is the bridge between the paper prototype and John's technical shell.

---

## Design Principles

1. **Calm, warm, unhurried** — this is a meditative game. UI transitions are smooth. Nothing flashes or demands attention.
2. **Reading is the core skill** — customer text should be legible but not obvious. Subtext and cues are present but require attention.
3. **Planning is visible** — the player sees their plan before each run. What they chose and why should be clear throughout.
4. **Consequences land gently** — outcome screens show warmth without being saccharine. Wrong answers don't feel punishing.

---

## Screen Flow

```
[1. Departure] → [2. Stock Selection] → [3. Route Map] → [4. Encounters × 4] → [5. End Run Summary] → [Loop or Exit]
```

---

## Screen 1 — Departure

**Purpose:** Set the conditions for the run. Weather + route choice.

**Layout:**
- Title: "Your Boat, Your Route" (or similar warm header)
- Weather selector: 2 options shown as atmospheric descriptions with small icon
  - "Sunshine" — warm yellow, light
  - "Rain" — blue-grey, droplets
- Route selector: 2-3 routes shown as short names + brief description
  - "Morning Run" — quiet, early customers
  - "Afternoon Route" — busier, more variety
  - "Evening Cruise" — reflective, quieter
- "Set Sail" button (disabled until both chosen)
- Optional: show what flowers are available but not yet selected

**Interaction:**
- Click weather → selected state (highlighted border, not checkmark)
- Click route → selected state
- "Set Sail" triggers transition to Stock Selection

**Transitions:**
- Departure → Stock Selection: gentle fade + slight zoom forward

---

## Screen 2 — Stock Selection

**Purpose:** Choose 3 of 4 flowers. This is the pre-commitment moment.

**Layout:**
- Header: "Stock the Boat" (3 slots shown at top, empty)
- Flower cards in a row below: 4 options
  - Each card shows: flower name, small illustration area, emotional keyword
  - Card states: available, selected (moves to top/slot), unavailable (greyed, crossed if already 3 selected)
- Below cards: brief description of each flower's emotional association (from paper prototype)
- "Confirm Stock" button (disabled until exactly 3 selected)

**Interaction:**
- Click flower → animates into stock slot at top
- Click selected flower → returns to available
- Cannot select more than 3
- When 3 selected, remaining card shows as unavailable
- "Confirm Stock" → transition to Route Map

**Visual:**
- Selected flowers shown in slots at top
- Slots have subtle glow when filled
- Unselected flowers slightly dimmed but readable

**Transitions:**
- Stock Selection → Route Map: fade + forward

---

## Screen 3 — Route Map

**Purpose:** Show the planned route. This is where the player forms expectations.

**Layout:**
- Header: route name (e.g., "Morning Run")
- Simple visual: vertical or horizontal flow showing stops in order
  - Stop 1: The Quiet Pier
  - Stop 2: The Corner House
  - Stop 3: The Café Dock
  - Stop 4: The Old Bridge
- Each stop shown as small node/card
- Below the map: "Your flowers: [sunflower icon] [lavender icon] [wildflower icon]"
- "Begin Run" button

**Interaction:**
- Player studies the route against their stock
- "Begin Run" → first encounter

**Important:**
- The route map does NOT show customer types — only stop names and descriptions
- Player should think: "I have X flowers, I expect customers who need X, let's see if my bet was right"

**Transitions:**
- Route Map → Encounter 1: fade

---

## Screen 4 — Encounter (one per stop, ×4)

**Purpose:** The core moment. Player reads, suggests, sees consequence.

**Layout:**
- Stop name + brief atmospheric description at top (e.g., "The Quiet Pier — a small wooden dock, morning light on the water")
- Customer card in center:
  - What they say: shown in quote (e.g., "I just need something quick. I'm running late.")
  - Below: subtext (in different style — italic or softer color) — this is the hint
  - Below: cue description (e.g., "They're checking their watch. Standing on one foot.") — small, muted
- Below customer: 3 flower buttons (the flowers the player chose to stock)
  - Each button: flower name
  - "Suggest" label or player understands this is what they're doing
- Optional: "Let them choose" link/text (below flower buttons) — they pick from what's on the boat

**Interaction:**
- Player reads all three layers (what they say, subtext, cue)
- Player clicks a flower to suggest, OR clicks "let them choose"
- Outcome appears immediately (below or replacing the selection)

**Outcome display:**
- Brief text: customer's reaction (warm if right, neutral if literal, slightly off if wrong)
- One-line summary: "They found what they needed" / "They took the flower but..." / "Something didn't fit"
- "Continue" button → next encounter or end run summary

**Important notes:**
- Right/wrong is evaluative, not punitive. Wrong answers feel like "you tried" not "you failed."
- "Let them choose" always works — they pick something and the outcome reflects what they grabbed and why

**States per encounter:**
- Reading state (customer shown, no selection yet)
- Selected state (flower chosen, outcome hidden)
- Outcome state (reaction shown, "Continue" visible)

**Transitions:**
- Encounter → Encounter: fade
- Last Encounter → End Run Summary: fade

---

## Screen 5 — End Run Summary

**Purpose:** Compare plan vs. result. This is where the planning layer pays off.

**Layout:**
- Header: "Run Complete" or "Back to Dock"
- Summary of the run:
  - Flowers stocked: [icons/names]
  - Customers helped: X of 4
  - "Right flower, right person" moments: [list or count]
  - "They chose something else" moments: [list or count]
- Did plan match? One-line question: "Did you sell what you expected to sell?"
  - Player's answer shown (yes/no/mixed)
- "Play Again (same route)" button
- "New Run" button → returns to Departure

**Interaction:**
- Simple, clean display
- No scoring — just reflection

**Transitions:**
- Summary → Departure (New Run): fade back to start
- Summary → same route restart: quick reset

---

## UI Components

### Flower Card (in Stock Selection)
- States: available, selected, unavailable
- Shows: flower name, small illustration placeholder, one emotional keyword
- Available: full color, clickable
- Selected: in stock slot, slightly elevated shadow
- Unavailable: greyed, non-interactive

### Flower Button (in Encounter)
- States: default, hover, selected
- Shows: flower name only
- Default: outlined or subtle fill
- Hover: fill or glow
- Selected: triggers outcome

### Customer Card
- Not interactive — display only
- Three layers with distinct visual treatment:
  - What they say: regular text, quote marks
  - Subtext: italic or softer color
  - Cue: smaller, muted color, parenthetical or descriptive

### Outcome Toast/Screen
- Replaces or appears below customer card
- Shows: reaction text + one-line fit assessment
- Warm color if right, neutral if literal, slightly cool if wrong
- "Continue" button

### Stock Slot (top of Stock Selection)
- 3 slots shown horizontally
- Empty: dashed border, "?" or flower icon placeholder
- Filled: flower icon + name, subtle glow

---

## State Machine

```
DEPARTURE
  → select weather → WEATHER_SELECTED
  → select route → ROUTE_SELECTED
  → both selected → enable "Set Sail"
  → "Set Sail" → STOCK_SELECTION

STOCK_SELECTION
  → select flower (up to 3) → FLOWER_SELECTED (up to 3)
  → 3 selected → enable "Confirm Stock"
  → "Confirm Stock" → ROUTE_MAP

ROUTE_MAP
  → "Begin Run" → ENCOUNTER_1

ENCOUNTER (each)
  → read customer → customer_displayed
  → click flower OR "let them choose" → outcome_displayed
  → "Continue" → next ENCOUNTER or END_SUMMARY

END_SUMMARY
  → "Play Again" → ROUTE_MAP (reset encounters, same weather/route)
  → "New Run" → DEPARTURE (full reset)
```

---

## Data Structure

### Flowers
```javascript
const flowers = [
  { id: 'sunflower', name: 'Sunflower', keyword: 'Warmth', association: 'Warmth, joy, celebration' },
  { id: 'lavender', name: 'Lavender', keyword: 'Calm', association: 'Calm, relaxation, comfort' },
  { id: 'wildflower', name: 'Wildflower Mix', keyword: 'Surprise', association: 'Nostalgia, freedom, surprise' },
  { id: 'lily', name: 'White Lily', keyword: 'Renewal', association: 'Renewal, sincerity, grief' }
];
```

### Routes
```javascript
const routes = [
  { id: 'morning', name: 'Morning Run', description: 'Quiet, early customers', stops: ['quiet_pier', 'corner_house', 'cafe_dock', 'old_bridge'] },
  { id: 'afternoon', name: 'Afternoon Route', description: 'Busier, more variety', stops: ['...'] },
  { id: 'evening', name: 'Evening Cruise', description: 'Reflective, quieter', stops: ['...'] }
];
```

### Weather
```javascript
const weather = [
  { id: 'sunshine', name: 'Sunshine', description: 'Warm and bright' },
  { id: 'rain', name: 'Rain', description: 'Grey and soft' }
];
```

### Customers
```javascript
const customers = [
  {
    id: 'hurry',
    stop: 'quiet_pier',
    whatTheySay: '"I just need something quick. I\'m running late."',
    subtext: 'They feel guilty for not putting more thought into it.',
    cue: 'Checking their watch. Standing on one foot.',
    rightFlower: 'sunflower',
    reactions: {
      right: 'Warmth — they brighten immediately. "This is perfect."',
      literal: 'They take it. "Thanks." A beat too fast.',
      wrong: 'They accept it, but something doesn\'t land.'
    }
  },
  // ... The Griever, The Stuck, The Present
];
```

---

## What John Handles (Technical)

- HTML/JS rendering
- State machine implementation
- CSS transitions and animations (smooth, warm)
- Local state — no backend needed
- Card data (content from paper prototype, structured as above)

## What This Spec Handles (UX/Design)

- Screen layouts and flows
- Component states and visual treatments
- Interaction behaviors
- Transition styles
- Content structure and data schema (John fills in implementation details)

---

## Deferred (Not in V1 Prototype)

- Weather affecting which customers appear
- Route affecting customer distribution
- Multiple routes in one session
- Visual polish beyond functional UI
- Sound and ambient audio
- Art/illustration (placeholder text + icons acceptable for prototype)

---

**Canonical file:** `projects/flower-boat/prototype/digital-prototype-ux-spec.md`
