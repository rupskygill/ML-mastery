# Self Organizing Map (Kohonen)

# load the library
library("kohonen")
# load the dataset
data(iris)
# split input and output
x <- data.matrix(iris[,1:4])
y <- iris[,5]
# set the random seed for repetable results
set.seed(7)
# create a map of the x values
iris_map <- som(data=x, grid=somgrid(5, 5, "hexagonal"))
# plot the map
plot(iris_map)

# TODO label the map by class
