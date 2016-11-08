# Identify and remove highly correlated features

# load the libraries
library(mlbench)
library(caret)
# load the data
data(PimaIndiansDiabetes)
# calculate correlation matrix
correlationMatrix <- cor(PimaIndiansDiabetes[,1:8])
# find attributes that are highly corrected (ideally >0.75)
cutoff <- 0.50
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=cutoff)
# create a new dataset without highly corrected features
dataset <- PimaIndiansDiabetes[,-highlyCorrelated]
