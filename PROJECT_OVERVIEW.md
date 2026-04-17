# Project Overview — tidplotR

This file is the canonical control plane for `tidplotR`. If another document or
proposed change conflicts with this file, stop and resolve the conflict before
proceeding.

## North Star

Build a reusable R package that owns the generic time-oriented plotting and
deterministic SVG-export layer across Analytid reporting packages. `tidplotR`
should stay distinct from `tidflowR`: it renders plots and assets, while data
flow, database access, spec handling, and JSON contract assembly remain outside
this package.

## Definition of Done (DoD)

- A local repository exists under `/workspaces/tidplotR` with package metadata,
  control-plane documents, tests, vignettes, and a reusable code structure.
- The public surface of `tidplotR` is documented clearly enough that a follow-up
  session can continue without re-discovery.
- The package can be used standalone with plain data frames and simple lists.
- The package can also be used in tandem with `tidflowR` without creating a
  hard dependency between the two packages.
- Generic plot builders and deterministic SVG export are implemented or
  scaffolded clearly enough for migration work to continue.
- Verification commands are defined for tests, smoke checks, and documentation generation.
- Known limitations, deferred abstractions, and risky boundaries are captured explicitly.

## Constraints & Invariants

- **Security & Privacy**
  - Do not commit credentials or production secrets.
  - Do not pull data-access logic into this repository under the guise of
    convenience helpers.
- **Platform / Runtime**
  - Must run on Linux.
  - Must support local development from `/workspaces/tidplotR`.
  - Must work with ordinary R package workflows such as `pkgload::load_all()`
    and `R CMD check`.
- **Tooling**
  - Allowed: R, ggplot2, scales, svglite, roxygen2, testthat, knitr, rmarkdown.
  - Disallowed without approval: database connectors, warehouse clients,
    hidden build-time network calls, remote-only workflow requirements.
- **Interfaces & Outputs**
  - `tidplotR` inputs should remain ordinary data frames and lightweight lists.
  - Plot helpers should remain generic and reusable across multiple consumers.
  - SVG export should stay deterministic and fixed-dimension.
  - `tidplotR` must not become the owner of JSON artifact contracts or report
    assembly behavior.
- **Operational**
  - Keep the repository independent from `tidflowR`, while documenting tandem usage.
  - Prefer a shallow dependency surface where that does not materially harm clarity.

## Optimisation Weights

| Criterion | Weight | Notes |
| --- | ---: | --- |
| Human time | HIGH | Reduce repeated plot maintenance across packages. |
| Complexity | HIGH | Keep the package narrowly scoped and boring. |
| Regression risk | HIGH | Avoid breaking downstream plot contracts during migration. |
| Maintainability | HIGH | Make the plot layer easy to understand and extend. |
| Data correctness | HIGH | Plot helpers must faithfully represent the supplied data. |
| Runtime/infra cost | MED | Keep dependency depth and native-library burden reasonable. |
| User preference | LOW | Use preferences when explicitly stated; otherwise optimize for the repo goals. |

## Decision Gates

Seek approval before proceeding if the change:

1. Alters published plot signatures, SVG naming, or smoke-test contracts.
2. Introduces or removes a major runtime dependency.
3. Pulls database, spec, contract-assembly, or report-layout ownership into `tidplotR`.
4. Creates a hard dependency between `tidplotR` and `tidflowR`.
5. Renames exported functions that current consumers may already use.

## Exec Plan Triggers

Create or update a plan under `plans/` when the change:

- is expected to take more than 2 to 4 hours
- touches public plot contracts or SVG behavior
- has meaningful regression risk across current consumers
- changes the recommended package boundary between `tidplotR` and `tidflowR`

## Working Agreements

- Read `PROJECT_OVERVIEW.md`, `TODO.md`, and the active plan before making substantive changes.
- Compare at least two options for architectural changes.
- Prefer generic plot-ready inputs over package-specific abstractions.
- Prefer minimal diffs in current consumers while the shared plot layer stabilizes.
- Every substantive change must include verification steps.
- Record decisions and surprises instead of assuming they will be remembered.
