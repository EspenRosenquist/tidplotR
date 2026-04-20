normalize_risk_categories <- function(risk_categories) {
  required <- c("riskLevel", "label")
  if (!is.data.frame(risk_categories) || !all(required %in% names(risk_categories))) {
    stop("risk_categories must be a data.frame with columns riskLevel and label")
  }

  normalized <- data.frame(
    riskLevel = as.integer(risk_categories$riskLevel),
    label = as.character(risk_categories$label),
    stringsAsFactors = FALSE
  )

  if ("colour" %in% names(risk_categories)) {
    normalized$colour <- as.character(risk_categories$colour)
  }

  normalized[order(normalized$riskLevel), , drop = FALSE]
}

as_plot_margin <- function(margin_mm) {
  if (is.null(margin_mm)) {
    return(NULL)
  }

  if (!is.numeric(margin_mm) || length(margin_mm) != 4L || any(is.na(margin_mm))) {
    stop("margin_mm must be NULL or a numeric vector of length 4")
  }

  ggplot2::margin(
    t = margin_mm[[1]],
    r = margin_mm[[2]],
    b = margin_mm[[3]],
    l = margin_mm[[4]],
    unit = "mm"
  )
}

validate_named_palette <- function(palette) {
  if (!is.character(palette) || is.null(names(palette)) || !length(palette)) {
    stop("palette must be a named character vector")
  }
}

ensure_parent_dir <- function(path) {
  dir_path <- dirname(path)
  if (!dir.exists(dir_path)) {
    dir.create(dir_path, recursive = TRUE, showWarnings = FALSE)
  }

  invisible(path)
}

validate_dimension_mm <- function(value, arg) {
  if (!is.numeric(value) || length(value) != 1L || is.na(value) || value <= 0) {
    stop(sprintf("%s must be a single positive number", arg))
  }

  as.numeric(value)
}

#' Plot indicator value distribution
#'
#' @param value_dist_df Aggregated value distribution with `value`, `andel_n`,
#'   and `riskLevel` columns.
#' @param indicator_def Indicator definition list.
#' @param risk_categories Data frame with `riskLevel` and `label`.
#' @param palette Optional named color vector keyed by risk label.
#' @param base_family Optional font family for plot text. When `NULL`, uses the
#'   default `NOArtisan` family if that package is loaded, otherwise `"sans"`.
#' @param base_size Base font size for the plot theme.
#' @param margin_mm Optional numeric vector of plot margins in millimeters:
#'   `c(top, right, bottom, left)`.
#' @return A `ggplot` object or `NULL` when no data.
#' @seealso [ggplot2::ggplot()], [scales::percent_format()].
#' @examples
#' indicator_def <- list(
#'   id = "def01",
#'   x_breaks = c(1, 2, 3, 4),
#'   x_labels = c("1", "2", "3", "4"),
#'   x_vertical_lines = c(2, 3),
#'   xlab = "Example bins"
#' )
#' risk_categories <- data.frame(
#'   riskLevel = 1:4,
#'   label = c("low", "medium", "high", "critical"),
#'   colour = c("#53A63A", "#F9E49D", "#E88D21", "#AF2F2C"),
#'   stringsAsFactors = FALSE
#' )
#' palette <- stats::setNames(risk_categories$colour, risk_categories$label)
#' value_df <- data.frame(
#'   indicator_id = rep("def01", 4),
#'   value = 1:4,
#'   riskLevel = 1:4,
#'   andel_n = c(0.42, 0.28, 0.19, 0.11),
#'   stringsAsFactors = FALSE
#' )
#' plot_value_distribution(
#'   value_df,
#'   indicator_def = indicator_def,
#'   risk_categories = risk_categories,
#'   palette = palette
#' )
#' @export
plot_value_distribution <- function(value_dist_df,
                                    indicator_def,
                                    risk_categories,
                                    palette = NULL,
                                    base_family = NULL,
                                    base_size = 9,
                                    margin_mm = NULL) {
  if (!nrow(value_dist_df)) {
    return(NULL)
  }

  risk_categories <- normalize_risk_categories(risk_categories)
  fallback_palette <- NULL
  if ("colour" %in% names(risk_categories)) {
    fallback_palette <- stats::setNames(risk_categories$colour, risk_categories$label)
  }
  palette <- resolve_palette(risk_categories$label, palette = palette, fallback = fallback_palette)

  risk_map <- stats::setNames(risk_categories$label, as.character(risk_categories$riskLevel))
  df <- value_dist_df
  df$risk <- risk_map[as.character(df$riskLevel)]
  df$risk <- factor(df$risk, levels = risk_categories$label, ordered = TRUE)
  df <- df[order(df$value), , drop = FALSE]

  x_breaks <- indicator_def$x_breaks
  x_labels <- indicator_def$x_labels %||% x_breaks
  x_limits <- indicator_def$x_limits
  if (is.null(x_limits)) {
    x_limits <- c(min(x_breaks) - 0.5, max(x_breaks) + 0.5)
  }

  plot <- ggplot2::ggplot(df, ggplot2::aes(x = value, y = andel_n, fill = risk)) +
    ggplot2::geom_col(width = 0.9) +
    ggplot2::scale_x_continuous(
      breaks = x_breaks,
      labels = x_labels,
      limits = x_limits,
      expand = ggplot2::expansion(mult = c(0, 0))
    ) +
    ggplot2::scale_y_continuous(
      labels = proportion_labeler(),
      expand = ggplot2::expansion(mult = c(0, 0.06))
    ) +
    ggplot2::scale_fill_manual(values = palette, drop = FALSE, guide = "none") +
    ggplot2::labs(x = indicator_def$xlab %||% NULL, y = NULL) +
    default_plot_theme(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank()
    )

  vertical_lines <- indicator_def$x_vertical_lines %||% numeric()
  if (length(vertical_lines)) {
    plot <- plot + ggplot2::geom_vline(
      xintercept = vertical_lines + 0.5,
      colour = "#E6E6E6",
      linewidth = 0.4
    )
  }

  plot_margin <- as_plot_margin(margin_mm)
  if (!is.null(plot_margin)) {
    plot <- plot + ggplot2::theme(plot.margin = plot_margin)
  }

  plot
}

