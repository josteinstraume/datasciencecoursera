# Returns a data frame in the following form:
# id    nobs
# 1    117
# 2    1041

# where 'id' is the monitor ID number and
# 'nobs' is the number of complete cases
complete <- function(directory, id = 1:332) {
	# 'directory' is a character vector of length 1
	# indicating the location of the CSV files

	# 'id' is an integer vector indicating the monitor
	# ID numbers to be used

	# Creates list of files to loop through
	filelist <- list.files(path = directory, patter = '.csv', full.names = TRUE)

	nobs <- numeric()

	for (i in id) {
		data <- read.csv(filelist[i])
		nobs <- c(nobs, sum(complete.cases(data)))
	}

	nobsDF <- data.frame(id, nobs)
	nobsDF
}
