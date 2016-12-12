# Ebola_challenge_renewal
## https://github.com/Outbreak-analysis/Ebola_challenge_renewal
## An attempt to rebuild Latent_incidence_fitting (link wanted)

current: target

target pngtarget pdftarget vtarget acrtarget: T2S1.hi.Rout 

##################################################################

### Crib (temporary)

%: Latent_incidence_fitting/%
	$(copy)

######################################################################

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

.PRECIOUS: %.hybrid.Rout
%.hybrid.Rout: hybrid.params.Rout %.scen.Rout hybrid5.autobug hybrid.R
	$(run-R)

T1S1.hybrid.Rout: hybrid.params.Rout T1S1.scen.Rout hybrid5.autobug hybrid.R
	$(run-R)

T2S1.hybrid.Rout: hybrid.R

######################################################################

## Hybrid-intervention fitting model

## Making bug files from templates
.PRECIOUS: hi%.autobug
hi%.autobug: hi.bugtmp lagchain.pl
	$(RM) $@
	$(PUSHSTAR)
	$(READONLY)

.PRECIOUS: %.hi.Rout
%.hi.Rout: hi.params.Rout %.scen.Rout %.int.Rout hybrid5.autobug hi.R
	$(run-R)

T2S1.hi.Rout: hi.params.Rout T2S1.scen.Rout T2S1.int.Rout hybrid5.autobug hi.R
	$(run-R)

######################################################################

Sources += Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
include $(ms)/perl.def

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
