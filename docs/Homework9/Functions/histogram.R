# --------------------------------------
# FUNCTION histogram
# required packages: none
# description: function to generate a histogram from data and save in outputs
# inputs: data= data frame where data is held, x= data to be plotted, n=name to be included in file name
# outputs:
########################################
histogram <- function(data=NULL,x=NULL,n=NULL){

  # assign parameter defaults
  if (is.null(x) | is.null(data)|is.null(n)) {
    stop("Please specify data")
  }

  # function body
  a_hist <- ggplot(data=data) +
    aes(x=x) +
    geom_histogram(fill="coral",color="black")

  file_name <- paste0("Homework9/Plots/",n,"histogram.rds")

  saveRDS(a_hist, file=file_name)

  return(paste("File saved as:", file_name))

} # end of function histogram
# --------------------------------------
# histogram()
