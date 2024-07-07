## code to prepare `kpi_data_reqs` dataset goes here

# overview is kept in xlsx file in ./data-raw
# --> check an overwrite, as appropriate

kpi_data_reqs <- readxl::read_xlsx(here::here("data-raw","KPI-data-reqs.xlsx"))

usethis::use_data(kpi_data_reqs, overwrite = TRUE) # writes data to data sub-folder

# document data set; i.e. #' World Health Organization TB data
# #'
# #' A subset of data from the World Health Organization Global Tuberculosis
# #' Report ...
# #'
# #' @format ## `who`
# #' A data frame with 7,240 rows and 60 columns:
# #' \describe{
# #'   \item{country}{Country name}
# #'   \item{iso2, iso3}{2 & 3 letter ISO country codes}
# #'   \item{year}{Year}
# #'   ...
# #' }
# #' @source <https://www.who.int/teams/global-tuberculosis-programme/data>
# "who"
