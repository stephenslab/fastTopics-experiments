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
diag(cor(fit1$L,lda1@gamma))
diag(cor(fit2$L,lda2@gamma))
diag(cor(fit1$F,fit2$F))

# Try to cluster the cells.
L <- fit2$L
n <- nrow(L)
clusters <- rep("T cells",n)
names(clusters) <- rownames(fit2$L)
clusters[L[,3] > 0.4]  <- "NK cells"
clusters[L[,1] > 0.3]  <- "myeloid"
clusters[L[,5] > 0.2]  <- "B cells"
clusters[L[,2] > 0.9]  <- "Megakaryocytes"
clusters <- factor(clusters,
                   c("Megakaryocytes","myeloid","B cells",
                     "NK cells","T cells"))

n    <- nrow(fit1$L)
rows <- sample(n,2000)
fit1 <- select_loadings(fit1,rows)
fit2 <- select_loadings(fit2,rows)
    
k <- 7
topic_colors <- c("#a6cee3","#1f78b4","#b2df8a","#33a02c","#fb9a99",
                  "#e31a1c","#fdbf6f")
set.seed(1)
p1 <- structure_plot(fit1,grouping = clusters[rows],topics = 1:k,
                     colors = topic_colors,gap = 20)
set.seed(1)
p2 <- structure_plot(fit2,grouping = clusters[rows],topics = 1:k,
                     colors = topic_colors,gap = 20)
plot_grid(p1,p2,nrow = 2,ncol = 1)

# Myeloid cells.
k <- 1
dat <- data.frame(gene = genes$symbol,
                  f0 = apply(fit2$F[,-k],1,max),
                  f1 = fit1$F[,k],
                  f2 = fit2$F[,k])
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 4 & f2 > 0.001)

# Megakaryocytes
k <- 2
dat <- data.frame(gene = genes$symbol,
                  f0 = apply(fit2$F[,-k],1,max),
                  f1 = fit1$F[,k],
                  f2 = fit2$F[,k])
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 10 & f2 > 0.001)

# B cells.
k <- 5
dat <- data.frame(gene = genes$symbol,
                  f0 = apply(fit2$F[,-k],1,max),
                  f1 = fit1$F[,k],
                  f2 = fit2$F[,k])
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 4 & f2 > 0.0001)

# NK cells.
k <- 3
dat <- data.frame(gene = genes$symbol,
                  f0 = apply(fit2$F[,-k],1,max),
                  f1 = fit1$F[,k],
                  f2 = fit2$F[,k])
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 4 & f2 > 0.001)

# X cells.
k <- 2
dat <- data.frame(gene = genes$symbol,
                  f0 = apply(fit2$F[,-k],1,max),
                  f1 = fit1$F[,k],
                  f2 = fit2$F[,k])
dat <- transform(dat,lfc = log2(f2/f0))
subset(dat,lfc > 10 & f2 > 0.001)

# Ribosomal protein genes.
k <- 6
dat <- data.frame(gene = genes$symbol,
                  f0 = apply(fit2$F[,-k],1,max),
                  f1 = fit1$F[,k],
                  f2 = fit2$F[,k])
dat <- transform(dat,lfc = log2(f2/f0),r21 = f2/f1)
subset(dat,lfc > 0.5 & f2 > 0.0001)
