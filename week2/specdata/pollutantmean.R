setwd("/Users/Jostein/Projects/datasciencecoursera/week2/specdata")

# Returns the weighted mean of the pollutant across all monitors list in
# the 'id' vector (ignoring NA values), without rounding.
#
# 'directory' is a character vector of length 1 indicating the location of the CSV files
#
# 'pollutant' is a character vector of length 1 indicating the name
# of the pollutant for which we will calculate the mean; either "sulfate" or "nitrate"
#
# 'id' is the integer vector indicating the monitor ID numbers to be used.
pollutantmean <- function(directory, pollutant, id = 1:332) {
	fileList <- list.files(path = directory, pattern = ".csv", full.names = TRUE)
	values <- numeric()

	for (i in id) {
		data <- read.csv(fileList[i])
		values <- c(values, data[[pollutant]])
	}
	mean(values, na.rm = TRUE)
}
