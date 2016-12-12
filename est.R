q <- c(0.05, 0.25, 0.5, 0.75, 0.95)

m <- sim$BUGSoutput$sims.matrix

# endWeek is the first week with zero
# lastWeek is the week that meets NIH condition (first of three consecutive weeks with <3 cases)
tstats <- as.data.frame(t(apply(m, 1, function(r){
	obs <- r[grepl("obs", names(r))]
	low <- obs<3
	threelow <- (low
		+ c(low[-1], TRUE)
		+ c(low[c(-1, -2)], TRUE, TRUE)
	)
	return(c(
		finalSize = sum(obs) 
		, peakSize = max(obs)
		, peakWeek = which.max(obs)
		, endWeek = suppressWarnings(min(which(obs==0)))
		, lastWeek = suppressWarnings(min(which(threelow==3)))
	))
})))

names(tstats) <- c(
	"finalSize", "peakSize", "peakWeek", "endWeek", "lastWeek"
)

m <- cbind(m, tstats)

print(summary(m))

allest <- t(apply(m, 2, function(v){quantile(v, probs = q)}))
oc <- grepl("obs", row.names(allest))

est <- allest[oc, ]
parest <- allest[!oc, ]

print(parest)

# rdsave(q, est, parest, obs)
