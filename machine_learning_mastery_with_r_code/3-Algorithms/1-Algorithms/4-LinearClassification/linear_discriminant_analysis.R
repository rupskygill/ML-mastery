# Linear Discriminant Analysis

# load the package
library(MASS)
data(iris)
# fit model
fit <- lda(Species~., data=iris)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4])$class
# summarize accuracy
table(predictions, iris$Species)

