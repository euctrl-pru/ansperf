#' GANP KPI table
#'
#' A table listing the current GANP KPIs and associated data items.
#'
#'
#' @format ## `data_ganp_kpi_reqs`
#' A data frame with 22 KPIs and 6 columns, 2 header rows
#' \describe{
#'   \item{KPI}{indicator and number, e.g. KPI08}
#'   \item{name}{descriptive name of indicator}
#'   \item{data-basic}{data items typically found in a basic flight table dataset}
#'   \item{data-advanced}{either ATFM data, meta-data, or trajectory data required to calculate or derive the trajectory based indicators}
#' }
#' @source <https://www4.icao.int/ganpportal/ASBU/KPI>
"data_ganp_kpi_reqs"
