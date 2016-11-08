# Update Data Frame to Remove Outliers

# load the libraries
library(mlbench)
# load the dataset
data(PimaIndiansDiabetes)
# calculate stats for pregnant (number of times pregnant)
pregnant.mean <- mean(PimaIndiansDiabetes$pregnant)
pregnant.sd <- sd(PimaIndiansDiabetes$pregnant)
# max reasonable value is within 99.7% of the data (if Gaussian)
pregnant.max <- pregnant.mean + (3*pregnant.sd)
# mark outlier pregnant values as N/A
PimaIndiansDiabetes$pregnant[PimaIndiansDiabetes$pregnant>pregnant.max] <- NA
