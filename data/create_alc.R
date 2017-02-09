# Johanna Troberg
# 9.2.2017

# Data set of student alcohol consumption downloaded from The UCI Machine Learning Repository, https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION

# Read student-mat.csv and student-por.csv into R. These files are saved under same folder than current working directory is, so they can be called by their filename.
math<-read.table("student-mat.csv", sep=";", header=TRUE)
por<-read.table("student-por.csv", sep=";", header=TRUE)

# Explore the structure and dimensions of the data.
str(math)
dim(math)
str(por)
dim(por)

#There are 395 objects and 33 variables in the math-file. Most of the variables are integers, but some are factors (answered by no/yes).
#There are 649 objects and 33 variables in the por-file. The questions are the same than in mat, but there are more students answering to questionare in this datafile. 

