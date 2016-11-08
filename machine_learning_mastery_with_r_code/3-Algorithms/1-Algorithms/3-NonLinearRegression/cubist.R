# Cubist

# load the package
library(Cubist)
# load data
data(longley)
# fit model
fit <- cubist(longley[,1:6], longley[,7])
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, longley[,1:6])
# summarize accuracy
mse <- mean((longley$Employed - predictions)^2)
print(mse)