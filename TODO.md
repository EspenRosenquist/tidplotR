# TODO — Goal Stack and Backlog

This file is the active memory for `tidplotR`. Keep the goal stack short,
ordered, and current.

## Goal Stack (ordered; keep 3–7 items)

1. Finalize the first-wave `tidplotR` public API and package boundary.
2. Keep `tidplotR` usable both standalone and in tandem with `tidflowR`.
3. Migrate generic plotting and SVG export responsibilities out of `tidflowR`
   and into `tidplotR`.
4. Keep the dependency surface shallow while preserving deterministic SVG output.
5. Document downstream migration guidance for current report packages.
6. Create and connect the intended GitHub remote once the repository exists.

Review cadence: session-by-session while extraction is active

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
- [ ] Repoint downstream consumers or compatibility wrappers.
- [ ] Create the target GitHub repository and push the local repo.

## Backlog (prioritised)

- P0: Complete the migration boundary with `tidflowR` so generic plot helpers
  and SVG writing no longer need to live in the data-flow package.
- P0: Verify that `tidplotR` can be used directly on plain data frames without
  any `tidflowR` dependency.
- P0: Publish the target GitHub repository and connect the local repo cleanly.
- P1: Decide whether temporary compatibility wrappers should remain in
  `tidflowR` during downstream migration.
- P1: Add one or two more reusable plot patterns only if they are clearly
  generic across multiple consumers.
- P1: Repoint `modeltemplateR` and `atidmodelR` to `tidplotR` for generic plots.
- P2: Add a migration vignette focused on downstream package adoption.
- P2: Revisit namespace ergonomics and naming once two consumers are migrated.
