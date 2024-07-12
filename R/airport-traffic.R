#' Title
#'
#' @param .apdf airport movement table 
#' @param .apt  (optional) trim results to specific airport
#' @param .yr   (optional) filter for annual results
#' @param ...   potential variables
#'
#' @return tibble of traffic counts
#' @export
#'
#' @examples
#' \dontrun{
#'   airport_daily_stats(my_apdf_data, "LSZH")
#' }
airport_daily_stats <- function(.apdf, .apt = NULL, .yr = NULL, ...){
  
  # todo - check entry and fail early
  df <- .apdf
  # check if variables are not in data set ----
  if (!("CLASS" %in% colnames(df))){
    usethis::ui_stop("Required variable(s) is(are) not in the data set.")
  }
  
  # check for European specifics in terms of regional (~ domestic) traffic
  ecac <- ecac_2digits()
  
  df <- df |>  dplyr::mutate( ICAO = .apt) 
  # append DOF - in not existing
  if(! "DOF" %in% colnames(df) ) df <- df |> append_dof()
  
  arr_dep <- df  |> 
    dplyr::group_by(.data$ICAO, .data$DOF) |>
    dplyr::summarise( 
           ARRS     = sum(.data$PHASE == "ARR", na.rm = TRUE)
          ,DEPS     = sum(.data$PHASE == "DEP", na.rm = TRUE)
          ,SRC_NA   = sum(is.na(.data$PHASE))
          ,.groups = "drop"
    )
  
  reg_arrs <- df |> dplyr::filter(.data$PHASE == "ARR") |>
    dplyr::mutate(ADEP_REG = dplyr::case_when(
      stringr::str_extract(.data$ADEP, pattern = "^[A-Z]{2}") %in% ecac ~ "EUR")
    ) |>
    dplyr::group_by(.data$ICAO, .data$DOF) |>
    dplyr::summarise(ARRS_REG = sum(.data$ADEP_REG %in% "EUR"))
  
  reg_deps <- df |> dplyr::filter(.data$PHASE == "DEP") |>
    dplyr::mutate(ADES_REG = dplyr::case_when(
      stringr::str_extract(.data$ADES, pattern = "^[A-Z]{2}") %in% ecac ~ "EUR")
    ) |>
    dplyr::group_by(.data$ICAO, .data$DOF) |>
    dplyr::summarise(DEPS_REG = sum(.data$ADES_REG %in% "EUR"))
  
  hml <- df |> dplyr::group_by(.data$ICAO, .data$DOF) |>
    dplyr::summarise( 
         HEL  = sum(.data$CLASS %in% "HEL", na.rm = TRUE)
        ,H    = sum(.data$CLASS %in% c("H"), na.rm = TRUE)
        ,M    = sum(.data$CLASS %in% c("M","MJ","MT"), na.rm = TRUE)
        ,L    = sum(.data$CLASS %in% c("L","LJ","LT","LP"), na.rm = TRUE)
        ,'NA' = sum(is.na(.data$CLASS))
        , .groups = "drop"
    )
  
  reg_tfc <- reg_arrs |> dplyr::left_join(reg_deps, by = c("ICAO","DOF"))
  apt_tfc <- arr_dep |>  dplyr::left_join(reg_tfc,  by = c("ICAO","DOF"))
  apt_tfc <- apt_tfc |>  dplyr::left_join(hml,      by = c("ICAO","DOF"))
  
  if(! is.null(.yr)){
    apt_tfc <- apt_tfc |> dplyr::filter(lubridate::year(.data$DOF) == .yr)
  }
  return(apt_tfc)
}


ecac_2digits <- function(){
  #------------- identification of domestic (aka regional) traffic == ECAC
  ECAC_North_West <- c("EB", "ED", "ET", "EG", "EH", "EI", "EK", "EL", "LF", "LN", "LO", "LS")
  ECAC_South_West <- c("GC", "GE", "LE", "LP", "LX")
  ECAC_North_East <- c("EE", "EF", "EN", "EP", "ES", "EV", "EY", "LK", "LZ", "UK")
  ECAC_South_East <- c("LA", "LB", "LC", "LD", "LG", "LH", "LI", "LJ", "LM", "LQ", "LR", "LT",
                       "LU", "LW", "LY", "UB", "UD", "UG")
  
  # TODO check remaining airports and fix ECAC Oceanic
  ecac <- c(ECAC_North_West,ECAC_North_East, ECAC_South_West, ECAC_South_East)
}