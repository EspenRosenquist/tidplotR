.PHONY: document test smoke check

document:
	Rscript --vanilla -e 'roxygen2::roxygenise()'

test:
	Rscript --vanilla -e 'pkgload::load_all(export_all = FALSE, helpers = FALSE, quiet = TRUE); testthat::test_dir("tests/testthat", reporter = "summary")'

smoke:
	Rscript --vanilla -e 'pkgload::load_all(); coverage <- data.frame(month = as.Date(c("2024-01-01", "2024-02-01")), employee_count = c(12L, 15L)); plot <- plot_monthly_measurement_coverage(coverage); path <- tempfile(fileext = ".svg"); write_svg(plot, path, width_mm = 120, height_mm = 70); cat("svg: ", path, "\n", sep = "")'

check:
	R CMD check .
