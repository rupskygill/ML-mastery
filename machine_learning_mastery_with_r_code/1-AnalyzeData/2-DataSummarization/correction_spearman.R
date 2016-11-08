# Pair-wise correlations using pearson spearman coefficients

# load the libraries
library(mlbench)
# load the dataset
data(PimaIndiansDiabetes)
# calculate a correlation matrix for numeric variables
correlations <- cor(PimaIndiansDiabetes[,1:8], method="spearman")
# display the correlation matrix
print(correlations)

