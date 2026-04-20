test_that("NOArtisan bridge helpers use NOArtisan when it is loaded", {
  skip_if_not_installed("NOArtisan")

  attached_here <- FALSE
  if (!("package:NOArtisan" %in% search())) {
    library(NOArtisan)
    attached_here <- TRUE
  }

  on.exit({
    if (attached_here && ("package:NOArtisan" %in% search())) {
      detach("package:NOArtisan", unload = TRUE, character.only = TRUE)
    }
  }, add = TRUE)

  expect_equal(proportion_labeler()(0.123), NOArtisan::norwegian_percent(0.123))

  bridge_theme <- tidplotR:::default_plot_theme(base_size = 10)
  expected_theme <- NOArtisan::theme_STAMI(base_size = 10)

  expect_equal(bridge_theme$plot.title.position, expected_theme$plot.title.position)
})
