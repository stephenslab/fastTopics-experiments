# TO DO: Explain here what this script does, and how to use it.
library(fastTopics)
library(MCMCpack)
set.seed(1)

# SCRIPT PARAMETERS
# -----------------
n <- 100
m <- 1000
k <- 6

# SIMULATE DATA
# -------------
# Simulate the relative expression levels.
F <- matrix(0,m,k)
for (j in 1:m) {
  u <- abs(rnorm(1,0,3)) - 5
  s <- exp(-u/3)
  a <- runif(k)
  z <- (a >= 0.2) * rnorm(k,u,s/10) +
       (a < 0.2)  * rnorm(k,u,s)
  F[j,] <- exp(pmax(-5,z))
}
F <- t(t(F)/colSums(F))
rm(a,s,u,z,j)

# Generate the topic mixture proportions.
L  <- matrix(0,n,k)
k1 <- sample(k,n,replace = TRUE,prob = 2^(-seq(1,k)))
for (i in 1:n) {
  j      <- sample(k,k1[i])
  L[i,j] <- rdirichlet(1,rep(1,k1[i]))
}
rm(i,j,k1)

# Generate the total counts.
s <- ceiling(10^rnorm(n,3,0.2))

# Generate the counts data.
X <- matrix(0,n,m)
P <- tcrossprod(L,F)
for (i in 1:n)
  X[i,] <- rmultinom(1,s[i],P[i,])
rm(P,i)

# Remove all-zero columns.
X <- X[,colSums(X > 0) > 0]

# Fit a Poisson non-negative matrix factorization using EM and
# extrapolated SCD updates.
fit0 <- fit_poisson_nmf(X,k,numiter = 20,method = "em",
                        control = list(numiter = 4,nc = 4))
fit1 <- fit_poisson_nmf(X,fit0 = fit0,numiter = 250,method = "em",
                        control = list(numiter = 4,nc = 4))
fit2 <- fit_poisson_nmf(X,fit0 = fit0,numiter = 250,method = "scd",
                        control = list(extrapolate = TRUE,numiter = 4,nc = 4))
fit1 <- poisson2multinom(fit1)
fit2 <- poisson2multinom(fit2)

# Plot the improvement in the solution over time.
print(plot_progress(list(em = fit1,scd = fit2),x = "iter"))

stop()

plot(fit1$L,fit2$L,pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
