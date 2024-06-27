#' hello_world returns greeting with name
#'
#' @param .name 
#'
#' @return
#' @export
#'
#' @examples
hello_world <- function(.name){
  greeting <- paste0("Hello, my ruler ", .name)
  return(greeting)
}