#' Plot entity risk comparison
#'
#' @param risk_dist_df Aggregated risk distribution.
#' @param risk_categories Data frame with `riskLevel` and `label`.
#' @param palette Optional named color vector keyed by risk label.
#' @param entity_levels Ordered entity labels.
#' @param base_family Optional font family for plot text. When `NULL`, uses the
#'   default `NOArtisan` family if that package is loaded, otherwise `"sans"`.
#' @param base_size Base font size for the plot theme.
#' @param margin_mm Optional numeric vector of plot margins in millimeters:
#'   `c(top, right, bottom, left)`.
#' @return A `ggplot` object or `NULL` when no data.
#' @seealso [ggplot2::ggplot()], [scales::percent_format()].
#' @examples
#' risk_categories <- data.frame(
#'   riskLevel = 1:4,
#'   label = c("low", "medium", "high", "critical"),
#'   colour = c("#53A63A", "#F9E49D", "#E88D21", "#AF2F2C"),
#'   stringsAsFactors = FALSE
#' )
#' palette <- stats::setNames(risk_categories$colour, risk_categories$label)
#' risk_df <- data.frame(
#'   indicator_id = rep("def01", 8),
#'   entity = rep(c("bedriften", "alle"), each = 4),
#'   riskLevel = rep(1:4, 2),
#'   andel_n = c(0.38, 0.30, 0.20, 0.12, 0.45, 0.27, 0.18, 0.10),
#'   stringsAsFactors = FALSE
#' )
#' plot_risk_comparison(
#'   risk_df,
#'   risk_categories = risk_categories,
#'   palette = palette
#' )
#' @export
plot_risk_comparison <- function(risk_dist_df,
                                 risk_categories,
                                 palette = NULL,
                                 entity_levels = c("bedriften", "alle"),
                                 base_family = NULL,
                                 base_size = 9,
                                 margin_mm = NULL) {
  if (!nrow(risk_dist_df)) {
    return(NULL)
  }

  risk_categories <- normalize_risk_categories(risk_categories)
  fallback_palette <- NULL
  if ("colour" %in% names(risk_categories)) {
    fallback_palette <- stats::setNames(risk_categories$colour, risk_categories$label)
  }
  palette <- resolve_palette(risk_categories$label, palette = palette, fallback = fallback_palette)

  risk_map <- stats::setNames(risk_categories$label, as.character(risk_categories$riskLevel))
  df <- risk_dist_df
  df$risk <- risk_map[as.character(df$riskLevel)]
  df$risk <- factor(df$risk, levels = risk_categories$label, ordered = TRUE)
  df$entity <- factor(as.character(df$entity), levels = entity_levels, ordered = TRUE)

  plot <- ggplot2::ggplot(df, ggplot2::aes(y = entity, x = andel_n, fill = risk)) +
    ggplot2::geom_col(position = "stack", width = 0.6) +
    ggplot2::scale_fill_manual(values = palette, drop = FALSE, guide = "none") +
    ggplot2::scale_x_continuous(
      labels = proportion_labeler(),
      limits = c(0, 1.1),
      expand = ggplot2::expansion(mult = c(0, 0))
    ) +
    ggplot2::labs(x = NULL, y = NULL) +
    default_plot_theme(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_blank()
    )

  plot_margin <- as_plot_margin(margin_mm)
  if (!is.null(plot_margin)) {
    plot <- plot + ggplot2::theme(plot.margin = plot_margin)
  }

  plot
}

