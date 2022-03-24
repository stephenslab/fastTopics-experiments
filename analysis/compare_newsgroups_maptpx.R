library(maptpx)
library(ggplot2)
library(cowplot)
fit1 <- readRDS("maptpx-newsgroups-em-k=10.rds")
fit2 <- readRDS("maptpx-newsgroups-scd-ex-k=10.rds")
ymax <- max(c(fit1$progress,fit2$progress))
n1   <- length(fit1$progress)
n2   <- length(fit2$progress)
pdat <- rbind(data.frame(init = "em",    iter = 1:n1,y = fit1$progress),
              data.frame(init = "scd-ex",iter = 1:n2,y = fit2$progress))
pdat <- transform(pdat,y = ymax - y + 0.01)
p <- ggplot(pdat,aes(x = iter,y = y,color = init)) +
  geom_line(size = 0.75) +
  xlim(c(0,1500)) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values = c("darkblue","darkorange")) +
  labs(x = "iteration",y = "distance from best log-posterior") +
  theme_cowplot(font_size = 10)
print(p)

