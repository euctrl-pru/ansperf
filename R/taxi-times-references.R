#' @importFrom stats quantile
#'
build_txxt_reference <- function(refdf){

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

establish_reference_ganp <- function(refs_prep, ref_year){
  this_refs <- refs_prep |>
    dplyr::filter(lubridate::year(.data$BLOCK_TIME) %in% ref_year) |>
    dplyr::group_by(.data$ICAO, .data$PHASE, .data$STND, .data$RWY) |>      # group to catch multiple airports/phases
    dplyr::reframe(
       REF_GANP   = stats::quantile(.data$TXXT, probs = 0.2)
      ,REF_YEAR   = ref_year
      ,GANP_VALID = sum( (!is.na(.data$STND) | !is.na(.data$RWY)) & !is.na(.data$TXXT) )
      ,GANP_SMPL  = dplyr::n()

      )

  return(this_refs)
}
