library(tools)
library(Matrix)
library(fastTopics)
library(cowplot)

# Script parameters.
seed <- 1
k    <- 10

# Initialize the sequence of pseudorandom numbers.
set.seed(1)

# Load the newsgroups data, and sample a random subset of 4,000
# documents.
cat("Loading data.\n")
load("../data/newsgroups.RData")
n      <- nrow(counts)
rows   <- sample(n,4000)
topics <- topics[rows]
counts <- counts[rows,]

# Remove words appearing in fewer than 10 documents.
cols <- which(colSums(counts > 0) >= 10)
counts <- counts[,cols]

# Prefit the Poisson NMF model. The aim here is to run enough EM
# updates so that it is difficult for the other algorithms to "escape"
# this local maximum of the likelihood surface.
cat("Prefitting Poisson NMF model.\n")
print(seed)
set.seed(seed)
fit0 <- fit_poisson_nmf(counts,k = k,numiter = 50,method = "em",
                        init.method = "random",
                        control = list(numiter = 4,nc = 4))

# Fit the Poisson NMF model by performing 150 EM + 50 SCD updates.
cat("Running 200 EM updates.\n")
fit1 <- fit_poisson_nmf(counts,fit0 = fit0,numiter = 150,method = "em",
                        control = list(numiter = 4,nc = 4))

# Fit the Poisson NMF model by performing 150 extrapolated SCD updates.
cat("Running 200 extrapolated SCD updates.\n")
fit2 <- fit_poisson_nmf(counts,fit0 = fit0,numiter = 150,method = "scd",
                        control = list(numiter = 4,nc = 4,extrapolate = TRUE))

# Plot the improvement in the solution over time.
p1 <- plot_progress(list(em = fit1,scd = fit2),x = "iter",y = "loglik",
                    add.point.every = 20)
p2 <- plot_progress(list(em = fit1,scd = fit2),x = "iter",y = "res",
                    add.point.every = 20)
dev.new(height = 2,width = 6)
print(plot_grid(p1,p2))

# Compare the EM and SCD estimates of the topic 
colors <- c("#a6cee3","#1f78b4","#b2df8a","#33a02c","#fb9a99",
            "#e31a1c","#fdbf6f","#ff7f00","#cab2d6","#6a3d9a")
p3 <- structure_plot(fit1,grouping = topics,gap = 20,n = 2000,colors = colors)
p4 <- structure_plot(fit2,grouping = topics,gap = 20,n = 2000,colors = colors)
dev.new(height = 3.5,width = 6)
print(plot_grid(p3,p4,nrow = 2,ncol = 1))

# Compare the EM and SCD estimates of the topic proportions in a
# simple scatterplot.
dev.new(height = 3.5,width = 3)
plot(poisson2multinom(fit1)$L,poisson2multinom(fit2)$L,pch = 20,cex = 0.5,
     xlab = "EM",ylab = "SCD")
abline(a = 0,b = 1,col = "magenta",lty = "dotted")

# Save the newsgroups data to an .RData file.
counts <- as.matrix(counts)
save(list = "counts",file = "newsgroups_smaller.RData")
resaveRdaFiles("newsgroups_smaller.RData")
