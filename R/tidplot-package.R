#' tidplotR: Shared Time-Oriented Plot Helpers
#'
#' Shared infrastructure for generic time-oriented plots and deterministic SVG
#' export. The package is designed to work standalone on plain data frames or
#' alongside tidflowR and related report pipelines.
#'
#' See `vignette("tidplotR-overview")` for a package walkthrough and
#' `vignette("integration-with-tidflowR")` for tandem usage with tidflowR.
#'
#' @keywords internal
"_PACKAGE"

NULL

#' Null-coalescing infix helper
#'
#' Returns the right-hand side when the left-hand side is `NULL` or empty.
#'
#' @param x Value to test.
#' @param y Fallback value.
#' @return `x` when non-null/non-empty, otherwise `y`.
#' @keywords internal
`%||%` <- function(x, y) {
  if (is.null(x) || length(x) == 0) y else x
}