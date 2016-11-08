# Sammons Mapping

# load library
library(MASS)
# load dataset
data(iris)
# remove duplicates
clean <- unique(iris)
# split out numerical inputs
x <- data.matrix(clean[, 1:4])
# create a sammon mapping
mapping <- sammon(dist(x))
# plot mapping by class
plot(mapping$points, type="n")
text(mapping$points, labels=clean[,5])

# TODO colour dots by class