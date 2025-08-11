#' demo - simple traffic counts of an airport
#'
#' @param apdf input airport level data frame/tibble
#'
#' @return tibble of counts
#' @export
#'
#' @examples
#' \dontrun{
#'   apt_traffic_count(lszh)
#' }
apt_traffic_count <- function(apdf){
  # to-do: check for necessary variables

  this_arrs <- apdf |>
    dplyr::filter(.data$PHASE == "ARR") |>
    dplyr::rename(ICAO = .data$ADES) |>
    dplyr::group_by(.data$ICAO, .data$PHASE) |>
    dplyr::reframe(FLTS = dplyr::n())

  this_deps <- apdf |>
    dplyr::filter(.data$PHASE == "DEP") |>
    dplyr::rename(ICAO = .data$ADEP) |>
    dplyr::group_by(.data$ICAO, .data$PHASE) |>
    dplyr::reframe(FLTS = dplyr::n())

  counts <- dplyr::bind_rows(this_arrs, this_deps)
  return(counts)
}
