# Datasets from the dataset library

# list the contents of the library
library(help = "datasets")

# list all available datasets in all loaded libraries
data()

# Iris flowers datasets
data(iris)
dim(iris)
levels(iris$Species)
head(iris)

# Longley's Economic Regression Data
data(longley)
dim(longley)
head(longley)