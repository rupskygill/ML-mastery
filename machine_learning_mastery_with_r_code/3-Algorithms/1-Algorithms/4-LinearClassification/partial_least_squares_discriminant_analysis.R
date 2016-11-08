# Partial Least Squares Discriminant Analysis

# load the package
library(caret)
data(iris)
x <- iris[,1:4]
y <- iris[,5]
# fit model
fit <- plsda(x, y, probMethod="Bayes")
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4])
# summarize accuracy
table(predictions, iris$Species)
