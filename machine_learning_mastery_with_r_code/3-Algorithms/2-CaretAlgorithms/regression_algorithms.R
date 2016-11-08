# Regression Algorithms

# Demonstrate minimal usage of the most popular algorithms with caret.

# load libraries
library(caret)
library(doMC)
registerDoMC(cores=4)

# load data
data(longley)
dataset <- longley
x <- dataset[,1:6]
y <- dataset[,7]

# prepare simple test suite
control <- trainControl(method="cv", number=5)
seed <- 7
metric <- "RMSE"

# Linear Regresson Models

# Linear regression
set.seed(seed)
fit.lm <- train(Employed~., data=dataset, method="lm", metric=metric, preProc=c("center", "scale"), trControl=control)
# Robust Linear Model
set.seed(seed)
fit.rlm <- train(Employed~., data=dataset, method="rlm", metric=metric, preProc=c("center", "scale"), trControl=control)
# Partial Least Squares
set.seed(seed)
fit.pls <- train(Employed~., data=dataset, method="pls", metric=metric, preProc=c("center", "scale"), trControl=control)
# Elasticnet
set.seed(seed)
fit.enet <- train(Employed~., data=dataset, method="enet", metric=metric, preProc=c("center", "scale"), trControl=control)
# glmnet
set.seed(seed)
fit.glmnet <- train(Employed~., data=dataset, method="glmnet", metric=metric, preProc=c("center", "scale"), trControl=control)
# Least Angle Regression
set.seed(seed)
fit.lars <- train(Employed~., data=dataset, method="lars", metric=metric, preProc=c("center", "scale"), trControl=control)


# Nonlinear Regresson Models

# Neural Network
set.seed(seed)
fit.nnet <- train(Employed~., data=dataset, method="nnet", metric=metric, preProc=c("center", "scale"), trControl=control, trace=FALSE)
# Model Averaged Neural Network
set.seed(seed)
fit.avNNet <- train(Employed~., data=dataset, method="avNNet", metric=metric, preProc=c("center", "scale"), trControl=control, trace=FALSE)
# Multivariate Adaptive Regression Spline
set.seed(seed)
tunegrid <- expand.grid(.degree=1:2, .nprune=2:38)
fit.earth <- train(Employed~., data=dataset, method="earth", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control)
# Support Vector Machines with Radial Basis Function Kernel
set.seed(seed)
fit.svmRadial <- train(Employed~., data=dataset, method="svmRadial", metric=metric, preProc=c("center", "scale"), trControl=control)
# k-Nearest Neighbors
set.seed(seed)
tunegrid <- expand.grid(.k=1:20)
fit.knn <- train(Employed~., data=dataset, method="knn", metric=metric, tuneGrid=tunegrid, preProc=c("center", "scale"), trControl=control)


# Regression Trees

# CART
set.seed(seed)
fit.rpart <- train(Employed~., data=dataset, method="rpart", metric=metric, trControl=control)
# Conditional Inference Tree
set.seed(seed)
fit.ctree <- train(Employed~., data=dataset, method="ctree", metric=metric, trControl=control)
# Model Tree
set.seed(seed)
fit.M5 <- train(Employed~., data=dataset, method="M5", metric=metric, trControl=control)
# Model Rules
set.seed(seed)
fit.M5Rules <- train(Employed~., data=dataset, method="M5Rules", metric=metric, trControl=control)


# Ensembles

# Bagged CART
set.seed(seed)
fit.treebag <- train(Employed~., data=dataset, method="treebag", metric=metric, trControl=control)
# Random Forest
set.seed(seed)
fit.rf <- train(Employed~., data=dataset, method="rf", metric=metric, trControl=control)
# Stochastic Gradient Boosting
set.seed(seed)
tunegrid <- expand.grid(.interaction.depth=seq(1,7,by=2), .n.trees=seq(100,1000,by=60), .shrinkage=c(0.01, 0.1), .n.minobsinnode=c(1,3,5,7,9))
fit.gbm <- train(Employed~., data=dataset, method="gbm", metric=metric, tuneGrid=tunegrid, trControl=control, verbose=FALSE)
# Cubist
set.seed(seed)
fit.cubist <- train(Employed~., data=dataset, method="cubist", metric=metric, trControl=control)

# Quantile Random Forest
set.seed(seed)
fit.qrf <- train(diabetes~., data=dataset, method="qrf", metric=metric, trControl=control)
# Quantile Regression Neural Network
set.seed(seed)
fit.qrnn <- train(diabetes~., data=dataset, method="qrnn", metric=metric, trControl=control)




