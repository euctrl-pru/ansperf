#' Calculate Punctuality
#'
#' Computes the punctuality per airport (`adep`),
#' based on different punctuality definitions (`v1a`, `v1b`, `v2a`, `v2b`).
#'
#' @param df A data frame containing the following columns:
#'   - `adep`: Airport (character or factor).
#'   - `v1a`, `v1b`, `v2a`, `v2b`: Binary indicators (0 or 1) representing on-time status.
#'
#' @return
#' A summarised data frame with one row per airport, containing:
#' \describe{
#'   \item{punc_v1a}{Proportion of flights on time within ±5 minutes.}
#'   \item{punc_v1b}{Proportion of flights with delay < +5 minutes.}
#'   \item{punc_v2a}{Proportion of flights on time within ±15 minutes.}
#'   \item{punc_v2b}{Proportion of flights with delay < +15 minutes.}
#' }
#'
#' @details
#' The KPI01 indicator measures flight punctuality at, expressed as
#' the proportion of flights classified as on time under four tolerance definitions.
#' Variants `v1a` and `v1b` use a ±5-minute threshold, while `v2a` and `v2b`
#' apply a ±15-minute tolerance.
#'
#' @examples
#' library(dplyr)
#' df <- data.frame(
#'   adep = c("SBSP", "SBSP", "SBRJ", "SBRJ"),
#'   v1a = c(1, 0, 1, 1),
#'   v1b = c(1, 1, 1, 1),
#'   v2a = c(1, 1, 1, 1),
#'   v2b = c(1, 1, 1, 1)
#' )
#' calculate_punctuality(df)
#'
#' @importFrom dplyr group_by summarise n ungroup
#' @export
calculate_punctuality <- function(df) {
  punc_df <- df |>
    dplyr::group_by(adep) |>
    dplyr::summarise(
      punc_v1a = sum(v1a == 1, na.rm = TRUE) / dplyr::n(),
      punc_v1b = sum(v1b == 1, na.rm = TRUE) / dplyr::n(),
      punc_v2a = sum(v2a == 1, na.rm = TRUE) / dplyr::n(),
      punc_v2b = sum(v2b == 1, na.rm = TRUE) / dplyr::n()
    ) |>
    dplyr::ungroup()

  return(punc_df)
}
