rankall2 <- function(outcome, num = "best") {
      ## Read outcome data
      x <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

      ## Check that state and outcome are valid
      colNum <- c('heart attack'=11, 'heart failure'=17, 'pneumonia'=23)[outcome]
      if (is.na(colNum)) {
	stop('invalid outcome')
      }
      x[, colNum] <- suppressWarnings(as.numeric(x[, colNum]))
      nameCol <- 2

      ## For each state, find the hospital of the given rank
      hospitalList <- lapply (split(x, x$State), function(x){
			    unordered <- x[!is.na(x[colNum]),] # unordered can have no rows
			    ordered <- unordered[order(unordered[colNum],unordered[nameCol]),]

			    position <- c('best'=1, 'worst'= nrow(unordered))[num]
			    if (is.na(position)) {position <- num}

			    ordered[position, nameCol]
			  }
      )

      ## Return a data frame with the hospital names and the
      ## (abbreviated) state name
      data.frame(hospital=unlist(hospitalList), state=names(hospitalList))
}
