# For paper, highlight results with K = 10.
library(Matrix)
library(fastTopics)
library(ggplot2)
library(cowplot)
set.seed(1)
load("../data/newsgroups.RData")
topics <- factor(topics,
                 c("rec.sport.hockey",
                   "rec.sport.baseball",
                   "sci.med",
                   "comp.graphics",
                   "comp.windows.x",
                   "comp.os.ms-windows.misc",
                   "comp.sys.ibm.pc.hardware",
                   "comp.sys.mac.hardware",
                   "misc.forsale",
                   "sci.electronics",
                   "sci.space",
                   "alt.atheism",
                   "soc.religion.christian",
                   "talk.religion.misc",
                   "rec.autos",
                   "rec.motorcycles",
                   "sci.crypt",
                   "talk.politics.misc",
                   "talk.politics.guns",
                   "talk.politics.mideast"))
topic_ordering <- c(2,3,4,5,6,7,8,9,10,1)
topic_colors <- c("#a6cee3","#1f78b4","#b2df8a","#33a02c","#fb9a99",
                  "#e31a1c","#fdbf6f","#ff7f00","#cab2d6","#6a3d9a")
fit1 <- readRDS("../output/newsgroups/rds/fit-newsgroups-em-k=10.rds")$fit
fit2 <- readRDS("../output/newsgroups/rds/fit-newsgroups-scd-ex-k=10.rds")$fit
lda1 <- readRDS("../output/newsgroups/rds/lda-newsgroups-em-k=10.rds")$lda
lda2 <- readRDS("../output/newsgroups/rds/lda-newsgroups-scd-ex-k=10.rds")$lda
fit1 <- poisson2multinom(fit1)
fit2 <- poisson2multinom(fit2)
cor(as.vector(fit1$L),as.vector(lda1@gamma))
# 0.98
cor(as.vector(fit2$L),as.vector(lda2@gamma))
# 0.9791
n    <- nrow(fit1$L)
rows <- sample(n,2000)
fit1 <- select_loadings(fit1,rows)
fit2 <- select_loadings(fit2,rows)
L1 <- lda1@gamma[rows,]
L2 <- lda2@gamma[rows,]

p1 <- structure_plot(L1,topics = 1:10,grouping = topics[rows],
                     colors = topic_colors,gap = 20) +
  scale_x_continuous(breaks = NULL) +
  ggtitle("EM without extrapolation") +
  theme(plot.title = element_text(face = "plain",size = 10))
p2 <- structure_plot(L2,topics = 1:10,grouping = topics[rows],
                     colors = topic_colors,gap = 20) +
  ggtitle("CD with extrapolation") +
  theme(plot.title = element_text(face = "plain",size = 10))
print(plot_grid(p1,p2,nrow = 2,ncol = 1,rel_heights = c(1,2)))

k <- 1
dat <- data.frame(word = colnames(counts),
                    x  = exp(apply(lda2@beta[-k,],2,max)),
                    y1 = exp(lda1@beta[k,]),
                    y2 = exp(lda2@beta[k,]))
subset(transform(dat,r = y2/y1),
       x > 1e-6 & y2/x > 5)

k <- 9
dat <- data.frame(word = colnames(counts),
                    x  = exp(apply(lda2@beta[-k,],2,max)),
                    y1 = exp(lda1@beta[k,]),
                    y2 = exp(lda2@beta[k,]))
subset(transform(dat,r = y2/y1),
       x < 1e-5 & y2 > 1e-3)

k <- 5
dat <- data.frame(word = colnames(counts),
                    x  = exp(apply(lda2@beta[-k,],2,max)),
                    y1 = exp(lda1@beta[k,]),
                    y2 = exp(lda2@beta[k,]))
subset(transform(dat,r = y2/y1),
       x < 1e-4 & y2 > 2e-4 & r > 10)

k <- 8
dat <- data.frame(word = colnames(counts),
                    x  = exp(apply(lda2@beta[-k,],2,max)),
                    y1 = exp(lda1@beta[k,]),
                    y2 = exp(lda2@beta[k,]))
subset(dat,x < 1e-5 & y2 > 5e-4)
