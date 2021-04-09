# Compare K = 7 topic models fit to trachea droplet data.
load("../output/droplet/fits-droplet.RData")
fit1 <- poisson2multinom(fits[["fit-droplet-em-k=7"]])
fit2 <- poisson2multinom(fits[["fit-droplet-scd-ex-k=7"]])
plot(fit1$L,fit2$L,pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")

# Compare K = 7 topic models fit to 68k PBMC data.
load("../output/pbmc68k/fits-pbmc68k.RData")
fit1 <- poisson2multinom(fits[["fit-pbmc68k-em-k=7"]])
fit2 <- poisson2multinom(fits[["fit-pbmc68k-scd-ex-k=7"]])
plot(fit1$L,fit2$L,pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")

# Compare K = 12 topic models fit to 68k PBMC data.
fit1 <- poisson2multinom(fits[["fit-pbmc68k-em-k=12"]])
fit2 <- poisson2multinom(fits[["fit-pbmc68k-scd-ex-k=12"]])
plot(fit1$L,fit2$L,pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
