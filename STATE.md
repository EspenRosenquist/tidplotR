# State - tidplotR

Last updated: 2026-06-25

## Current checkpoint

- `tidplotR` is a standalone pure R package, not a report-platform workspace
  repository and not a `tidflowR` submodule.
- The package owns generic plotting, plot-local validation, and deterministic
  fixed-dimension SVG export.
- Data ingress, connectors, specs, JSON assembly, and model-engine manifests
  belong outside this package.
- The steering ritual now follows the report-platform low-token pattern:
  overview, state, TODO, decisions, and Exec Plans.

## Active next action

Audit the current public plotting and SVG surface against downstream
model-engine needs. Create or update an Exec Plan before changing exported plot
contracts, SVG behavior, dependency posture, or the boundary with `tidflowR`.

## Blockers / limits

- The package must remain usable without `tidflowR`.
- Branded styling may be optional, but must not become a hard dependency unless
  a decision gate is approved.

## Ritual

- Start: read `PROJECT_OVERVIEW.md`, this file, `TODO.md`, `DECISIONS.md`, and
  any active plan.
- During work: keep plan progress and surprises current for multi-step work.
- Before handoff: update this file if checkpoint, blocker, or next action
  changed.

## Verification posture

- Docs-only steering changes: inspect diffs and run text search for stale
  routing or boundary conflicts.
- Code changes: run the relevant subset of `make document`, `make test`,
  `make smoke`, and `make check`.
