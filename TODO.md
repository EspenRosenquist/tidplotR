# TODO - tidplotR

This file is the active memory for `tidplotR`. Keep the goal stack short,
ordered, and current.

State ledger: [STATE.md](STATE.md)

## Goal Stack (ordered; keep 3-7 items)

1. Keep `tidplotR` a standalone pure R package with durable state, TODO,
   decision, and plan handoff files.
2. Finalize the first-wave `tidplotR` public API and package boundary.
3. Keep `tidplotR` usable both standalone and in tandem with `tidflowR`.
4. Preserve strictly shaped SVG products through deterministic fixed dimensions,
   predictable file output, and focused tests.
5. Migrate generic plotting and SVG export responsibilities out of `tidflowR`
   and into `tidplotR`.
6. Keep the dependency surface shallow while preserving deterministic SVG output.
7. Document downstream migration guidance for current model-engine packages and
   keep `origin/main` synchronized when publishing is requested.

Review cadence: session-by-session while extraction is active

## Current First-Pass Work Orders

- [x] Add low-token steering state through `STATE.md` and `AGENTS.md`.
- [x] Align `plans/README.md` with the package-control ritual.
- [ ] Audit public plot and SVG behavior against strict model-engine product
  expectations.
- [ ] Repoint downstream consumers to direct `tidplotR` usage.
- [x] Confirm the target GitHub remote exists at `origin/main`.
- [ ] Push local package changes when publishing is requested.

## Bootstrap Checklist

- [x] Fill out `PROJECT_OVERVIEW.md`.
- [x] Populate the Goal Stack above.
- [x] Capture the current domain and package boundary in `CONTEXT.md`.
- [x] Record the starting decisions in `DECISIONS.md`.
- [x] Create the first execution plan under `plans/`.
- [x] Scaffold the local R package structure, tests, and host-native project setup.
- [x] Run `make document`.
- [x] Run `make test`.
- [x] Run `make smoke`.
- [x] Add a current state ledger and agent handoff ritual.
- [ ] Repoint downstream consumers to direct `tidplotR` usage.
- [x] Confirm the target GitHub remote exists at `origin/main`.

## Backlog (prioritised)

- P0: Complete the migration boundary with `tidflowR` so generic plot helpers
  and SVG writing no longer need to live in the data-flow package.
- P0: Verify that `tidplotR` can be used directly on plain data frames without
  any `tidflowR` dependency.
- P0: Verify deterministic fixed-dimension SVG output against model-engine
  product expectations.
- P0: Keep the local repository cleanly connected to `origin/main` and publish
  changes when requested.
- P1: Keep `tidflowR` free of plotting compatibility wrappers unless the
  boundary decision is explicitly revisited.
- P1: Add one or two more reusable plot patterns only if they are clearly
  generic across multiple consumers.
- P1: Repoint `modeltemplateR` and `atidmodelR` to `tidplotR` for generic plots.
- P2: Add a migration vignette focused on downstream package adoption.
- P2: Revisit namespace ergonomics and naming once two consumers are migrated.
