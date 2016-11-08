# Ordinary Least Squares Regression

# load data
data(longley)
# fit model
fit <- lm(Employed~., longley)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, longley)
# summarize accuracy
mse <- mean((longley$Employed - predictions)^2)
print(mse)

