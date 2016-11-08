# Glass

# Multi-class classification, numeric inputs

# Dataset Description: https://archive.ics.uci.edu/ml/datasets/Glass+Identification
# World-Class results: http://www.is.umk.pl/projects/datasets.html#Other

library(mlbench)
library(caret)
library(doMC)
library(corrplot)
registerDoMC(cores=8)

# 1. Load data
data(Glass)
dataset <- Glass

# 2. Summarize data
# dimensions of dataaset
dim(dataset)
# list types for each attribute
sapply(dataset, class)
# split input and output
x <- dataset[,1:9]
y <- dataset[,10]
# class distribution
cbind(freq=table(y), percentage=prop.table(table(y))*100)
# summarize attribute distributions
summary(dataset)
# summarize correlations between input variables
cor(x)

# 3. Visualize Data
# a) Univariate
# boxplots for each attribute
par(mfrow=c(3,3))
for(i in 1:9) {
	boxplot(dataset[,i], main=names(dataset)[i])
}
# histograms each attribute
par(mfrow=c(2,4))
for(i in 1:7) {
	hist(dataset[,i], main=names(dataset)[i])
}
# density plot for each attribute
par(mfrow=c(3,3))
for(i in 1:9) {
	plot(density(dataset[,i]), main=names(dataset)[i])
}
# b) Multivariate
# scatterplot matrix colored by class
pairs(Type~., data=dataset, col=dataset$Type)
# box and whisker plots for each attribute by class
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="box", scales=scales)
# density plots for each attribute by class value
featurePlot(x=x, y=y, plot="density", scales=scales)
# correlation plot
correlations <- cor(x)
corrplot(correlations, method="circle")

# 4. Data Transforms
dataset[,1:9] <- scale(dataset[,1:9])

# 5. Evaluate Algorithms
# Run algorithms using 10-fold cross validation
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# LDA
set.seed(7)
fit.lda <- train(Type~., data=dataset, method="lda", metric="Accuracy", trControl=control)
# SVM
set.seed(7)
grid <- expand.grid(.sigma=c(0.01,0.05,0.1), .C=c(1))
fit.svm <- train(Type~., data=dataset, method="svmRadial", metric="Accuracy", tuneGrid=grid, trControl=control)
# CART
set.seed(7)
grid <- expand.grid(.cp=c(0.01,0.05,0.1))
fit.cart <- train(Type~., data=dataset, method="rpart", metric="Accuracy", tuneGrid=grid, trControl=control)
# kNN
set.seed(7)
grid <- expand.grid(.k=c(1,3,5,7))
fit.knn <- train(Type~., data=dataset, method="knn", metric="Accuracy", tuneGrid=grid, trControl=control)
# Compare algorithms
results <- resamples(list(SVM=fit.svm, CART=fit.cart, kNN=fit.knn, lda=fit.lda))
summary(results)
dotplot(results)



