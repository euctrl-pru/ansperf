#' Add date-of-flight (DOF) to APDF
#'
#' @param .flts tibble of flights with a column BLOCK_TIME
#'
#' @return tibble with appended DOF column
#' @export
#'
#' @examples
#' \dontrun{
#' df_with_DOF <- df |> append_dof
#' }
#' @importFrom rlang .data
append_dof <- function(.flts){
  
  apdf_time_vars <- c("BLOCK_TIME", "MVT_TIME")
  
  if( any( apdf_time_vars %in% colnames(.flts) ) ){
    updated_df <- .flts |> 
      dplyr::mutate(
        DOF = dplyr::case_when(
          !is.na(BLOCK_TIME) ~ lubridate::date(BLOCK_TIME)
         , is.na(BLOCK_TIME) & !is.na(MVT_TIME) ~ lubridate::date(MVT_TIME)
         , TRUE ~ as.Date(NA)
         )
      )
  }
  updated_df
}
