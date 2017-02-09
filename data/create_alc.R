# Johanna Troberg
# 9.2.2017

# Data set of student alcohol consumption downloaded from The UCI Machine Learning Repository, https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION

# Read student-mat.csv and student-por.csv into R. These files are saved under same folder than current working directory is, so they can be called by their filename.
math<-read.table("student-mat.csv", sep=";", header=TRUE)
por<-read.table("student-por.csv", sep=";", header=TRUE)

# Explore the structure and dimensions of the data.
str(math); dim(math)
str(por); dim(por)

# There are 395 objects and 33 variables in the math-file. Most of the variables are integers, but some are factors (answered by no/yes).
# There are 649 objects and 33 variables in the por-file. The questions are the same than in mat, but there are more students answering to questionare in this datafile. 

# Join 2 data sets using variables "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", and "internet" as identifiers. 
# Identifiers are needed because we want to find the duplicates (persons that have taken the questionnaire twice, and can be found in both math and por data files.)
# Identifiers are questions (columns) that are very likely answered in the same way in both question times.
# First we need an access to dplyr library (enables inner.join())
library(dplyr)

# Telling which columns are the identifiers
join_by<-c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery", "internet")

# Creating one data set from the 2 data sets by join_by identifiers. 
# The inner_join will return all rows from "math" where there are matching values in "por", and all columns from "math" and "por". 
# So this gives the students who answered in both questionnaires (math_por).
math_por <- inner_join(math, por, by = join_by, suffix=c(".math", ".por"))

# Studying the structure and dimensions of the joined data 
str(math_por); dim(math_por)

# The combined data file has now 382 objects and 53 variables. The number of variables is increased, because we have now the same questions but from two different
# sources. So if we had 33+33 questions in the beginning, we told that 13 of them are identifiers what makes 33+33-13=53.

# To combine the duplicate answers from the joined data if-else structure is used. If the answer for question is numeric, a mean value is taken, but if it is a factor, the first answer will be picked and another one ignored.

# First starting new combined data set named alc. First the joined columns are put here.
alc <-select(math_por, one_of(join_by))

# Calling the not joined columns for combination (then making for them for if-else structure)
notjoined_columns<-colnames(math)[!colnames(math)%in%join_by]
for(column_name in notjoined_columns){
  # select 2 columns with combined data file with same original name
  two_columns<-select(math_por, starts_with (column_name))
  # select first column vector of two columns
  first_column<-select(two_columns, 1)[[1]]
  #if it is numeric...
  if (is.numeric(first_column)){
    #...take an average of each row and add it to data frame,
    alc[column_name]<-round(rowMeans(two_columns))
  # else if not numeric, add the first column vector to data frame.
    }else{alc[column_name]<-first_column}}

# Make a new column (alc_use) in joined data (alc) about average of the answers of weekday and weekend alcohol consumption.
alc<-mutate(alc, alc_use=(Dalc+Walc)/2)

# Make new logical column (high_use) in joined data (alc), what is TRUE for those which alc_use is >2 
alc<-mutate(alc, high_use=alc_use>2)

