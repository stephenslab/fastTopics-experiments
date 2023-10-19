# TO DO: Explain here what this script is for and how to use it.
library(Matrix)
library(flashier)
load("../data/newsgroups.RData")
set.seed(1)

# Artificially grow the data set.
counts <- rbind(counts,counts)
counts <- cbind(counts,counts)

# Add a small amount of "noise" to the data.
n <- nrow(counts)
m <- ncol(counts)
counts <- counts +
          sparseMatrix(i = 1:n,j = sample(m,n,replace = TRUE),
                       x = rep(1,n),dims = c(n,m))
          sparseMatrix(i = sample(n,m,replace = TRUE),j = 1:m,
                       x = rep(1,m),dims = c(n,m))
rownames(counts) <- NULL
colnames(counts) <- NULL

# Run flashier on the full Newsgroups data set.
cat("Running on full data set:\n")
cat("nonzero rate = ",format(100*mean(counts > 0),digits = 2),"%\n",sep="")
cat("N =",nnzero(counts),"\n")
t0 <- proc.time()
fit_full <- flash(counts,greedy_Kmax = 4,backfit = FALSE,nullcheck = FALSE)
fit_full <- flash_backfit(fit_full,maxiter = 4,tol = 1e-8,verbose = 3)
t1 <- proc.time()
print(t1 - t0)

# Run flashier on a random subset of rows and columns ("smaller").
cat("Running on 25% of the data:\n")
n <- 18774
m <- 55911
counts <- counts[1:n,1:m]
temp <- counts
for (i in 1:3)
  temp <- temp + 0.1*(counts[sample(n),sample(m)] > 0)
counts <- temp
cat("nonzero rate = ",format(100*mean(counts > 0),digits = 2),"%\n",sep="")
cat("N =",nnzero(counts),"\n")
t0 <- proc.time()
fit_smaller <- flash(counts,greedy_Kmax = 4,backfit = FALSE,nullcheck = FALSE)
fit_smaller <- flash_backfit(fit_smaller,maxiter = 4,verbose = 3)
t1 <- proc.time()
print(t1 - t0)

# Run flashier on an even smaller random subset of rows and columns
# ("smallest").
cat("Running on 6% of the data:\n")
n <- 9387
m <- 27956
counts <- counts[1:n,1:m]
temp <- counts
for (i in 1:3)
  temp <- temp + 0.1*(counts[sample(n),sample(m)] > 0)
counts <- temp
cat("nonzero rate = ",format(100*mean(counts > 0),digits = 2),"%\n",sep="")
cat("N =",nnzero(counts),"\n")
t0 <- proc.time()
fit_smallest <- flash(counts,greedy_Kmax = 4,backfit = FALSE,nullcheck = FALSE)
fit_smallest <- flash_backfit(fit_smaller,maxiter = 4,verbose = 3)
t1 <- proc.time()
print(t1 - t0)


