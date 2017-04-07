rankhospital <- function(state, outcome, num = "best") {
	data <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors = FALSE)
	data <- data[,c(2, 7, 11, 17, 23)]
	names(data) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")

	outcomes <- c("heart attack"=3, "heart failure"=4, "pneumonia"=5)

	if (!state %in% data$state) {
		stop('invalid state')
	}
	if (!outcome %in% names(data)) {
		stop('invalid outcome')
	}
	if (num != "best" & num != "worst" & !is.numeric(num)) {
		stop('invalid rank')
	}

	df <- data[data$state == state, c(1, outcomes[outcome])]
	names(df) <- c("name", "deaths")
	df <- na.omit(df)

	nums <- c("best" = 1, "worst" = nrow(df))

	if (num == "best") {
		num <- 1
	}
	else if (num == "worst") {
		num <- as.numeric(nrow(df))
	}
	else if (num > nrow(df)) {
		return(NA)
	}

	return(df[order(df$deaths, df$name), 1][num])
}
