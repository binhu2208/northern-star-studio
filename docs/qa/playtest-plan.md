# Playtest Plan: Emotion Cards
**Task:** QA-001  
**Project:** Emotion Cards — Roguelike Deckbuilder  
**Author:** Sakura 🔍  
**Date:** March 14, 2026  
**Due:** March 19, 2026

---

## 1. Overview

This playtest plan defines metrics, methodologies, and success criteria for validating "fun" in Emotion Cards — a roguelike deckbuilder where cards represent feelings and memories.

**Core Question:** Does the emotion card mechanic create engaging, meaningful gameplay?

---

## 2. Playtest Objectives

### Primary Goals
1. Validate the "fun factor" of the emotion card mechanic
2. Measure learning curve and accessibility
3. Assess emotional engagement with the narrative/theme
4. Identify friction points in core gameplay loop

### Success Criteria
- **Fun Rating:** ≥ 7/10 average from target players
- **Learning Curve:** Players understand core mechanics within 15 minutes
- **Emotional Engagement:** ≥ 60% of players report connection to card themes
- **Session Completion:** ≥ 70% of players complete a full run (win or lose)

---

## 3. Target Testers

### Primary Audience (Cozy Roguelike Players)
- **Demographic:** Ages 18-35, all genders
- **Experience:** Played at least 2 roguelikes (Slay the Spire, Monster Train, etc.)
- **Interest:** Enjoys narrative-driven games and deckbuilders
- **Sample Size:** 20-30 players for quantitative data

### Secondary Audience (New to Roguelikes)
- **Experience:** Limited or no roguelike experience
- **Purpose:** Validate accessibility for genre newcomers
- **Sample Size:** 10-15 players

### Recruitment Strategy
1. **Discord communities:** r/roguelikes, Slay the Spire, cozy gaming servers
2. **Reddit:** r/gamedev, r/playmygame, r/deckbuilders
3. **Personal networks:** Friends/family who match target demographic
4. **Incentives:** Game key on release, name in credits, early access

---

## 4. Metrics Framework

### 4.1 Fun Metrics

| Metric | Method | Target | Measurement |
|--------|--------|--------|-------------|
| Overall Fun | Post-session survey (1-10) | ≥ 7.0 | Average score |
| "One More Run" | Survey: "Want to play again?" | ≥ 75% Yes | Percentage |
| Core Loop Satisfaction | Survey: Combat/deckbuilding fun | ≥ 7.0 | Average score |
| Emotional Resonance | Survey: Connection to card themes | ≥ 6.5 | Average score |

### 4.2 Learning Curve Metrics

| Metric | Method | Target | Measurement |
|--------|--------|--------|-------------|
| Time to First Victory | Analytics tracking | ≤ 3 runs | Median runs |
| Tutorial Completion | Analytics | ≥ 90% | Percentage |
| Confusion Points | Observation + survey | ≤ 2 major | Count |
| Help Requests | Support tickets/DM | ≤ 5 total | Count |

### 4.3 Engagement Metrics

| Metric | Method | Target | Measurement |
|--------|--------|--------|-------------|
| Session Length | Analytics | 20-45 min | Average |
| Runs per Session | Analytics | ≥ 2 | Average |
| Cards Unlocked | Analytics | ≥ 15 unique | Per player |
| Narrative Choices | Analytics | ≥ 3 per run | Average |

### 4.4 Emotional Engagement Metrics

| Metric | Method | Target | Measurement |
|--------|--------|--------|-------------|
| Card Theme Recall | Post-session: "Favorite card?" | ≥ 80% recall | Percentage |
| Emotional Connection | Survey: "Felt something?" | ≥ 60% Yes | Percentage |
| Narrative Interest | Survey: Story engagement | ≥ 7.0 | Average score |
| Memory Association | Open response: Card memories | Thematic alignment | Qualitative |

---

## 5. Playtest Sessions

### 5.1 Session Structure

**Duration:** 45-60 minutes  
**Format:** Remote (Discord/Zoom) or async (written feedback)

**Flow:**
1. **Pre-session (5 min):** Demographics, experience survey
2. **Gameplay (30-45 min):** Unstructured play, observe
3. **Post-session (10-15 min):** Survey + interview

### 5.2 Observation Protocol

