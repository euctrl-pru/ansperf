#' A cool salutation of a guest
#'
#' @param greeted_actor the person to greet
#'
#' @return salute phrase
#'
#' @export
#'
x_hello_world <- function(greeted_actor){
  tt     <- c("Master","King", "My Lord", "Highness")
  pick   <- sample(tt, 1)

  salute <- paste0("Welcome, dear ", pick, " ", greeted_actor)

  return(salute)
}
