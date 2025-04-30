# --------------------------------------
# FUNCTION extractyear
# required packages: none
# description: extracts years from file names
# inputs: list of file names
# outputs: list of years
########################################
extractyear <- function(x=NULL){

  # assign parameter defaults
  if (is.null(x)) {
    return("Please enter valid file names")
  }

  # function body

  # extract years
  years <- str_extract(x, pattern = "20\\d{2}")

  saveRDS(years, file = "Homework9/DataObjects/year_data.rds")

  print("Years saved as an RDS file")

} # end of function extractyear
# --------------------------------------
# extractyear()
