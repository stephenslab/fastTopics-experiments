library(fastTopics)
library(cowplot)
load("../data/nips.RData")
load("../output/nips/fits-nips.RData")
plot_progress(fits[dat$k == 10],x = "iter",add.point.every = 100) +
  theme_cowplot(font_size = 10)
fit1 <- poisson2multinom(fits[["fit-nips-em-k=10"]])
fit2 <- poisson2multinom(fits[["fit-nips-scd-ex-k=10"]])
hist(apply(fit2$L,1,max),n = 64)
plot(fit1$L,fit2$L,pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
i <- 1
table(cut(fit1$L[,i],seq(0,1,0.05)))
which(fit1$L[,i] > 0.95)
