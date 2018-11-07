# Jussi-Pekka Martikainen
# 6.11.2018
# IODS RStudio Exercise 2 - Data wrangling.
##
##Step 1. The comments above
##
#
##
##Step 2. Read the data file from web to memory.
##
df_in <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# With structure command (str) below we learn that 'learning2018' is:
# - data.frame object
# - has 183 observations (rows) with 60 variables (columns)
#   - executing the command shows the data.frame as transposed: columns as rows, rows as columns 
# - 59 of the variables are numeric and 1 is factor
str(df_in)

# With structure command (dim) below we learn that 'learning2018' has:
# - 183 rows and 60 columns
dim(df_in)

##
##Step 3. Create analysis dataset.
##
# empty data.frame with 183 rows to land the analysis data
learning2014 <- data.frame(matrix(ncol=0,nrow=183))

# copy from read in data to analysis data
learning2014$gender <- df_in$gender
learning2014$age <- df_in$Age
learning2014$attitude<- df_in$Attitude
learning2014$points<- df_in$Points

# take dplyr in to use
library(dplyr)

# create the 3 groups of column name vectors
deep_questions <- c("D03","D11","D19","D27","D07","D14","D22","D30","D06","D15","D23","D31")
surf_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
stra_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select each group column from data read in, combine and scale them to analysis data
deep_columns <- select(df_in, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)
surf_columns <- select(df_in, one_of(surf_questions))
learning2014$surf <- rowMeans(surf_columns)
stra_columns <- select(df_in, one_of(stra_questions))
learning2014$stra <- rowMeans(stra_columns)

# filter out data rows where points 0 or less
learning2014 <- filter(learning2014, points > 0)

##
## Step 4. Saving the data
##
# sequence of getwd - setwd - getwd commands
# I have commented the commands and omitted the my environment specific values
#----
#getwd() #to show working directory
#setwd(".../IODS-project/data/") # set working directory to data-folder in IODS-project
#getwd() #and to show that current working directory is as set
#----

# write data.frame to .txt file with now row namas, quotes and with tab as separator
write.table(learning2014, file="learning2014.txt", row.names = FALSE, quote = FALSE, sep = "\t")

# check that the saved file can be read
df2_in <- read.table("learning2014.txt", sep="\t", header=TRUE)
str(df2_in)
