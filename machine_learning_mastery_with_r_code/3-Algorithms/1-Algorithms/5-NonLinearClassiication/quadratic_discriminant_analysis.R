# Quadratic Discriminant Analysis

# load the package
library(MASS)
data(iris)
# fit model
fit <- qda(Species~., data=iris)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4])$class
# summarize accuracy
table(predictions, iris$Species)
