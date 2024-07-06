#' hello_world returns greeting with name
#'
#' @param .name the addressee of the greeting
#'
#' @return greeting phrase with name
#' @export
#'
#' @examples
#' hello_world("Rainer")
hello_world <- function(.name){
  greeting <- paste0("Hello, my highness ", .name, "!")
  return(greeting)
}