**Watch For:**
- Confusion moments (pauses, misclicks, reading help)
- Emotional reactions (laughs, frustration, surprise)
- Strategic depth (planning moves, combo recognition)
- Narrative engagement (reading card text, story choices)

**Note Taking:**
- Timestamp key moments
- Quote player reactions verbatim
- Screenshot interesting plays (with permission)

---

## 6. Survey Instruments

### 6.1 Pre-Session Survey

```
1. Age: [18-24] [25-34] [35-44] [45+]
2. Roguelike experience: [None] [1-2 games] [3-5 games] [6+ games]
3. Favorite roguelike: ___________
4. Deckbuilder experience: [None] [Casual] [Regular] [Expert]
5. Interest in narrative games: [Low] [Medium] [High]
```

### 6.2 Post-Session Survey

```
1. Overall fun (1-10): ___
2. Would play again? [Yes] [Maybe] [No]
3. Combat satisfaction (1-10): ___
4. Deckbuilding satisfaction (1-10): ___
5. Emotion card mechanic clarity (1-10): ___
6. Connection to card themes (1-10): ___
7. Story engagement (1-10): ___
8. Difficulty: [Too Easy] [Just Right] [Too Hard]
9. Most confusing moment: ___________
10. Favorite card: ___________
11. One thing to change: ___________
12. One thing to keep: ___________
```

### 6.3 Interview Questions (Optional)

- "Tell me about a moment that stood out."
- "How did the emotion cards feel different from other deckbuilders?"
- "Did any card make you feel something? Which one?"
- "What would make you recommend this to a friend?"

---

## 7. Testing Phases

### Phase 1: Internal Testing (Week 1-2)
- **Testers:** Team members, close friends
- **Focus:** Basic functionality, obvious bugs
- **Deliverable:** Hotfix list, initial fun score

### Phase 2: Friends & Family (Week 3)
- **Testers:** 5-10 trusted players
- **Focus:** Learning curve, first impressions
- **Deliverable:** Refined tutorial, balance tweaks

### Phase 3: Target Audience (Week 4-5)
- **Testers:** 20-30 recruited players
- **Focus:** Fun validation, emotional engagement
- **Deliverable:** Full metrics report, recommendations

### Phase 4: Stress Test (Week 6)
- **Testers:** 10+ concurrent players
- **Focus:** Stability, edge cases
- **Deliverable:** Bug fixes, performance optimization

---

## 8. Success Criteria Summary

| Category | Metric | Target | Priority |
|----------|--------|--------|----------|
| **Fun** | Overall rating | ≥ 7/10 | 🔴 Critical |
| **Fun** | "One more run" | ≥ 75% | 🔴 Critical |
| **Learning** | Time to first win | ≤ 3 runs | 🟡 High |
| **Learning** | Tutorial completion | ≥ 90% | 🟡 High |
| **Engagement** | Session length | 20-45 min | 🟡 High |
| **Emotional** | Theme connection | ≥ 60% | 🟢 Medium |
| **Emotional** | Card recall | ≥ 80% | 🟢 Medium |

**Release Blockers:** Any 🔴 metric below target requires iteration before launch.

---

## 9. Reporting

### Weekly Reports
- Tester count and demographics
- Key metrics trends
- Top 3 issues/feedback themes
- Action items for next week

### Final Report (March 19)
- Complete metrics analysis
- Player quotes and stories
- Recommendations for launch
- Risk assessment

---

## 10. Tools & Resources

### Analytics
- **Game analytics:** Unity Analytics or GameAnalytics
- **Survey tool:** Google Forms or Typeform
- **Session recording:** OBS (with consent)

### Recruitment
- Discord server for tester community
- Google Form for sign-ups
- Email list for updates

### Documentation
- Tester NDA (if needed)
- Bug report template
- Feedback submission form

---

## 11. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Low tester recruitment | High | Start early, offer incentives |
| Biased feedback (friends) | Medium | Weight target audience higher |
| Negative early feedback | Medium | Iterate fast, retest quickly |
| Technical issues | High | Internal testing first |
| Scope creep | Medium | Stick to defined metrics |

---

## 12. Next Steps

1. **March 15:** Finalize build for testing
2. **March 16:** Begin recruitment
3. **March 17-18:** Conduct playtest sessions
4. **March 19:** Compile report and recommendations

---

**Status:** In Progress  
**Next Update:** March 15 (recruitment status)

*Prepared by Sakura 🔍 for NorthernStar Studio*
