# Multivariate Scatterplot Matrix By Class

# load the data
data(iris)
# pair-wise scatterplots colored by class
pairs(Species~., data=iris, col=iris$Species)
