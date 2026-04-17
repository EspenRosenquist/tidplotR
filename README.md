# tidplotR

`tidplotR` is a shared R package for generic time-oriented plots and
deterministic SVG export. It is intentionally separate from `tidflowR`:
`tidplotR` renders plot-ready inputs, while `tidflowR` handles data flow,
database access, specs, and JSON artifact assembly.

The current package surface is centered on:

- reusable ggplot builders for value distributions, risk comparisons, context
  distributions, weekly heatmaps, and monthly coverage plots
- deterministic fixed-dimension SVG writing through `svglite`
- standalone use on ordinary data frames
- tandem use with `tidflowR` and related report packages

## Install

The target GitHub repository is intended to be
`EspenRosenquist/tidplotR`, but local development is the current supported path:

```r
install.packages("pak")
pak::local_install(".")
```

If you use the VS Code devcontainer in this repo, the required system
dependencies for `svglite` are installed automatically.

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

For package development inside this repo, the common commands are:

```sh
make document
make test
make smoke
```

Useful one-off commands:

```sh
Rscript --vanilla -e 'pkgload::load_all(); testthat::test_dir("tests/testthat")'
Rscript --vanilla -e 'pkgload::load_all(); coverage <- data.frame(month = as.Date(c("2024-01-01", "2024-02-01")), employee_count = c(12L, 15L)); plot <- plot_monthly_measurement_coverage(coverage); path <- tempfile(fileext = ".svg"); write_svg(plot, path, width_mm = 120, height_mm = 70); cat(path, "\n")'
```
