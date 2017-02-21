# Read the “Human development” and “Gender inequality” datas into R. 

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Structure and dimensions of the datasets
str(hd)
dim(hd)
str(gii)
dim(gii)

# Create summaries of the variables. 
summary(hd)
summary(gii)

# Look at the meta files
colnames(hd)
colnames(gii)

# Rename the variables with (shorter) descriptive names. 
colnames(hd)[3]<-"HDI"
colnames(hd)[4]<-"Life.Exp"
colnames(hd)[5]<-"Edu.Exp"
colnames(hd)[6]<-"Edu.Mean"
colnames(hd)[7]<-"GNI"
colnames(hd)[8]<-"GNI.Rank-HDI.Rank"
colnames(gii)[3]<-"GII"
colnames(gii)[4]<-"Mat.Mor"
colnames(gii)[5]<-"Abo.Birth"
colnames(gii)[6]<-"Parli"   
colnames(gii)[7]<-"Edu2.F"
colnames(gii)[8]<-"Edu2.M"  
colnames(gii)[9]<-"Labo.F"
colnames(gii)[10]<-"Labo.M"      

# Mutate the “Gender inequality” data and create two new variables, the first ratio female/male
# with secondary education in each country (i.e. edu2F / edu2M) 
gii<-mutate(gii, Edu2.FM=(Edu2.F/Edu2.M))

# The second new variable should be the ratio of labour force participation 
# of females and males in each country (i.e. labF / labM)
gii<-mutate(gii, Labo.FM=(Labo.F/Labo.M))

# Join together the two datasets using the variable Country as the identifier, keeping 
# only the countries in both data sets.
# For function inner_join() the dplyr package needs to be loaded.
library(dplyr)

join_by<-c("Country")
hd_gii<-inner_join(hd, gii, by =join_by, suffix=c(".hd", ".gii"))

glimpse(hd_gii)
# The joined data should have 195 observations and 19 variables, as it does. 

# Call the new joined data "human" and save it in your data folder
setwd("~/Desktop/IODS-project/data")
write.table(hd_gii, file="human.txt")
