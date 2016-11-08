# Parallel Coordinates

# load library
library(MASS)
# load dataset
data(iris)
# convert data frame to matrix
iris_matrix <- data.matrix(iris)
parcoord(iris_matrix)
