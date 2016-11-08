# Housing Values in Suburbs of Boston

# Regression, numeric inputs

# Dataset Description: https://archive.ics.uci.edu/ml/datasets/Housing


# load libraries
library(mlbench)
library(caret)
library(corrplot)

# attach the BostonHousing dataset
data(BostonHousing)

# Split out validation dataset
# create a list of 80% of the rows in the original dataset we can use for training
set.seed(7)
validation_index <- createDataPartition(BostonHousing$medv, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- BostonHousing[-validation_index,]
# use the remaining 80% of data to training and testing the models
dataset <- BostonHousing[validation_index,]


# Summarize data

# dimensions of dataset
dim(dataset)

# list types for each attribute
sapply(dataset, class)

# take a peek at the first 5 rows of the data
head(dataset, n=20)

# summarize attribute distributions
summary(dataset)

# convert factor to numeric
dataset[,4] <- as.numeric(as.character(dataset[,4]))


# summarize correlations between input variables
cor(dataset[,1:13])


# Univaraite Visualization

# histograms each attribute
par(mfrow=c(2,7))
for(i in 1:13) {
	hist(dataset[,i], main=names(dataset)[i])
}

# density plot for each attribute
par(mfrow=c(2,7))
for(i in 1:13) {
	plot(density(dataset[,i]), main=names(dataset)[i])
}

# boxplots for each attribute
par(mfrow=c(2,7))
for(i in 1:13) {
	boxplot(dataset[,i], main=names(dataset)[i])
}


# Multivariate Visualizations

# scatterplot matrix
pairs(dataset[,1:13])

# correlation plot
correlations <- cor(dataset[,1:13])
corrplot(correlations, method="circle")


# Evaluate Algorithms: Baseline

# Run algorithms using 10-fold cross validation
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "RMSE"
# lm
set.seed(7)
fit.lm <- train(medv~., data=dataset, method="lm", metric=metric, preProc=c("center", "scale"), trControl=control)
# GLM
set.seed(7)
fit.glm <- train(medv~., data=dataset, method="glm", metric=metric, preProc=c("center", "scale"), trControl=control)
# GLMNET
set.seed(7)
fit.glmnet <- train(medv~., data=dataset, method="glmnet", metric=metric, preProc=c("center", "scale"), trControl=control)
# SVM
set.seed(7)
fit.svm <- train(medv~., data=dataset, method="svmRadial", metric=metric, preProc=c("center", "scale"), trControl=control)
# CART
set.seed(7)
grid <- expand.grid(.cp=c(0, 0.05, 0.1))
fit.cart <- train(medv~., data=dataset, method="rpart", metric=metric, tuneGrid=grid, preProc=c("center", "scale"), trControl=control)
# kNN
set.seed(7)
fit.knn <- train(medv~., data=dataset, method="knn", metric=metric, preProc=c("center", "scale"), trControl=control)
# Compare algorithms
results <- resamples(list(LM=fit.lm, GLM=fit.glm, GLMNET=fit.glmnet, SVM=fit.svm, CART=fit.cart, KNN=fit.knn))
summary(results)
dotplot(results)


# Evaluate Algorithms: Feature Selection

# remove correlated attributes
# find attributes that are highly corrected
set.seed(7)
cutoff <- 0.70
correlations <- cor(dataset[,1:13])
highlyCorrelated <- findCorrelation(correlations, cutoff=cutoff)
for (value in highlyCorrelated) {
	print(names(dataset)[value])
}
# create a new dataset without highly corrected features
dataset_features <- dataset[,-highlyCorrelated]
dim(dataset_features)

# Run algorithms using 10-fold cross validation
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "RMSE"
# lm
set.seed(7)
fit.lm <- train(medv~., data=dataset_features, method="lm", metric=metric, preProc=c("center", "scale"), trControl=control)
# GLM
set.seed(7)
fit.glm <- train(medv~., data=dataset_features, method="glm", metric=metric, preProc=c("center", "scale"), trControl=control)
# GLMNET
set.seed(7)
fit.glmnet <- train(medv~., data=dataset_features, method="glmnet", metric=metric, preProc=c("center", "scale"), trControl=control)
# SVM
set.seed(7)
fit.svm <- train(medv~., data=dataset_features, method="svmRadial", metric=metric, preProc=c("center", "scale"), trControl=control)
# CART
set.seed(7)
grid <- expand.grid(.cp=c(0, 0.05, 0.1))
fit.cart <- train(medv~., data=dataset_features, method="rpart", metric=metric, tuneGrid=grid, preProc=c("center", "scale"), trControl=control)
# kNN
set.seed(7)
fit.knn <- train(medv~., data=dataset_features, method="knn", metric=metric, preProc=c("center", "scale"), trControl=control)
# Compare algorithms
feature_results <- resamples(list(LM=fit.lm, GLM=fit.glm, GLMNET=fit.glmnet, SVM=fit.svm, CART=fit.cart, KNN=fit.knn))
summary(feature_results)
dotplot(feature_results)


# Evaluate Algorithnms: Box-Cox Transform

# Run algorithms using 10-fold cross validation
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "RMSE"
# lm
set.seed(7)
fit.lm <- train(medv~., data=dataset, method="lm", metric=metric, preProc=c("center", "scale", "BoxCox"), trControl=control)
# GLM
set.seed(7)
fit.glm <- train(medv~., data=dataset, method="glm", metric=metric, preProc=c("center", "scale", "BoxCox"), trControl=control)
# GLMNET
set.seed(7)
fit.glmnet <- train(medv~., data=dataset, method="glmnet", metric=metric, preProc=c("center", "scale", "BoxCox"), trControl=control)
# SVM
set.seed(7)
fit.svm <- train(medv~., data=dataset, method="svmRadial", metric=metric, preProc=c("center", "scale", "BoxCox"), trControl=control)
# CART
set.seed(7)
grid <- expand.grid(.cp=c(0, 0.05, 0.1))
fit.cart <- train(medv~., data=dataset, method="rpart", metric=metric, tuneGrid=grid, preProc=c("center", "scale", "BoxCox"), trControl=control)
# kNN
set.seed(7)
fit.knn <- train(medv~., data=dataset, method="knn", metric=metric, preProc=c("center", "scale", "BoxCox"), trControl=control)
# Compare algorithms
transform_results <- resamples(list(LM=fit.lm, GLM=fit.glm, GLMNET=fit.glmnet, SVM=fit.svm, CART=fit.cart, KNN=fit.knn))
summary(transform_results)
dotplot(transform_results)


# Improve Results With Tuning

# look at parameters
print(fit.svm)

# tune SVM sigma and C parametres
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "RMSE"
set.seed(7)
grid <- expand.grid(.sigma=c(0.025, 0.05, 0.1, 0.15), .C=seq(1, 10, by=1))
fit.svm <- train(medv~., data=dataset, method="svmRadial", metric=metric, tuneGrid=grid, preProc=c("BoxCox"), trControl=control)
print(fit.svm)
plot(fit.svm)


# Ensemble Methods

# try ensembles
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "RMSE"
# Random Forest
set.seed(seed)
fit.rf <- train(medv~., data=dataset, method="rf", metric=metric, preProc=c("BoxCox"), trControl=control)
# Stochastic Gradient Boosting
set.seed(seed)
fit.gbm <- train(medv~., data=dataset, method="gbm", metric=metric, preProc=c("BoxCox"), trControl=control, verbose=FALSE)
# Cubist
set.seed(seed)
fit.cubist <- train(medv~., data=dataset, method="cubist", metric=metric, preProc=c("BoxCox"), trControl=control)
# Compare algorithms
ensemble_results <- resamples(list(RF=fit.rf, GBM=fit.gbm, CUBIST=fit.cubist))
summary(ensemble_results)
dotplot(ensemble_results)


# Tune Cubist

# look at parameters used for Cubist
print(fit.cubist)

# Tune the Cubist algorithm
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "RMSE"
set.seed(7)
grid <- expand.grid(.committees=seq(15, 25, by=1), .neighbors=c(3, 5, 7))
tune.cubist <- train(medv~., data=dataset, method="cubist", metric=metric, preProc=c("BoxCox"), tuneGrid=grid, trControl=control)
print(tune.cubist)
plot(tune.cubist)


# Finalize Model


# prepare the data transform using training data
set.seed(7)
x <- dataset[,1:13]
y <- dataset[,14]
preprocessParams <- preProcess(x, method=c("BoxCox"))
trans_x <- predict(preprocessParams, x)
# train the final model
finalModel <- cubist(x=trans_x, y=y, committees=18)
summary(finalModel)

# transform the validation dataset
set.seed(7)
val_x <- validation[,1:13]
trans_val_x <- predict(preprocessParams, val_x)
val_y <- validation[,14]
# use final model to make predictions on the validation dataset
predictions <- predict(finalModel, newdata=trans_val_x, neighbors=3)
# calculate RMSE
rmse <- RMSE(predictions, val_y)
r2 <- R2(predictions, val_y)
print(rmse)

