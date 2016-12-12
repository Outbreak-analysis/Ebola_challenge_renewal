forecastPlot <- function(est, obs, finTime, topQuant){
	t <- 1:finTime
	est <- est[1:finTime, ]
	obs <- obs[1:finTime]
	ymax <- max(est[, topQuant])

	plot(t, est[, qm]
		, main=scenario
		, type="l"
		, xlab="Week", ylab="Cases"
		, ylim = c(0, ymax)
	)

	points(t, obs)
	for(i in 1:length(q)){
		lines(t, est[, i]
			, lty = 1 + abs(i-qm)
		)
	}
}
