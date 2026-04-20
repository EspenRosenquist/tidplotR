noartisan_is_loaded <- function() {
  "NOArtisan" %in% loadedNamespaces()
}

noartisan_export <- function(name) {
  if (!noartisan_is_loaded()) {
    return(NULL)
  }

  getExportedValue("NOArtisan", name)
}

default_plot_theme <- function(base_size, base_family = NULL) {
  if (noartisan_is_loaded()) {
    theme_fun <- noartisan_export("theme_STAMI")
    if (is.null(base_family)) {
      return(theme_fun(base_size = base_size))
    }

    return(theme_fun(base_size = base_size, base_family = base_family))
  }

  ggplot2::theme_minimal(
    base_size = base_size,
    base_family = if (is.null(base_family)) "sans" else base_family
  )
}

proportion_labeler <- function() {
  if (noartisan_is_loaded()) {
    return(noartisan_export("norwegian_percent"))
  }

  scales::label_percent(accuracy = 1, decimal.mark = ",", suffix = " %")
}

percent_number_labeler <- function() {
  scales::label_number(accuracy = 1, decimal.mark = ",", suffix = " %")
}

resolve_palette <- function(levels, palette = NULL, fallback = NULL) {
  levels <- unique(as.character(levels))
  levels <- levels[!is.na(levels)]

  if (!length(levels)) {
    stop("levels must contain at least one value")
  }

  if (!is.null(palette)) {
    validate_named_palette(palette)
    missing_levels <- setdiff(levels, names(palette))
    if (length(missing_levels)) {
      stop(
        sprintf(
          "palette must define colours for: %s",
          paste(missing_levels, collapse = ", ")
        )
      )
    }

    return(stats::setNames(as.character(palette[levels]), levels))
  }

  if (!is.null(fallback)) {
    if (is.null(names(fallback))) {
      if (length(fallback) != length(levels)) {
        stop("fallback palette must be named or match the number of levels")
      }

      return(stats::setNames(as.character(fallback), levels))
    }

    missing_levels <- setdiff(levels, names(fallback))
    if (!length(missing_levels)) {
      return(stats::setNames(as.character(fallback[levels]), levels))
    }
  }

  if (noartisan_is_loaded()) {
    palette_fun <- noartisan_export("getSTAMIpalett")
    colours <- palette_fun("ordinal", n = length(levels), .names = levels)
    return(stats::setNames(unname(colours), levels))
  }

  stats::setNames(scales::hue_pal()(length(levels)), levels)
}
