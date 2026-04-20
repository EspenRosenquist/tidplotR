# Bootstrap `tidplotR`

**Date:** 2026-04-17

**Owner(s):** Analytid platform workstream

**Status:** Completed

## 1) Objective

- Establish a sibling shared package repository under `/home/esro/analytid-platform/tidplotR`.
- Separate generic plotting and deterministic SVG export from `tidflowR`.
- Reuse the same control-plane, package, and test scaffold that
  already works in `tidflowR`.
- **Done when:** the repository can be opened on its own and the next session
  can continue the migration without re-discovery.

## 2) Constraints & invariants

- Must respect `PROJECT_OVERVIEW.md`.
- Must keep `tidplotR` independent from `tidflowR`.
- Must keep the package focused on generic plotting and SVG export.
- Must not pull in database, spec, or JSON contract logic.
- Decision gates crossed? Yes.
  - The shared package boundary is changing.
  - A new repository and dependency boundary are being introduced.
  - User approval for the overall direction has already been provided.

## 3) Options & quantified evaluation

| Option | Human time | Complexity | Regression risk | Maintainability | Data correctness | Notes |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| A. Keep plotting in `tidflowR` and only document the boundary | 1 | 1 | 1 | 4 | 2 | Fastest, but keeps responsibilities blurred and preserves the deeper SVG dependency chain in the flow package. |
| B. Create `tidplotR` as a separate shared plotting package | 2 | 2 | 2 | 1 | 1 | Cleaner ownership, cleaner dependency story, and better standalone reuse. |

Scale: 1 is better, 5 is worse.

**Recommendation:** B, because the user explicitly wants a separate plotting
toolbox that can be used either independently or together with `tidflowR`.

## 4) Proposed approach

Clone the cognitive-template repo into the requested sibling path, reuse the
current `tidflowR` repository structure as the local scaffold, copy the generic
plotting layer as the code baseline, and then narrow the package boundary and
dependencies so `tidplotR` owns only plot building and SVG export.

## 5) Execution steps

- [x] Clone the cognitive-template repo into `/home/esro/analytid-platform/tidplotR`.
- [x] Copy the current `tidflowR` scaffold structure as the baseline.
- [x] Replace the package metadata and code with a plot-focused `tidplotR` surface.
- [x] Fill the control-plane documents and first plan for the new repository.
- [x] Point the local git remote at the intended GitHub repository URL.
- [x] Run documentation, tests, and smoke checks.
- [ ] Complete the follow-on migration in `tidflowR` and downstream consumers.

## 6) Acceptance & verification

- **Build/lint:** `make document`
- **Tests:** `make test`
- **Smoke test / manual check:** `make smoke`
- **Boundary checks:** confirm `tidplotR` accepts plain data frames and does not depend on `tidflowR`
- **Security/privacy checks:** confirm no secrets or live credentials are committed in docs or tests
- **Performance checks:** keep dependency depth lean and avoid unnecessary runtime packages

## 7) Rollback & recovery

- **Rollback:** archive or remove `/home/esro/analytid-platform/tidplotR` if the boundary decision is revisited.
- **Recovery / rerun safety:** the scaffold is local-file based and safe to recreate.

## 8) Progress log

- 2026-04-17 — Cloned the cognitive-template repo into `/home/esro/analytid-platform/tidplotR`,
  copied the existing `tidflowR` scaffold shape, created a standalone plotting
  package surface, slimmed the package dependency list, and
  filled the control-plane documents for the new boundary. Verification and
  downstream migration remain for the next step.
- 2026-04-17 — Generated docs, passed `make test`, passed `make smoke`, and
  installed the local `tidplotR` package so `tidflowR` wrappers could be
  verified against it.

## 9) Surprises & decisions

- 2026-04-17 — The target GitHub repo `EspenRosenquist/tidplotR` does not yet
  exist, and GitHub CLI is not available in the environment.
- 2026-04-17 — The generic plotting layer was simple enough to keep standalone
  with base-R data preparation, allowing `tidplotR` to avoid a `dplyr`
  dependency in its initial scaffold.
