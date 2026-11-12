---
name: lean-coding
description: Keep Codex coding tasks focused on the smallest safe change and avoid unnecessary context, tool output, and credit usage. Use for UI tweaks, bugs, resumed tasks, or requests to conserve tokens. Never skip essential verification.
---

# Lean coding workflow

1. Identify the exact requested change and the likely affected files. Avoid unnecessary full-repository scans, old chat transcripts, and long plans.
2. Search filenames and symbols first. Read small relevant excerpts; expand only if the evidence requires it.
3. On resumed work, consult `docs/STATE.md` only when useful. Verify it against current source; the repository is authoritative.
4. Reuse existing styles, components, and dependencies. Avoid broad refactors, reformatting, package upgrades, and new dependencies unless required.
5. Make the smallest coherent diff, preserving responsive layout, accessibility, authentication, security, financial logic, and existing behavior.
6. Run focused tests or basic checks; broaden verification for high-risk integrations. Never trade correctness for token savings.
7. Keep command output and replies concise. Report files changed, tests run, and any remaining issues.
8. Update `docs/STATE.md` briefly at milestones, not on every request. No deployment or destructive operations without authorization.

This workflow may reduce avoidable usage but does not guarantee a credit reduction.
