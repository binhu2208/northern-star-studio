# Emotion Cards — Launch Rollout Checklist

**Game:** Emotion Cards  
**Owner:** Gabe 📊  
**Branch target:** `release/v0.5.0`  
**Status:** Execution checklist

This checklist is meant to be the simple operational companion to the broader launch planning docs. Use it to confirm what must happen before launch, on launch day, and through the first week after release.

---

## Rollout Owners

| Area | Primary owner | Support | Notes |
|---|---|---|---|
| Launch calendar, messaging, social rollout | Gabe | Shig | Final marketing coordination and public-facing checklist ownership |
| Release readiness, cross-team go/no-go | Shig | John, Gabe | Confirms timing, escalation path, and launch-day coordination |
| Build stability, hotfix readiness, bug triage | John | Sakura | Owns build, release branch health, and emergency fixes |
| Store setup, pricing, discount, live publish steps | Bin | Gabe, Shig | Steamworks/manual platform steps and final approvals |
| Trailer, key art, capsules, screenshots, social visuals | Yoshi | Gabe | Final asset exports and visual consistency |
| Gameplay framing, feature accuracy, beginner-facing clarity | Hideo | Gabe | Reviews public descriptions so marketing stays accurate |
| QA smoke test, known issues, player confusion flags | Sakura | John | Validates launch build and flags likely friction points |
| Community moderation, FAQ, response routing | Gabe | Sakura, Shig | Discord/support messaging and escalation routing |

---

## Key Dependencies

### Must be locked before launch
- [ ] Final launch date/time confirmed
- [ ] Steam page copy, screenshots, capsules, trailer, and pricing approved
- [ ] Stable release candidate build available for final smoke test
- [ ] Known issues list reviewed and ready for public/internal use
- [ ] Launch messaging approved: one-line pitch, CTA, channel copy
- [ ] Press kit and outreach links verified
- [ ] Community support path ready: where bugs, questions, and feedback go
- [ ] Launch-day owners know who is on point for each window

### Helpful companion docs
- `docs/marketing/launch-campaign-plan.md`
- `docs/marketing/launch-assets-plan.md`
- `docs/marketing/launch-outreach-plan.md`
- `docs/release/v0.5.0-release-tracker.md`

---

## Pre-Launch Checklist

### 1) Launch readiness and approvals
- [ ] Confirm launch date/time with Shig and Bin
- [ ] Confirm `release/v0.5.0` is the active branch for launch deliverables
- [ ] Confirm go/no-go criteria with John and Sakura
- [ ] Confirm final approval path for any last-minute asset or copy changes
- [ ] Confirm launch-day coverage windows so no key period is unattended

### 2) Product and store readiness
- [ ] Final build passes basic smoke test
- [ ] No known blocker bugs remain open
- [ ] Release notes draft updated with player-facing highlights
- [ ] Known issues list reviewed and phrased clearly
- [ ] Steam page short description clearly states the hook
- [ ] Store screenshots are current, varied, and readable
- [ ] Trailer is final and uploaded correctly
- [ ] Price and any launch discount are set correctly
- [ ] Store tags/categories checked for accuracy

### 3) Marketing assets and message lock
- [ ] Finalize the core positioning line: narrative roguelike deckbuilder + emotion-based strategy
- [ ] Lock launch CTA language for pre-launch and live launch states
- [ ] Prepare launch announcement copy for Steam, Discord, X/Twitter, TikTok, YouTube, and press
- [ ] Export launch-day asset pack: trailer, clips, screenshots, quote card template, key art
- [ ] Prepare backup static assets in case video upload or trailer timing slips
- [ ] Verify all links point to the correct Steam/store destination

### 4) Outreach and creator/press prep
- [ ] Send final reminder to warm press/creator contacts who asked for launch timing
- [ ] Confirm which creators are targeting launch day vs launch week
- [ ] Verify press kit contents and download links
- [ ] Prepare a concise “out now” press note for launch day
- [ ] Prepare fallback “in case you missed it” note for later in the week

### 5) Community and support prep
- [ ] Prepare Discord announcement copy and pinned support links
- [ ] Prepare FAQ answers for likely confusion points
- [ ] Confirm where bug reports should be filed and who triages them
- [ ] Prepare a polite review-request message for after first-session play
- [ ] Prepare first-week community prompts: favorite card, first run, screenshots, strategy tips

### 6) Internal operating prep
- [ ] Assign live owners for store checks, community checks, and coverage monitoring
- [ ] Prepare a launch-day tracker for links, reactions, issues, and follow-ups
- [ ] Confirm escalation path for critical issues: John -> Shig -> Gabe/Bin as needed
- [ ] Confirm fallback decision owner if launch conditions degrade

---

## Launch Day Checklist

### 1) Before going live
- [ ] Reconfirm launch timing and time zone
- [ ] Verify Steam page, price, discount, screenshots, trailer, and copy are correct
- [ ] Verify live links for press kit, trailer, and store page
- [ ] Reconfirm launch posts are loaded and final
- [ ] Reconfirm support coverage windows and response owners
- [ ] Reconfirm hotfix path if a blocker appears after release

### 2) At launch
- [ ] Confirm the game is live on Steam/store as expected
- [ ] Publish Steam launch announcement
- [ ] Publish Discord launch post and support routing message
- [ ] Publish launch posts across planned social channels
- [ ] Send launch-day press/creator “out now” note to engaged contacts
- [ ] Share the launch trailer and strongest short-form clip set
- [ ] Begin monitoring replies, questions, bugs, and broken links immediately

