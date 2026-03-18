# Launch Day Support Monitoring — Emotion Cards

**Task:** QA-005  
**Owner:** Sakura (QA)  
**Release Branch:** `release/v0.5.0`  
**Launch Day:** August 18, 2026  
**Primary Goal:** Catch player-facing issues fast, separate true blockers from noise, and hand off clear, actionable fixes to the right owner without slowing launch communications.

---

## 1. Scope

This checklist covers the first 24 hours of launch support for **Emotion Cards**.

It focuses on:
- monitoring inbound player issues and launch-day friction
- triaging severity quickly and consistently
- escalating blockers to production and development
- keeping marketing/community responses aligned with actual issue status
- handing off reproducible bugs for follow-up patch work

This document does **not** replace:
- `docs/qa/playtest-plan.md` for pre-launch QA goals and reporting
- `docs/marketing/steam-page-setup.md` for store-page launch checks
- `docs/marketing/press-outreach-plan.md` for press and creator response workflows

---

## 2. Launch-Day Coverage Window

### Core monitoring window
- **T-60 min to T+4 hrs:** continuous monitoring
- **T+4 hrs to T+12 hrs:** check every 30-60 minutes
- **T+12 hrs to T+24 hrs:** check every 2-3 hours, or faster if active incidents exist

### Recommended active roles
- **Sakura (QA):** intake triage, severity assignment, repro capture, QA summary updates
- **John (Programming):** technical investigation, fixes, build risk assessment
- **Gabe (Marketing):** community messaging, storefront/social announcement alignment
- **Shig (Producer):** escalation owner, go/no-go decisions for hotfixes, cross-team coordination
- **Bin:** final owner for external platform/account actions if a manual storefront or publishing step is required

---

## 3. Issue Intake Sources

Monitor these sources in priority order.

| Priority | Source | What to look for | Owner watching |
|----------|--------|------------------|----------------|
| P1 | Discord community server | crash reports, softlocks, install failures, repeated confusion, save-loss claims | Sakura + Gabe |
| P1 | Steam store page / community hub / reviews | negative review spikes, launch access complaints, pricing/region issues, controller/performance complaints | Sakura + Gabe |
| P1 | Internal team channel / direct reports | confirmed repro cases, build regressions, publishing mistakes | Sakura |
| P2 | Support email or contact form | detailed player bug reports with hardware/context | Sakura |
| P2 | Press / creator replies | review-build problems, missing keys, broken launch build links | Gabe |
| P3 | Social mentions (X/Twitter, TikTok, YouTube comments) | recurring public complaints worth verifying | Gabe, escalated to Sakura if technical |

### Intake rule
If the same complaint appears in **2+ independent places** within a short window, treat it as a likely pattern instead of a one-off report.

---

## 4. Triage Fields For Every Report

Capture the following before escalation whenever possible:
- **Source:** Discord / Steam / email / internal / creator
- **Timestamp**
- **Reporter handle or link**
- **Build/version** if known
- **Platform:** Windows / Steam Deck / other target device
- **Severity:** Critical / High / Medium / Low
- **Category:** crash, softlock, save, input, performance, store/publishing, balance, UX confusion, content typo
- **Repro status:** unknown / intermittent / reproducible
- **Repro steps**
- **Attachments:** screenshot, video, logs, save file
- **Current owner:** Sakura / John / Gabe / Shig / Bin
- **Player-facing response needed:** yes / no

### Fast logging template
```md
- Time:
- Source:
- Reporter:
- Platform/build:
- Summary:
- Severity:
- Repro:
- Evidence:
- Owner:
- Next action:
```

---

## 5. Severity and Escalation Rules

### Critical — immediate escalation
Use **Critical** if any issue:
- prevents players from launching or buying the game correctly
- causes frequent crashes in normal play
- creates a progression blocker or softlock with no clear workaround
- risks save corruption or save loss
- ships the wrong build / missing content / broken storefront state
- creates a major public trust risk during the launch window

**Action:**
- escalate to **John + Shig immediately**
- notify **Gabe** if public messaging or expectation-setting is required
- open/update a single incident thread instead of scattering reports
- check whether a workaround exists and document it clearly
- begin 15-minute status updates until stabilized

### High — same-block response window
Use **High** if any issue:
- significantly harms first-session experience but does not fully block progress
- affects a meaningful player segment (for example common hardware or controller path)
- causes severe performance drops, broken controls, unreadable UI, or major tutorial confusion
- produces a visible wave of public complaints likely to hurt sentiment/reviews

**Action:**
- escalate to **John within 30 minutes**
- notify **Shig** in next status update, sooner if trend is growing
- prepare approved player-facing acknowledgment if issue is public

### Medium — monitor and batch
Use **Medium** if any issue:
- has a workaround
- affects edge cases or uncommon flows
- is a bug but not a launch-risk bug
- reflects repeated UX confusion that may need messaging rather than code

**Action:**
- log it
- batch similar reports together
- include in hourly summary
- assign owner by category

### Low — backlog / after launch rush
Use **Low** for:
- isolated typos
- cosmetic issues
- minor balance concerns
- one-off feedback without repro or pattern

**Action:**
- log for follow-up
- do not interrupt active launch support unless it escalates into a pattern

---

