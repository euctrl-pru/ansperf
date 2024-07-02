#' Add date-of-flight (DOF) to APDF
#'
#' @param .flts 
#'
#' @return tibble with appended DOF column
#' @export
#'
#' @examples
#' \dontrun{
#' df_with_DOF <- df |> append_dof
#' }
append_dof <- function(.flts){
  if(c("BLOCK_TIME") %in% colnames(.flts)){
    updated_df <- .flts |> dplyr::mutate(DOF = lubridate::date(BLOCK_TIME))
  }
}