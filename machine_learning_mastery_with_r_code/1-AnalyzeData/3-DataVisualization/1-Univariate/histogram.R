# Univariate Histograms

# load the data
data(iris)
# create histograms for each attribute
par(mfrow=c(1,4))
for(i in 1:4) {
	hist(iris[,i], main=names(iris)[i])
}