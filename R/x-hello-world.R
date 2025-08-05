#' Lauding a person
#'
#' Saluting a to-be greated person.
#'
#' @param greeted_actor the person's name to be greeted
#'
#' @return the salutation
#' @export
#'
#' @examples
#' x_hello_world("Master")
#'
x_hello_world <- function(greeted_actor){

  salute <- paste0("Welcome, dear Highness, ", greeted_actor)

  return(salute)
}
