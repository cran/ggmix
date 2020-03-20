## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(ggmix)
data("admixed")

# the default penalty factor
p.fac <- rep(1, ncol(admixed$xtrain))

# set 1 of the causal SNPs to not be penalized at all
p.fac[match(sample(admixed$causal, 1),colnames(admixed$xtrain))] <- 0

# supply p.fac to the penalty.factor argument
res <- ggmix(x = admixed$xtrain, y = admixed$ytrain, kinship = admixed$kin_train,
             penalty.factor = p.fac)
plot(res)

