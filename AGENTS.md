# AURA: Codex project instructions

- Use `.agents/skills/lean-coding/SKILL.md` for focused, cost-aware coding tasks when relevant.
- This repository has distinct areas: `admin-web/`, `backend/`, `mobile-flutter/`, and `docs/`. Work only inside the area relevant to the task.
- For admin-web design changes, inspect relevant UI files first; do not read the backend or mobile app unless a dependency requires it.
- Preserve login, roles, wallets, coins, payout logic, moderation, and privacy protections. Never guess billing rates.
- Reuse existing code, avoid unrelated rewrites and new dependencies, and prefer targeted tests with broader checks where risk requires.
- Read `docs/STATE.md` only when useful for resumed tasks; validate against current source and update briefly at meaningful milestones.
- Never deploy, modify secrets, delete data, or change financial/security rules without explicit authorization.
