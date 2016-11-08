# Abalone

# Background
# Dataset description: http://archive.ics.uci.edu/ml/datasets/Abalone

# 0. Load Libraries
library(AppliedPredictiveModeling)
library(caret)
library(doMC)
library(corrplot)
registerDoMC(cores=8)

# 1. Load Dataset
data(abalone)
dataset <- abalone

# 2. Summarize Dataset
dim(dataset)
# list types for each attribute
sapply(dataset, class)
# split input and output
x <- dataset[,1:8]
y <- dataset[,9]
# summarize attribute distributions
summary(dataset)
# summarize correlations between input variables
cor(x[,2:8])

# 3. Visualize Dataset
# a) Univariate
# boxplots for each attribute
par(mfrow=c(3,3))
for(i in 2:9) {
	boxplot(dataset[,i], main=names(dataset)[i])
}
# histograms each attribute
par(mfrow=c(3,3))
for(i in 2:9) {
	hist(dataset[,i], main=names(dataset)[i])
}
# density plot for each attribute
par(mfrow=c(3,3))
for(i in 2:9) {
	plot(density(dataset[,i]), main=names(dataset)[i])
}
# b) Multivariate
# scatterplot matrix
pairs(dataset)
# correlation plot
correlations <- cor(dataset[,2:9])
corrplot(correlations, method="circle")

# 4. Feature Selection
# a) remove redundant
# b) remove highly correlated

# 5. Data Transforms

# 6. Evaluate Algorithms
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "RMSE"
seed <- 6
# a) linear algorithms
# GLM
set.seed(seed)
fit.glm <- train(Rings~., data=dataset, method="glm", metric=metric, trControl=control)
# lm
set.seed(seed)
fit.lm <- train(Rings~., data=dataset, method="lm", metric=metric, trControl=control)
# b) nonlinear algorithms
# SVM
set.seed(seed)
grid <- expand.grid(.sigma=c(0.01,0.05,0.1), .C=c(1))
fit.svm <- train(Rings~., data=dataset, method="svmRadial", metric=metric, tuneGrid=grid, trControl=control)
# CART
set.seed(seed)
grid <- expand.grid(.cp=c(0.01,0.05,0.1))
fit.cart <- train(Rings~., data=dataset, method="rpart", metric=metric, tuneGrid=grid, trControl=control)
# kNN
set.seed(seed)
grid <- expand.grid(.k=c(1,3,5,7))
fit.knn <- train(Rings~., data=dataset, method="knn", metric=metric, tuneGrid=grid, trControl=control)
# c) advanced algorithms
# Bagging
set.seed(seed)
fit.bagging <- train(Rings~., data=dataset, method="treebag", metric=metric, trControl=control)
# Gradient Boosting
set.seed(seed)
grid <- expand.grid( .n.trees=c(100, 250, 500), .shrinkage=c(0, 0.001, 0.1, 0.2, 0.3, 0.5, 1), .interaction.depth=c(1,2,3))
fit.boosting <- train(Rings~., data=dataset, method="gbm", metric=metric, tuneGrid=grid, trControl=control)
# d) compare algorithms
results <- resamples(list(SVM=fit.svm, CART=fit.cart, kNN=fit.knn, glm=fit.glm, lm=fit.lm, bag=fit.bagging, boost=fit.boosting))
summary(results)
dotplot(results)

# 7. Improve Results
# a) Algorithm Tuning
# b) Ensembles

# 8. Present Results
index <- best(fit.cart$results, metric, maximize=TRUE)
config <- fit.cart$results[index,]
print(config)


