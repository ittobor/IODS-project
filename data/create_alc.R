# Jussi-Pekka Martikainen
# 16.11.2018
# IODS RStudio Exercise 3 - Data wrangling.
# Student Performance Data (including alcohol consumption)
##
##Step 1. data files downloaded and extracted to "../data/" folder
##Step 2. creted this file with above comments
##
#
##
##Step 3. Read the data files to R.
##
data_dir <- "C:/Users/ittobor/projects/iods/IODS-project/data"
path_mat <- paste(data_dir, "student-mat.csv", sep="/")
path_por <- paste(data_dir, "student-por.csv", sep="/")
stud_mat <- read.table(path_mat, sep = ";" , header=TRUE)
stud_por <- read.table(path_por, sep = ";" , header=TRUE)

str(stud_mat)
str(stud_por)
dim(stud_mat)
dim(stud_por)
summary(stud_mat)
summary(stud_por)
colnames(stud_mat)
colnames(stud_por)

##
##Step 4. Join the datasets by chosen variables.
##
# need dplyr
library(dplyr)

# common columns to use as identifiers
  join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
# suffix for each dataset's uncommon columns
suff <- c(".mat",".por")

# join the two datasets by the selected identifies, inner_join will only keep rows found in both
mat_por <- inner_join(stud_mat, stud_por, by = join_by, suffix = suff)
str(mat_por)
dim(mat_por)
summary(mat_por)
colnames(mat_por)

##
##Step 5. Combine duplicate answers
##
# create alc data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

# the columns not used in joining
notjoined_columns <- colnames(stud_mat)[!colnames(stud_mat) %in% join_by]

# Using the DataCamp solution to compbine duplicate data
# for every column name not used for joining
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

##
##Step 6. Mutate colums alc_use and high_use to alc dataset
##
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)


# glimpse at the new combined data
glimpse(alc)
# write data.frame to .txt file with now row namas, quotes and with tab as separator

out_data_name <- "alc.csv"
out_data_path <- paste(data_dir, out_data_name, sep="/")
write.table(alc, file=out_data_path, row.names = FALSE, quote = FALSE, sep = ";")

alc_check <- read.table(out_data_path, sep = ";" , header=TRUE)
dim(alc_check)
