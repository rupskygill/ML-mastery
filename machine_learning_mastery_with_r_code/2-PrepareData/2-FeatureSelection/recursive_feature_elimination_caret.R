# Use RFE and to select features

# load the library
library(mlbench)
library(caret)
# load the data
data(Sonar)
# define the control using a random forest selection function
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
# run the RFE algorithm
x <- Sonar[,1:60]
y <- Sonar[,61]
sizes <- c(10,20,30,40,50,60)
results <- rfe(x, y, sizes=sizes, rfeControl=control)
# summarize the results
print(results)
# list the chosen features
predictors(results)
# plot accuracy versus the number of features
plot(results, type=c("g", "o"))
