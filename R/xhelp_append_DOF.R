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
  if(c("BLOCK_TIME") %in% colnames(.flts)){
    updated_df <- .flts |> dplyr::mutate(DOF = lubridate::date(.data$BLOCK_TIME))
  }
}