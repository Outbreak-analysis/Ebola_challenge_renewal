require("R2jags")

set.seed(seed)

if(forecast>0) obs <- c(obs, rep(NA, forecast))

# Parse the lag out of the model file name (clunky)
lag <- as.numeric(gsub("[A-Za-z_.]*", "", input_files[1]))

data <- list (
	obs = obs
	, max = length(obs)
	, lag = lag
	, lagvec = 1:lag
	, pop = pop
	, foieps = foieps
	, kappa = kappa
	, effRepHa = effRepHShape/(1-effRepHmean)
	, effRepHb = effRepHShape/effRepHmean
	, preExp = preMean/(lag+preMean)
	, hetShape = hetShape
	, hetMean = hetMean
	, shapeH = shapeH
	, Rshape = Rshape
	, Rmean = Rmean
	, gpShape = gpShape
	, gpMean = gpMean
	, gsShape = gsShape
	, gsMean = gsMean
   # , Burial = Burial
   # , ETU = ETU
	# , Tracing = Tracing
)

inits <- lapply (mult, function(m){
	pre <- 1+obs[[1]]
	return(list(
		genPos = gpMean
		, effRep = maxRep/m
		, preInc = c(
			rep(pre, lag)
			, 1+obs
		)
	))
})

print(inits)

sim <- jags(model.file=input_files[[1]],
	data=data, inits=inits, 
	parameters = c("ker", "R0", "gen"
		, "repMean"
		, "effRep", "RRprop", "alpha"
		, "obs"
		, "inc", "preInc", "foi"
	),
	n.chains = length(mult), n.iter = iterations
)

print(sim)
plot(sim)
traceplot(sim)

proc.time()
