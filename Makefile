# Ebola_challenge_renewal
## https://github.com/Outbreak-analysis/Ebola_challenge_renewal
## An attempt to rebuild Latent_incidence_fitting (link wanted)

current: target

target pngtarget pdftarget vtarget acrtarget: T2S1.hip.Rout 

##################################################################

# Files to put in github

Sources += $(wildcard *.R)
Sources += $(wildcard *.pl)
Sources += $(wildcard *.bugtmp)

######################################################################

## Making bug files from templates
.PRECIOUS: hybrid%.autobug
hybrid%.autobug: hybrid.bugtmp lagchain.pl
	$(RM) $@
	$(PUSHSTAR)
	$(READONLY)

##################################################################

## Data 

Sources += $(wildcard data/*.csv)

%.scen.Rout: data/%.csv scen.R
	$(run-R)

%.int.Rout: data/%.int.csv interventions.R
	$(run-R)

######################################################################

## Hybrid fitting model (no interventions)

## Making bug files from templates
.PRECIOUS: hybrid%.autobug
hybrid%.autobug: hybrid.bugtmp lagchain.pl
	$(RM) $@
	$(PUSHSTAR)
	$(READONLY)

## Fitting
.PRECIOUS: %.hybrid.Rout
%.hybrid.Rout: hybrid.params.Rout %.scen.Rout hybrid5.autobug hybrid.R
	$(run-R)

T1S1.hybrid.Rout: hybrid.params.Rout T1S1.scen.Rout hybrid5.autobug hybrid.R
	$(run-R)

######################################################################

## Hybrid-intervention fitting model

## Making bug files from templates
.PRECIOUS: hi%.autobug
hi%.autobug: hi.bugtmp lagchain.pl
	$(RM) $@
	$(PUSHSTAR)
	$(READONLY)

## Fitting
.PRECIOUS: %.hi.Rout
%.hi.Rout: hi.params.Rout %.scen.Rout %.int.Rout hybrid5.autobug hi.R
	$(run-R)

##################################################################

### Calculate estimation quantiles for output to NIH

.PRECIOUS: %.est.Rout
%.est.Rout: %.Rout est.R
	$(run-R)

##################################################################

### Look at projections 

## Hybrid
.PRECIOUS: %.project.Rout
%.project.Rout: %.hybrid.est.Rout forecastPlot.Rout project.R
	$(run-R)

## Hybrid-interventions
.PRECIOUS: %.hip.Rout
%.hip.Rout: %.hi.est.Rout forecastPlot.Rout project.R
	$(run-R)

######################################################################

Sources += Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
include $(ms)/perl.def

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
