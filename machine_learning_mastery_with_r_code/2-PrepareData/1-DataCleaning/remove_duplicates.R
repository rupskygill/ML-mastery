# Remove Duplicate Instances

# load the libraries
library(mlbench)
# load the dataset
data(iris)
dim(iris)
# remove duplicates
clean <- unique(iris)
dim(clean)