#' Plot stacked context-level risk distribution
#'
#' @param dist_df Aggregated context/risk distribution with `context`, `pct`,
#'   and `risk_level`.
#' @param palette Optional named color vector keyed by risk level labels.
#' @param context_levels Ordered context labels.
#' @param base_family Optional font family for plot text. When `NULL`, uses the
#'   default `NOArtisan` family if that package is loaded, otherwise `"sans"`.
#' @param base_size Base font size for the plot theme.
#' @param title Optional plot title.
#' @param y_lab Y-axis label.
#' @param legend_position Legend position passed to `ggplot2::theme()`.
#' @return A `ggplot` object or `NULL` when no data.
#' @seealso [ggplot2::ggplot()], [scales::label_number()].
#' @examples
#' dist_df <- data.frame(
#'   context = c("company", "company", "baseline", "baseline"),
#'   risk_level = c("low", "high", "low", "medium"),
#'   pct = c(62.5, 37.5, 55.0, 45.0),
#'   stringsAsFactors = FALSE
#' )
#' palette <- c(low = "#4caf50", medium = "#ffb300", high = "#e53935")
#' plot_context_risk_distribution(dist_df, palette = palette, title = "IND01")
#' @export
plot_context_risk_distribution <- function(dist_df,
                                           palette = NULL,
                                           context_levels = c("company", "baseline"),
                                           base_family = NULL,
                                           base_size = 9,
                                           title = NULL,
                                           y_lab = "Percent of weeks",
                                           legend_position = "bottom") {
  if (!nrow(dist_df)) {
    return(NULL)
  }

  required <- c("context", "pct", "risk_level")
  if (!all(required %in% names(dist_df))) {
    stop("dist_df must include context, pct, and risk_level")
  }

  palette <- resolve_palette(unique(as.character(dist_df$risk_level)), palette = palette)

  df <- dist_df
  df$context <- factor(as.character(df$context), levels = context_levels, ordered = TRUE)
  df$risk_level <- factor(as.character(df$risk_level), levels = names(palette), ordered = TRUE)

  ggplot2::ggplot(df, ggplot2::aes(x = context, y = pct, fill = risk_level)) +
    ggplot2::geom_col(width = 0.6) +
    ggplot2::scale_fill_manual(values = palette, drop = FALSE) +
    ggplot2::scale_y_continuous(
      labels = percent_number_labeler(),
      expand = ggplot2::expansion(mult = c(0, 0.05))
    ) +
    ggplot2::labs(title = title, x = NULL, y = y_lab) +
    default_plot_theme(base_size = base_size, base_family = base_family) +
    ggplot2::theme(legend.position = legend_position)
}

#' Plot weekly risk levels as a heatmap
#'
#' @param weekly_df Weekly risk data with `week`, `context`, and `risk_level`.
#' @param palette Optional named color vector keyed by risk level labels.
#' @param context_levels Ordered context labels.
#' @param base_family Optional font family for plot text. When `NULL`, uses the
#'   default `NOArtisan` family if that package is loaded, otherwise `"sans"`.
#' @param base_size Base font size for the plot theme.
#' @param title Optional plot title.
#' @param x_lab X-axis label.
#' @param tile_colour Tile border color.
#' @return A `ggplot` object or `NULL` when no data.
#' @seealso [ggplot2::ggplot()].
#' @examples
#' weekly_df <- data.frame(
#'   indicator_id = rep("IND01", 8),
#'   week = rep(1:4, 2),
#'   context = rep(c("company", "baseline"), each = 4),
#'   risk_level = c("low", "medium", "high", "low", "low", "low", "medium", "medium"),
#'   stringsAsFactors = FALSE
#' )
#' palette <- c(low = "#4caf50", medium = "#ffb300", high = "#e53935")
#' plot_weekly_risk_heatmap(weekly_df, palette = palette, title = "IND01 weekly risk")
#' @export
plot_weekly_risk_heatmap <- function(weekly_df,
                                     palette = NULL,
                                     context_levels = c("company", "baseline"),
                                     base_family = NULL,
                                     base_size = 8,
                                     title = NULL,
                                     x_lab = "Week",
                                     tile_colour = "white") {
  if (!nrow(weekly_df)) {
    return(NULL)
  }

  required <- c("week", "context", "risk_level")
  if (!all(required %in% names(weekly_df))) {
    stop("weekly_df must include week, context, and risk_level")
  }

  palette <- resolve_palette(unique(as.character(weekly_df$risk_level)), palette = palette)

  df <- weekly_df
  df$context <- factor(as.character(df$context), levels = context_levels, ordered = TRUE)
  df$risk_level <- factor(as.character(df$risk_level), levels = names(palette), ordered = TRUE)

  ggplot2::ggplot(df, ggplot2::aes(x = week, y = context, fill = risk_level)) +
    ggplot2::geom_tile(color = tile_colour) +
    ggplot2::scale_fill_manual(values = palette, drop = FALSE, guide = "none") +
    ggplot2::labs(title = title, x = x_lab, y = NULL) +
    default_plot_theme(base_size = base_size, base_family = base_family)
}

