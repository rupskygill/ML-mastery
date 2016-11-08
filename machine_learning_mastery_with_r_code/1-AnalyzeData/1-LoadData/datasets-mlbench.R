# Datasets from the mlbench library

# load the library
library(mlbench)

# list the contents of the library
library(help = "mlbench")

# Boston Housing dataset
data(BostonHousing)
dim(BostonHousing)
head(BostonHousing)

# Wisconsin Breast Cancer dataset
data(BreastCancer)
dim(BreastCancer)
levels(BreastCancer$Class)
head(BreastCancer)

# Glass Identification dataset
data(Glass)
dim(Glass)
levels(Glass$Type)
head(Glass)

# Johns Hopkins University Ionosphere dataset
data(Ionosphere)
dim(Ionosphere)
levels(Ionosphere$Class)
head(Ionosphere)

# Pima Indians Diabetes dataset
data(PimaIndiansDiabetes)
dim(PimaIndiansDiabetes)
levels(PimaIndiansDiabetes$diabetes)
head(PimaIndiansDiabetes)

# Sonar, Mines vs. Rocks dataset
data(Sonar)
dim(Sonar)
levels(Sonar$Class)
head(Sonar)

# Soybean dataset
data(Soybean)
dim(Soybean)
levels(Soybean$Class)
head(Soybean)