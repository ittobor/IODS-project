# Jussi-Pekka Martikainen
# 28.11.2018
# IODS RStudio Exercise 5 - Data wrangling.
# Human development and Gender inequality
##
##Pre-Step: loaded the data "mutilated" last week and renaming the columns once again
##
data_dir <- "~/projects/iods/IODS-project/data"
out_data_name <- "human.csv"
out_data_path <- paste(data_dir, out_data_name, sep="/")
human <- read.table(out_data_path, sep = ";" , header=TRUE)
# rename here and see that it works
names(human) <- c("HDI.Rank","Country","HDI","Life.Exp","Edu.Exp","Edu.Mean","GNI","GNI.Minus.Rank","GII.Rank","GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M","Edu2.FM","Labo.FM")
colnames(human)
dim(human)
str(human)
##
## Step1: Mutate the data
##
# take the stringr library to use
library(stringr)
# mutate GNI from factorial to numeric and see that it is done so
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric
str(human)
#
##
## Step2: Exclude unneeded variables
##
#
library(dplyr)
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
str(human)
#
##
## Step3: Remove all observations with NA values
##
#
#  look first -> filter -> look after
complete.cases(human)
human <- filter(human, complete.cases(human)==TRUE)
complete.cases(human)
#
##
## Step4: Remove all observations that is not a country
##
#
# by a quick look one might suggest that the non-country observations are in the end of the dataset
# precisely 7 last are not countries but other geographic areas
# same can be interpreted from the meta-data description
str(human)
tail(human, n=20)
human <- human[1:(nrow(human) - 7), ]
str(human)
#
##
## Step5: Add row names as country names and lose the Country column.
## Show first 10 rows to see that rows have been named.
## Show structure to see the number of observations and variables
## Save file as human2.csv
##
#
rownames(human) <- human$Country
human <- dplyr::select(human, -Country)
head(human, n=10)
str(human)
out_data_name <- "human2.csv"
out_data_path <- paste(data_dir, out_data_name, sep="/")
write.table(human, file=out_data_path, row.names = TRUE, quote = FALSE, sep = ";")
