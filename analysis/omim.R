library(Matrix)
library(rsvd)
library(uwot)
library(fastTopics)
library(ggplot2)
library(cowplot)
load("../data/omim.RData")
load("../output/omim_topics_k=40.RData")
L <- poisson2multinom(tm)$L
F <- poisson2multinom(tm)$F
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
# k8, k10, k32
p1 <- ggplot(pdat,aes(x = umap1,y = umap2,color = k8)) +
  geom_point() +
  scale_color_gradient(low = "gainsboro",high = "black") +
    theme_cowplot(font_size = 12)
i <- which(L[,8] > 0.5)
ks <- which(colSums(L[i,]) > 1)
p2 <- structure_plot(L[i,],topics = ks,n = Inf)

stop()

# Inspecting the topics:
k <- 1
L <- poisson2multinom(tm)$L
F <- poisson2multinom(tm)$F
i <- head(order(L[,k],decreasing = TRUE),n = 20)
j <- which(F[,k] > apply(F[,-k],1,max))
j <- head(j[order(F[j,k],decreasing = TRUE)],n = 30)
keywords <- rownames(F)[j]
dat <- data.frame(L     = L[,k],
                  mim   = meta_data$mim,
                  title = substr(meta_data$title,1,60))
cat("Topic ",k,":\n",sep = "")
print(format(dat[i,],justify = "left"),
      row.names = FALSE)
cat("keywords:\n")
print(keywords,quote = FALSE)

