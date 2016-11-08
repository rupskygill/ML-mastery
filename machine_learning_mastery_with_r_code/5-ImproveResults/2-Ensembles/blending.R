# Blending (linear combination of models)

# load libraries
library(caret)
library(caretEnsemble)
# load the dataset
data(PimaIndiansDiabetes)
# define training control
train_control <- trainControl(method="cv", number=10, savePredictions=TRUE, classProbs=TRUE)
# train a list of models
methodList <- c('glm', 'lda', 'knn')
models <- caretList(diabetes~., data=PimaIndiansDiabetes, trControl=train_control, methodList=methodList)
# create ensemble of trained models
ensemble <- caretEnsemble(models)
# summarize ensemble
summary(ensemble)
