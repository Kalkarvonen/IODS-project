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

write.csv(human, "C:/Users/Kalka/OneDrive/Desktop/Random/School/Open_Data/IODS-project/data/human.csv", row.names = FALSE)
