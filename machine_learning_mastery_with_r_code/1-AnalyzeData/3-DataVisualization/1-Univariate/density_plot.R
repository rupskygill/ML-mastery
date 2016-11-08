# Univariate Density Plots

# load libraries
library(lattice)
# load dataset
data(iris)
# create a panel of simpler density plots by attribute
par(mfrow=c(1,4))
for(i in 1:4) {
	plot(density(iris[,i]), main=names(iris)[i])
}

