# Breast Cancer

# binary classification, categorical attributes

# Description: https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+(Original)
# World-Class Results: http://www.is.umk.pl/projects/datasets.html#Wisconsin

# load libraries
library(mlbench)
library(caret)

# use multiple cores
library(doMC)
registerDoMC(cores=8)

# Load data
data(BreastCancer)

# Split out validation dataset
# create a list of 80% of the rows in the original dataset we can use for training
set.seed(7)
validation_index <- createDataPartition(BreastCancer$Class, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- BreastCancer[-validation_index,]
# use the remaining 80% of data to training and testing the models
dataset <- BreastCancer[validation_index,]


# data analysis

# dimensions of dataaset
dim(dataset)

# peek
head(dataset, n=20)

# types
sapply(dataset, class)

# Remove redundant variable Id
dataset <- dataset[,-1]
# convert input values to numeric
for(i in 1:9) {
	dataset[,i] <- as.numeric(as.character(dataset[,i]))
}

# summary
summary(dataset)

# class distribution
cbind(freq=table(dataset$Class), percentage=prop.table(table(dataset$Class))*100)

# summarize correlations between input variables
complete_cases <- complete.cases(dataset)
cor(dataset[complete_cases,1:9])

# histograms each attribute
par(mfrow=c(3,3))
for(i in 1:9) {
	hist(dataset[,i], main=names(dataset)[i])
}

# density plot for each attribute
par(mfrow=c(3,3))
complete_cases <- complete.cases(dataset)
for(i in 1:9) {
	plot(density(dataset[complete_cases,i]), main=names(dataset)[i])
}

# boxplots for each attribute
par(mfrow=c(3,3))
for(i in 1:9) {
	boxplot(dataset[,i], main=names(dataset)[i])
}

# scatterplot matrix
jittered_x <- sapply(dataset[,1:9], jitter)
pairs(jittered_x, names(dataset[,1:9]), col=dataset$Class)

# bar plots of each variable by class
par(mfrow=c(3,3))
for(i in 1:9) {
	barplot(table(dataset$Class,dataset[,i]), main=names(dataset)[i], legend.text=unique(dataset$Class))
}



# Evaluate Algorithms

# 10-fold cross validation with 3 repeats
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "Accuracy"
# LG
set.seed(7)
fit.glm <- train(Class~., data=dataset, method="glm", metric=metric, trControl=control)
# LDA
set.seed(7)
fit.lda <- train(Class~., data=dataset, method="lda", metric=metric, trControl=control)
# GLMNET
set.seed(7)
fit.glmnet <- train(Class~., data=dataset, method="glmnet", metric=metric, trControl=control)
# KNN
set.seed(7)
fit.knn <- train(Class~., data=dataset, method="knn", metric=metric, trControl=control)
# CART
set.seed(7)
fit.cart <- train(Class~., data=dataset, method="rpart", metric=metric, trControl=control)
# Naive Bayes
set.seed(7)
fit.nb <- train(Class~., data=dataset, method="nb", metric=metric, trControl=control)
# SVM
set.seed(7)
fit.svm <- train(Class~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Compare algorithms
results <- resamples(list(LG=fit.glm, LDA=fit.lda, GLMNET=fit.glmnet, KNN=fit.knn, CART=fit.cart, NB=fit.nb, SVM=fit.svm))
summary(results)
dotplot(results)


# Evaluate Algorithms Transform

# 10-fold cross validation with 3 repeats
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "Accuracy"
# LG
set.seed(7)
fit.glm <- train(Class~., data=dataset, method="glm", metric=metric, preProc=c("BoxCox"), trControl=control)
# LDA
set.seed(7)
fit.lda <- train(Class~., data=dataset, method="lda", metric=metric, preProc=c("BoxCox"), trControl=control)
# GLMNET
set.seed(7)
fit.glmnet <- train(Class~., data=dataset, method="glmnet", metric=metric, preProc=c("BoxCox"), trControl=control)
# KNN
set.seed(7)
fit.knn <- train(Class~., data=dataset, method="knn", metric=metric, preProc=c("BoxCox"), trControl=control)
# CART
set.seed(7)
fit.cart <- train(Class~., data=dataset, method="rpart", metric=metric, preProc=c("BoxCox"), trControl=control)
# Naive Bayes
set.seed(7)
fit.nb <- train(Class~., data=dataset, method="nb", metric=metric, preProc=c("BoxCox"), trControl=control)
# SVM
set.seed(7)
fit.svm <- train(Class~., data=dataset, method="svmRadial", metric=metric, preProc=c("BoxCox"), trControl=control)
# Compare algorithms
transform_results <- resamples(list(LG=fit.glm, LDA=fit.lda, GLMNET=fit.glmnet, KNN=fit.knn, CART=fit.cart, NB=fit.nb, SVM=fit.svm))
summary(transform_results)
dotplot(transform_results)



# Tune SVM

# 10-fold cross validation with 3 repeats
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "Accuracy"
set.seed(7)
grid <- expand.grid(.sigma=c(0.025, 0.05, 0.1, 0.15), .C=seq(1, 10, by=1))
fit.svm <- train(Class~., data=dataset, method="svmRadial", metric=metric, tuneGrid=grid, preProc=c("BoxCox"), trControl=control)
print(fit.svm)
plot(fit.svm)


# Tune kNN

# 10-fold cross validation with 3 repeats
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "Accuracy"
set.seed(7)
grid <- expand.grid(.k=seq(1,20,by=1))
fit.knn <- train(Class~., data=dataset, method="knn", metric=metric, tuneGrid=grid, preProc=c("BoxCox"), trControl=control)
print(fit.knn)
plot(fit.knn)



# Ensembles: Boosting and Bagging


# 10-fold cross validation with 3 repeats
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "Accuracy"
# Bagged CART
set.seed(7)
fit.treebag <- train(Class~., data=dataset, method="treebag", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(Class~., data=dataset, method="rf", metric=metric, preProc=c("BoxCox"), trControl=control)
# Stochastic Gradient Boosting
set.seed(7)
fit.gbm <- train(Class~., data=dataset, method="gbm", metric=metric, preProc=c("BoxCox"), trControl=control, verbose=FALSE)
# C5.0
set.seed(7)
fit.c50 <- train(Class~., data=dataset, method="C5.0", metric=metric, preProc=c("BoxCox"), trControl=control)
# Compare results
ensemble_results <- resamples(list(BAG=fit.treebag, RF=fit.rf, GBM=fit.gbm, C50=fit.c50))
summary(ensemble_results)
dotplot(ensemble_results)



# Finalize

# prepare parameters for data transform
set.seed(7)
dataset_nomissing <- dataset[complete.cases(dataset),]
x <- dataset_nomissing[,1:9]
preprocessParams <- preProcess(x, method=c("BoxCox"))
x <- predict(preprocessParams, x)

# prepare the validation dataset
set.seed(7)
# remove id column
validation <- validation[,-1]
# remove missing values (not allowed in this implementation of knn)
validation <- validation[complete.cases(validation),]
# convert to numeric
for(i in 1:9) {
	validation[,i] <- as.numeric(as.character(validation[,i]))
}
# transform the validation dataset
validation_x <- predict(preprocessParams, validation[,1:9])

# make predictions
set.seed(7)
predictions <- knn3Train(x, validation_x, dataset_nomissing$Class, k=9, prob=FALSE)
confusionMatrix(predictions, validation$Class)



