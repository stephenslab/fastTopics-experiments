library(Matrix)
library(fastTopics)

# The number of topics to learn.
k <- 10

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
rm(n,rows,cols)

# Prefit the Poisson NMF model. The aim here is to run enough EM
# updates so that it is difficult for the other algorithms to "escape"
# this local maximum of the likelihood surface.
cat("Prefitting Poisson NMF model.\n")
fit0 <- fit_poisson_nmf(counts,k = k,numiter = 20,method = "em",
                        control = list(numiter = 4,nc = 4))


# Fit the Poisson NMF model by performing 200 EM updates.
cat("Running 200 EM updates.\n")
fit1 <- fit_poisson_nmf(counts,fit0 = fit0,numiter = 200,method = "em",
                        control = list(numiter = 4,nc = 4))

# Fit the Poisson NMF model by performing 200 extrapolated SCD updates.
cat("Running 200 extrapolated SCD updates.\n")
fit2 <- fit_poisson_nmf(counts,fit0 = fit0,numiter = 200,method = "scd",
                        control = list(numiter = 4,nc = 4,extrapolate = TRUE))
