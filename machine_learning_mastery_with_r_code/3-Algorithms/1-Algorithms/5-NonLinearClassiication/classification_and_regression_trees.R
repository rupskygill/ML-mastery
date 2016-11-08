# Classification and Regression Trees

# load the package
library(rpart)
# load data
data(iris)
# fit model
fit <- rpart(Species~., data=iris)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4], type="class")
# summarize accuracy
table(predictions, iris$Species)

