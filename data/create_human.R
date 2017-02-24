# Johanna Troberg
# Data wrangling of human data
# United Nations Development Programme, Human Development Reports 
# http://hdr.undp.org/en/content/human-development-index-hdi

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
colnames(hd)[8]<-"GNI.Minus.Rank"
colnames(gii)[3]<-"GII"
colnames(gii)[4]<-"Mat.Mor"
colnames(gii)[5]<-"Ado.Birth"
colnames(gii)[6]<-"Parli.F"   
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




# Read the human data from local data folder into r for further data wrangling.
human<- read.table("~/Desktop/IODS-project/data/human.txt", sep="", header=T)
str(human)

# Mutate the data by transforming the GNI variable to numeric. 
# To keep numbers correct, the commas need to be removed from GNI column.
# Stringr and tidyr packages are loaded first

library(stringr)
library(tidyr)
human$GNI<-str_replace(human$GNI, pattern=",", replace="")%>%as.numeric(human$GNI)

# Exclude unneeded variables keeping only the columns: "Country", "Edu2.FM", "Labo.FM", 
# "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" 

# Columns to keep
keep<-c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" )

# Select the keep columns
human<-select(human, one_of(keep)) 

# Remove all rows with missing values.
human_<-filter(human, complete.cases(human))

# Remove the observations which relate to regions instead of countries. 
# Printing Country column to see which rows are countries and which are regions.
human_$Country

# The last 7 rows of the data set are regions, so they need to be removed.
# Define the last indice we want to keep
last<-nrow(human_)-7

# Choose everything until the last 7 observations
human_<-human_[1:last,]

# Define the row names of the data by the country names and remove the country name column 
# from the data. 
# Add countries as rownames
rownames(human_)<-human_$Country

# Remove the Country variable and then check the variables
human_<-select(human_, -Country)
dim(human_)
# The data should now have 155 observations and 8 variables, as it does

# Save the human data in your data folder including the row names, overwriting old human.txt
setwd("~/Desktop/IODS-project/data")
write.table(human_, file="human.txt")




