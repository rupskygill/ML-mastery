# Install a list of packages

# preferred repo
repository <- "http://cran.ms.unimelb.edu.au/"
# list of packages used by project
packages <- c("ggplot2", "caret", "mlbench", "caretEnsemble", "ipred", "rpart",
	"doMC", "AppliedPredictiveModeling", "corrplot", "Hmisc", "DMwR", "lattice",
	"RWeka", "e1071", "C50")

for (p in packages) {
	if(p %in% rownames(installed.packages()) == FALSE) {
		install.packages(p, repos=repository)
	}
}
