# Decisions — tidplotR

- 2026-04-20 — Keep host-safe default fonts and provide an explicit installer for branded font assets.
  - Status: accepted
  - Why: package examples and checks should not depend on a local Fira Sans installation, but downstream report outputs still need a reproducible way to install the recommended font family.
  - Consequence: plot helpers keep `base_family = "sans"` by default, and branded font installation lives only in `NOArtisan::install_STAMI_fonts()`.

- 2026-04-20 — Prefer host-native R package development and remove repo-local IDE scaffolding.
  - Status: accepted
  - Why: for this package the extra repo-local tooling adds setup friction, environment-specific troubleshooting, and root-owned file hazards without enough payoff over the standard R package workflow.
  - Consequence: the repo should carry a committed `tidplotR.Rproj`, package docs should describe host-based development, and obsolete repo-local setup files are removed.

- 2026-04-17 — Create the shared plotting repository locally at `/home/esro/analytid-platform/tidplotR`.
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

- 2026-04-17 — Reuse the current `tidflowR` repository structure as the scaffold for `tidplotR`.
  - Status: accepted
  - Why: it preserves the same control-plane workflow, package layout, and
    development conventions across both shared repositories.

- 2026-04-17 — Point the local git remote at `https://github.com/EspenRosenquist/tidplotR.git`.
  - Status: accepted
  - Why: this is the intended long-term remote, even though the repository does
    not exist yet and cannot be created automatically from the current environment.