## 6. Escalation Matrix

| Issue type | First escalation | Secondary escalation | Notes |
|------------|------------------|----------------------|-------|
| Crash / softlock / save issue | John | Shig | Highest technical priority |
| Store page not live / wrong pricing / broken purchase path | Bin | Shig + Gabe | Manual platform action may be required |
| Review/key/access problem for press or creators | Gabe | Shig | Keep outbound messaging consistent |
| Major community confusion or FAQ gap | Gabe | Sakura | May need pinned response instead of code change |
| Repeated negative player reports without confirmed repro | Sakura | John | QA verifies pattern before fix commitment |
| Hotfix release decision | Shig | Bin | Producer-led decision with risk check |

### Escalation triggers
Escalate immediately when any of these occur:
- 3+ matching reports in under 60 minutes
- first confirmed crash with repro steps
- first confirmed save-loss or progression-blocker report
- review score / public sentiment shifts because of one identifiable technical issue
- storefront or release timing mismatch versus announced launch state

---

## 7. Reporting Cadence

### Pre-launch hour (T-60 to launch)
Post one readiness note covering:
- live channels being watched
- current build/version under observation
- open known issues worth watching
- on-call owner confirmation

### Launch window cadence
| Window | Cadence | Report content |
|--------|---------|----------------|
| T to T+4 hrs | every 30 minutes | incident count, top themes, new critical/high issues, owner status, player-facing notes needed |
| T+4 hrs to T+12 hrs | hourly | trends, unresolved issues, workaround status, whether hotfix prep is needed |
| T+12 hrs to T+24 hrs | every 2-3 hours | remaining active issues, handoff state, overnight risks |

### Minimum contents of each support report
- total new reports since last update
- grouped themes by category
- critical/high issues and current owner
- confirmed repros vs unverified reports
- public response posted / pending
- recommendation: monitor / investigate / workaround / hotfix

---

## 8. Player-Facing Response Rules

- Do **not** promise fix timing until John and Shig confirm scope.
- Acknowledge public issues once a pattern is credible; silence is worse than over-polished wording.
- Prefer: **what players should do now**, **whether a workaround exists**, and **when the next update will come**.
- If reports are still unverified, say they are being investigated rather than confirmed as universal.
- Keep public wording aligned across Discord, Steam, and any launch announcement follow-up.

### Safe acknowledgment template
> We’re investigating reports of [issue] affecting some players at launch. If you’re seeing this, please share your platform, what happened right before the issue, and any screenshot/log if available. We’ll post the next update by [time].

---

## 9. Owner Handoff Checklist

Use this whenever a report moves from intake to implementation or external response.

### QA → Dev handoff
- [ ] Severity assigned
- [ ] Repro steps written clearly
- [ ] Frequency/pattern noted
- [ ] Platform/build captured
- [ ] Screenshot/log/save attached if available
- [ ] Workaround noted if one exists
- [ ] Player impact described in one sentence
- [ ] Decision needed called out: investigate / fix now / defer

### QA → Marketing/community handoff
- [ ] Issue is confirmed or credibly trending
- [ ] Approved summary written in plain language
- [ ] Affected audience/channel identified
- [ ] Workaround included if available
- [ ] Next update time included
- [ ] Avoided unconfirmed root-cause claims

### Active issue → Producer handoff
- [ ] Current severity and risk stated
- [ ] Scope estimate from John requested or attached
- [ ] Recommendation stated: monitor / hotfix / hold messaging / escalate to Bin
- [ ] Dependencies noted (storefront action, branch build, patch notes, QA verify)

### End-of-day handoff
- [ ] All critical/high issues listed with current status
- [ ] Open investigations assigned to owner
- [ ] Known workarounds collected in one place
- [ ] Public statements linked or quoted
- [ ] Overnight monitoring expectations set
- [ ] Next check-in time scheduled

---

## 10. Launch-Day Checklist

### Before launch goes live
- [ ] Confirm support watchers are active and reachable
- [ ] Confirm live build/version number being monitored
- [ ] Open shared issue log / incident note
- [ ] Pin support intake instructions for players if needed
- [ ] Review known issues / FAQ with Gabe
- [ ] Confirm John and Shig escalation path

### First 4 hours after launch
- [ ] Check Discord at least every 10-15 minutes
- [ ] Check Steam page / community / reviews every 15-30 minutes
- [ ] Group duplicate reports instead of logging them separately forever
- [ ] Escalate first confirmed critical issue immediately
- [ ] Post cadence updates on schedule even if status is “no major incidents”

### Rest of day
- [ ] Keep hourly summaries clean and decision-focused
- [ ] Re-test any claimed fix or workaround before declaring resolved
- [ ] Separate launch-noise feedback from true defects
- [ ] Track sentiment shifts that may need messaging support
- [ ] Prepare end-of-day owner handoff summary

---

## 11. Recommended Day-One Output

By the end of launch day, QA should have:
- one clean incident log for all critical/high issues
- one summary of top recurring player problems
- one prioritized dev follow-up list for hotfix or next patch
- one community-facing issue/status summary aligned with Gabe and Shig
- one end-of-day handoff note for the next monitoring block

---

**Status:** Ready for launch-day use  
**Prepared by:** Sakura 🌸 for NorthernStar Studio
