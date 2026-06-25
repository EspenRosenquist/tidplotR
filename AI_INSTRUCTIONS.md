# AI Instructions - tidplotR

These instructions guide assistants working in this standalone R package.

## Source hierarchy

Read these files in order when resuming or planning work:

1. `PROJECT_OVERVIEW.md` - canonical package boundary, invariants, and gates.
2. `STATE.md` - current handoff ledger, next action, blockers, and evidence.
3. `TODO.md` - ordered goal stack and active work orders.
4. `DECISIONS.md` - accepted choices and historical rationale.
5. `CONTEXT.md` - domain map, consumers, and non-obvious assumptions.
6. `plans/` - Exec Plans for work that crosses gates or needs durable steps.
7. `README.md` and vignettes - user-facing package behavior.

If these files conflict, update the stale steering file before following it.
Do not rely on conversational memory for package state.

## Always

- Keep `tidplotR` a pure, standalone R package.
- Own only generic plot builders, plot-local validation, and deterministic
  fixed-dimension SVG export.
- Keep exported functions usable with plain data frames and simple lists so
  `tidplotR` stays independent from `tidflowR`.
- Preserve strictly shaped SVG products: stable dimensions, stable filenames
  when callers provide them, deterministic output, and focused tests.
- Keep data access, connector logic, spec loading, JSON contract assembly, and
  model-engine product manifests outside this package.
- Prefer shallow dependencies. Use base R transformations when they keep code
  clear and materially reduce dependency depth.
- Compare at least two options for architectural changes and quantify human
  time, complexity, regression risk, maintainability, and data correctness.
- Include verification steps for every substantive change.
- Update `STATE.md`, `TODO.md`, `DECISIONS.md`, or an active plan when facts or
  status change.

## Plan ritual

Create or update an Exec Plan under `plans/` when work crosses a decision gate,
changes public plot/SVG contracts, changes dependency posture, affects
downstream model-engine usage, or is expected to take more than 2 to 4 hours.

## When to ask

Ask only when a required detail cannot be deduced from the repository, a
decision gate in `PROJECT_OVERVIEW.md` is crossed, or two mutually exclusive
behaviors are genuinely unresolved. Otherwise proceed with explicit assumptions
and record them.

## Deliverable discipline

For planning or implementation tasks, state changed files, verification,
assumptions, and any remaining open work.

## Never

- Do not introduce secrets into specs or committed files.
- Do not widen contract surfaces silently.
- Do not pull database, connector, spec-loading, JSON assembly, or deployment
  tooling into `tidplotR`.
