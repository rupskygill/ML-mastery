# Partial Least Squares Regression

# load the package
library(pls)
# load data
data(longley)
# fit model
fit <- plsr(Employed~., data=longley, validation="CV")
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, longley, ncomp=6)
# summarize accuracy
mse <- mean((longley$Employed - predictions)^2)
print(mse)

