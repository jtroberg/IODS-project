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
