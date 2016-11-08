# Binary Classification Algorithms

# Demonstrate minimal usage of the most popular algorithms with caret.

# load libraries
library(mlbench)
library(caret)
library(doMC)
registerDoMC(cores=8)

# load data
data(PimaIndiansDiabetes)
dataset <- PimaIndiansDiabetes
x <- dataset[,1:8]
y <- dataset[,9]

# prepare simple test suite
control <- trainControl(method="cv", number=5)
seed <- 7
metric <- "Accuracy"

# Linear Models


# Linear Discriminant Analysis
set.seed(seed)
fit.lda <- train(diabetes~., data=dataset, method="lda", metric=metric, preProc=c("center", "scale"), preProc=c("center", "scale"), trControl=control)
# Logistic Regression
set.seed(seed)
fit.glm <- train(diabetes~., data=dataset, method="glm", metric=metric, preProc=c("center", "scale"), trControl=control)
# Penalized Logistic Regression
set.seed(seed)
fit.plr <- train(diabetes~., data=dataset, method="plr", metric=metric, preProc=c("center", "scale"), trControl=control)
# Ordered Logistic or Probit Regression
set.seed(seed)
fit.polr <- train(diabetes~., data=dataset, method="polr", metric=metric, preProc=c("center", "scale"), trControl=control)
# Partial Least Squares
set.seed(seed)
fit.pls <- train(diabetes~., data=dataset, method="pls", metric=metric, preProc=c("center", "scale"), trControl=control)
# GLMNET
set.seed(seed)
tunegrid <- expand.grid(.alpha=seq(0,1,by=0.1), .lambda=c(1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6))
fit.glmnet <- train(diabetes~., data=dataset, method="glmnet", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control)
# sparce LDA
set.seed(seed)
fit.sda <- train(diabetes~., data=dataset, method="sparseLDA", metric=metric, preProc=c("center", "scale"), trControl=control)
# Nearest Shrunken Centroids
set.seed(seed)
tunegrid <- expand.grid(.threshold=seq(0,1,by=0.1))
fit.pam <- train(diabetes~., data=dataset, method="pam", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control)



# Non-Linear Models

