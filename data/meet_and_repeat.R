# Jussi-Pekka Martikainen
# 05.12.2018
# IODS RStudio Exercise 6 - Data wrangling.
# BPRS and RATS
##
##Step 1. Load datasets
##
# load both datasets BPRS and RATS
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '\t',header = T)

# structure command (str) gives us dimensions, variable names and types, and few first observation values
str(BPRS)
str(RATS)

# from the structure of both of the datasets we can see that 
# them both have response variable measured on a number of different occasions in time.


##
##Step 2. Convert to factorials
##
# BPRS factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
# RATS factors
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

##
##Step 3. Convert both datasets to longform
##
library(tidyr)
library(dplyr)
# Convert BPRS to longform and add week variable
BPRS <- BPRS %>% 
        gather(key = weeks, value = bprs, -treatment, -subject) %>% 
        mutate(week = as.integer(substr(weeks, 5, 6)))

RATS <- RATS %>% 
        gather(key = WD, value = Weight, -ID, -Group) %>% 
        mutate(Time = as.integer(substr(WD,3,5)))

str(BPRS)
str(RATS)

# we can observe by comparing the structure of the dataset after the changes
# to the structure in which they were before and see that they have transformed
# from wide to long format: the repeating columns were transformed into multiple observations

data_dir <- "~/projects/iods/IODS-project/data"
out_data_name_1 <- "BPRS.txt"
out_data_name_2 <- "RATS.txt"
out_data_path_1 <- paste(data_dir, out_data_name_1, sep="/")
out_data_path_2 <- paste(data_dir, out_data_name_2, sep="/")
write.table(BPRS, file=out_data_path_1, row.names = FALSE, sep = "\t", quote = FALSE)
write.table(RATS, file=out_data_path_2, row.names = FALSE, sep = "\t", quote = FALSE)

