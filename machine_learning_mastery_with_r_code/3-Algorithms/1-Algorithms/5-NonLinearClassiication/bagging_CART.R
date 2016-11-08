# Bagging CART

# load the package
library(ipred)
# load data
data(iris)
# fit model
fit <- bagging(Species~., data=iris)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4], type="class")
# summarize accuracy
table(predictions, iris$Species)
