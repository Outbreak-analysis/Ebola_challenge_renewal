# Ebola_challenge_renewal
## https://github.com/Outbreak-analysis/Ebola_challenge_renewal
## An attempt to rebuild Latent_incidence_fitting (link wanted)

current: target

target pngtarget pdftarget vtarget acrtarget: notarget

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

## Data wrangling

######################################################################

Sources += Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
