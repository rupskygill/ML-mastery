# Bagging or Bootstrap Aggregation of Decision Trees

# load the libraries
library(ipred)
library(rpart)
library(mlbench)
# load the dataset
data(PimaIndiansDiabetes)
# bag the decision tree
model <- bagging(diabetes~., data=PimaIndiansDiabetes, nbagg=25, coob=TRUE)
# make predictions on the training dataset
predictions <- predict(model, PimaIndiansDiabetes[,1:8])
# summarize accuracy
table(predictions, PimaIndiansDiabetes$diabetes)
