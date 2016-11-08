# Rule System

# load the package
library(RWeka)
# load data
data(longley)
# fit model
fit <- M5Rules(Employed~., data=longley)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, longley[,1:6])
# summarize accuracy
mse <- mean((longley$Employed - predictions)^2)
print(mse)
