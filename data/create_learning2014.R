#Johanna Troberg, 30.1.2017, Rstudio exercise 2, data wrangling

#reading the data frum the given file into R, telling that each fields are separated by tabs and that there is a name of the column in the first line.
learning2014<-read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
str(learning2014)
#Studying the data by str() command and dim() command shows that it has 183 obs of 60 variables. 
#The structure gives more details about these variables, dimensions give just 183 and 60, which means that there are 183 lines and 60 columns.

#Access the dplyr library
library(dplyr)

# Because some of the data is not yet in the final form, the deep, surface and strategic learning questions need to be combined. 

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06", "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#Combining these columns and creating their own column by averaging.

deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

#Because attitude toward statistics is formed from multiple questions (Da+Db+Dc+Dd+De+Df+Dg+Dh+Di+Dj) the average value should be divided by the number of questions (=10)
learning2014$attitude<-learning2014$Attitude/10

#Choosing what columns are kept for analysis dataset
keep_columns<-c("gender","Age","attitude", "deep", "stra", "surf", "Points")

#Creating analysis dataset that includes gender, age, attitude, deep, stra, surf and points.
analysis_dataset <- select(learning2014, one_of(keep_columns))
str(analysis_dataset)

#Exclude observations where the exam points variable is 0.
analysis_dataset<-filter(analysis_dataset, Points>0)

#analysis of the dimensions of the filtered dataset.
dim(analysis_dataset)

#Saving the R.file into txt format. Before this the working directory has been changed to IODS-project and under Data folder.
write.table(analysis_dataset, file="learning2014.txt")

#Checking that txt file can be read and same dimensions are present (=166 and 7)
testing_txt<-read.table("learning2014.txt")
str(testing_txt)
head(testing_txt)