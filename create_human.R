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

#DIDN'T HAVE ENOUGH TIME TO DO THE FOLLOWING DURING THIS WEEK!!
#Look at the meta files and rename the variables with (shorter) descriptive names. (1 point)
#Mutate the “Gender inequality” data and create two new variables. 
#The first one should be the ratio of Female and Male populations with secondary 
#education in each country. (i.e. edu2F / edu2M). 
#The second new variable should be the ratio of labour force participation 
#of females and males in each country (i.e. labF / labM). (1 point)
#Join together the two datasets using the variable Country as the identifier. 
#Keep only the countries in both data sets (Hint: inner join). 
#The joined data should have 195 observations and 19 variables. 

#Call the new joined data "human" and save it in your data folder. (1 point)
