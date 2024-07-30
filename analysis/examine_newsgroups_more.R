library(fastTopics)
library(cowplot)
set.seed(1)
k <- 10
load("../data/newsgroups.RData")
fit1 <- readRDS("../output/newsgroups/rds/fit-newsgroups-em-k=10.rds")$fit
fit2 <- readRDS("../output/newsgroups/rds/fit-newsgroups-scd-ex-k=10.rds")$fit
cor(fit1$L,fit2$L)
n    <- nrow(fit1$L)
rows <- sample(n,2000)
fit1 <- select_loadings(fit1,rows)
fit2 <- select_loadings(fit2,rows)
tsne <- tsne_from_topics(fit1,dims = 1,verbose = FALSE)
p1 <- structure_plot(fit1,loadings_order = order(tsne[,1]),topics = 1:k,
                     grouping = topics[rows])
p2 <- structure_plot(fit2,loadings_order = order(tsne[,1]),topics = 1:k,
                     grouping = topics[rows])
plot_grid(p1,p2,nrow = 2,ncol = 1)

lda1 <- readRDS("../output/newsgroups/rds/lda-newsgroups-em-k=10.rds")$lda
lda2 <- readRDS("../output/newsgroups/rds/lda-newsgroups-scd-ex-k=10.rds")$lda
cor(lda1@gamma,lda2@gamma)
p3 <- structure_plot(lda1@gamma[rows,],loadings_order = order(tsne[,1]),
                     topics = 1:k)
p4 <- structure_plot(lda2@gamma[rows,],loadings_order = order(tsne[,1]),
                     topics = 1:k)
plot_grid(p1,p2,p3,p4,nrow = 4,ncol = 1)
