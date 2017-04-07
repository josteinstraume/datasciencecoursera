# Returns a numeric vector of correlations, without rounding
corr <- function(directory, threshold = 0) {
	# 'directory' is a character vector of length 1
	# indicating the location of the CSV files

	# 'threshold' is a numeric vector of length 1 indicating
	# the number of completely observed observations
	# (on all variables) required to compute the correlation
	# between nitrate and sulfate; the default is 0.

	filelist <- list.files(path = directory, patter = '.csv', full.names = TRUE)

	completeData <- complete(directory, 1:332)
	completeDataThresh <- subset(completeData, nobs > threshold)

	corrs <- vector()

	for (i in completeDataThresh[[id]]) {
		data <- read.csv()
	}
}
