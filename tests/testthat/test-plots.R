test_that("value and risk plots build from standalone aggregated inputs", {
  indicator_def <- list(
    id = "def01",
    x_breaks = c(1, 2, 3, 4),
    x_labels = c("1", "2", "3", "4"),
    x_vertical_lines = c(2, 3),
    xlab = "Example bins"
  )
  risk_categories <- data.frame(
    riskLevel = 1:4,
    label = c("low", "medium", "high", "critical"),
    colour = c("#53A63A", "#F9E49D", "#E88D21", "#AF2F2C"),
    stringsAsFactors = FALSE
  )
  palette <- stats::setNames(risk_categories$colour, risk_categories$label)

  value_df <- data.frame(
    indicator_id = rep("def01", 4),
    value = 1:4,
    riskLevel = 1:4,
    andel_n = c(0.41, 0.29, 0.18, 0.12),
    stringsAsFactors = FALSE
  )
  risk_df <- data.frame(
    indicator_id = rep("def01", 8),
    entity = rep(c("bedriften", "alle"), each = 4),
    riskLevel = rep(1:4, 2),
    andel_n = c(0.35, 0.33, 0.20, 0.12, 0.46, 0.24, 0.18, 0.12),
    stringsAsFactors = FALSE
  )

  value_plot <- plot_value_distribution(
    value_dist_df = value_df,
    indicator_def = indicator_def,
    risk_categories = risk_categories,
    palette = NULL,
    margin_mm = c(0, 0, 1, 0)
  )
  risk_plot <- plot_risk_comparison(
    risk_dist_df = risk_df,
    risk_categories = risk_categories,
    palette = NULL
  )

  expect_s3_class(value_plot, "ggplot")
  expect_s3_class(risk_plot, "ggplot")

  svg_path <- tempfile(fileext = ".svg")
  write_svg(value_plot, svg_path, width_mm = 170, height_mm = 80)
  expect_true(file.exists(svg_path))
})

test_that("monthly coverage plot builds from aggregated monthly coverage data", {
  coverage_df <- data.frame(
    month = as.Date(c("2024-01-01", "2024-02-01", "2024-03-01")),
    employee_count = c(12L, 15L, 14L),
    stringsAsFactors = FALSE
  )
  coverage_plot <- plot_monthly_measurement_coverage(coverage_df)

  expect_s3_class(coverage_plot, "ggplot")
})

test_that("context distribution and weekly heatmap plots build from synthetic weekly risk data", {
  weekly_df <- data.frame(
    indicator_id = rep("IND01", 8),
    week = rep(1:4, 2),
    context = rep(c("company", "baseline"), each = 4),
    risk_level = c("low", "medium", "high", "low", "low", "low", "medium", "medium"),
    stringsAsFactors = FALSE
  )

  dist_counts <- aggregate(
    list(count = rep(1, nrow(weekly_df))),
    by = list(context = weekly_df$context, risk_level = weekly_df$risk_level),
    FUN = sum
  )
  dist_totals <- aggregate(list(total = dist_counts$count), by = list(context = dist_counts$context), FUN = sum)
  dist_df <- merge(dist_counts, dist_totals, by = "context")
  dist_df$pct <- round(100 * dist_df$count / dist_df$total, 1)

  palette <- c(low = "#4caf50", medium = "#ffb300", high = "#e53935")

  context_plot <- plot_context_risk_distribution(dist_df, palette = NULL, title = "IND01")
  heatmap_plot <- plot_weekly_risk_heatmap(weekly_df, palette = NULL, title = "IND01 weekly risk")

  expect_s3_class(context_plot, "ggplot")
  expect_s3_class(heatmap_plot, "ggplot")
})
