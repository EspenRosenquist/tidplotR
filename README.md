# tidplotR

`tidplotR` is a shared R package for generic time-oriented plots and
deterministic SVG export. It is intentionally separate from `tidflowR`:
`tidplotR` renders plot-ready inputs, while `tidflowR` handles data flow,
database access, specs, and JSON artifact assembly.

The package is standalone. It uses the same low-token steering ritual as the
report-platform workspace, but only for local package memory: `STATE.md`,
`TODO.md`, `DECISIONS.md`, and `plans/` are the handoff surface. Runtime
deployment, connectors, specs, and model JSON assembly stay outside this
repository.

The current package surface is centered on:

- reusable ggplot builders for value distributions, risk comparisons, context
  distributions, weekly heatmaps, and monthly coverage plots
- deterministic fixed-dimension SVG writing through `svglite`
- standalone use on ordinary data frames
- tandem use with `tidflowR` and related report packages
- strictly shaped SVG products for model-engine callers that need stable
  dimensions and predictable file output

## Steering For Agents

Before substantive work, read `PROJECT_OVERVIEW.md`, `STATE.md`, `TODO.md`,
`DECISIONS.md`, and `CONTEXT.md`. Use an Exec Plan under `plans/` for public
plot contract changes, SVG behavior changes, dependency posture changes, risky
migrations, or work expected to take more than 2 to 4 hours.

## Install

Install the current package directly from the GitHub repo:

```r
install.packages("pak")
pak::pkg_install("EspenRosenquist/tidplotR")
```

For local development from this checkout:

```r
install.packages("pak")
pak::local_install(".")
```

If you develop on Linux, make sure the required host-side system dependencies
for `svglite` are installed.

## Fonts

`tidplotR` keeps its plot defaults on the host-safe `sans` family so examples,
tests, and checks do not depend on local font installation. If you use
`NOArtisan`, prefer its branded font installer:

```r
NOArtisan::install_STAMI_fonts()
```

After installing the fonts you can opt into the family explicitly:

```r
plot <- plot_monthly_measurement_coverage(coverage_df, base_family = "Fira Sans")
```

If `NOArtisan` is loaded in the session, `tidplotR` will also use the STAMI
theme defaults and Norwegian percentage labelling automatically while still
remaining usable without that package.

## Start Using tidplotR

### Standalone plotting

```r
library(tidplotR)

coverage_df <- data.frame(
  month = as.Date(c("2024-01-01", "2024-02-01", "2024-03-01")),
  employee_count = c(12L, 15L, 14L)
)

plot <- plot_monthly_measurement_coverage(coverage_df)
path <- tempfile(fileext = ".svg")

write_svg(plot, path, width_mm = 120, height_mm = 70)
```

### Pairing tidplotR with tidflowR

The boundary is simple:

- `tidflowR` prepares or aggregates data
- `tidplotR` renders reusable plots and SVG assets from those outputs

For example, if another package or helper already gives you an aggregated risk
distribution data frame, `plot_risk_comparison()` can render it directly as
long as the expected columns are present.

## Package Boundary

`tidplotR` owns:

- generic plot builders
- SVG export helpers
- plot-local validation and documentation

`tidplotR` does not own:

- YAML specs or report configuration
- database connectors or SQL assets
- JSON model assembly or artifact manifests
- report-specific layout composition
- domain-specific transforms and warehouse contracts

## Vignettes

Use the package vignettes for the fuller workflows:

- `vignette("tidplotR-overview")`
- `vignette("integration-with-tidflowR")`

## Development

For package development inside this repo, open `tidplotR.Rproj` in RStudio or
keep the repo root as the working directory in VS Code. That matches the
standard package workflow: use `pkgload::load_all()`, run tests often, and
check the package early.

The common commands are:

```sh
make document
make test
make smoke
make check
```

Useful one-off commands:

```sh
Rscript --vanilla -e 'pkgload::load_all(); testthat::test_dir("tests/testthat")'
Rscript --vanilla -e 'pkgload::load_all(); coverage <- data.frame(month = as.Date(c("2024-01-01", "2024-02-01")), employee_count = c(12L, 15L)); plot <- plot_monthly_measurement_coverage(coverage); path <- tempfile(fileext = ".svg"); write_svg(plot, path, width_mm = 120, height_mm = 70); cat(path, "\n")'
```
