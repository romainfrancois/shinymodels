library(testthat)
library(shinymodels)
source(test_path("helper.R"))

test_that("can accurately plot predicted probabilities vs true class plot", {
  skip_on_cran()
  data(cell_race)

  org <- organize_data(cell_race)
  org$predictions$.color <- "black"

  expect_error(
    plot_twoclass_obs_pred(org, org$y_name),
    "'class' is not a column in the dataset"
  )
  expect_error(
    plot_twoclass_obs_pred(org$predictions, y_name),
    "object 'y_name' not found"
  )
  a <- plot_twoclass_obs_pred(org$predictions, org$y_name)
  expect_snapshot_output(make_clean_snapshot(a))
})

test_that("can accurately plot confusion matrix plot", {
  skip_on_cran()
  data(cell_race)

  org <- organize_data(cell_race)
  org$predictions$.color <- "black"

  expect_error(
    plot_twoclass_conf_mat(org),
    "no applicable method for 'conf_mat' applied to an object of class"
  )
  b <- plot_twoclass_conf_mat(org$predictions)
  expect_snapshot_output(make_clean_snapshot(b))
})

test_that("can accurately plot predicted probabilities vs. a numeric column plot", {
  skip_on_cran()
  data(cell_race)

  org <- organize_data(cell_race)
  org$predictions$.color <- "black"

  expect_error(
    plot_twoclass_pred_numcol(org, org$y_name, "AXL"),
    "'class' is not a column in the dataset"
  )
  expect_error(
    plot_twoclass_pred_numcol(org$predictions, y_name, "AXL"),
    "object 'y_name' not found"
  )
  expect_warning(
    expect_error(
      plot_twoclass_pred_numcol(org$predictions, org$y_name, "potato"),
      "object 'potato' not found"
    ),
    "Ignoring unknown aesthetics"
  )
  expect_warning(
    c <- plot_twoclass_pred_numcol(org$predictions, org$y_name, "angle_ch_1"),
    "Ignoring unknown aesthetics"
  )
  expect_snapshot_output(make_clean_snapshot(c))
})

test_that("can accurately plot predicted probabilities vs. a factor column plot", {
  skip_on_cran()
  data(cell_race)

  org <- organize_data(cell_race)

  set.seed(1)
  org$predictions <-
    org$predictions %>%
    mutate(
      fact_col = sample(letters[1:2], nrow(org$predictions), replace = TRUE),
      fact_col = factor(fact_col),
      .color = "black"
    )

  expect_error(
    plot_twoclass_pred_factorcol(org, org$y_name, "fact_col"),
    "'class' is not a column in the dataset"
  )
  expect_error(
    plot_twoclass_pred_factorcol(org$predictions, y_name, "fact_col"),
    "object 'y_name' not found"
  )
  expect_warning(
    expect_error(
      plot_twoclass_pred_factorcol(org$predictions, org$y_name, "potato"),
      "object 'potato' not found"
    ),
    "Ignoring unknown aesthetics"
  )
  expect_warning(
    d <- plot_twoclass_pred_factorcol(org$predictions, org$y_name, "fact_col"),
    "Ignoring unknown aesthetics"
  )
  expect_snapshot_output(make_clean_snapshot(d))
})

test_that("can accurately plot the ROC curve", {
  skip_on_cran()
  data(cell_race)

  org <- organize_data(cell_race)
  org$predictions$.color <- "black"

  expect_error(
    plot_twoclass_roc(org, org$y_name),
    "'class' is not a column in the dataset"
  )
  expect_error(
    plot_twoclass_roc(org$predictions, y_name),
    "object 'y_name' not found"
  )
  e <- plot_twoclass_roc(org$predictions, org$y_name)
  expect_snapshot_output(make_clean_snapshot(e))
})

test_that("can accurately plot the PR curve", {
  skip_on_cran()
  data(cell_race)

  org <- organize_data(cell_race)
  org$predictions$.color <- "black"

  expect_error(
    plot_twoclass_pr(org, org$y_name),
    "'class' is not a column in the dataset"
  )
  expect_error(
    plot_twoclass_pr(org$predictions, y_name),
    "object 'y_name' not found"
  )
  expect_error(
    plot_twoclass_pr(org$predictions, "mpg"),
    "'mpg' is not a column in the dataset"
  )
  f <- plot_twoclass_pr(org$predictions, org$y_name)
  expect_snapshot_output(make_clean_snapshot(f))
})
