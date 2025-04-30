# --------------------------------------
# FUNCTION cleandata
# required packages:
# description: remove empty and missing cases from files and save
# inputs: x: name of file to be cleaned
# outputs: .csv file of cleaned data and name of said file
########################################

cleandata <- function(x = NULL) {
  # Check if a file path was provided
  if (is.null(x)) {
    stop("Please specify a valid file name")
  }

  # Read the CSV file
  data <- read.csv(x, stringsAsFactors = FALSE)

  # Make sure empty strings are also NAs
  data[data == ""] <- NA

  # Remove rows without a scientific name
  data_clean <- data[!is.na(data$scientificName),]


  # Save the cleaned data (overwriting copy within the cleaned data folder/ original data is in a different folder)
  write.csv(data_clean, file = x, row.names = FALSE)

  # Print confirmation
  print(paste("Cleaned data saved to:", x))
}

# end of function cleandata
# --------------------------------------
# cleandata()

