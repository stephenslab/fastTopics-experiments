library(Matrix)
library(rsvd)
library(uwot)
library(flashier)
library(fastTopics)
library(ggplot2)
library(cowplot)
load("../data/omim.RData")
load("../output/omim/omim_topics_k=40.RData")
load("../output/omim/omim_log1p_k=40.RData")
normalize_cols <- function (A)
  t(t(A) / apply(A,2,max))

k <- 40
L <- poisson2multinom(tm)$L
F <- poisson2multinom(tm)$F
L_log1p <- fit_log1p$LL
F_log1p <- fit_log1p$FF
L_log1p <- normalize_cols(L_log1p)
F_log1p <- normalize_cols(F_log1p)
colnames(L_log1p) <- paste0("k",1:k)
colnames(F_log1p) <- paste0("k",1:k)
set.seed(1)
a <- 1
s <- rowSums(counts)
s <- s/mean(s)
shifted_log_counts <- log1p(counts/(a*s))
# U <- rsvd(counts,k = 100)$u
Y <- umap(L,n_neighbors = 20,metric = "euclidean",
          n_threads = 4,verbose = TRUE)
out <- kmeans(Y,centers = 38)
pdat <- data.frame(umap1 = Y[,1],
                   umap2 = Y[,2],
                   cluster = factor(out$cluster))
pdat2 <- cbind(data.frame(umap1 = Y[,1],umap2 = Y[,2]),L_log1p)
p1 <- ggplot(pdat,aes(x = umap1,y = umap2,color = cluster)) +
  geom_point(size = 0.5) +
  scale_color_manual(values = fastTopics:::glasbey()[-1]) +
  theme_cowplot(font_size = 12)
p1b <- ggplot(pdat2,aes(x = umap1,y = umap2,color = k6)) +
  geom_point(size = 0.5) +
  scale_color_gradient(low = "gainsboro",high = "black") +
    theme_cowplot(font_size = 12)
i <- which(L[,8] > 0.25)
ks <- which(colSums(L[i,]) > 5)
ks2 <- which(colSums(L_log1p[i,]) > 5)
p2 <- structure_plot(L[i,],topics = ks,n = Inf)
p3 <- structure_plot(L_log1p[i,],topics = ks2,n = Inf)
plot_grid(p2,p3,nrow = 2,ncol = 1)

stop()

# Inspecting the topics:
k <- 5
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

# Inspecting the log1pNMF factors:
# k6, k9 (compare to k5, k37 in the topic model)
plot(F_log1p[,6],F_log1p[,9],pch = 20)
j1 <- which(F_log1p[,6] > 0.4 & F_log1p[,9] < 0.05)
j2 <- which(F_log1p[,6] < 0.05 & F_log1p[,9] > 0.4)
print(rownames(F_log1p)[j1])
print(rownames(F_log1p)[j2])

par(mfrow = c(1,2))
# Deafness, log1pNMF
k <- 38
plot(L_log1p[,k],L_log1p[,9],pch = 20)
plot(L_log1p[,k],L_log1p[,6],pch = 20)
i <- which(L_log1p[,38] > 0.75 & L_log1p[,6] > 0.2)
meta_data[i,]
i <- which(L_log1p[,38] > 0.75 & L_log1p[,6] < 0.01)
meta_data[i,]

# k6 = dominant
# k9 = recessive

# Deafness, topic model
plot(L[,16],L_log1p[,38],pch = 20)
i <- which(L[,16] > 0.5 & L_log1p[,38] > 0.5)
plot(L[i,5],L_log1p[i,6],pch = 20)
plot(L[i,37],L_log1p[i,9],pch = 20)

# k10, k11
hist(L_log1p[,10],breaks = 64)
hist(L_log1p[,11],breaks = 64)
plot(F_log1p[,10],F_log1p[,11],pch = 20)
j1 <- which(F_log1p[,10] > 0.2 & F_log1p[,11] < 0.01)
j2 <- which(F_log1p[,10] < 0.01 & F_log1p[,11] > 0.2)
print(rownames(F_log1p)[j1])
print(rownames(F_log1p)[j2])

par(mfrow = c(1,2))
k <- 15
plot(L_log1p[,k],L_log1p[,9],pch = 20)
plot(L_log1p[,k],L_log1p[,6],pch = 20)
i <- which(L_log1p[,15] > 0.75 & L_log1p[,6] > 0.2)
meta_data[i,]
i <- which(L_log1p[,15] > 0.75 & L_log1p[,6] < 0.01)
meta_data[i,]

i <- which(L[,9] > 0.5 & L_log1p[,15] > 0.5)
plot(L[i,5],L_log1p[i,6],pch = 20)
plot(L[i,37],L_log1p[i,9],pch = 20)

i1 <- i[which(L[i,5] < 0.01 & L_log1p[i,6] > 0.1)]
meta_data[i1,]
