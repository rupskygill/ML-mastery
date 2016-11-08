# Iris Flowers Case Study
# Hello world machine learning project

# Background
# Multi-class classification, numeric inputs
# Dataset Description: https://archive.ics.uci.edu/ml/datasets/Iris
# World-class results: http://www.is.umk.pl/projects/rules.html#Iris

# Load Libraries
library(caret)

# 1. Load Data
# attach the iris dataset to the environment
data(iris)
# rename the dataset
dataset <- iris

# 2. Split out validation dataset
# create a list of 80% of the rows in the original dataset we can use for training
validation_index <- createDataPartition(dataset$Species, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- dataset[-validation_index,]
# use the remaining 80% of data to training and testing the models
dataset <- dataset[validation_index,]

# 3. Summarize Dataset
# dimensions of dataset
dim(dataset)
# list types for each attribute
sapply(dataset, class)
# take a peek at the first 5 rows of the data
head(dataset)
# list the levels for the class
levels(dataset$Species)
# split input and output
x <- dataset[,1:4]
y <- dataset[,5]
# summarize the class distribution
percentage <- prop.table(table(dataset$Species)) * 100
cbind(freq=table(dataset$Species), percentage=percentage)
# summarize attribute distributions
summary(dataset)

# 4. Visualize Dataset
# a) Univariate
# boxplots for numeric
par(mfrow=c(1,4))
for(i in 1:4) {
	boxplot(x[,i], main=names(dataset)[i])
}
# barplot for class breakdown
plot(y)
# b) Multivariate
# scatterplot matrix
featurePlot(x=x, y=y, plot="ellipse")
# box and whisker plots for each attribute
featurePlot(x=x, y=y, plot="box")
# density plots for each attribute by class value
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)

# 5. Evaluate Algorithms
# Run algorithms using 10-fold cross validation
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"
# a) linear algorithms
set.seed(7)
fit.lda <- train(Species~., data=dataset, method="lda", metric=metric, trControl=control)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(Species~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(Species~., data=dataset, method="knn", metric=metric, trControl=control)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(Species~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(Species~., data=dataset, method="rf", metric=metric, trControl=control)
# d) compare algorithms
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)
dotplot(results)
# summarize Best Model
print(fit.lda)

# 6. Estimate Skill on Validation Dataset
set.seed(7)
predictions <- predict(fit.lda, newdata=validation)
confusionMatrix(predictions, validation$Species)
