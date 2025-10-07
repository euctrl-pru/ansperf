#' Calculate Flight Delays (Generic)
#'
#' Computes the time difference (in minutes) between actual and estimated
#' times for either **departures** or **arrivals**, adding a new column `delay`
#' to the input data frame.
#'
#' @param df A data frame containing the relevant time columns:
#'   - For departures (`mode = "departure"`): `etot` (estimated take-off time) and `atot` (actual take-off time)
#'   - For arrivals (`mode = "arrival"`): `eldt` (estimated landing time) and `aldt` (actual landing time)
#' @param mode A character string indicating whether to calculate departure or arrival delay.
#'   Must be one of `"departure"` or `"arrival"`. Defaults to `"departure"`.
#'
#' @return
#' The same data frame with an additional numeric column `delay` (in minutes).
#'
#' @examples
#' # Departure delay
#' df_dep <- data.frame(
#'   etot = c("2025-09-26 07:45:00", "2025-09-26 09:00:00"),
#'   atot = c("2025-09-26 08:00:00", "2025-09-26 09:30:00")
#' )
#' calculate_delay(df_dep, mode = "departure")
#'
#' # Arrival delay
#' df_arr <- data.frame(
#'   eldt = c("2025-09-26 10:00:00", "2025-09-26 10:15:00"),
#'   aldt = c("2025-09-26 10:10:00", "2025-09-26 10:30:00")
#' )
#' calculate_delay(df_arr, mode = "arrival")
#'
#' @export
calculate_delay <- function(df, mode = c("departure", "arrival")) {
  mode <- match.arg(mode)

  # Escolhe colunas de acordo com o modo
  if (mode == "departure") {
    est_col <- "etot"
    act_col <- "atot"
  } else {
    est_col <- "eldt"
    act_col <- "aldt"
  }

  # Verifica se as colunas existem
  if (!all(c(est_col, act_col) %in% names(df))) {
    stop(
      sprintf(
        "Missing required columns for mode = '%s': %s and %s",
        mode, est_col, act_col
      )
    )
  }

  # Calcula o delay em minutos
  df$delay <- as.numeric(
    difftime(
      as.POSIXct(df[[act_col]], format = "%Y-%m-%d %H:%M:%OS"),
      as.POSIXct(df[[est_col]], format = "%Y-%m-%d %H:%M:%OS"),
      units = "mins"
    )
  )

  return(df)
}
