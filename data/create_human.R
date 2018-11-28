# Jussi-Pekka Martikainen
# 21.11.2018
# IODS RStudio Exercise 4 - Data wrangling.
# Human development and Gender inequality
##
##Step 1. Create this r-script and save it with name create_human.R
##Step 2. Read "Human development" and "Gender inequality" dataset to R
##

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

##
##Step 3. Explore datasets
##
# exploring with different functions
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)
colnames(hd)
colnames(gii)

##
##Step 4. Rename columns for both dataframes
##
# replacing current names with new names in string-vectors. Kept country name the same in both as it is used as join variable

names(hd) <- c("HDI.rank", "country", "HDI.hdi", "HDI.lifeexpect","HDI.expeyearsedu","HDI,meanyearsedu","GDI.gni","HDI.gnirank")
names(gii) <- c("GII.rank", "country", "GII.gii", "GII.matemortratio","GII.adobirthrate","GII.repinparperc","GII.secedupopF","GII.secedupopM","GII.labourrateF","GII.labourrateM")

##
##Step 5. Mutate "Gender inequality" dataset
##
# mutating the gii-dataset with dplyr-library
library(dplyr)
gii <- mutate(gii, GII.seceduaratioFM = (GII.secedupopF / GII.secedupopM))
gii <- mutate(gii, GII.labourrateratioFM = (GII.labourrateF / GII.labourrateM))
str(gii)

##
##Step 6. Join and save the dataset
##
# joining the datasets with inner-join which keeps only data (countries) it can find from both datasets.
# Then printing exploring the joined dataset
human <- inner_join(hd, gii, by = "country")
str(human)
dim(human)
summary(human)

# Saving the dataset as file
#data_dir <- "C:/Users/ittobor/projects/iods/IODS-project/data"
data_dir <- "/Users/ittobor/studies/iods/IODS-project/data"
out_data_name <- "human.csv"
out_data_path <- paste(data_dir, out_data_name, sep="/")
write.table(human, file=out_data_path, row.names = FALSE, sep = ";")

# checking that the dimesions match
human_check <- read.table(out_data_path, sep = ";" , header=TRUE)
dim(human_check)


### Week5 ###
