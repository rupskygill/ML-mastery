# Random Forest

# load the package
library(randomForest)
# load data
data(longley)
# fit model
fit <- randomForest(Employed~., data=longley)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, longley[,1:6])
# summarize accuracy
mse <- mean((longley$Employed - predictions)^2)
print(mse)