### 3) First 2–6 hours
- [ ] Check for pricing mistakes, broken store assets, or missing media
- [ ] Amplify creator posts, articles, clips, and streams that go live
- [ ] Log early reactions, useful quotes, and recurring questions
- [ ] Route urgent player issues to John/Sakura quickly
- [ ] Update messaging if a repeated confusion point appears
- [ ] Post at least one follow-up community prompt to keep the game feeling active

### 4) End of day wrap-up
- [ ] Summarize launch-day results: coverage, community activity, issues, next actions
- [ ] Capture which channels/content types performed best
- [ ] Confirm whether fallback beats are needed for day two
- [ ] Prepare next-day social proof post using real coverage or player response
- [ ] Update the release tracker with any known day-one problems

---

## First-Week Checklist

### Day 2–3
- [ ] Share real player reactions, screenshots, clips, or review quotes
- [ ] Post beginner-friendly strategy/support content
- [ ] Follow up with warm contacts who wanted a live reminder
- [ ] Keep Discord/support channels active and responsive
- [ ] Track recurring issues and decide whether a hotfix/update post is needed
- [ ] Watch wishlist-to-purchase and community engagement signals if available

### Day 4–5
- [ ] Run a light “in case you missed it” beat for press/creators who are slower to publish
- [ ] Publish a roundup of creator coverage or community highlights
- [ ] Re-share strongest-performing clips with a cleaner post angle if needed
- [ ] Review whether the store page top section is converting clearly enough
- [ ] Decide whether to lead with social proof, update messaging, or discovery framing next

### Day 6–7
- [ ] Prompt for reviews from active players in a respectful way
- [ ] Share a week-one thank-you/update message if appropriate
- [ ] Publish bug-fix or quality-of-life update messaging if changes shipped
- [ ] Collect lessons from launch week: what landed, what stalled, what needs correction
- [ ] Prepare a second-wave beat if launch day was soft
- [ ] Hand off durable follow-up items to the longer post-launch plan

---

## Owners and Dependencies by Phase

## Pre-launch
- **Primary owner:** Gabe
- **Critical dependencies:** final assets from Yoshi, final build from John, QA verification from Sakura, launch date/store approval from Bin, go/no-go alignment from Shig
- **Blocked if:** build is unstable, store page is incomplete, trailer/assets slip, or launch messaging is not approved

## Launch day
- **Primary owner:** Shig for coordination, Gabe for external rollout
- **Critical dependencies:** live store status, stable build, approved copy/assets, active monitoring coverage, support path ready
- **Blocked if:** game does not go live correctly, pricing/store assets are wrong, or a blocker bug forces a hold

## First week
- **Primary owner:** Gabe for marketing/community follow-through
- **Critical dependencies:** active issue triage from John/Sakura, continued approvals from Shig/Bin as needed, fresh social proof from live player activity or creator coverage
- **Blocked if:** unresolved technical issues dominate player sentiment or no one owns follow-up beats after launch day

---

## Risk Notes and Fallback Actions

### Risk: launch build has a visible issue or blocker
**Warning signs**
- repeated bug reports immediately after launch
- broken progression/combat flow
- creators/reporters flag technical issues first

**Fallback actions**
- pause nonessential promotional pushes until the issue is understood
- publish a calm acknowledgement if players are impacted
- route issue ownership to John immediately and log workaround/ETA if available
- shift messaging from “celebration” to “active support” until stable

### Risk: store page or pricing is wrong at launch
**Warning signs**
- broken trailer, wrong screenshots, incorrect discount, incorrect live status

**Fallback actions**
- treat as top-priority operational fix with Bin + Gabe
- stop driving paid/earned attention to a broken page until corrected
- re-post corrected links/status once fixed
- extend launch-day posting cadence slightly if the issue ate the first visibility window

### Risk: creator/press pickup is lighter than expected
**Warning signs**
- few launch-day posts go live
- inbox response stays low
- social proof is too thin to reuse by day two

**Fallback actions**
- activate backup creator and smaller fast-turnaround outreach
- lead with strongest differentiator: emotional strategy + narrative consequence
- use an “in case you missed it” beat later in the week
- repurpose any authentic player reactions into proof content quickly

### Risk: messaging is unclear or players misunderstand the hook
**Warning signs**
- players confuse the game’s genre or tone
- the same FAQ shows up repeatedly
- social posts get attention but poor click intent

**Fallback actions**
- simplify the one-line pitch across all channels
- swap to clearer clips/screenshots that show card play and outcomes fast
- pin FAQ/support messaging in Discord and update store/community descriptions if needed
- stop using softer copy that hides the deckbuilder angle

### Risk: launch momentum fades after day one
**Warning signs**
- no fresh posts after launch day
- community goes quiet
- coverage exists but is not being amplified

**Fallback actions**
- schedule a day-2 social proof beat immediately
- publish community prompts and highlight player stories/screenshots
- share a quick update, strategy tip, or coverage roundup
- shift to a “still worth checking out” discovery beat instead of repeating the same launch post

---

## Go / No-Go Snapshot

### Go if
- [ ] Build is stable enough for public play
- [ ] Store page is accurate and complete
- [ ] Messaging and assets are approved
- [ ] Launch-day owners are assigned and reachable
- [ ] Known issues and support routing are ready

### Hold if
- [ ] A blocker bug affects the core play loop
- [ ] Store/publish setup is incorrect or incomplete
- [ ] The team does not have active coverage for launch-day monitoring
- [ ] A major asset/copy problem would materially misrepresent the game

---

*Owner: Gabe / Marketing*  
*Recommended use: keep this open alongside the release tracker during the final 72 hours before launch and through the first week.*
