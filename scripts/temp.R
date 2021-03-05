library(fastTopics)
library(cowplot)
load("../output/nips/fits-nips.RData")
i <- which(dat$k == 12)
plot_progress(fits[i],x = "iter",add.point.every = 100) +
  theme_cowplot(font_size = 10)
fit1 <- poisson2multinom(fits[["fit-nips-em-k=12"]])
fit2 <- poisson2multinom(fits[["fit-nips-scd-ex-k=12"]])
plot(fit1$L,fit2$L,pch = 20)
