test_that("airport traffic returns data frame", {
  test_sample <- readr::read_csv("sample_apdf.csv") |> 
    airport_daily_stats(.apt = "LSZH")
  # fails with missing variables
  expect_error(test_sample |> rename(CLASS2 = CLASS))
  
  # returns daily stats
  expect_type(test_sample, "list")
  expect_s3_class(test_sample, "data.frame")
})
