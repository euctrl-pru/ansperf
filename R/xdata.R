#' Load example APDF data for an airport
#'
#' @param .apt character of airport location indicator, either EGLL, LSZH, or LTFM
#'
#' @return tibble of APDF data set
#' @export
#'
#' @examples
#' #'\dontrun{
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
read_apdf <- function(.apt){
  fn <- list.files("./data-src", pattern = .apt, full.names = TRUE)
  ds <- arrow::read_parquet(fn) |> tibble::as_tibble()
  return(ds)
}

#' nice names
#' 
# utility function to recode/rename column names
make_nice_names_apdf <- function(.df){
  rn_df <- .df
  oldnames <- names(rn_df)
  newnames <- gsub(pattern = "(AP_C_)|(AC_)|(_ICAO)|(_UTC)|(_CROSS)|(EA|IN)", replacement = "", x = oldnames)
  names(rn_df) <- newnames
  rn_df |> dplyr::rename(PHASE = SRC_PHASE, TYPE = ARCTYP)
}

#' GANP colspec from APDF --------------------------------------------------
#' 
# define col naming convention for APDF data 
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
trim_ganp_cols <- function(.ds){
  ds <- .ds |> dplyr::select(
    AP_C_FLTID,
    AP_C_REG,
    ADEP_ICAO,
    ADES_ICAO,
    MVT_TIME_UTC,
    BLOCK_TIME_UTC,
    SCHED_TIME_UTC,
    AP_C_FLTRUL,
    ARCTYP,
    AC_CLASS,
    AP_C_RWY,
    AP_C_STND,
    SRC_PHASE,
    C40_CROSS_TIME, C40_CROSS_LAT, C40_CROSS_LON, C40_CROSS_FL, C40_BEARING,
    C100_CROSS_TIME, C100_CROSS_LAT, C100_CROSS_LON,C100_CROSS_FL, C100_BEARING
  )
  return(ds)
}