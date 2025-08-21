## code to prepare `DATA-APDF` dataset goes here

lszh <- load_apdf("LSZH")

data_apdf_sample <- lszh |>
  mutate(MONTH = lubridate::month(MVT_TIME)) |>
  dplyr::group_by(MONTH) |>
  dplyr::slice_sample(n = 100)

usethis::use_data(data_apdf_sample, overwrite = TRUE)
