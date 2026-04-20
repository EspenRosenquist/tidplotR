# Integrate `tidplotR` With `NOArtisan` and Harden `NOArtisan`

**Date:** 2026-04-20

**Owner(s):** Analytid platform workstream

**Status:** In progress

## 1) Objective

- Keep `tidplotR` fully usable as a standalone plotting package.
- Let `tidplotR` adopt `NOArtisan` styling automatically when `NOArtisan` is loaded.
- Audit and harden `NOArtisan` so it is suitable as the organisation's primary styling package.
- Move or duplicate the branded font-installation capability into `NOArtisan` as the canonical stylistic home.
- **Done when:** `NOArtisan` passes local package checks, `tidplotR` can opportunistically use `NOArtisan` without a hard dependency, and `NOArtisan` has working vignette coverage for its core capabilities.

## 2) Constraints & invariants

- `tidplotR` must not require `NOArtisan` to load or run.
- `NOArtisan` should own STAMI-specific palettes, themes, defaults, typography helpers, and branded font installation.
- `tidplotR` should keep ownership of generic time-oriented plot builders and SVG writing.
- Avoid increasing runtime dependency depth in `NOArtisan`; remove dependencies when a clear base-R alternative exists.
- Preserve current exported entrypoints where possible; prefer compatibility wrappers over removals in the first pass.

## 3) Options & quantified evaluation

| Option | Human time | Complexity | Regression risk | Maintainability | Dependency impact | Notes |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| A. Compatibility-first bridge | 2 | 2 | 2 | 1 | 1 | Keep `tidplotR` standalone, let it detect `NOArtisan` when loaded, and harden `NOArtisan` in place. |
| B. Full extraction now | 4 | 4 | 4 | 2 | 2 | Move branded helpers out of `tidplotR` immediately, but this risks breaking a currently healthy package surface. |

Scale: 1 is better, 5 is worse.

**Recommendation:** A. It addresses the package boundary and the current `NOArtisan` quality issues without forcing a hard dependency or a breaking extraction.

## 4) Proposed approach

1. Fix `NOArtisan` check failures, documentation problems, and avoidable dependencies.
2. Add branded font-installation support to `NOArtisan` and cover it with tests.
3. Make `tidplotR` styling helpers route through `NOArtisan` only when its namespace is loaded.
4. Add or refresh vignettes so `NOArtisan` showcases themes, palettes/scales, and mapping/font capabilities.
5. Re-run package checks for both packages.

## 5) Acceptance & verification

- `NOArtisan`: `R CMD build . && R CMD check NOArtisan_*.tar.gz`
- `tidplotR`: `make check`
- `NOArtisan` tests cover palettes, styling, and branded font installation.
- `tidplotR` continues to pass standalone tests and can use `NOArtisan` styling when available.

## 6) Risks & rollback

- Main risk: subtle plot appearance changes when `NOArtisan` is loaded.
- Rollback: revert the `tidplotR` bridge helpers while keeping `NOArtisan` hardening changes, since those are independently valuable.
