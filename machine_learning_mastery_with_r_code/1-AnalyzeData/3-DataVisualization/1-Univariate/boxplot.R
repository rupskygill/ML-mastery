# Univarate Box And Whisker Plots

# load dataset
data(iris)
# Create separate boxplots for each attribute
par(mfrow=c(1,4))
for(i in 1:4) {
	boxplot(iris[,i], main=names(iris)[i])
}
