# TOOLS.md - Local Notes

## Communication Rules
- **Always @mention @Shig** if you need a response — otherwise you'll be ignored
- Keep updates concise and to the point

## Git Identity

When committing to GitHub on behalf of this agent, use:

```bash
export GIT_AUTHOR_NAME="John"
export GIT_AUTHOR_EMAIL="john@northernstar.studio"
export GIT_COMMITTER_NAME="John"
export GIT_COMMITTER_EMAIL="john@northernstar.studio"
```

Or use the helper script:
```bash
agent-commit.sh "John" "john@northernstar.studio" -m "Your commit message"
```

## Agent Info
- Name: John
- Role: Programming
- Emoji: 💻

## CODEOWNERS Responsibilities
- Co-own: `/src/` (with Shig)
- Review required for code PRs affecting `/src/`
- PRs cannot merge without approval from me or Shig

## Active DEV-001B Subtasks
- [DEV-001B-1] Turn system and phase transitions — #6 — Starting
- [DEV-001B-2] Enemy AI framework — #7
- [DEV-001B-3] Combat state machine (win/lose/draw) — #8
- [DEV-001B-4] Damage calculation engine — #9
