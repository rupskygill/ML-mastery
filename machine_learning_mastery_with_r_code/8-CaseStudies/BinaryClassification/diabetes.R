# Onset of Diabetes in Pima Indians

# Binary classification, features have varying scales, missing data

# Dataset Description: https://archive.ics.uci.edu/ml/datasets/Pima+Indians+Diabetes
# World-class results: http://www.is.umk.pl/projects/datasets.html#Diabetes


library(mlbench)
library(DMwR)
library(Hmisc)
library(caret)
library(doMC)

# use multiple cores
registerDoMC(cores=8)

# 1. Load data
data(PimaIndiansDiabetes)
dataset <- PimaIndiansDiabetes
dim(dataset)

# 2. Summarize Data
x <- dataset[,1:8]
y <- dataset[,9]
# summarize distribution
summary(dataset)
# correlations
cor(x)

# 3. Visualize Data
# scatterplot matrix
featurePlot(x=x, y=y, plot="pairs")
# box and whisker plots for each attribute
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="box", scales=scales)
# density plots for each attribute by class value
featurePlot(x=x, y=y, plot="density", scales=scales)

# 4. Data Cleaning (does not improve accuracy)
# Mark missing values
# invalid <- 0
# dataset$pressure[dataset$pressure==invalid] <- NA
# dataset$mass[dataset$mass==invalid] <- NA
# dataset$glucose[dataset$glucose==invalid] <- NA
# # Impute missing values
# dataset$pressure <- with(dataset, impute(pressure, mean))
# dataset$mass <- with(dataset, impute(mass, mean))
# dataset$glucose <- with(dataset, impute(glucose, mean))

# 5. Evaluate Algorithms
# Run algorithms using 10-fold cross validation
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# GLM
set.seed(7)
fit.glm <- train(diabetes~., data=dataset, method="glm", metric="Accuracy", trControl=control)
# LDA
set.seed(7)
fit.lda <- train(diabetes~., data=dataset, method="lda", metric="Accuracy", trControl=control)
# SVM
set.seed(7)
grid <- expand.grid(.sigma=c(0.01,0.05,0.1), .C=c(1))
fit.svm <- train(diabetes~., data=dataset, method="svmRadial", metric="Accuracy", tuneGrid=grid, trControl=control)
# CART
set.seed(7)
grid <- expand.grid(.cp=c(0.01,0.05,0.1))
fit.cart <- train(diabetes~., data=dataset, method="rpart", metric="Accuracy", tuneGrid=grid, trControl=control)
# kNN
set.seed(7)
grid <- expand.grid(.k=c(1,3,5,7))
fit.knn <- train(diabetes~., data=dataset, method="knn", metric="Accuracy", tuneGrid=grid, trControl=control)
# Compare algorithms
results <- resamples(list(SVM=fit.svm, CART=fit.cart, kNN=fit.knn, glm=fit.glm, lda=fit.lda))
summary(results)
dotplot(results)
