# Emotion Cards — Style Guide

**Document:** Design System & Style Guide  
**Version:** 1.0  
**Date:** March 17, 2026  
**Status:** Living Document

---

## Table of Contents

1. [Overview](#overview)
2. [Typography](#typography)
3. [Color System](#color-system)
4. [Spacing System](#spacing-system)
5. [Animation Guidelines](#animation-guidelines)
6. [Sound Design](#sound-design)
7. [Icon Library](#icon-library)
8. [Accessibility](#accessibility)

---

## 1. Overview

This style guide establishes the visual and auditory language for Emotion Cards. It ensures consistency across all UI elements while conveying the emotional depth of the game.

### Design Principles

| Principle | Description |
|-----------|-------------|
| **Emotional Authenticity** | Colors and animations should match the feeling they represent |
| **Cozy & Safe** | No jarring transitions; everything feels inviting |
| **Clarity First** | Information hierarchy must always be clear |
| **Accessibility** | Design for all players; never sacrifice inclusivity for aesthetics |

---

## 2. Typography

### 2.1 Font Stack

```css
/* Primary Font — UI & Body */
--font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;

/* Secondary Font — Headings & Emphasis */
--font-display: 'Fraunces', Georgia, serif;

/* Mono Font — Debug info, counters */
--font-mono: 'JetBrains Mono', 'Fira Code', monospace;
```

### 2.2 Type Scale

| Element | Font | Weight | Size | Line Height | Example |
|---------|------|--------|------|-------------|---------|
| **H1** (Page Title) | Display | 700 | 3rem (48px) | 1.2 | "Emotion Cards" |
| **H2** (Section) | Display | 600 | 2.25rem (36px) | 1.25 | "Your Deck" |
| **H3** (Card Name) | Primary | 600 | 1.5rem (24px) | 1.3 | "Twinge of Hope" |
| **Body** | Primary | 400 | 1rem (16px) | 1.6 | Card descriptions |
| **Caption** | Primary | 500 | 0.875rem (14px) | 1.4 | Stats, tooltips |
| **Label** | Primary | 600 | 0.75rem (12px) | 1.2 | Button text, tags |
| **Counter** | Mono | 500 | 1.125rem (18px) | 1 | Energy, card count |

### 2.3 Usage Examples

```css
/* Card Title */
.card-title {
    font-family: var(--font-primary);
    font-weight: 600;
    font-size: 1.5rem;
    line-height: 1.3;
    color: var(--neutral-900);
}

/* Section Header */
.section-header {
    font-family: var(--font-display);
    font-weight: 600;
    font-size: 2.25rem;
    line-height: 1.25;
    color: var(--neutral-800);
}

/* Stat Label */
.stat-label {
    font-family: var(--font-mono);
    font-weight: 500;
    font-size: 0.875rem;
    letter-spacing: 0.05em;
    text-transform: uppercase;
}
```

---

## 3. Color System

### 3.1 Emotion Families

Each family has a **primary**, **secondary**, and **accent** color that work together.

#### 🔥 Fire Family (Anger, Frustration, Passion, Determination)

```css
--fire-primary: #E85D04;      /* Warm orange-red */
--fire-secondary: #DC2F02;    /* Deep red */
--fire-accent: #FFBA08;       /* Bright yellow-gold */
--fire-light: #FFF3E0;        /* Light tint for backgrounds */
--fire-dark: #9D0208;          /* Dark shade for text/borders */
```

**Usage:** Aggressive cards, damage effects, energy indicators  
**Mood:** Intense, passionate, urgent

**Visual Example:**
```
┌─────────────────────────┐
│  ████████               │  ← fire-accent glow
│  FLAME STRIKE            │  ← fire-primary text
│  3 Energy  •  2 Damage   │  ← fire-secondary accent
│  [Fire Family: 3/4]      │  ← family indicator
└─────────────────────────┘
```

#### 🌊 Storm Family (Fear, Anxiety, Doubt, Uncertainty)

```css
--storm-primary: #4CC9F0;    /* Electric cyan */
--storm-secondary: #4361EE;  /* Deep blue */
--storm-accent: #7209B7;     /* Purple-violet */
--storm-light: #E0F4FF;      /* Light tint */
--storm-dark: #1A1A40;       /* Dark navy */
```

**Usage:** Defensive cards, status effects, uncertainty mechanics  
**Mood:** Unsettling, electric, shifting

#### 🌑 Shadow Family (Sadness, Grief, Melancholy, Longing)

```css
--shadow-primary: #6B705C;   /* Muted olive-gray */
--shadow-secondary: #3F4238; /* Deep forest */
--shadow-accent: #A5A58D;    /* Pale khaki */
--shadow-light: #F5F5F0;     /* Off-white tint */
--shadow-dark: #1C1C18;      /* Near-black */
```

**Usage:** Healing cards, reflection mechanics, loss-themed content  
**Mood:** Quiet, contemplative, gentle

#### ☀️ Warmth Family (Joy, Gratitude, Contentment, Love)

```css
--warmth-primary: #FFB703;   /* Golden yellow */
--warmth-secondary: #FB8500; /* Warm orange */
--warmth-accent: #FFEA00;    /* Bright yellow */
--warmth-light: #FFF8E1;     /* Cream tint */
--warmth-dark: #8B5A00;      /* Amber brown */
```

**Usage:** Healing, positive effects, reward animations  
**Mood:** Comforting, inviting, hopeful

### 3.2 Neutral Colors

```css
/* Grayscale */
--neutral-050: #FAFAFA;       /* Page background */
--neutral-100: #F5F5F5;       /* Card background */
--neutral-200: #E5E5E5;       /* Borders, dividers */
--neutral-300: #CCCCCC;       /* Disabled states */
--neutral-400: #999999;       /* Placeholder text */
--neutral-500: #666666;       /* Secondary text */
--neutral-600: #444444;       /* Body text */
--neutral-700: #333333;       /* Primary text */
--neutral-800: #1A1A1A;       /* Headings */
--neutral-900: #0D0D0D;       /* Page title */

/* Semantic Neutrals */
--surface-card: #FFFFFF;      /* Card surfaces */
--surface-elevated: #FFFFFF;  /* Modals, dropdowns */
--surface-overlay: rgba(0, 0, 0, 0.5); /* Modal backdrop */
```

### 3.3 Semantic Colors

```css
/* Game State */
--success: #2D6A4F;            /* Victory, completion */
--warning: #E9C46A;           /* Caution, low resources */
--danger: #E63946;            /* Danger, damage */
--info: #457B9D;              /* Information, tips */

/* UI Feedback */
--selected: #4CC9F0;          /* Current selection */
--hover: rgba(0, 0, 0, 0.05); /* Hover overlay */
--focus: #4361EE;             /* Focus ring */
```

### 3.4 Color Usage by Context

| Context | Primary | Secondary | Accent |
|---------|---------|-----------|--------|
| Card (Fire) | fire-primary | fire-secondary | fire-accent |
| Card (Storm) | storm-primary | storm-secondary | storm-accent |
| Card (Shadow) | shadow-primary | shadow-secondary | shadow-accent |
| Card (Warmth) | warmth-primary | warmth-secondary | warmth-accent |
| UI Buttons | neutral-700 | neutral-600 | warmth-primary |
| Disabled | neutral-400 | neutral-300 | — |

---

## 4. Spacing System

### 4.1 Base Unit

All spacing multiples of **4px**:

```css
--space-1: 4px;
--space-2: 8px;
--space-3: 12px;
--space-4: 16px;
--space-5: 20px;
--space-6: 24px;
--space-8: 32px;
--space-10: 40px;
--space-12: 48px;
--space-16: 64px;
--space-20: 80px;
```

### 4.2 Component Spacing

```css
/* Card Layout */
--card-padding: var(--space-4);
--card-gap: var(--space-3);
--card-border-radius: 12px;

/* Card Inner Elements */
--card-title-margin: var(--space-2);
--card-description-margin: var(--space-3);
--card-stats-gap: var(--space-2);
--card-family-badge-margin: var(--space-2);

/* Section Layout */
--section-padding: var(--space-8);
--section-gap: var(--space-6);

/* Grid */
--grid-gap: var(--space-4);
--grid-min-card-width: 200px;
```

### 4.3 Responsive Breakpoints

```css
/* Mobile First */
--breakpoint-sm: 640px;   /* Large phones */
--breakpoint-md: 768px;   /* Tablets */
--breakpoint-lg: 1024px;  /* Small laptops */
--breakpoint-xl: 1280px;  /* Desktops */
--breakpoint-2xl: 1536px; /* Large screens */
```

### 4.4 Card Dimensions

```css
/* Standard Card */
--card-width: 240px;
--card-height: 336px;  /* 5:7 ratio */
--card-aspect-ratio: 0.714;  /* width / height */

/* With padding (internal use) */
--card-content-width: calc(var(--card-width) - var(--card-padding) * 2);
--card-content-height: calc(var(--card-height) - var(--card-padding) * 2);
```

---

## 5. Animation Guidelines

### 5.1 Timing Functions

```css
--ease-instant: cubic-bezier(0, 0, 0, 1);
--ease-quick: cubic-bezier(0.25, 0.1, 0.25, 1);
--ease-normal: cubic-bezier(0.4, 0, 0.2, 1);
--ease-smooth: cubic-bezier(0.4, 0, 0.2, 1);    /* Default */
--ease-bounce: cubic-bezier(0.34, 1.56, 0.64, 1);
--ease-elastic: cubic-bezier(0.68, -0.55, 0.265, 1.55);
```

### 5.2 Durations

```css
--duration-instant: 0ms;
--duration-fast: 100ms;
--duration-normal: 200ms;
--duration-slow: 300ms;
--duration-slower: 500ms;
--duration-pause: 1000ms;
```

### 5.3 Card Animations

#### Card Hover (Lift Effect)

```css
.card:hover {
    transform: translateY(-8px) scale(1.02);
    transition: transform var(--duration-normal) var(--ease-smooth),
                box-shadow var(--duration-normal) var(--ease-smooth);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
}
```

#### Card Selection (Pulse)

```css
@keyframes card-pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

.card.selected {
    animation: card-pulse var(--duration-slow) var(--ease-bounce);
    box-shadow: 0 0 0 3px var(--focus);
}
```

#### Card Play (Fly to Center)

```css
@keyframes card-play {
    0% {
        transform: translateY(0) scale(1);
        opacity: 1;
    }
    50% {
        transform: translateY(-50vh) scale(0.8);
        opacity: 0.8;
    }
    100% {
        transform: translateY(-100vh) scale(0);
        opacity: 0;
    }
}

.card.playing {
    animation: card-play var(--duration-slower) var(--ease-instant) forwards;
}
```

### 5.4 Family-Specific Animations

#### Fire Family — Ignition

```css
@keyframes fire-ignite {
    0% { 
        filter: brightness(1);
        transform: scale(1);
    }
    50% { 
        filter: brightness(1.3);
        transform: scale(1.1);
        box-shadow: 0 0 20px var(--fire-primary);
    }
    100% { 
        filter: brightness(1);
        transform: scale(1);
    }
}

.card.fire:hover {
    animation: fire-ignite var(--duration-slow) var(--ease-bounce);
}
```

#### Storm Family — Shimmer

```css
@keyframes storm-shimmer {
    0%, 100% { 
        box-shadow: 0 0 0 rgba(76, 201, 240, 0);
    }
    50% { 
        box-shadow: 0 0 15px rgba(76, 201, 240, 0.5);
    }
}

.card.storm:hover {
    animation: storm-shimmer var(--duration-slower) var(--ease-smooth) infinite;
}
```

#### Shadow Family — Fade

```css
@keyframes shadow-float {
    0%, 100% { 
        transform: translateY(0);
        filter: brightness(1);
    }
    50% { 
        transform: translateY(-4px);
        filter: brightness(0.95);
    }
}

.card.shadow:hover {
    animation: shadow-float var(--duration-slower) var(--ease-smooth);
}
```

#### Warmth Family — Glow

```css
@keyframes warmth-glow {
    0%, 100% { 
        box-shadow: 0 4px 12px rgba(255, 183, 3, 0.2);
    }
    50% { 
        box-shadow: 0 4px 20px rgba(255, 183, 3, 0.4);
    }
}

.card.warmth:hover {
    animation: warmth-glow var(--duration-slower) var(--ease-smooth) infinite;
}
```

### 5.5 UI Transitions

#### Button Hover

```css
.button {
    transition: background-color var(--duration-fast) var(--ease-quick),
                transform var(--duration-fast) var(--ease-quick),
                box-shadow var(--duration-fast) var(--ease-quick);
}

.button:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}
```

#### Modal Open (Fade + Scale)

```css
@keyframes modal-open {
    0% {
        opacity: 0;
        transform: scale(0.95) translateY(10px);
    }
    100% {
        opacity: 1;
        transform: scale(1) translateY(0);
    }
}

.modal {
    animation: modal-open var(--duration-normal) var(--ease-bounce);
}
```

---

## 6. Sound Design

### 6.1 Sound Categories

| Category | Purpose | Examples |
|----------|---------|----------|
| **UI** | Menu navigation, button clicks | Click, hover, success, error |
| **Card** | Drawing, playing, discarding | Card flip, card place, shuffle |
| **Combat** | Attacks, defenses, effects | Fire crackle, wind howl, healing chime |
| **Ambient** | Background atmosphere | Forest, fireplace, rain |
| **Music** | Emotional themes per family | Per-family leitmotifs |

### 6.2 UI Sounds

```css
/* Recommended sounds */
--sound-ui-click: 'ui_click_soft.wav';      /* Button press */
--sound-ui-hover: 'ui_hover_soft.wav';       /* Button hover */
--sound-ui-success: 'ui_success_chime.wav'; /* Positive action */
--sound-ui-error: 'ui_error_soft.wav';      /* Invalid action */
--sound-ui-card-hover: 'card_hover.wav';    /* Card highlight */
```

**Implementation:**
```javascript
// Audio manager interface
const AudioManager = {
    play: (soundId, options = {}) => {
        const volume = options.volume ?? 1.0;
        const pitch = options.pitch ?? 1.0;
        const position = options.position ?? 'center';
        // Play sound with parameters
    },
    
    playCardHover: () => play('ui-card-hover', { volume: 0.3 }),
    playCardPlay: () => play('card-play', { volume: 0.8 })
};
```

### 6.3 Family-Specific Sounds

#### Fire Family

| Sound | Description | Mood |
|-------|-------------|------|
| `fire-ignite` | Whoosh + crackle | Intense |
| `fire-play` | Roaring burst | Aggressive |
| `fire-draw` | Spark + flare | Energetic |

#### Storm Family

| Sound | Description | Mood |
|-------|-------------|------|
| `storm-charge` | Electric hum building | Tension |
| `storm-play` | Thunder crack | Unsettling |
| `storm-draw` | Wind whistle | Shifting |

#### Shadow Family

| Sound | Description | Mood |
|-------|-------------|------|
| `shadow-appear` | Soft fade-in | Gentle |
| `shadow-play` | Whisper + sigh | Melancholy |
| `shadow-draw` | Soft rustle | Quiet |

#### Warmth Family

| Sound | Description | Mood |
|-------|-------------|------|
| `warmth-appear` | Gentle bell | Comforting |
| `warmth-play` | Harmonic chime | Positive |
| `warmth-draw` | Light sparkle | Joyful |

### 6.4 Ambient Sounds

```css
/* Layered ambient system */
--ambient-base: 'ambient_soft_pad.wav';     /* Always playing */
--ambient-weather: 'ambient_rain_soft.wav'; /* Contextual */
--ambient-fireside: 'ambient_crackle.wav';  /* Story mode */

/* Volume levels */
--ambient-base-volume: 0.2;
--ambient-layer-volume: 0.15;
--ambient-max-volume: 0.3;
```

### 6.5 Music Guidelines

```css
/* Each family has a leitmotif */
/* Tempo: 80-100 BPM (calm, not rushed) */
/* Key: Emotional minor / major as appropriate */

/* Music transitions */
--music-fade-duration: 2000ms;  /* Crossfade between themes */
--music-intro-duration: 3000ms; /* Track buildup */
```

---

## 7. Icon Library

### 7.1 Icon Requirements

**Format:** SVG (scalable)  
**Style:** Line icons with 2px stroke, rounded caps  
**Sizes:** 16px, 24px, 32px, 48px  
**Colors:** Inherit from parent or use neutral-600

### 7.2 Required Icons

#### Action Icons

| Icon | Usage | Design |
|------|-------|--------|
| ⚔️ Attack | Damage cards | Sword crossing |
| 🛡️ Defend | Shield block | Shield outline |
| 💚 Heal | Restore health | Heart with + |
| 🎯 Draw | Draw cards | Arrow into deck |
| ⚡ Energy | Resource | Lightning bolt |
| 🔄 Transform | Transmute | Arrows in circle |

#### Emotion Family Icons

| Family | Icon | Description |
|--------|------|-------------|
| Fire | 🔥 | Flame |
| Storm | ⚡ | Lightning bolt |
| Shadow | 🌑 | Crescent moon |
| Warmth | ☀️ | Sun with rays |

#### UI Icons

| Icon | Name | Usage |
|------|------|-------|
| ≡ | Menu | Navigation |
| × | Close | Close modal |
| ? | Help | Tooltip trigger |
| ⭐ | Favorite | Bookmark |
| 📊 | Stats | Statistics view |

### 7.3 Icon System Implementation

```css
.icon {
    width: var(--icon-size, 24px);
    height: var(--icon-size, 24px);
    stroke: currentColor;
    stroke-width: 2px;
    stroke-linecap: round;
    stroke-linejoin: round;
    fill: none;
    transition: stroke var(--duration-fast);
}

.icon-sm { --icon-size: 16px; }
.icon-md { --icon-size: 24px; }
.icon-lg { --icon-size: 32px; }
.icon-xl { --icon-size: 48px; }
```

```html
<!-- Usage -->
<svg class="icon icon-md">
    <use href="/assets/icons/action/attack.svg#icon" />
</svg>
```

### 7.4 Custom Family Icons

```css
/* Fire */
.icon-fire {
    stroke: var(--fire-primary);
    filter: drop-shadow(0 0 4px var(--fire-accent));
}

/* Storm */
.icon-storm {
    stroke: var(--storm-primary);
    animation: icon-pulse 2s ease-in-out infinite;
}

/* Shadow */
.icon-shadow {
    stroke: var(--shadow-primary);
    opacity: 0.8;
}

/* Warmth */
.icon-warmth {
    stroke: var(--warmth-primary);
    filter: drop-shadow(0 0 6px var(--warmth-accent));
}
```

---

## 8. Accessibility

### 8.1 Color Contrast

```css
/* WCAG 2.1 AA Compliance */
--contrast-ratio-large: 3.0;  /* 18pt+ text, icons */
--contrast-ratio-normal: 4.5; /* Normal text */

/* Ensure text on colored backgrounds passes */
.card-fire { color: #FFFFFF; }  /* Dark on fire-primary */
.card-storm { color: #FFFFFF; } /* Dark on storm-secondary */
.card-shadow { color: #FFFFFF; } /* Light on shadow-dark */
.card-warmth { color: #1A1A1A; } /* Dark on warmth-primary */
```

**Verification:**
- All text ≥ 4.5:1 contrast ratio
- Large text (18pt+) ≥ 3:1
- Interactive elements have visible focus states
- Color is never the only indicator of state

### 8.2 Focus Management

```css
/* Visible focus indicator */
:focus-visible {
    outline: 3px solid var(--focus);
    outline-offset: 2px;
    border-radius: 4px;
}

/* Skip link for keyboard navigation */
.skip-link {
    position: absolute;
    top: -40px;
    left: 0;
    background: var(--focus);
    color: white;
    padding: 8px;
    z-index: 100;
}

.skip-link:focus {
    top: 0;
}
```

### 8.3 Screen Reader Support

```html
<!-- Card with proper labeling -->
<article class="card fire" aria-labelledby="card-title-1" aria-describedby="card-desc-1">
    <h3 id="card-title-1">Flame Strike</h3>
    <p id="card-desc-1">Deal 2 damage. If Fire family: deal 1 additional.</p>
    <div class="card-stats" role="group" aria-label="Card statistics">
        <span>⚡ 3 Energy</span>
        <span>⚔️ 2 Damage</span>
    </div>
    <span class="family-badge" aria-label="Fire family">🔥 Fire</span>
</article>
```

### 8.4 Reduced Motion

```css
@media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
    }
}
```

### 8.5 Keyboard Navigation

```javascript
// Card selection with keyboard
document.querySelectorAll('.card').forEach(card => {
    card.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            card.classList.toggle('selected');
        }
    });
});
```

### 8.6 Accessibility Checklist

- [ ] All images have alt text
- [ ] Color contrast passes WCAG AA
- [ ] Focus states visible on all interactive elements
- [ ] Forms have proper labels
- [ ] No content relies solely on color
- [ ] Reduced motion preference respected
- [ ] Screen reader navigation logical
- [ ] Error messages are descriptive
- [ ] Text scalable to 200%

---

## Appendix: Quick Reference

### CSS Variables Summary

```css
/* Fonts */
--font-primary, --font-display, --font-mono

/* Spacing */
--space-1 through --space-20

/* Timing */
--duration-fast, --duration-normal, --duration-slow
--ease-quick, --ease-smooth, --ease-bounce

/* Families */
--fire-primary/secondary/accent/light/dark
--storm-primary/secondary/accent/light/dark
--shadow-primary/secondary/accent/light/dark
--warmth-primary/secondary/accent/light/dark

/* Neutrals */
--neutral-050 through --neutral-900
--surface-card, --surface-elevated
```

---

**Document Version:** 1.0  
**Last Updated:** March 17, 2026  
**Maintainer:** Yoshi 🎨  
**Next Review:** With major feature releases