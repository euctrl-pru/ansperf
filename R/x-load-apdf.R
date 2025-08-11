#' Load example APDF data for an airport based on European data extraction.
#'
#' This data is provided for testing purposes.
#' We need to see whether to provide this data as part of the package to the end user.
#'
#' @param .apt character of airport location indicator, either EGLL, LSZH, or LTFM
#' @param .trim boolean to remove superflous columns from supplied tibble
#'
#' @return tibble of APDF data set
#' @export
#'
#' @examples
#' \dontrun{
#' ds <- load_apdf("LSZH")
#' }

load_apdf <- function(.apt, .trim = TRUE){
  ds <- read_apdf(.apt)
  if(isTRUE(.trim)){
    ds <- ds |> trim_ganp_cols()
  }
    ds <- ds |> make_nice_names_apdf()
  return(ds)
}

#' read the APDF file
#'
#' @param .apt ICAO location indicator of airport
read_apdf <- function(.apt){
  fn <- list.files("./data-src", pattern = .apt, full.names = TRUE)
  ds <- arrow::read_parquet(fn) |> tibble::as_tibble()
  return(ds)
}

#' nice names
#'
#' utility function to recode/rename column names
#'
#' @param .df APDF tibble/dataframe
#' @importFrom rlang .data

make_nice_names_apdf <- function(.df){
  rn_df <- .df
  oldnames <- names(rn_df)
  newnames <- gsub(pattern = "(AP_C_)|(AC_)|(_ICAO)|(_UTC)|(_CROSS)|(EA|IN)", replacement = "", x = oldnames)
  names(rn_df) <- newnames
  rn_df |> dplyr::rename(PHASE = .data$SRC_PHASE, TYPE = .data$ARCTYP)
}

#' GANP colspec from APDF
#'
#' define col naming convention for APDF data
colspec <- readr::cols_only(
  AP_C_FLTID      = readr::col_character(),
  AP_C_REG        = readr::col_character(),
  ADEP_ICAO       = readr::col_character(),
  ADES_ICAO       = readr::col_character(),
  MVT_TIME_UTC    = readr::col_datetime(format = "%d%.%m%.%Y %T"),
  BLOCK_TIME_UTC  = readr::col_datetime(format = "%d%.%m%.%Y %T"),
  SCHED_TIME_UTC  = readr::col_datetime(format = "%d%.%m%.%Y %T"),
  AP_C_FLTRUL     = readr::col_character(),
  ARCTYP          = readr::col_character(),
  AC_CLASS        = readr::col_character(),
  AP_C_RWY        = readr::col_character(),
  AP_C_STND       = readr::col_character(),
  SRC_PHASE       = readr::col_character(),
  C40_CROSS_TIME  = readr::col_datetime(format = "%d%.%m%.%Y %T"),
  C40_CROSS_LAT   = readr::col_double(),
  C40_CROSS_LON   = readr::col_double(),
  C40_CROSS_FL    = readr::col_double(),
  C40_BEARING     = readr::col_double(),
  C100_CROSS_TIME = readr::col_datetime(format = "%d%.%m%.%Y %T"),
  C100_CROSS_LAT  = readr::col_double(),
  C100_CROSS_LON  = readr::col_double(),
  C100_CROSS_FL   = readr::col_double(),
  C100_BEARING    = readr::col_double()
)

#' extract cols from APDF
#' @param .ds tibble with APDF variables
#' @importFrom rlang .data
trim_ganp_cols <- function(.ds){
  ds <- .ds |> dplyr::select(
    .data$AP_C_FLTID,
    .data$AP_C_REG,
    .data$ADEP_ICAO,
    .data$ADES_ICAO,
    .data$MVT_TIME_UTC,
    .data$BLOCK_TIME_UTC,
    .data$SCHED_TIME_UTC,
    .data$AP_C_FLTRUL,
    .data$ARCTYP,
    .data$AC_CLASS,
    .data$AP_C_RWY,
    .data$AP_C_STND,
    .data$SRC_PHASE,
    .data$C40_CROSS_TIME, .data$C40_CROSS_LAT, .data$C40_CROSS_LON,
    .data$C40_CROSS_FL, .data$C40_BEARING,
    .data$C100_CROSS_TIME, .data$C100_CROSS_LAT, .data$C100_CROSS_LON,
    .data$C100_CROSS_FL, .data$C100_BEARING
  )
  return(ds)
}
