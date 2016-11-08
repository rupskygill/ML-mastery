# Select the best tuning configuration

# load libraries
library(mlbench)
library(caret)
# load the dataset
data(PimaIndiansDiabetes)
# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# CART
set.seed(7)
tunegrid <- expand.grid(.cp=seq(0,0.1,by=0.01))
fit.cart <- train(diabetes~., data=PimaIndiansDiabetes, method="rpart", metric="Accuracy", tuneGrid=tunegrid, trControl=control)
# display the best configuration
print(fit.cart$bestTune)
