# Gradient Boosted Machine

# load the package
library(gbm)
# load data
data(iris)
# fit model
fit <- gbm(Species~., data=iris, distribution="multinomial")
# summarize the fit
print(fit)
# make predictions
probabilities <- predict(fit, iris[,1:4], n.trees=1)
predictions <-  colnames(probabilities)[apply(probabilities, 1, which.max)]
# summarize accuracy
table(predictions, iris$Species)

