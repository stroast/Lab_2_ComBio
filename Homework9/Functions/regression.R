# --------------------------------------
# FUNCTION regression
# required packages: none
# description:
# inputs:
# outputs:
########################################
regression <- function(S=NULL,A=NULL){

  # assign parameter defaults
  if (is.null(S) | is.null(A)) {
    stop("Please input data")
  }

  # function body
  model_fit <- lm(A~S) # fit to linear
  output <- c(slope=summary(model_fit)$coefficients[2,1],
              p_value=summary(model_fit)$coefficients[2,4])


  return(output)

} # end of function regression
# --------------------------------------
# regression()
