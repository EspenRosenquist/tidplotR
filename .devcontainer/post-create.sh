#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

Rscript --vanilla -e "repos <- c(CRAN = 'https://cloud.r-project.org'); install.packages(c('ggplot2', 'knitr', 'languageserver', 'pkgload', 'roxygen2', 'rmarkdown', 'scales', 'svglite', 'testthat'), repos = repos, INSTALL_opts = '--no-test-load')"