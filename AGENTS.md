# AGENTS.md

This repository uses a lightweight package-control workflow.

Before substantive work:

1. Read `PROJECT_OVERVIEW.md`.
2. Read `STATE.md`.
3. Read `TODO.md`.
4. Read `DECISIONS.md`.
5. Read `CONTEXT.md`.
6. Read any relevant plan under `plans/`.

Rules:

- Treat `tidplotR` as a standalone R package.
- Keep the package focused on generic plot builders and deterministic
  fixed-dimension SVG export.
- Keep inputs as plain data frames and simple lists.
- Keep data access, connectors, specs, JSON model assembly, and deployment
  tooling outside this package.
- Keep `tidflowR` as an optional tandem package, never a hard dependency.
- Use an Exec Plan for public plot contract changes, SVG behavior changes,
  dependency changes, risky migrations, or work spanning multiple packages.
- Update `STATE.md`, `TODO.md`, and `DECISIONS.md` when the durable state
  changes.
