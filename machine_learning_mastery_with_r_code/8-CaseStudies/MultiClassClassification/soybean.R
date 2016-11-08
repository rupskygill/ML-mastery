# Soybean

# Background
# Multi-class classification, categorical inputs, lots of NAs
# Dataset Description: http://archive.ics.uci.edu/ml/datasets/Soybean+%28Large%29

# 0. Load Libraries
library(mlbench)
library(caret)
library(doMC)
registerDoMC(cores=8)

# 1. Load Dataset
data(Soybean)
dataset <- Soybean
# move class to the end
dataset <- cbind(dataset[,-1], dataset[,1])
colnames(dataset)[36] <- "Class"
# remove classes that have no data
badclasses <- c("2-4-d-injury", "cyst-nematode", "diaporthe-pod-&-stem-blight", "herbicide-injury")
dataset <- dataset[! dataset$Class %in% badclasses,]
dataset <- droplevels(dataset)

# 2. Summarize Dataset
# dimensions of dataset
dim(dataset)
# list types for each attribute
sapply(dataset, class)
# split input and output
x <- dataset[,1:35]
y <- dataset[,36]
# class distribution
cbind(freq=table(y), percentage=prop.table(table(y))*100)
# summarize attribute distributions
summary(dataset)

# 3. Visualize Dataset
# a) Univariate
# bar plots of each variable
# par(mfrow=c(4,5))
# for(i in 1:18) {
# 	barplot(table(x[,i]), main=names(dataset)[i])
# }
# par(mfrow=c(4,5))
# for(i in 19:36) {
# 	barplot(table(x[,i]), main=names(dataset)[i])
# }
# b) Multivariate
# n/a

# 4. Feature Selection
# n/a

# 5. Data Transforms
# n/a

# 6. Evaluate Algorithms
control <- trainControl(method="cv", number=10)
# a) linear algorithms
# n.a
# b) nonlinear algorithms
# SVM
set.seed(7)
grid <- expand.grid(.sigma=c(0.01,0.05,0.1), .C=c(1))
fit.svm <- train(Class~., data=dataset, method="svmRadial", metric="Accuracy", tuneGrid=grid, trControl=control)
# CART
set.seed(7)
grid <- expand.grid(.cp=c(0.01,0.05,0.1))
fit.cart <- train(Class~., data=dataset, method="rpart", metric="Accuracy", tuneGrid=grid, trControl=control)
# kNN
set.seed(7)
grid <- expand.grid(.k=c(1,3,5,7))
fit.knn <- train(Class~., data=dataset, method="knn", metric="Accuracy", tuneGrid=grid, trControl=control)
# c) advanced algorithms
# Random Forest
set.seed(7)
grid <- expand.grid(.mtry=c(100, 250, 500))
fit.rf <- train(Class~., data=dataset, method="rf", metric="Accuracy", tuneGrid=grid, trControl=control)
# Bagging
set.seed(7)
fit.bagging <- train(Class~., data=dataset, method="treebag", metric="Accuracy", trControl=control)
# Gradient Boosting
set.seed(7)
grid <- expand.grid(.n.trees=c(100, 250, 500), .shrinkage=c(0, 0.001, 0.1, 0.2, 0.3, 0.5, 1), .interaction.depth=c(1,2,3), .n.minobsinnode=c(1, 2, 3))
fit.boosting <- train(Class~., data=dataset, method="gbm", metric="Accuracy", tuneGrid=grid, trControl=control)
# d) Compare algorithms
results <- resamples(list(SVM=fit.svm, CART=fit.cart, kNN=fit.knn, RF=fit.rf, bag=fit.bagging, boost=fit.boosting))
summary(results)
dotplot(results)

# 7. Improve Results
# a) Algorithm Tuning
# n.a
# b) Ensembles
# n.a

# 8. Present Results
index <- best(fit.svm$results, "Accuracy", maximize=TRUE)
config <- fit.svm$results[index,]
print(config)

