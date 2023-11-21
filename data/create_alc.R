# Kalle Karvonen
#Logistic regressions task open data science
# Data used http://www.archive.ics.uci.edu/dataset/320/student+performance

setwd("C:/Users/Kalka/OneDrive/Desktop/Random/School/Open_Data/IODS-project/data")
getwd()
mat <- read.csv("student-mat.csv",sep = ";",header = TRUE)
por <- read.csv("student-por.csv",sep = ";",header = TRUE)

dim(mat)
# 395 rows of  data across 33 columns of different categories on mathematic performance
dim(por)
# 649 rows of data across 33 columns of different categories on portuguese performance
colnames(mat)
colnames(por)

#Based on ex3 3.2 we define what we want to exlude from our join
free_cols <- c("paid","failures","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols,suffix = c(".math",".por"))

#Check the data

glimpse(math_por)

# Getting rid of duplicates by using the if else structure from 3.3

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}
glimpse(alc)
#Taking the averages of alcohol consumption and mutating alc by adding a new column
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#Defining high use columns

alc <- mutate(alc,high_use =ifelse(alc_use>2,TRUE,FALSE))

# now we have 370 observations as expected

write.csv(alc, "C:/Users/Kalka/OneDrive/Desktop/Random/School/Open_Data/IODS-project/alc.csv", row.names = FALSE)

              