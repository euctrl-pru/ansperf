#' Establish the reference data set for the additional taxi-in/taxi-out method.
#'
#' @param refdf data frame/tibble of taxi-times serving as reference data set
#' @param variant of the determination of the reference times (i.e., GANP, PBWG)
#' @param ref_period the reference period (currently: year)
#'
#' @importFrom stats quantile
#'
build_txxt_reference <- function(refdf, variant = NULL, ref_period = NULL){
  # variant and ref_period given?
  stopifnot("required parameters 'variant' and/or 'reference period' missing!" = !is.null(variant), !is.null(ref_period))
  stopifnot("wrong variant!" = variant %in% c("GANP", "PBWG"))
  # TO DO - CHECK refdf INPUT and other stuff
  # ....

  # reshape the input data
  df_clean <- refdf |>
    reshape_ref_txxt() |>
    prepare_ref_txxt()

  # GANP - 20th percentile
  if(variant %in% "GANP"){
   txxt_ref <- df_clean |>
     establish_ref_txxt_ganp(ref_period)
  }

  # PBWG - average of 5th and 15th percentile
  if(variant %in% "PBWG"){
    txxt_ref <- df_clean |>
      establish_ref_txxt_pbwg(ref_period)
  }

  # combined reference data set
  if(variant %in% "GANPPBWG"){
    message("GANPPBWG variant not yet implemented. Come back soon!")
    return() # empty return
  }

  return(txxt_ref)
}

reshape_ref_txxt <- function(ref_df){
  # check APDF
  apdf_cols <- c("ADEP","ADES","PHASE","BLOCK_TIME","MVT_TIME", "STND","RWY")
  is_apdf   <- apdf_cols %in% colnames(ref_df)

  # append "reporting" airport and trim payload
  ref_df <- ref_df |>
    dplyr::select(dplyr::all_of(apdf_cols), dplyr::everything()) |>
    dplyr::mutate(
      ICAO = dplyr::case_when(
         PHASE == "ARR" ~ ADES
        ,PHASE == "DEP" ~ ADEP
        , .default = NA
      )
      , .before = 1     # put ICAO to the front
    )
  return(ref_df)
}

prepare_ref_txxt <- function(payload){
  refs_raw <- payload |>
    dplyr::mutate(
      TXXT = dplyr::case_when(           # default taxi times to min, check phase
         PHASE == "ARR" ~ difftime(BLOCK_TIME, MVT_TIME, units = "min") |> as.numeric()
        ,PHASE == "DEP" ~ difftime(MVT_TIME, BLOCK_TIME, units = "min") |> as.numeric()
        )
      ,.after = .data$RWY
    )
  return(refs_raw)
}

establish_ref_txxt_ganp <- function(refs_prep, ref_period){
  this_refs <- refs_prep |>
    dplyr::filter(lubridate::year(.data$BLOCK_TIME) %in% .data$ref_period) |>
    dplyr::group_by(.data$ICAO, .data$PHASE, .data$STND, .data$RWY) |>      # group to catch multiple airports/phases
    dplyr::reframe(
       REF_GANP   = stats::quantile(.data$TXXT, probs = 0.2, na.rm = TRUE)
      ,REF_YEAR   = .data$ref_period
      ,GANP_VALID = sum( (!is.na(.data$STND) | !is.na(.data$RWY)) & !is.na(.data$TXXT) )
      ,GANP_SMPL  = dplyr::n()

      )

  return(this_refs)
}

#' @description
#' The PBWG method uses the average of the sub-sample defined by the 5th and 15th percentile.
#' This implementation labels the sample and counts the cases, both per grouping and for the subsample.
#' PBWG considers a stand-grouping mechanism that requires additional prep work (or some sophisticated coding here - to be developed).
#'
establish_ref_txxt_pbwg <- function(refs_prep, ref_period){
  this_refs <- refs_prep |>
    dplyr::filter(lubridate::year(.data$BLOCK_TIME) %in% ref_period) |>
    dplyr::group_by(.data$ICAO, .data$PHASE, .data$STND, .data$RWY) |>
    # determine the subsample of 5th and 15th percentile |>
    dplyr::mutate(
        PBWG_P05   = stats::quantile(.data$TXXT, probs = 0.05, na.rm = TRUE)
      , PBWG_P15   = stats::quantile(.data$TXXT, probs = 0.15, na.rm = TRUE)
      # between: left <= x <= right
      , is_P05_P15 = dplyr::between(.data$TXXT, .data$PBWG_P05, .data$PBWG_P15)
    ) |>
    dplyr::reframe(
        PBWG_P05   = unique(.data$PBWG_P05)
      , PBWG_P15   = unique(.data$PBWG_P15)
      , PBWG_VALID = sum( (!is.na(.data$STND) | !is.na(.data$RWY)) & !is.na(.data$TXXT) )
      , PBWG_SMPL  = dplyr::n()
      , PBWG_P05P15= sum(.data$is_P05_P15)
      , PBWG_REF   = mean(.data$TXXT[.data$is_P05_P15])
      ) |>
    dplyr::mutate(
      PBWG_REF2   = (.data$PBWG_P05 + .data$PBWG_P15) / 2      # average of
      )
   return(this_refs)
}
