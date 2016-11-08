# Sonar

# Binary classification, numeric inputs

# Dataset: https://archive.ics.uci.edu/ml/datasets/Connectionist+Bench+(Sonar,+Mines+vs.+Rocks)
# World-class results: http://www.is.umk.pl/projects/datasets.html#Sonar

library(mlbench)
library(caret)
library(doMC)
library(caretEnsemble)

# use multiple cores
registerDoMC(cores=8)

# 1. Load the dataset
data(Sonar)
dataset <- Sonar

# 2. Summarize data
# dimensions of dataaset
dim(dataset)
# split input and output
x <- dataset[,1:60]
y <- dataset[,61]
# class distribution
cbind(freq=table(y), percentage=prop.table(table(y))*100)
# summarize attribute distributions
summary(dataset)
# summarize correlations between input variables
cor(x)

# 3. Visualize Data
# box and whisker plots for each attribute
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="box", scales=scales)
# density plots for each attribute by class value
featurePlot(x=x, y=y, plot="density", scales=scales)

# 4 Data Transforms
dataset[,1:60] <- scale(dataset[,1:60])

# 5. Evaluate Algorithms
# Run algorithms using 10-fold cross validation
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# GLM
set.seed(7)
fit.glm <- train(Class~., data=dataset, method="glm", metric="Accuracy", trControl=control)
# LDA
set.seed(7)
fit.lda <- train(Class~., data=dataset, method="lda", metric="Accuracy", trControl=control)
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
# Compare algorithms
results <- resamples(list(SVM=fit.svm, CART=fit.cart, kNN=fit.knn, glm=fit.glm, lda=fit.lda))
summary(results)
dotplot(results)


# TODO how to estimate skill of ensemble using Accuracy rather than AUC?

# 6. Improve Results
# ensemble
control <- trainControl(method="repeatedcv", number=10, repeats=3, savePredictions=TRUE, classProbs=TRUE)
models <- caretList(Class~., data=dataset, trControl=control, metric='Accuracy', methodList=c('glm', 'lda'),
  tuneList=list(
    svmRadial=caretModelSpec(method='svmRadial', tuneGrid=expand.grid(.sigma=c(0.05), .C=c(1))),
    rpart=caretModelSpec(method='rpart', tuneGrid=expand.grid(.cp=c(0.1))),
    knn=caretModelSpec(method='knn', tuneGrid=expand.grid(.k=c(1)))
  )
)
ensemble <- caretEnsemble(models)
summary(ensemble)
