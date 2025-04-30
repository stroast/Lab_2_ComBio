# Load libraries
library(pracma)
library(pryr)
library(devtools)
library(upscaler)
library(tidyverse)
library(ggplot2)

set_up_log()
source_batch(folder="C:/Users/stroast/OneDrive - University of Vermont/Desktop/Lab_2_ComBio/Homework9/Functions")

# Gather file names
main_data <- "C:/Users/stroast/OneDrive - University of Vermont/Desktop/Lab_2_ComBio/Homework9/CleanData/NEON_count-landbird"

# Set up a list to put filenames into
count_files <- list()

# Get the list of folders within the main folder
year_folders <- list.dirs(main_data, recursive = FALSE)

# Loop through each year folder and grab the first matching file
for (i in year_folders) {
  file_names <- list.files(i, pattern = "countdata", full.names = TRUE)
  if (length(file_names) > 0) {
    count_files[[basename(i)]] <- file_names[1]
 }
}
l("File names gathered")

# Create initial data frame ----
n_files <- length(count_files)
df <- data.frame(
  year = rep(NA, n_files),
  file_name = unlist(count_files, use.names = FALSE),
  abundance = rep(NA, n_files),
  species_richness = rep(NA, n_files),
  stringsAsFactors = FALSE
)

df$file_name <- unlist(count_files, use.names = FALSE)
l("Initial data frame created")

# clean all data sets
source("Homework9/Functions/cleandata.R")
for (name in names(count_files)) {
  count_files[[name]] <- cleandata(count_files[[name]])
}
l("Data cleaned")

# Extract years ----
source("Homework9/Functions/extractyear.R")
years <- sapply(names(count_files), extractyear)  # Assuming extractyear returns a single year
df$year <- years
saveRDS(years, file = "Homework9/DataObjects/year_data.rds")
l("Years extracted")

# Calculate abundance ----
source("Homework9/Functions/calculateabundance.R")
abundance_data <- sapply(count_files, calculateabundance)
df$abundance <- unlist(abundance_data)
l("Abundance calculated")

# Calculate species richness ----
source("Homework9/Functions/calculateS.R")
s_data <- sapply(count_files, calculateS)
df$species_richness <- unlist(s_data)
l("Species richness calculated")

# Run regression of richness vs. abundance ----
source("Homework9/Functions/regression.R")
reg_data <- regression(S = df$species_richness, A = df$abundance)
reg_data <- as.data.frame(reg_data)
l("Regression run")

# Generate histograms ----
source("Homework9/Functions/histogram.R")
histogram(data = df, x = df$abundance, n = "abundance")
a_histo <- readRDS("Homework9/Plots/abundancehistogram.rds")
print(a_histo)

histogram(data = df, x = df$species_richness, n = "Species_Richness")
s_histo <- readRDS("Homework9/Plots/Species_Richnesshistogram.rds")
print(s_histo)
l("Histograms generated")

# Export summary table
data_table_template(data_frame = df, file_name = "Homework9/Output/summary_table.csv")

