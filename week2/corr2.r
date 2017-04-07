corr2 <- function(directory, threshold = 0) {
	corr <- numeric(0)

	for (i in 1:332) {
		data <- na.omit(read.csv(paste(directory, '/', sprintf("%03d", i), ".csv", sep="")))

		if (nrow(data) >= threshold) {
			cr <- cor(data["sulfate"], data["nitrate"])

			if (!is.na(cr)) {
				corr <- append(corr, cr)
			}
		}
	}

	corr
}
