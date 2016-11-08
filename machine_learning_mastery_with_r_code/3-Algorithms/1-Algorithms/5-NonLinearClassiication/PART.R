# PART

# load the package
library(RWeka)
# load data
data(iris)
# fit model
fit <- PART(Species~., data=iris)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, iris[,1:4])
# summarize accuracy
table(predictions, iris$Species)
