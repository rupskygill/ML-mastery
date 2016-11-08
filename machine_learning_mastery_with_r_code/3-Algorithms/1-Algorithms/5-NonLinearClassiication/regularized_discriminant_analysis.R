# Regularized Discriminant Analysis

# load the package
library(klaR)
data(iris)
# fit model
fit <- rda(Species~., data=iris, gamma=0.05, lambda=0.01)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4])$class
# summarize accuracy
table(predictions, iris$Species)
