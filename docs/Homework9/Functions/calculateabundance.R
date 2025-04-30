# --------------------------------------
# FUNCTION calculateabundance
# required packages: none
# description:
# inputs:
# outputs:
########################################
calculateabundance <- function(x=NULL){

  # assign parameter defaults
  if (is.null(x)) {
    stop("Please specify a list of files")
  }

  # function body

  # Create a list to store abundance values
  abundance <- list()

  # Loop through each file and calculate abundance
  for (i in x) {
    data <- read.csv(i)
    abundance[[i]] <- nrow(data)
  }

  saveRDS(abundance, file="Homework9/DataObjects/abundancedata.rds")

  return(abundance)

}
# end of function calculateabundance
# --------------------------------------
# calculateabundance()
