rankall <- function(outcome, num = "best") {
	data <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors = FALSE)
	data <- data[,c(2, 7, 11, 17, 23)]

	names(data) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")

	outcomes <- c("heart attack"=3, "heart failure"=4, "pneumonia"=5)

	if (!outcome %in% names(data)) {
		stop('invalid outcome')
	}
	if (num != "best" & num != "worst" & !is.numeric(num)) {
		stop('invalid rank')
	}

	df <- data[, c(1, 2, outcomes[outcome])]

	#un commented this
	df <- na.omit(df)

	names(df) <- c("hospital", "state", "deaths")
	#dfOrder <- df[order(df$state, df$deaths),]
	#dfOrder <- df[order(df$state, df$deaths, df$hospital),]
	dfSplit <- split(df, df$state)

	#dfSplit <- dfSplit[order(dfSplit$deaths, dfSplit$hospital)]

	if (num == "best") {
		num <- 1
	} else if (num == "worst") {
		num <- as.numeric(nrow(df))
	}

	results <- lapply(dfSplit, function(dfSplit) dfSplit[num,])
	resultsUnlist <- unlist(results)
	return(data.frame(hospital=resultsUnlist, state=names(results), row.names=names(resultsUnlist)))
}



