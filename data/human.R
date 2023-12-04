# Kalle karvonen
# Data wrangling for week 5

# This data consists of the Human development and gender inequality dataset
#https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv

install.packages("tidyverse")
library(tidyverse)
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


str(hd)
dim(hd)
# 195 rows 8 columns

str(gii)
dim(gii)
# 195 rows 10 columns

# renaming variables
colnames(hd)
colnames(hd)[c(4,5,7)] <- c("Life.Exp","Edu.Exp","GNI")

colnames(gii)
colnames(gii)[c(4:10)]<-c("Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")

gii <- gii %>% 
  mutate(Edu2.FM = Edu2.F / Edu2.M,Labo.FM=Labo.F/Labo.M)

human <- inner_join(hd, gii, by = "Country")

str(human)
dim(human)
summary(human)
# Dimensionality is correct with 195 rows and 19 columns of data 
# Data consists of countries and their gross national income alongside some other data
# Regarding the countrys welfare such as life expectancy and maternal mortality
# Removing unneseccary columns
human <- human %>%
  select("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
# Removing missing values
human <- na.omit(human)
# We notice that the last rows in country variable relate to areas instead of countries so we remove them
# last 7 rows are areas instead of countries
human <- human %>%
  slice(1:(nrow(human) - 7))
#saving the new data
write.csv(human, "C:/Users/Kalka/OneDrive/Desktop/Random/School/Open_Data/IODS-project/data/human.csv", row.names = FALSE)
