# Ebola_challenge_renewal
## https://github.com/Outbreak-analysis/Ebola_challenge_renewal
## An attempt to rebuild Latent_incidence_fitting (link wanted)

current: target

target pngtarget pdftarget vtarget acrtarget: notarget

##################################################################

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

Sources += Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

-include $(ms)/git.mk
-include $(ms)/visual.mk

# -include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
