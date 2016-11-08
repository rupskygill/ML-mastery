# Principal Component Analysis

# load the dataset
data(iris)
# separate numerical inputs
x <- data.matrix(iris[,1:4])
y <- iris[,5]
# calculate components
components <- prcomp(x, center=TRUE, scale=TRUE)
# display components
print(components)
# summarize components
summary(ir.pca)
# plot the components
biplot(components)
