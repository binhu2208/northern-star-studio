# DEV-006A — Engineering Closeout Checklist

Concise engineering wrap-up for `release/v0.5.0` based on current release and post-launch support docs.

## Done

- [x] Release tracker scaffold exists in `docs/release/v0.5.0-release-tracker.md`.
- [x] Player-facing patch notes scaffold exists in `docs/release/v0.5.0-patch-notes-draft.md`.
- [x] Post-launch patch workflow is documented in `docs/qa/post-launch-patch-workflow.md`.
- [x] Bug intake / triage template exists in `docs/qa/post-launch-triage-template.md`.
- [x] Focused post-launch smoke checklist exists in `tests/qa/post-launch-smoke-checklist.md`.
- [x] Release branch target is defined as `release/v0.5.0` across release / QA docs.
- [x] Patch guardrails are already defined: small fixes, targeted verification, no mixed feature work in hotfix patches.

## Pending

- [ ] Fill `docs/release/v0.5.0-release-tracker.md` with real launch data:
  - target build/date
  - go / no-go state
  - actual player-facing fixes
  - actual known issues
- [ ] Replace placeholder entries in `docs/release/v0.5.0-patch-notes-draft.md` with confirmed shipped items only.
- [ ] Pre-seed the post-launch fix queue with any known-but-nonblocking issues before launch so day-one triage does not start from a blank table.
- [ ] Confirm the engineering owner for live bug intake review and patch execution on `release/v0.5.0`.
- [ ] Define the minimum engineering response path for live issues:
  - where bug records are created
  - who reproduces first
  - who decides patch now vs hold
- [ ] Make sure every live fix follows the documented patch loop:
  - written repro
  - targeted fix on `release/v0.5.0`
  - focused smoke pass from `tests/qa/post-launch-smoke-checklist.md`
  - short patch note entry
- [ ] Keep patch scope engineering-only for post-launch work: no opportunistic refactors, no bundled feature work, no speculative balance redesign hidden inside bugfixes.
- [ ] If a fix touches combat, card logic, or save/progression, explicitly run the extra area checks already called out in `docs/qa/post-launch-patch-workflow.md`.
- [ ] Add one concise update entry to the release tracker once launch state is final so the tracker stops being a scaffold and becomes the source of truth.

## Owner-Needed / External Dependencies

### QA / Sakura needed
- Needs QA to provide reproducible bug reports using `docs/qa/post-launch-triage-template.md`.
- Needs QA sign-off on focused smoke results for live fixes, especially combat / card / save-related changes.
- Needs QA to confirm whether any known issues should be preloaded into the post-launch fix queue before release.

### Shig needed
- Needs Shig to lock release timing / go-no-go so engineering can finalize the tracker and patch readiness state.
- Needs Shig to confirm priority order if multiple non-blocking issues compete for the first patch.
- Needs Shig to decide whether any issue is acceptable as a known issue versus a must-fix-before-release item.

### Bin needed
- Needs Bin approval on final release state if go / no-go or first-patch scope requires product-level call.
- Needs Bin to confirm any player-facing messaging constraints if known issues or day-one patch notes must be published externally.

## Engineering Closeout Standard

Engineering is effectively closed out for launch support when:
- release tracker is populated with real launch status
- patch notes contain confirmed shipped items only
- first-response bug triage path is clear
- post-launch fix queue is ready to use
- smoke verification path is agreed and repeatable
- no one is relying on undocumented launch-day decisions
