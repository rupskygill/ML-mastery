# Randomly search algorithm parameters

# load the library
library(caret)
# load the dataset
data(iris)
# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3, search="random")
# train the model
model <- train(Species~., data=iris, method="lvq", trControl=control, tuneLength=25)
# summarize the model
print(model)
# plot the effect of parameters on accuracy
plot(model)