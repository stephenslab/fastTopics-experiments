# TO DO: Try with k = 6 and/or k = 7.
library(fastTopics)
library(cowplot)
load("../data/newsgroups.RData")
load("../output/newsgroups/fits-newsgroups.RData")
plot_progress(fits[dat$k == 10],x = "iter",add.point.every = 100) +
  theme_cowplot(font_size = 10)
fit1 <- poisson2multinom(fits[["fit-newsgroups-em-k=10"]])
fit2 <- poisson2multinom(fits[["fit-newsgroups-scd-ex-k=10"]])
hist(apply(fit2$L,1,max),n = 64)
i <- c(2:7,9:10)
plot(fit1$L[,i],fit2$L[,i],pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
plot(fit1$L[,c(1,8)],fit2$L[,c(8,1)],pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
loadings_plot(fit2,topics,k = 1:4)
loadings_plot(fit2,topics,k = 5:8)
loadings_plot(fit2,topics,k = 9:10)
i <- 8
x <- apply(fit2$F[,-i],1,max) + 1e-6
y <- fit2$F[,i] + 1e-6
plot(x,y,pch = 20,log = "xy")
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
names(which(y/x > 100 & y > 1e-4))
