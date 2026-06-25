# Project Overview - tidplotR

This file is the canonical control plane for `tidplotR`. If another document or
proposed change conflicts with this file, stop and resolve the conflict before
proceeding.

## North Star

Build a standalone pure R package that owns generic time-oriented plotting and
deterministic fixed-dimension SVG export across Analytid model-engine packages
and adjacent data products. `tidplotR` should stay distinct from `tidflowR`: it
renders already-shaped plot inputs, while data flow, database access, connector
logic, spec handling, JSON contract assembly, and deployment tooling remain
outside this package.

## Definition of Done (DoD)

- A local repository exists under `/home/esro/analytid-platform/tidplotR` with package metadata,
  control-plane documents, tests, vignettes, and a reusable code structure.
- Restart state is durable in `STATE.md`, `TODO.md`, `DECISIONS.md`, and
  `plans/`, so agents can resume without conversational memory.
- The public surface of `tidplotR` is documented clearly enough that a follow-up
  session can continue without re-discovery.
- The package can be used standalone with plain data frames and simple lists.
- The package can also be used in tandem with `tidflowR` without creating a
  hard dependency between the two packages.
- Generic plot builders and deterministic SVG export are implemented or
  scaffolded clearly enough for migration work to continue.
- SVG-producing helpers preserve strict product shape through stable dimensions,
  deterministic output, and focused verification.
- Verification commands are defined for tests, smoke checks, and documentation generation.
- Known limitations, deferred abstractions, and risky boundaries are captured explicitly.

## Constraints & Invariants

- **Security & Privacy**
  - Do not commit credentials or production secrets.
  - Do not pull data-access logic into this repository under the guise of
    convenience helpers.
- **Platform / Runtime**
  - Must run on Linux.
  - Must support local development from `/home/esro/analytid-platform/tidplotR`.
  - Must remain a pure R package with no repository-local deployment,
    Kubernetes, or workspace orchestration tooling.
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
  - Plot/SVG outputs used by model engines should remain strictly shaped through
    documented arguments, stable dimensions, and predictable file output.
  - `tidplotR` must not become the owner of JSON artifact contracts or report
    assembly behavior.
- **Operational**
  - Keep the repository independent from `tidflowR`, while documenting tandem usage.
  - Keep report-platform workspace rituals as steering inspiration only;
    `tidplotR` is independently versioned and implemented.
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
6. Changes deterministic SVG behavior, dimensions, or product naming contracts.

## Exec Plan Triggers

Create or update a plan under `plans/` when the change:

- is expected to take more than 2 to 4 hours
- touches public plot contracts or SVG behavior
- has meaningful regression risk across current consumers
- changes the recommended package boundary between `tidplotR` and `tidflowR`
- changes strict SVG product shape, dependency posture, or downstream
  model-engine expectations

## Working Agreements

- Read `PROJECT_OVERVIEW.md`, `STATE.md`, `TODO.md`, `DECISIONS.md`, and the
  active plan before making substantive changes.
- Compare at least two options for architectural changes.
- Prefer generic plot-ready inputs over package-specific abstractions.
- Prefer minimal diffs in current consumers while the shared plot layer stabilizes.
- Preserve deterministic fixed-dimension SVG output for model-engine products.
- Every substantive change must include verification steps.
- Record decisions and surprises instead of assuming they will be remembered.
