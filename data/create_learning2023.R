## Kalle Karvonen 13.11.2023
## Assignment 2 Data wrangling IODS2023 course
## Data from https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt



library(dplyr)
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",
 sep="\t", header=TRUE)
#dimensions and structure
dim(lrn14)
str(lrn14)
# There are 183 rows and 60 columns of variables

# Creating the analysis dataset according to ex2
lrn14$attitude <- lrn14$Attitude / 10
# questions related to deep, surface and strategic learning

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(lrn14, one_of(deep_questions))
# and create column 'deep' by averaging
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(lrn14, one_of(surface_questions))
# and create column 'surf' by averaging
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(lrn14, one_of(strategic_questions))
# and create column 'stra' by averaging
lrn14$stra <- rowMeans(strategic_columns)

# keeping the necessary columns while discarding the rest
keep_columns <-select(lrn14,c("gender","Age","attitude", "deep", "stra", "surf", "Points"))
learning2014 <- keep_columns
learning2014 <- filter(learning2014,Points>0)

#setting the wd
getwd()
#wd already in the correct position no need to setwd
write.csv(learning2014, "C:/Users/Kalka/OneDrive/Desktop/Random/School/Open_Data/IODS-project/learning2014.csv", row.names = FALSE)
test <- read.csv("C:/Users/Kalka/OneDrive/Desktop/Random/School/Open_Data/IODS-project/learning2014.csv")
          