# MDA
set.seed(seed)
tunegrid <- expand.grid(.subclasses=seq(1:8))
fit.mda <- train(diabetes~., data=dataset, method="mda", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control)
# RDA
set.seed(seed)
tunegrid <- expand.grid(.gamma=c(0, 0.5, 1), .lambda=c(0, 0.5, 1))
fit.rda <- train(diabetes~., data=dataset, method="rda", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control)
# sparce MDA
set.seed(seed)
tunegrid <- expand.grid(.NumVars=c(2), .lambda=c(0, 0.01), .R=c(2))
fit.smda <- train(diabetes~., data=dataset, method="smda", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control)
# Neural net
set.seed(seed)
tunegrid <- expand.grid(.size=seq(1:10), .decay=c(0, .1, 1, 2))
maxSize <- max(tunegrid$.size)
numWeights <- 1*(maxSize * (length(dataset) + 1) + maxSize + 1)
maxit <- 2000
fit.nnet <- train(diabetes~., data=dataset, method="nnet", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale", "spatialSign"), trControl=control, trace=FALSE, maxit=maxit, MaxNWts=numWeights)
# Multi-Layer Perceptron
set.seed(seed)
fit.mlp <- train(diabetes~., data=dataset, method="mlp", metric=metric, preProc=c("center", "scale"), trControl=control)
# Radial Basis Function Network
set.seed(seed)
fit.rbf <- train(diabetes~., data=dataset, method="rbf", metric=metric, preProc=c("center", "scale"), trControl=control)
# FDA
set.seed(seed)
fit.fda <- train(diabetes~., data=dataset, method="fda", metric=metric, preProc=c("center", "scale"), trControl=control)
# Support Vector Machines with Linear Kernel
set.seed(seed)
sigma <- sigest(as.matrix(x))
tunegrid <- expand.grid(.C=2^(seq(-4, 4)))
fit.svmLinear <- train(diabetes~., data=dataset, method="svmLinear", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control)
# Support Vector Machines with Polynomial Kernel
set.seed(seed)
fit.svmPoly <- train(diabetes~., data=dataset, method="svmPoly", metric=metric, preProc=c("center", "scale"), trControl=control, fit=FALSE)
# Support Vector Machines with Radial Basis Function Kernel
set.seed(seed)
fit.svmRadialCost <- train(diabetes~., data=dataset, method="svmRadialCost", metric=metric, preProc=c("center", "scale"), trControl=control, fit=FALSE)
# Support Vector Machines with Radial Basis Function Kernel
set.seed(seed)
sigma <- sigest(as.matrix(x))
tunegrid <- expand.grid(.sigma=sigma, .C=2^(seq(-4, 4)))
fit.svmRadial <- train(diabetes~., data=dataset, method="svmRadial", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control, fit=FALSE)
# kNN
set.seed(seed)
tunegrid <- expand.grid(.k=c(4*(0:5)+1, 20*(1:5)+1, 50*(2:9)+1))
fit.knn <- train(diabetes~., data=dataset, method="knn", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control)
# naive bayes
set.seed(seed)
tunegrid <- expand.grid(.fL=c(0, 1, 2, 3), .usekernel=TRUE)
fit.nb <- train(diabetes~., data=dataset, method="nb", metric=metric, tuneGrid=tunegrid, trControl=control)
# Learning Vector Quantization
set.seed(seed)
fit.lvq <- train(diabetes~., data=dataset, method="lvq", metric=metric, trControl=control)
# Self-Organizing Maps
set.seed(seed)
fit.xyf <- train(diabetes~., data=dataset, method="xyf", metric=metric, trControl=control)



# Trees


# CART
set.seed(seed)
tunegrid <- expand.grid(.cp=seq(0,0.1,by=0.01))
fit.cart <- train(diabetes~., data=dataset, method="rpart", metric=metric, tuneGrid=tunegrid, trControl=control)
# C4.5 (AKA C4.8 or J48)
set.seed(seed)
fit.j48 <- train(diabetes~., data=dataset, method="J48", metric=metric, trControl=control)
# Logistic Model Trees
set.seed(seed)
fit.LMT <- train(diabetes~., data=dataset, method="LMT", metric=metric, trControl=control)



# Rules

# PART Rule-Based Classifier
set.seed(seed)
fit.part <- train(diabetes~., data=dataset, method="PART", metric=metric, trControl=control)
# Rule-Based Classifier
set.seed(seed)
fit.JRIP <- train(diabetes~., data=dataset, method="JRip", metric=metric, trControl=control)



# Boosting Ensemble Algorithms

# AdaBoost.M1
set.seed(seed)
fit.AdaBoost.M1 <- train(diabetes~., data=dataset, method="AdaBoost.M1", metric=metric, trControl=control)
# Bagged AdaBoost
set.seed(seed)
fit.AdaBag <- train(diabetes~., data=dataset, method="AdaBag", metric=metric, trControl=control)
# Boosted Classification Trees
set.seed(seed)
fit.ada <- train(diabetes~., data=dataset, method="ada", metric=metric, trControl=control)
# Boosted Generalized Additive Model
set.seed(seed)
fit.gamboost <- train(diabetes~., data=dataset, method="gamboost", metric=metric, trControl=control)
# Boosted Generalized Linear Model
set.seed(seed)
fit.glmboost <- train(diabetes~., data=dataset, method="glmboost", metric=metric, trControl=control)
# Boosted Linear Model
set.seed(seed)
fit.BstLm <- train(diabetes~., data=dataset, method="BstLm", metric=metric, trControl=control)
# Boosted Logistic Regression
set.seed(seed)
fit.LogitBoost <- train(diabetes~., data=dataset, method="LogitBoost", metric=metric, trControl=control)
# Boosted Smoothing Spline
set.seed(seed)
fit.bstSm <- train(diabetes~., data=dataset, method="bstSm", metric=metric, trControl=control)
# Boosted Tree
set.seed(seed)
fit.blackboost <- train(diabetes~., data=dataset, method="blackboost", metric=metric, trControl=control)
# Boosted Tree
set.seed(seed)
fit.bstTree <- train(diabetes~., data=dataset, method="bstTree", metric=metric, trControl=control)
# C5.0
set.seed(seed)
tunegrid <- expand.grid(.trials=c(5,10,15,20), .model=c("rules", "rules"), .winnow=c(TRUE, FALSE))
fit.c50 <- train(diabetes~., data=dataset, method="C5.0", metric=metric, tuneGrid=tunegrid, trControl=control)
# Cost-Sensitive C5.0
set.seed(seed)
fit.C5.0Cost <- train(diabetes~., data=dataset, method="C5.0Cost", metric=metric, trControl=control)
# eXtreme Gradient Boosting
set.seed(seed)
fit.xgbLinear <- train(diabetes~., data=dataset, method="xgbLinear", metric=metric, trControl=control)
# eXtreme Gradient Boosting
set.seed(seed)
fit.xgbTree <- train(diabetes~., data=dataset, method="xgbTree", metric=metric, trControl=control)
# Stochastic Gradient Boosting
set.seed(seed)
tunegrid <- expand.grid(.n.trees=c(5, 100, 500), .interaction.depth=c(1, 3, 5, 7, 9), .shrinkage=c(0, 1e-1, 1e-2, 1e-3, 1e-4), .n.minobsinnode=c(5, 10))
fit.gbm <- train(diabetes~., data=dataset, method="gbm", metric=metric, tuneGrid=tunegrid, trControl=control, verbose=FALSE)



# Bagged Ensemble Algorithms

# Bagged CART
set.seed(seed)
fit.treebag <- train(diabetes~., data=dataset, method="treebag", metric=metric, trControl=control)
# Bagged Flexible Discriminant Analysis
set.seed(seed)
fit.bagFDA <- train(diabetes~., data=dataset, method="bagFDA", metric=metric, trControl=control)
# Bagged Logic Regression
set.seed(seed)
fit.logicBag <- train(diabetes~., data=dataset, method="logicBag", metric=metric, trControl=control)
# Bagged MARS
set.seed(seed)
fit.bagEarthGCV <- train(diabetes~., data=dataset, method="bagEarthGCV", metric=metric, trControl=control)
# Bagged MARS using gCV Pruning
set.seed(seed)
fit.bagEarth <- train(diabetes~., data=dataset, method="bagEarth", metric=metric, trControl=control)
# Bagged Model
set.seed(seed)
fit.bag <- train(diabetes~., data=dataset, method="bag", metric=metric, trControl=control)
# Conditional Inference Random Forest
set.seed(seed)
fit.cforest <- train(diabetes~., data=dataset, method="cforest", metric=metric, trControl=control)
# Ensembles of Generalized Lienar Models
set.seed(seed)
fit.randomGLM <- train(diabetes~., data=dataset, method="randomGLM", metric=metric, trControl=control)
# Model Averaged Neural Network
set.seed(seed)
fit.avNNet <- train(diabetes~., data=dataset, method="avNNet", metric=metric, trControl=control)
# Parallel Random Forest
set.seed(seed)
fit.parRF <- train(diabetes~., data=dataset, method="parRF", metric=metric, trControl=control)
# Random Ferns
set.seed(seed)
fit.rFerns <- train(diabetes~., data=dataset, method="rFerns", metric=metric, trControl=control)
# Random Forest
set.seed(seed)
fit.ranger <- train(diabetes~., data=dataset, method="ranger", metric=metric, trControl=control)
# Random Forest (classical)
set.seed(seed)
fit.rf <- train(diabetes~., data=dataset, method="rf", metric=metric, trControl=control)
# Random Forest by Randomization
set.seed(seed)
fit.extraTrees <- train(diabetes~., data=dataset, method="extraTrees", metric=metric, trControl=control)
# Random Forest Rule-Based Model
set.seed(seed)
fit.rfRules <- train(diabetes~., data=dataset, method="rfRules", metric=metric, trControl=control)
# Regularized Random Forest
set.seed(seed)
fit.RRF <- train(diabetes~., data=dataset, method="RRF", metric=metric, trControl=control)
# Regularized Random Forest
set.seed(seed)
fit.RRFglobal <- train(diabetes~., data=dataset, method="RRFglobal", metric=metric, trControl=control)
# Weighted Subspace Random Forest
set.seed(seed)
fit.wsrf <- train(diabetes~., data=dataset, method="wsrf", metric=metric, trControl=control)






