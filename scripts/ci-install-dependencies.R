# CI validates generic plots. Optional NOArtisan branding is a separate gate.
options(repos = c(CRAN = "https://cloud.r-project.org"), Ncpus = 2L)
description <- read.dcf("DESCRIPTION")
imports <- trimws(gsub("\\s*\\([^)]*\\)", "", strsplit(description[1, "Imports"], ",")[[1]]))
required <- unique(c(imports, "pkgload", "testthat"))
required <- setdiff(required, rownames(installed.packages(priority = c("base", "recommended"))))
install.packages(required)
missing <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) stop("Required CI packages unavailable: ", paste(missing, collapse = ", "))