#' Plot monthly employee measurement coverage
#'
#' @param df Aggregated monthly coverage with `month` and `employee_count`.
#' @param bar_fill Fill color for the bars.
#' @param line_colour Line color for the overlay.
#' @param point_colour Point color for the overlay.
#' @param y_lab Y-axis label.
#' @param base_family Optional font family for plot text. When `NULL`, uses the
#'   default `NOArtisan` family if that package is loaded, otherwise `"sans"`.
#' @param base_size Base font size for the plot theme.
#' @return A `ggplot` object or `NULL` when no data.
#' @seealso [ggplot2::ggplot()].
#' @examples
#' coverage_df <- data.frame(
#'   month = as.Date(c("2024-01-01", "2024-02-01", "2024-03-01")),
#'   employee_count = c(12L, 15L, 14L)
#' )
#' plot_monthly_measurement_coverage(coverage_df)
#' @export
plot_monthly_measurement_coverage <- function(df,
                                              bar_fill = "#223A76",
                                              line_colour = "#51BAE8",
                                              point_colour = "#51BAE8",
                                              y_lab = "Ansatte med malinger",
                                              base_family = NULL,
                                              base_size = 9) {
  if (!nrow(df)) {
    return(NULL)
  }

  required <- c("month", "employee_count")
  if (!all(required %in% names(df))) {
    stop("df must include month and employee_count")
  }

  plot_df <- df
  plot_df$month <- as.Date(plot_df$month)
  plot_df <- plot_df[!is.na(plot_df$month), , drop = FALSE]
  plot_df <- plot_df[order(plot_df$month), , drop = FALSE]

  if (!nrow(plot_df)) {
    return(NULL)
  }

  month_label <- format(plot_df$month, "%m/%Y")
  plot_df$month_label <- factor(month_label, levels = month_label, ordered = TRUE)

  ggplot2::ggplot(plot_df, ggplot2::aes(x = month_label, y = employee_count, group = 1)) +
    ggplot2::geom_col(fill = bar_fill, width = 0.72) +
    ggplot2::geom_line(linewidth = 0.5, colour = line_colour) +
    ggplot2::geom_point(size = 1.8, colour = point_colour) +
    ggplot2::labs(x = NULL, y = y_lab) +
    default_plot_theme(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_text(angle = 0, hjust = 0.5)
    )
}

#' Write a plot to fixed-size SVG
#'
#' @param plot `ggplot` object to render.
#' @param path Destination file path.
#' @param width_mm Width in millimeters.
#' @param height_mm Height in millimeters.
#' @return The written path.
#' @seealso [svglite::svglite()], [ggplot2::ggplot()].
#' @examples
#' coverage_df <- data.frame(
#'   month = as.Date(c("2024-01-01", "2024-02-01")),
#'   employee_count = c(12L, 15L)
#' )
#' plot <- plot_monthly_measurement_coverage(coverage_df)
#' path <- tempfile(fileext = ".svg")
#' write_svg(plot, path, width_mm = 120, height_mm = 70)
#' file.exists(path)
#' unlink(path)
#' @export
write_svg <- function(plot, path, width_mm, height_mm) {
  width_mm <- validate_dimension_mm(width_mm, "width_mm")
  height_mm <- validate_dimension_mm(height_mm, "height_mm")

  ensure_parent_dir(path)
  svglite::svglite(path, width = width_mm / 25.4, height = height_mm / 25.4)
  on.exit(grDevices::dev.off(), add = TRUE)
  print(plot)
  path
}
