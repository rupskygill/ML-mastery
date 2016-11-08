# Support Vector Machine

# load the package
library(kernlab)
data(iris)
# fit model
fit <- ksvm(Species~., data=iris)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4], type="response")
# summarize accuracy
table(predictions, iris$Species)
