# Mark Missing Values as N/A

# load the libraries
library(mlbench)
# load the dataset
data(PimaIndiansDiabetes)
# mark a pressure of 0 as N/A, it is impossible
invalid <- 0
PimaIndiansDiabetes$pressure[PimaIndiansDiabetes$pressure==invalid] <- NA
