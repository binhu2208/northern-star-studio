# Northern Star Studio — Team Operations Guide

**Last Updated:** 2026-03-13  
**Maintained by:** Macs (Assistant)  
**For:** All Team Members

---

## 📋 Quick Reference: Who Does What

| Agent | Emoji | Role | Reports To | Primary Workspace |
|-------|-------|------|------------|-------------------|
| **Macs** | 🖥️ | Operations / Assistant | Bin (Studio Lead) | `~/.openclaw/workspace/` |
| **Shig** | 📋 | Game Producer/Manager | Macs → Bin | `~/.openclaw/agents/shig/` |
| **Gabe** | 📊 | Marketing & Market Analysis | Shig | `~/.openclaw/agents/gabe/` |
| **Hideo** | 🎮 | Game Design | Shig | `~/.openclaw/agents/hideo/` |
| **John** | 💻 | Programming | Shig | `~/.openclaw/agents/john/` |
| **Sakura** | 🔍 | QA/Research | Shig | `~/.openclaw/agents/sakura/` |
| **Yoshi** | 🎨 | Art & Audio | Shig | `~/.openclaw/agents/yoshi/` |

### Escalation Chain
```
Gabe/Hideo/John/Sakura/Yoshi → Shig → Macs → Bin
```
- Shig tries to resolve first, escalates to Macs if stuck
- Macs escalates to Bin only if unable to resolve

---

## 💬 Team Communication Workflows

### 1. Shig → Team Member (Assignment)

**Use fire-and-forget pattern:**
```javascript
sessions_send({
  sessionKey: "agent:gabe:discord:direct:1480376175262961826",  // or other agent
  message: "Your assignment here...",
  timeoutSeconds: 0  // fire-and-forget, no waiting
})
```

**Why:** Avoids timeout errors. Team member replies back manually.

### 2. Team Member → Shig (Assignment Complete)

**Option A: Have Deliverables**
- Push files to GitHub in your assigned folder
- Webhook automatically notifies #build-feedback channel
- Shig sees notification on next heartbeat

**Option B: No Deliverables (Status Update Only)**
```javascript
sessions_send({
  sessionKey: "agent:shig:discord:direct:1480376175262961826",
  message: "Assignment complete: [summary]",
  timeoutSeconds: 300  // 5 minute timeout for acknowledgment
})
```

### 3. General Team Communication

- **Discord #general:** Public discussions, @mentions for specific agents
- **DM Sessions:** Private assignments, escalations, sensitive topics
- **GitHub:** Code reviews, deliverables, documentation

### 4. Reply Patterns

| Scenario | How to Reply |
|----------|--------------|
| Assigned via DM | Reply via DM (`sessions_send` to their session) |
| Mentioned in #general | Reply in #general (if public) or DM (if private) |
| GitHub webhook | No reply needed — Shig monitors #build-feedback |

---

## 🔧 GitHub Workflow

### Repository Structure
```
northern-star-studio/
├── /src/           → John (code)
├── /assets/        → Yoshi (art/audio)
├── /docs/gdd/      → Hideo (design docs)
├── /docs/roadmap/  → Shig (milestones)
├── /docs/marketing/→ Gabe (marketing)
└── /tests/         → Sakura (QA)
```

### Your Git Identity

Set in your `TOOLS.md`:
```bash
export GIT_AUTHOR_NAME="YourName"
export GIT_AUTHOR_EMAIL="yourname@northernstar.studio"
export GIT_COMMITTER_NAME="YourName"
export GIT_COMMITTER_EMAIL="yourname@northernstar.studio"
```

### Checking GitHub Access

```bash
# Test authentication
gh auth status

# If not logged in
gh auth login

# Test repo access
cd ~/workspace/northern-star-studio
git status
gh repo view NorthernStar-Studio/northern-star-studio
```

### Committing Your Work

```bash
cd ~/workspace/northern-star-studio

# Set identity (if not already set)
export GIT_AUTHOR_NAME="YourName"
export GIT_AUTHOR_EMAIL="yourname@northernstar.studio"

# Stage and commit
git add .
git commit -m "Your commit message"
git push origin main
```

**Note:** Main branch requires 1 review for protection. For urgent changes, you can push directly; for significant changes, open a PR.

---

## 🔄 Heartbeat & Status Checks

### Shig's Heartbeat
- **Every 2 hours:** Checks with team for status updates
- **Monitors:** #build-feedback for GitHub webhooks
- **Escalates:** Critical issues to Macs

### Macs' Heartbeat
- **As needed:** Checks with Shig for escalations
- **Monitors:** Infrastructure, Discord, GitHub
- **Escalates:** Unresolved issues to Bin

### When to Expect Responses
- **Discord messages:** Real-time (during active hours)
- **DM assignments:** Within 2 hours (Shig's heartbeat)
- **GitHub pushes:** Automatic webhook notification

---

## 📁 GitHub CODEOWNERS (Auto-Assignment)

| Folder | Owner |
|--------|-------|
| `/src/**` | @john |
| `/assets/**` | @yoshi |
| `/docs/gdd/**` | @hideo |
| `/docs/roadmap/**` | @shig |
| `/docs/marketing/**` | @gabe |
| `/tests/**` | @sakura |

When you push to these folders, the owner is automatically notified.

---

## 🚨 Common Issues & Solutions

### Issue: `sessions_send` timeout
**Solution:** Use `timeoutSeconds: 0` (fire-and-forget). Team member replies back manually.

### Issue: Can't push to GitHub
**Solution:** Check `gh auth status`. If not logged in, run `gh auth login`.

### Issue: Don't know who to report to
**Solution:** Check the escalation chain above. When in doubt, ask Shig.

### Issue: Need urgent response
**Solution:** Use Discord @mention in #general, or escalate through chain.

---

## 📝 Session Keys for Direct Messages

Use these session keys for `sessions_send` to specific team members:

| Agent | Session Key Pattern |
|-------|---------------------|
| Shig | `agent:shig:discord:direct:1480376175262961826` |
| Gabe | `agent:gabe:discord:direct:1480376175262961826` |
| Hideo | `agent:hideo:discord:direct:1480376175262961826` |
| John | `agent:john:discord:direct:1480376175262961826` |
| Sakura | `agent:sakura:discord:direct:1480376175262961826` |
| Yoshi | `agent:yoshi:discord:direct:1480376175262961826` |
| Macs | `agent:macs:discord:direct:1480376175262961826` |

**Tip:** Use `sessions_list` to find current session keys if these change.

---

## 🎯 Current Project Status

### Active: Cozy Café Game (Working Title)
- **Status:** Pre-production / Market Research Phase
- **Lead:** Shig (Producer)
- **Next Milestone:** Complete market research (Gabe)

### Completed Setup
- ✅ Discord server with channels and roles
- ✅ GitHub repository with structure
- ✅ CI/CD with Discord notifications
- ✅ Team agent configuration
- ✅ Communication workflows

---

## ❓ Need Help?

1. **Check this document first** — most common questions are answered here
2. **Ask in Discord #general** — team can help with quick questions
3. **DM your direct report** — for assignment-related questions
4. **Escalate through chain** — if stuck, go up one level

---

*This document is a living reference. Updates are made as workflows evolve. Last updated by Macs on 2026-03-13.*
