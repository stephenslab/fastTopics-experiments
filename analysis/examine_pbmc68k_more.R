# For paper, highlight results with K = 7.
library(fastTopics)
library(cowplot)
set.seed(1)
k <- 7
load("../data/pbmc_68k.RData")
rm(counts)
fit1 <- readRDS("../output/pbmc68k/rds/fit-pbmc68k-em-k=7.rds")$fit
fit2 <- readRDS("../output/pbmc68k/rds/fit-pbmc68k-scd-ex-k=7.rds")$fit
lda1 <- readRDS("../output/pbmc68k/rds/lda-pbmc68k-em-k=7.rds")$lda
lda2 <- readRDS("../output/pbmc68k/rds/lda-pbmc68k-scd-ex-k=7.rds")$lda
fit1 <- poisson2multinom(fit1)
fit2 <- poisson2multinom(fit2)
k <- 6
plot(lda1@gamma[,k],lda2@gamma[,k],pch = 20)
diag(cor(fit1$L,lda1@gamma))
diag(cor(fit2$L,lda2@gamma))
diag(cor(lda1@gamma,lda2@gamma))
diag(cor(fit1$F,fit2$F))

n    <- nrow(fit1$L)
rows <- sample(n,2000)
fit1 <- select_loadings(fit1,rows)
fit2 <- select_loadings(fit2,rows)

# Try to cluster the cells.
## L <- lda2@gamma
## n <- nrow(L)
## clusters <- rep("T cells + other",n)
## names(clusters) <- rownames(fit1$L)
## clusters[L[,4] > 0.3]  <- "NK cells"
## clusters[L[,8] > 0.4]  <- "B cells"
## clusters[L[,10] > 0.1] <- "dendritic"
## clusters[L[,11] > 0.25] <- "myeloid"
## clusters <- factor(clusters)

set.seed(1)
k <- 7
p1 <- structure_plot(fit1,topics = 1:k,gap = 10)
p2 <- structure_plot(fit2,topics = 1:k,gap = 10)
plot_grid(p1,p2,nrow = 2,ncol = 1)

stop()

k <- 6
dat <- data.frame(gene = genes$symbol,
                  f0 = apply(fit2$L[,-k],2,max),
                  f1 = fit1$L[,k],
                  f2 = fit2$L[,k])
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 0.5 & f2 > 0.001)
