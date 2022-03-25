library(tm)
library(topicmodels)
library(ggplot2)
library(cowplot)
fit1 <- readRDS("lda-eb-newsgroups-em-k=10.rds")
fit2 <- readRDS("lda-eb-newsgroups-scd-ex-k=10.rds")
ymax <- max(c(fit1@logLiks,fit2@logLiks))
n1   <- length(fit1@logLiks)
n2   <- length(fit2@logLiks)
pdat <- rbind(data.frame(init = "em",    iter = 1:n1,y = fit1@logLiks),
              data.frame(init = "scd-ex",iter = 1:n2,y = fit2@logLiks))
pdat <- transform(pdat,y = ymax - y + 0.01)
p <- ggplot(pdat,aes(x = iter,y = y,color = init)) +
  geom_line(size = 0.75) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values = c("darkblue","darkorange")) +
  labs(x = "iteration",y = "distance from best log-posterior") +
  theme_cowplot(font_size = 10)
print(p)
print(fit1@alpha)
print(fit2@alpha)
print(diag(cor(fit1@gamma,fit2@gamma)),digits = 2)
k <- 1
plot(fit1@gamma[,k],fit2@gamma[,k],pch = 20)
abline(a = 0,b = 1,lty = "dotted",col = "skyblue")
