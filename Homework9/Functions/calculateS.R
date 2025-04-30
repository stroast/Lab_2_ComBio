# --------------------------------------
# FUNCTION calculateS
# required packages: none
# description:
# inputs:
# outputs:
########################################
calculateS <- function(x=NULL){

  # assign parameter defaults
  if (is.null(x)) {
    stop("Please specify a list of files")
  }

  # function body
  # Create a list to store species richness values
  species_richness <- list()

  # Loop through each file and calculate richness
  for (i in x) {
    data <- read.csv(i)
    species <- table(data$scientificName)
    species_richness[[i]] <- length(species)
  }

  saveRDS(species_richness, file="Homework9/DataObjects/species_data.rds")

  return(species_richness)

} # end of function calculateS
# --------------------------------------
# calculateS()
