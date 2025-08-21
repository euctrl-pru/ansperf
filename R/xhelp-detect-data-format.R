detect_apdf <- function(df){
  stopifnot(  "PHASE" %in% colnames(df) )
  return(df)
}
