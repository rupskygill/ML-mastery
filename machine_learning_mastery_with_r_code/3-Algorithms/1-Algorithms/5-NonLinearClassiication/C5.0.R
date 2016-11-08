# C5.0

# load the package
library(C50)
# load data
data(iris)
# fit model
fit <- C5.0(Species~., data=iris, trials=10)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4])
# summarize accuracy
table(predictions, iris$Species)
