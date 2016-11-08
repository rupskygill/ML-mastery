# Feed Forward Neural Network

# load the package
library(nnet)
data(iris)
# fit model
fit <- nnet(Species~., data=iris, size=4, decay=0.0001, maxit=500)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4], type="class")
# summarize accuracy
table(predictions, iris$Species)
