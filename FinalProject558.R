library(tidyverse)
library(sf)
library(mapview)
library(parallel)
library(tictoc)
# 
# read_csv("Amargosa_FishData_2022_totalsSite (1).csv") %>% 
#   pivot_longer(cols = c(Sp1,Sp2,Sp3)) %>% 
#   rename(Species = value) %>% 
#   mutate(Count_col = paste0(name,"_count"))  %>% 
#   mutate(count = NA) ->
#   f1
# 
# 
# for (idx in  seq(1, nrow(f1))) {
#   count_col_name = f1$Count_col[idx]
#   count = f1[idx, count_col_name]    #idx = "index" name for iterative variable in f1... also written as "i",so for "ith" variable in "Count"... changed idx to i
#   f1[idx, "count"] = count
# }
# 
# # reformat data to wide style
# f1 %>% 
#   select(Easting,
#          Northing,
#          Trap, 
#          Date, 
#          Species,
#          count) %>% 
#   filter(!is.na(Species)) %>% 
#   pivot_wider(names_from = Species, 
#               values_from = count,
#               values_fill = 0) ->
#   f1
# 
# # convert to spatial
# f1 %>% 
#   st_as_sf(coords = c("Easting", "Northing"), crs = 32611) ->
#   f1_sf
# 
# #view spatial data
# f1_sf %>% mapview()
# 
# # write spatial file. Change extension to desired filtetype
# f1_sf %>% st_write("Amargosa_FishData_2022_clean.shp")
# 
# # write plain csv
# f1 %>% write_csv("Amargosa_FishData_2022_totalsSite_cleaned.csv")
# 



setwd("~/Library/CloudStorage/GoogleDrive-rc463@humboldt.edu/My Drive/Spring2024/FISH 558 - popdy/Final Project")

library(readr)
am.surveydata <- read_csv("Data/Shoshone_Amargosa/2022 Surveys/SE_Query_Amargosa_5.14.23_cleaned_FINAL.csv")
# am.fishdata <- read_csv("Data/Shoshone_Amargosa/2022 Surveys/Amargosa_FishData_2022_totalsSite_cleaned.csv")

View(am.surveydata)
# View(am.fishdata)

am.surveydata%>%
  pivot_longer(cols = c(Sp1,Sp2,Sp3)) %>% #tidyr package. transforms data from wide to long format, gathering the columns sp1, sp2, sp3
  rename(Species = value) %>%
  mutate(Count_col = paste0(name,"_count"))  %>% 
  mutate(count = NA) -> #adds a new column named count to the dataset and initializes all its values as NA.
  f1

 for (i in  seq(1, nrow(f1))) { #for loop, iteration from 1 to number of rows in dataset
  count_col_name = f1$Count_col[i] #extracts value in count col at ith row of dataset
   count = f1[i, count_col_name] #extracts value in count col name at ith row of f1, assigns to variable "count"
   f1[i, "count"] = count #assigns value stored in "count" to column named "count" at the ith row.
 }

# reformat data to wide style
f1 %>%
  # select(Easting,
  #        Northing,
  #        Trap,
  #        Date,
  #        Species,
  #        count) %>% #This function, from the dplyr package, selects specific columns from the dataset
  # filter(!is.na(Species)) %>% #filters the dataset to remove any rows where the Species column contains NA values (missing values)
  pivot_wider(names_from = Species,
              values_from = count,
              values_fill = 0) ->
  f1
view(f1)

# # write plain csv
# f1 %>% write_csv("Amargosa_FishData_2022_Surveydata_cleaned.csv")

##standardize effort - CPUE based on trap hours
###combine fishdata and survey data -- 
