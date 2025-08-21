test_that("merge_var_mappings correctly overrides defaults", {
  defaults <- c(scheduled_time = "SOBT", actual_time = "AOBT")

  # Case 1: No user args → should return defaults unchanged
  expect_equal(merge_var_mappings(defaults), defaults)

  # Case 2: User overrides one column
  user_args <- list(scheduled_time = "DEP_TIME")
  expected <- c(scheduled_time = "DEP_TIME", actual_time = "AOBT")
  expect_equal(merge_var_mappings(defaults, user_args), expected)

  # Case 3: User overrides both columns
  user_args <- list(scheduled_time = "DEP_TIME", actual_time = "ACTUAL_DEP")
  expected <- c(scheduled_time = "DEP_TIME", actual_time = "ACTUAL_DEP")
  expect_equal(merge_var_mappings(defaults, user_args), expected)

  # Case 4: User provides NULL → should keep default
  user_args <- list(scheduled_time = NULL)
  expect_equal(merge_var_mappings(defaults, user_args), defaults)
})
