# For paper, highlight results with K = 11.
library(fastTopics)
library(cowplot)
set.seed(1)
k <- 11
load("../data/pbmc_68k.RData")
rm(counts)
fit1 <- readRDS("../output/pbmc68k/rds/fit-pbmc68k-em-k=11.rds")$fit
fit2 <- readRDS("../output/pbmc68k/rds/fit-pbmc68k-scd-ex-k=11.rds")$fit
lda1 <- readRDS("../output/pbmc68k/rds/lda-pbmc68k-em-k=11.rds")$lda
lda2 <- readRDS("../output/pbmc68k/rds/lda-pbmc68k-scd-ex-k=11.rds")$lda
fit1 <- poisson2multinom(fit1)
fit2 <- poisson2multinom(fit2)
diag(cor(fit1$L,lda1@gamma))
diag(cor(fit2$L,lda2@gamma))
n    <- nrow(fit1$L)
rows <- sample(n,2000)
fit1 <- select_loadings(fit1,rows)
fit2 <- select_loadings(fit2,rows)

# Try to cluster the cells.
L <- lda2@gamma
n <- nrow(L)
clusters <- rep("T cells",n)
names(clusters) <- rownames(fit1$L)
clusters[L[,4] > 0.3]  <- "NK cells"
clusters[L[,8] > 0.4]  <- "B cells"
clusters[L[,10] > 0.1] <- "dendritic"
clusters[L[,11] > 0.25] <- "myeloid"
clusters <- factor(clusters)

set.seed(1)
k <- 11
p1 <- structure_plot(lda1@gamma[rows,],topics = 1:k,
                     grouping = clusters[rows],gap = 10)
p2 <- structure_plot(lda2@gamma[rows,],topics = 1:k,
                     grouping = clusters[rows],gap = 10)
plot_grid(p1,p2,nrow = 2,ncol = 1)

# NK cells.
k <- 4
dat <- data.frame(gene = genes$symbol,
                  f0 = exp(apply(lda2@beta[-k,],2,max)),
                  f1 = exp(lda1@beta[k,]),
                  f2 = exp(lda2@beta[k,]))
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 2.5 & f2 > 0.001)

# B cells.
k <- 8
dat <- data.frame(gene = genes$symbol,
                  f0 = exp(apply(lda2@beta[-k,],2,max)),
                  f1 = exp(lda1@beta[k,]),
                  f2 = exp(lda2@beta[k,]))
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 2 & f2 > 0.0005)

# dendritic cells.
k <- 10
dat <- data.frame(gene = genes$symbol,
                  f0 = exp(apply(lda2@beta[-k,],2,max)),
                  f1 = exp(lda1@beta[k,]),
                  f2 = exp(lda2@beta[k,]))
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 2 & f2 > 0.001)

# myeloid cells.
k <- 11
dat <- data.frame(gene = genes$symbol,
                  f0 = exp(apply(lda2@beta[-k,],2,max)),
                  f1 = exp(lda1@beta[k,]),
                  f2 = exp(lda2@beta[k,]))
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 2.5 & f2 > 0.001)

