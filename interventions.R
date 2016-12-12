max <- 150

startFile <- read.csv(input_files[[1]])

interventions <- data.frame(startWeek=1:max)
weeks <- interventions
for(interv in levels(startFile$type)){
	sub <- subset(startFile, type==interv)
	ts <- with(sub, data.frame(startWeek, new))
	allNew <- merge(weeks, ts, all.x=TRUE)$new
	allNew <- ifelse(is.na(allNew), 0, allNew)
	allNew <- cumsum(allNew)
	interventions[[interv]] <- allNew
}

# rdsave(interventions)
