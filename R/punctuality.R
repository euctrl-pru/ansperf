#' Calculate arrival or departure punctuality
#' 
#' @description
#' What this set of functions should do:
#' 
#' * check that we have all the required data columns
#' * add the delay and delay group
#' * calculate the punctuality per phase
#'
#' @param .apdf tibble of data items 
#'
#' @return tibble of results
#' @export
#'
#' @examples
#' \dontrun{
#' mickey documentation needed
#' }
calc_punctuality <- function(.apdf){
  # check apdf version
  apdf_version <- check_punc_vars(.apdf)
  # full source
  if(apdf_version["SRC"]) {
    message("full apdf")
    punc <- .apdf |> 
      add_delay_and_dlygrp()
  }else{
    message("arrival and departure flavour to be developed")  
    punc <- NULL
  }
  return(punc)
}

#' @rdname calc_punctuality
#' @param .apdf APDF tibble
#' @return apdf_version vector of boolean flags for format version
check_punc_vars <- function(.apdf){
  # check apdf
  apdf_version <- c(
      SRC = all(c("ADEP","ADES","BLOCK_TIME","SCHED_TIME","PHASE") %in% colnames(.apdf))
    , ARR = all(c("ICAO","SIBT","AIBT") %in% colnames(.apdf))
    , DEP = all(c("ICAO","SOBT","AOBT") %in% colnames(.apdf))
    )
  return(apdf_version)
}

#' @rdname calc_punctuality
#' @importFrom rlang .data
add_delay_and_dlygrp <- function(.apdf){
  tmp <- .apdf |> 
    dplyr::mutate(
      BLOCK_DLY = difftime(.data$BLOCK_TIME
                                 , .data$SCHED_TIME, units = "mins") |> 
                        as.numeric()
    , DLY_GRP = dplyr::case_when(
        -Inf < .data$BLOCK_DLY & .data$BLOCK_DLY <= -60 ~ "(-INF,-60]"
      , -60 <  .data$BLOCK_DLY & .data$BLOCK_DLY <= -55 ~ "(-60,-55]"
      , -55 <  .data$BLOCK_DLY & .data$BLOCK_DLY <= -50 ~ "(-55,-50]"
      , -50 <  .data$BLOCK_DLY & .data$BLOCK_DLY <= -45 ~ "(-50,-45]"
      , -45 <  .data$BLOCK_DLY & .data$BLOCK_DLY <= -40 ~ "(-45,-40]"
      , -40 <  .data$BLOCK_DLY & .data$BLOCK_DLY <= -35 ~ "(-40,-35]"
      , -35 < .data$BLOCK_DLY & .data$BLOCK_DLY <= -30 ~ "(-35,-30]"
      , -30 < .data$BLOCK_DLY & .data$BLOCK_DLY <= -25 ~ "(-30,-25]"
      , -25 < .data$BLOCK_DLY & .data$BLOCK_DLY <= -20 ~ "(-25,-20]"
      , -20 < .data$BLOCK_DLY & .data$BLOCK_DLY <= -15 ~ "(-20,-15]"
      , -15 < .data$BLOCK_DLY & .data$BLOCK_DLY <= -10 ~ "(-15,-10]"
      , -10 < .data$BLOCK_DLY & .data$BLOCK_DLY <= - 5 ~ "(-10,-5]"
      ,  -5 < .data$BLOCK_DLY & .data$BLOCK_DLY <=   0 ~ "(-5,0]"
      ,   0 < .data$BLOCK_DLY & .data$BLOCK_DLY <=   5 ~ "(0,5)"
      ,   5 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   10 ~ "[5,10)"
      ,  10 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   15 ~ "[10,15)"
      ,  15 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   20 ~ "[15,20)"
      ,  20 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   25 ~ "[20,25)"
      ,  25 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   30 ~ "[25,30)"
      ,  30 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   35 ~ "[30,35)"
      ,  35 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   40 ~ "[35,40)"
      ,  40 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   45 ~ "[40,45)"
      ,  45 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   50 ~ "[45,50)"
      ,  50 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   55 ~ "[50,55)"
      ,  55 <= .data$BLOCK_DLY & .data$BLOCK_DLY <   60 ~ "[55,60)"
      ,  60 <= .data$BLOCK_DLY & .data$BLOCK_DLY <  Inf ~ "[60,INF)"
      , TRUE ~ NA_character_
      ) # end case_when
    )
}


dly_order <-   c(
  "(-INF,-60]"
  ,"(-60,-55]","(-55,-50]","(-50,-45]","(-45,-40]"
  ,"(-40,-35]","(-35,-30]","(-30,-25]","(-25,-20]"
  ,"(-20,-15]","(-15,-10]","(-10,-5]","(-5,0]"
  ,"(0,5)","[5,10)","[10,15)","[15,20)"
  ,"[20,25)","[25,30)","[30,35)","[35,40)"
  ,"[40,45)","[45,50)","[50,55)","[55,60)"
  ,"[60,INF)"
)

#' @rdname calc_punctuality
#' @param .dlys tible of delays
#' @param .dly_order vector of sorted ordering
#' @importFrom rlang .data
pivot_daily_dly_by_grp <- function(.dlys, .dly_order = dly_order){
  tmp <- .dlys  |>  
    dplyr::select(.data$ICAO, DATE = .data$DOF, .data$PHASE, .data$BLOCK_DLY, .data$DLY_GRP) |> 
    tidyr::pivot_wider(id_cols = c("ICAO","DATE","PHASE"),
                       names_from = "DLY_GRP",
                       values_from = "BLOCK_DLY",
                       values_fn = function(x) sum(!is.na(x))
                       , values_fill = 0
    ) |> 
    dplyr::mutate(VALID = rowSums(dplyr::across(dplyr::where(is.numeric))) ) |> 
    dplyr::select(.data$ICAO, .data$DATE, .data$PHASE
                  , .data$VALID, dplyr::any_of(dly_order)
                  )
  
  # check if groups exist
  missing_cols <- setdiff(dly_order, colnames(tmp))
  if(length(missing_cols) > 0){
    tmp[missing_cols] <- 0    # add missing columns and set to zero
    tmp <- tmp |>            # order them in desired sequence
      dplyr::select(.data$ICAO, .data$DATE
                    , .data$PHASE, .data$VALID
                    , dplyr::all_of(dly_order)
                    )
  }
  return(tmp)
}

#' @rdname calc_punctuality
#' @description
#' Early (-15,-5]","Early (-5,0]","Late (0,5)","Late [5,15)","Within (-5,5)","Within (-15,15)"
#' @param .dlys_wide summary pivot tibble with delays in wide format
#' @importFrom rlang .data
calc_earlylatewithin_bins <- function(.dlys_wide){
  tmp <- .dlys_wide |> 
    dplyr::mutate(
       `Early (-15,-5]` = .data[["(-15,-10]"]] + .data[["(-10,-5]"]]
      ,`Early (-5,0]`   = .data[["(-5,0]"]]
      ,`Late (0,5)`     = .data[["(0,5)"]]
      ,`Late [5,15)`    = .data[["[5,10)"]] + .data[["[10,15)"]] 
      ,`Within (-5,5)`  = .data[["Early (-5,0]"]] + .data[["Late (0,5)"]]
      ,`Within (-15,15)`= .data[["Early (-15,-5]"]] + .data[["Within (-5,5)"]] + .data[["Late [5,15)"]] 
    )
}