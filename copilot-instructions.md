# Copilot Instructions - tidplotR

- Read `PROJECT_OVERVIEW.md`, `STATE.md`, `TODO.md`, `DECISIONS.md`, and the
  active plan before making substantive changes.
- Keep `tidplotR` a standalone pure R package; do not add workspace,
  Kubernetes, connector, or deployment tooling.
- Keep `tidplotR` independent from `tidflowR`; accept plain data frames and simple lists at the package boundary.
- Preserve strictly shaped SVG products: fixed dimensions, predictable files,
  deterministic output, and tests.
- Prefer shallow dependencies when the resulting code stays clear.
- Stop and ask when a decision gate is crossed.
- Keep verification steps explicit.
- Update `STATE.md`, `TODO.md`, `DECISIONS.md`, or `CONTEXT.md` when durable
  facts change.
