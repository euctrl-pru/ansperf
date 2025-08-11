## -------------------------------------------------------
## code to prepare `DATA-GANP-KPI-REQS` dataset goes here
## -------------------------------------------------------

# This script is kept in the repo under data-raw/ to reproduce or update the
# dataset. It is ultimately not exposed to the package user.

# How to maintain?
# KPI data requirements are kept in "overview" xlsx file in ./data-raw
# --> check an overwrite, as appropriate

data_ganp_kpi_reqs <- readxl::read_xlsx(here::here("data-raw","DATA-GANP-KPI-REQS.xlsx"))

# to make data available - write out to data folder as rda file!
usethis::use_data(data_ganp_kpi_reqs, overwrite = TRUE) # writes data to data sub-folder

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


usethis::use_data(DATA-GANP-KPI-REQS, overwrite = TRUE)
