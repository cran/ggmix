## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(ggmix)
data("admixed")

# supply p.fac to the penalty.factor argument
res <- ggmix(x = admixed$xtrain, y = admixed$ytrain, kinship = admixed$kin_train)
plot(res)
coef(res, s = 0.059, type = "nonzero")

## -----------------------------------------------------------------------------
eigKinship <- eigen(admixed$kin_train)

resUD <- ggmix(x = admixed$xtrain, y = admixed$ytrain, 
               U = eigKinship$vectors[,which(eigKinship$values>0)],
               D = eigKinship$values[which(eigKinship$values>0)])
plot(resUD)
coef(resUD, s = 0.059, type = "nonzero")

## -----------------------------------------------------------------------------
svdXkinship <- svd(admixed$Xkinship)
resUDsvd <- ggmix(x = admixed$xtrain, y = admixed$ytrain, U = svdXkinship$u,
                  D = svdXkinship$d ^ 2)
plot(resUDsvd)
coef(resUDsvd, s = 0.059, type = "nonzero")

## -----------------------------------------------------------------------------
resK <- ggmix(x = admixed$xtrain, y = admixed$ytrain, K = admixed$kin_train)
plot(resK)
coef(resK, s = 0.059, type = "nonzero")

