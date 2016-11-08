# Rebalance a dataset using Synthetic Minority Over-sampling Technique (SMOTE)

# load the libraries
library(mlbench)
library(DMwR)
# load the dataset
data(PimaIndiansDiabetes)
# display count of instances of each class (unbalanced)
table(PimaIndiansDiabetes$diabetes)
# use SMOTE to created a "more balance" version of the dataset
balanced <- SMOTE(diabetes~., PimaIndiansDiabetes, perc.over=300, perc.under=100)
