library(Matrix)
library(rsvd)
library(uwot)
library(flashier)
library(fastTopics)
library(ggplot2)
library(cowplot)
load("../data/omim.RData")
load("../output/omim_topics_k=40.RData")
load("../output/omim_nmf_k=40.RData")
k <- 40
L <- poisson2multinom(tm)$L
F <- poisson2multinom(tm)$F
L_nmf <- fl_nmf_ldf$L
colnames(L_nmf) <- paste0("k",1:k)
set.seed(1)
a <- 1
s <- rowSums(counts)
s <- s/mean(s)
shifted_log_counts <- log1p(counts/(a*s))
U <- rsvd(counts,k = 100)$u
Y <- umap(U,n_neighbors = 40,metric = "cosine",
          min_dist = 0.1,n_threads = 4,
          verbose = TRUE)
pdat <- cbind(data.frame(umap1 = Y[,1],umap2 = Y[,2]),L)
pdat2 <- cbind(data.frame(umap1 = Y[,1],umap2 = Y[,2]),L_nmf)
p1 <- ggplot(pdat,aes(x = umap1,y = umap2,color = k16)) +
  geom_point() +
  scale_color_gradient(low = "gainsboro",high = "black") +
    theme_cowplot(font_size = 12)
p1b <- ggplot(pdat2,aes(x = umap1,y = umap2,color = k25)) +
  geom_point() +
  scale_color_gradient(low = "gainsboro",high = "black") +
    theme_cowplot(font_size = 12)
i <- which(L[,1] > 0.25)
ks <- which(colSums(L[i,]) > 5)
ks2 <- which(colSums(L_nmf[i,]) > 2)
ks2 <- setdiff(ks2,1)
p2 <- structure_plot(L[i,],topics = ks,n = Inf)
p3 <- structure_plot(L_nmf[i,],topics = ks2,n = Inf)
plot_grid(p2,p3,nrow = 2,ncol = 1)

stop()

# Inspecting the topics:
k <- 37 # 1, 5
L <- poisson2multinom(tm)$L
F <- poisson2multinom(tm)$F
i <- head(order(L[,k],decreasing = TRUE),n = 20)
j <- which(F[,k] > apply(F[,-k],1,max))
j <- head(j[order(F[j,k],decreasing = TRUE)],n = 50)
keywords <- rownames(F)[j]
dat <- data.frame(L     = L[,k],
                  mim   = meta_data$mim,
                  title = substr(meta_data$title,1,60))
cat("Topic ",k,":\n",sep = "")
print(format(dat[i,],justify = "left"),
      row.names = FALSE)
cat("keywords:\n")
print(keywords,quote = FALSE)

# Inspecting the NMF factors:
# k3 k7 k10 k11 k13 k19 k25
k <- 19
L_nmf <- fl_nmf_ldf$L
F_nmf <- fl_nmf_ldf$F
colnames(L_nmf) <- paste0("k",1:40)
colnames(F_nmf) <- paste0("k",1:40)
j <- which(F_nmf[,k] > apply(F_nmf[,-k],1,max))
j <- head(j[order(F_nmf[j,k],decreasing = TRUE)],n = 80)
keywords <- rownames(F_nmf)[j]

i <- which(L[,1] > 0.4 & L_nmf[,3] > 0.4)
i <- which(L[,1] > 0.4 & L_nmf[,3] < 0.05)
i <- which(L[,1] > 0.4 & L_nmf[,7] > 0.5)
i <- which(L[,1] > 0.4 & L_nmf[,7] < 0.01)
