# Remove rows with NA

# load library
library(mlbench)
# load dataset
data(BreastCancer)
# summarize dimensions of dataset
dim(BreastCancer)
# Remove all incomplete rows
dataset <- BreastCancer[complete.cases(BreastCancer),]
# summarize dimensions of resulting dataset
dim(dataset)