################################################################################
# Script:         kpi01.R
# Author:         Jean Lima
# Date:           2025-07-30
# Description:    Implementation of KPI01
################################################################################

#' @export

library(tidyverse)
library(dplyr)


# Calculates the delay for each flight
calculate_delay <- function(df) {
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
  df$v1a <- ifelse(df$delay >= -5 & df$delay <= 5, 1, 0)
  df$v1b <- ifelse(df$delay < 5, 1, 0)
  df$v2a <- ifelse(df$delay >= -15 & df$delay <= 15, 1, 0)
  df$v2b <- ifelse(df$delay < 15, 1, 0)

  return(df)
}


# Calculates KPI01 -- Percentage of on-time flights for each variant
calculate_kpi01 <- function(df) {
  kpi01_df <- df %>%
    group_by(adep) %>%
    summarise(
      kpi01_v1a = sum(v1a == 1, na.rm = TRUE) / n(),
      kpi01_v1b = sum(v1b == 1, na.rm = TRUE) / n(),
      kpi01_v2a = sum(v2a == 1, na.rm = TRUE) / n(),
      kpi01_v2b = sum(v2b == 1, na.rm = TRUE) / n()
    ) %>%
    ungroup()

  return(kpi01_df)
}
