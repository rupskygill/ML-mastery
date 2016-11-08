# Mixture Discriminant Analysis

# load the package
library(mda)
data(iris)
# fit model
fit <- mda(Species~., data=iris)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4])
# summarize accuracy
table(predictions, iris$Species)
