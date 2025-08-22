## code to prepare `DATA-APDF` dataset goes here

lszh <- load_apdf("LSZH")

data_apdf_sample <- lszh |>
  dplyr::mutate(MONTH = lubridate::month(MVT_TIME)) |>
  dplyr::group_by(MONTH) |>
  dplyr::slice_sample(n = 100) |>
  dplyr::ungroup() |>
  dplyr::select(-MONTH)

# deactivated to avoid erronuous write out/update!
# usethis::use_data(data_apdf_sample, overwrite = TRUE)
