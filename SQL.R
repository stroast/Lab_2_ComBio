## Basics of SQL (Structured Query Language)
# Feb 27 2025

library(sqldf)
library(tidyverse)

# Read in the dataset and take a look at it

species_clean <- read.csv("site_by_species.csv")

var_clean <- read.csv("site_by_variables.csv")

head(species_clean)
head(var_clean)


# Start with using operations/functions on just 1 file

# How to subset rows
# dplyr method - using filter()

species <- filter(species_clean, Site < 30)
var <- filter(var_clean, Site < 30)


# SQL Method for subsetting rows
query="SELECT Site, Sp1, Sp2, Sp3 FROM species WHERE Site < 30"

sqldf(query)


# Method for subsetting columns
# dplyr

edit_species <- species %>%
  select(Site, Sp1, Sp2, Sp3)

edit_species2 <- species %>%
  select(1,2,3,4)

# SQL Method for subsetting columns
# querying the entire table

query="SELECT * FROM species"

a <- sqldf(query)

sqldf(query)

# Renaming columns
# in dplyr, we just use the rename() function

species <- rename(species, Long=Longitude.x., Lat=Latitude.y.)

# Pull out all of the numeric columns
num_species <- species %>%
  mutate(letters=rep(letters, length.out=length(species$Site)))

num_species <- select(num_species, Site, Long, Lat, Sp1, letters)

num_species_edit <- select(num_species, where(is.numeric)) # adding the 'where' helper function serves to sort and add conditions to your select function

# Pivot longer will lengthen the data, decrease the number of columns and increase the number of rows. Can also use gather(), but it's outdated

species_long <- pivot_longer(edit_species, cols = c(Sp1, Sp2, Sp3), names_to="ID")

species_wide <- pivot_wider(species_long, names_from=ID)

# Aggregating the data, getting some kind of calculation

# SQL
query="SELECT SUM(Sp1 + Sp2 + Sp3) FROM species_wide GROUP BY SITE"

sqldf(query)


query="SELECT SUM(Sp1 + Sp2 + Sp3) AS Occurrence FROM species_wide GROUP BY SITE"

sqldf(query)

# query="ALTER TABLE species_wide ADD new_column VARCHAR"
# sqldf(query)
# error right now

# 2 file operations - joining datasets together
# species and environmental characteristics
# Left/Right/Union joins

# First start with clean - reset the species var variables, and then filter them to a manageable size

edit_species <- species_clean %>%
  filter(Site < 30) %>%
  select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.)

edit_var <- var_clean %>%
  filter(Site > 30) %>%
  select(Site, Longitude.x., Latitude.y., BIO1_Annual_mean_temperature, BIO12_Annual_precipitation)

# Left_join - basically means stitching the matching rows of file B to file A - does require a matching/marker column to link the two datasets

left <- left_join(edit_species, edit_var, by= "Site")
right <- right_join(edit_species, edit_var, by= "Site")

# Inner joins retains the rows that match between both files A and B. Loses a lot of information if the columns don't match well

inner <- inner_join(edit_species, edit_var, by = "Site")

# Full join - the opposite of inner join, just retains all values, all rows - ends up with a tradeoff where you get a bunch of NA's when you have missing data

full <- full_join(edit_species, edit_var, by = "Site")


# SQL Method for joining data

query = "SELECT BIO1_Annual_mean_temperature, BIO12_Annual_precipitation from edit_var LEFT JOIN edit_species ON edit_var.Site = edit_species.Site"

x <- sqldf(query)
x
