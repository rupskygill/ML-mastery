# Save and Load model


# load libraries
library(caret)
library(mlbench)
library(randomForest)
library(doMC)
registerDoMC(cores=8)
# load dataset
data(Sonar)
set.seed(7)
# create 80%/20% for training and validation datasets
validation_index <- createDataPartition(Sonar$Class, p=0.80, list=FALSE)
validation <- Sonar[-validation_index,]
training <- Sonar[validation_index,]
# create final standalone model using all training data
set.seed(7)
final_model <- randomForest(Class~., training, mtry=2, ntree=2000)
# save the model to disk
saveRDS(final_model, "./final_model.rds")

# later...

# load the model
super_model <- readRDS("./final_model.rds")
print(super_model)
# make a predictions on "new data" using the final model
final_predictions <- predict(super_model, validation[,1:60])
confusionMatrix(final_predictions, validation$Class)
