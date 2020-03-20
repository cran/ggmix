## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval=FALSE--------------------------------------------------------------
#  install.packages("pacman")
#  pacman::p_load_gh('sahirbhatnagar/ggmix')

## -----------------------------------------------------------------------------
library(ggmix)
data("admixed")
names(admixed)

## -----------------------------------------------------------------------------
# need to install the package if you don't have it
# pacman::p_load_gh('StoreyLab/popkin')
popkin::plot_popkin(admixed$kin_train)

## -----------------------------------------------------------------------------
fit <- ggmix(x = admixed$xtrain, 
             y = admixed$ytrain, 
             kinship = admixed$kin_train)
names(fit)
class(fit)

## -----------------------------------------------------------------------------
plot(fit)

## -----------------------------------------------------------------------------
coef(fit, s = c(0.1,0.02))

## -----------------------------------------------------------------------------
# need to provide x to the predict function
head(predict(fit, s = 0.01, newx = admixed$xtest))

## -----------------------------------------------------------------------------
# pass the fitted object from ggmix to the gic function:
hdbic <- gic(fit)
class(hdbic)

# we can also fit the BIC by specifying the an argument
bicfit <- gic(fit, an = log(length(admixed$ytrain)))

## -----------------------------------------------------------------------------
plot(hdbic)

## -----------------------------------------------------------------------------
hdbic[["lambda.min"]]

## -----------------------------------------------------------------------------
plot(bicfit, ylab = "BIC")
bicfit[["lambda.min"]]

## -----------------------------------------------------------------------------
coef(hdbic)

## -----------------------------------------------------------------------------
coef(hdbic, type = "nonzero")

## -----------------------------------------------------------------------------
predict(hdbic, newx = admixed$xtest)

## -----------------------------------------------------------------------------
plot(hdbic, type = "predicted", newx = admixed$xtrain, newy = admixed$ytrain)

## -----------------------------------------------------------------------------
plot(hdbic, type = "QQranef", newx = admixed$xtrain, newy = admixed$ytrain)
plot(hdbic, type = "QQresid", newx = admixed$xtrain, newy = admixed$ytrain)

## -----------------------------------------------------------------------------
plot(hdbic, type = "Tukey", newx = admixed$xtrain, newy = admixed$ytrain)

