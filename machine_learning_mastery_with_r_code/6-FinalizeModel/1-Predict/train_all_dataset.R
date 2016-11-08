# Train a model on the entire training dataset

# load libraries
library(caret)
library(mlbench)
# load dataset
data(PimaIndiansDiabetes)
set.seed(9)
control <- trainControl(method="none", number=10)
fit.lda <- train(diabetes~., data=training, method="lda", metric="Accuracy", trControl=control)
print(fit.lda)
print(fit.lda$finalModel)

