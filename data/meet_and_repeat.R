# Kalle Karvonen 
# IODS data wrangling 6:

# Data from Kimmo Vehkalahtis github
library(readr)
library(dplyr)
library(tidyr)
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt",header = TRUE)


rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt")                  


str(BPRS)
# The BPRS data consists of brief psychiatric rating scale values for 40 men
# before and after treatment on different timeframes on two different treatment groups

str(rats)
# The rats data consists of data from a nutritional study on rats where
# 16 rats were put on one of 3 diets and their body weight was measured by weekday



# Changing categorical variables to factos 
# in this case the first 2 columns for BPRS can only get certain values --> categorical
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# same for rats
rats$ID<- factor(rats$ID)
rats$Group<-factor(rats$Group)

#
# Convert to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "BPRS") %>%
  arrange(weeks) #order by weeks variable

# Extract the week number
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks,5,5)))

# we do not need the original weeks variable so lets subset it
BPRSL <- subset(BPRSL,select=-weeks)


# For rats we want to convert them to a long form and add Time variable
#
# Convert to long form
ratsl <-  pivot_longer(rats, cols = -c(Group, ID),
                       names_to = "WD", values_to = "Weight") %>%
  arrange(WD) #order by weeks variable

# Extract the week number
ratsl <-  ratsl %>% 
  mutate(Time = as.integer(substr(WD,3,4)))

# Subset similarily to Earlier

ratsl <- subset(ratsl,select=-WD)

# Summaries of the new data

str(BPRSL)
# The BPRS data is now in 4 columns and 360 rows and it is in order of treatments
# subjects and weeks so it is easier to do certain analyses for example differences between groups

str(ratsl)
# ratsl data is similarily in 4 columns and 176 rows sorted by the added variable
#Time The variables have the same inteprentation as mentioned above

# Generally speaking long form data is easier to read when there is a larger amount of variables
# Especially useful in data like this where our columns mostly just show timeframes such as days or weeks
# Also long data is often easier to manipulate if we need to add more columns etc

write.csv(BPRSL, "C:/Users/Kalka/OneDrive/Desktop/Random/School/Open_Data/IODS-project/data/BPRSL.csv", row.names = FALSE)
write.csv(ratsl, "C:/Users/Kalka/OneDrive/Desktop/Random/School/Open_Data/IODS-project/data/ratsl.csv", row.names = FALSE)
