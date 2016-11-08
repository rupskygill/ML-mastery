# Longley's Economic Regression Data

# Regression, all numeric inputs

library(caret)
library(doMC)

# use multiple cores
registerDoMC(cores=8)

# 1. Load data
data(longley)
dataset <- longley

# 2. Summarize data
# dimensions of dataaset
dim(dataset)
# summarize attribute distributions
summary(dataset)
# summarize correlations between input variables
cor(dataset)

# 3. Visualize Data
# scatterplot matrix
pairs(dataset)
# boxplots for each attribute
par(mfrow=c(2,4))
for(i in 1:7) {
	boxplot(dataset[,i], main=names(dataset)[i])
}
# histograms each attribute
par(mfrow=c(2,4))
for(i in 1:7) {
	hist(dataset[,i], main=names(dataset)[i])
}
# density plot for each attribute
par(mfrow=c(2,4))
for(i in 1:7) {
	plot(density(dataset[,i]), main=names(dataset)[i])
}
# correlation plot
correlations <- cor(dataset)
corrplot(correlations, method="circle")


# 4 Data Transforms
# scale dataset
dataset[,1:13] <- scale(dataset[,1:13])


# 5. Evaluate Algorithms
# Run algorithms using 10-fold cross validation
control <- trainControl(method="repeatedcv", number=10, repeats=3)
metric <- "RMSE"
# GLM
set.seed(7)
fit.glm <- train(Employed~., data=dataset, method="glm", metric=metric, trControl=control)
# lm
set.seed(7)
fit.lm <- train(Employed~., data=dataset, method="lm", metric=metric, trControl=control)
# SVM
set.seed(7)
grid <- expand.grid(.sigma=c(0.01,0.05,0.1), .C=c(1))
fit.svm <- train(Employed~., data=dataset, method="svmRadial", metric=metric, tuneGrid=grid, trControl=control)
# CART
set.seed(7)
grid <- expand.grid(.cp=c(0.01,0.05,0.1))
fit.cart <- train(Employed~., data=dataset, method="rpart", metric=metric, tuneGrid=grid, trControl=control)
# kNN
set.seed(7)
grid <- expand.grid(.k=c(1,3,5,7))
fit.knn <- train(Employed~., data=dataset, method="knn", metric=metric, tuneGrid=grid, trControl=control)
# Compare algorithms
results <- resamples(list(SVM=fit.svm, CART=fit.cart, kNN=fit.knn, glm=fit.glm, lm=fit.lm))
summary(results)
dotplot(results)

