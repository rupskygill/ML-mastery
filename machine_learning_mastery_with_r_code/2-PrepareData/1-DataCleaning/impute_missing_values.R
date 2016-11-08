 # Impute missing values

 # load the libraries
library(mlbench)
library(Hmisc)
# load the dataset
data(PimaIndiansDiabetes)
# mark a pressure of 0 as N/A, it is impossible
invalid <- 0
PimaIndiansDiabetes$pressure[PimaIndiansDiabetes$pressure==invalid] <- NA
# impute missing pressure values using the mean
PimaIndiansDiabetes$pressure <- with(PimaIndiansDiabetes, impute(pressure, mean))
