# NOTE - based on Jean's flow proposal, let's organise the indicator calculation in a series of steps
# 1. reshape - "decoding" of input data to "standardised" (APDF) data format
# 2. prepare - any preparatory transformations before establising the analytic data
# 3. establish analytic - code the analytic data set (PBWG convention)
# 3. calculate - calculate the performance metrics output given the PBWG conventions

# FOR A START - do not focus too much on the "reshape" step.
# the shared data-src is in APDF format := required formats, column names, etc.
# notice that
## ---- BLOCK_TIMES turn into AOBT or AIBT,
## ---- MVT_TIMES into ATOT or ALDT, and
## ---- SCHED_TIMES into SBOT or SIBT

# Calculates the delay for each flight
#' Title
#'
#' @param df
#'
#' @return
#' @export
#'
prepare_delay <- function(df) {
  df$delay <- as.numeric(
    difftime(
      as.POSIXct(df$atot, format = "%Y-%m-%d %H:%M:%OS"),
      as.POSIXct(df$etot, format = "%Y-%m-%d %H:%M:%OS"),
      units = "mins"
    )
  )
  return(df)
}


# Checks which variants classify each flight as on time
check_variants <- function(df) {
  df <- df |>
    dplyr::mutate(
       .data$v1a <- ifelse(.data$delay >= -5 & .data$delay <= 5, 1, 0)
      ,.data$v1b <- ifelse(delay < 5, 1, 0)
    )
  #df$v2a <- ifelse(df$delay >= -15 & df$delay <= 15, 1, 0)
  #df$v2b <- ifelse(df$delay < 15, 1, 0)

  return(df)
}


# # Calculates KPI01 -- Percentage of on-time flights for each variant
# calculate_punctualtiy <- function(df) {
#   kpi01_df <- df |>
#     dplyr::group_by(adep) |>
#     dplyr::summarise(
#       kpi01_v1a = sum(v1a == 1, na.rm = TRUE) / n(),
#       kpi01_v1b = sum(v1b == 1, na.rm = TRUE) / n(),
#       kpi01_v2a = sum(v2a == 1, na.rm = TRUE) / n(),
#       kpi01_v2b = sum(v2b == 1, na.rm = TRUE) / n()
#     ) |>
#     dplyr::ungroup()
#
#   return(kpi01_df)
# }
