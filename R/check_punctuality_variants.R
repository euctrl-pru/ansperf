#' Classify Flights into Punctuality Variants
#'
#' This function classifies flights according to the punctuality indicator,
#' creating four binary columns that represent different definitions of "on time"
#' performance. Each column receives a value of `1` if the flight meets the time
#' window criterion or `0` otherwise.
#'
#' @param df A data frame containing at least one numeric column:
#'   - `delay`: Flight delay in minutes (difference between actual and estimated take-off times).
#'
#' @return
#' The same data frame with four additional columns:
#' \describe{
#'   \item{v1a}{1 if the flight delay is between -5 and +5 minutes (inclusive); otherwise 0.}
#'   \item{v1b}{1 if the flight delay is less than +5 minutes; otherwise 0.}
#'   \item{v2a}{1 if the flight delay is between -15 and +15 minutes (inclusive); otherwise 0.}
#'   \item{v2b}{1 if the flight delay is less than +15 minutes; otherwise 0.}
#' }
#'
#' @details
#' These KPI01 variants allow different thresholds for evaluating flight
#' punctuality. For example, `v1a` corresponds to a stricter definition
#' (±5 minutes), while `v2a` allows a broader margin (±15 minutes).
#'
#' @examples
#' df <- data.frame(delay = c(-10, 0, 8, 20))
#' check_punctuality_variants(df)
#'
#' @export
check_punctuality_variants <- function(df) {
  df$v1a <- ifelse(df$delay >= -5 & df$delay <= 5, 1, 0)
  df$v1b <- ifelse(df$delay < 5, 1, 0)
  df$v2a <- ifelse(df$delay >= -15 & df$delay <= 15, 1, 0)
  df$v2b <- ifelse(df$delay < 15, 1, 0)

  return(df)
}
