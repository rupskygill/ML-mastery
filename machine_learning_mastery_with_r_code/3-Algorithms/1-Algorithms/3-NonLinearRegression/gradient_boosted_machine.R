# Gradient Boosted Machine

# load the package
library(gbm)
# load data
data(longley)
# fit model
fit <- gbm(Employed~., data=longley, distribution="gaussian", n.minobsinnode=1)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, longley[,1:6], n.trees=1)
# summarize accuracy
mse <- mean((longley$Employed - predictions)^2)
print(mse)
