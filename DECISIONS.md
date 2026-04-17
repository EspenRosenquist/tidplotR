# Decisions — tidplotR

- 2026-04-17 — Create the shared plotting repository locally at `/workspaces/tidplotR`.
  - Status: accepted
  - Why: gives the plot and SVG layer a stable owner without forcing `tidflowR`
    to carry the native SVG text-shaping stack.

- 2026-04-17 — Keep `tidplotR` independent from `tidflowR`.
  - Status: accepted
  - Why: the package must be usable as a standalone plotting toolbox or in
    tandem with `tidflowR`.
  - Constraint: `tidplotR` should accept plain data frames and simple lists
    instead of depending on `tidflowR` types or helpers.

- 2026-04-17 — Use `svglite` for deterministic SVG export in `tidplotR`.
  - Status: accepted
  - Why: `svglite` is the right SVG device for `ggplot2` output and keeps the
    native text-shaping dependency chain confined to the plotting package.

- 2026-04-17 — Keep `tidplotR` focused on generic ggplot builders and SVG export.
  - Status: accepted
  - Why: data ingress, spec loading, contract assembly, and report-specific
    layouts are distinct responsibilities that belong elsewhere.

- 2026-04-17 — Prefer a shallower dependency surface inside `tidplotR`.
  - Status: accepted
  - Why: this package should stay lightweight. Base R transformations are
    acceptable when they keep the code clear and reduce dependency depth.

- 2026-04-17 — Reuse the current `tidflowR` repository structure and devcontainer as the scaffold for `tidplotR`.
  - Status: accepted
  - Why: it preserves the same control-plane workflow, package layout, and
    development environment conventions across both shared repositories.

- 2026-04-17 — Point the local git remote at `https://github.com/EspenRosenquist/tidplotR.git`.
  - Status: accepted
  - Why: this is the intended long-term remote, even though the repository does
    not exist yet and cannot be created automatically from the current environment.
