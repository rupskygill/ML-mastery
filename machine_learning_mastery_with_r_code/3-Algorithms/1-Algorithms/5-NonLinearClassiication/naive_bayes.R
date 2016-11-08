# Naive Bayes

# load the package
library(e1071)
data(iris)
# fit model
fit <- naiveBayes(Species~., data=iris)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4])
# summarize accuracy
table(predictions, iris$Species)
