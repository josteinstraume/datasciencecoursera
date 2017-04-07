best <- function(state, outcome) {

	data <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors = FALSE)

	df <- data[,c(2, 7, 11, 17, 23)]

	outcomes <- c("heart attack"=3, "heart failure"=4, "pneumonia"=5)
	names(df) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")

	if (!state %in% df[,"state"]) {
		stop('invalid state')
	}

	else if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
		stop('invalid outcome')
	}

	df <- na.omit(df)
	df <- df[df$state == state, c(1, outcomes[outcome])]
	names(df) <- c("hospital", "deaths")
	df <- df[order(df$deaths),]
	return(df[1,]$hospital)
}
