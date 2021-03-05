library(fastTopics)
library(mvtnorm)
library(MCMCpack)
set.seed(1)

# SCRIPT PARAMETERS
# -----------------
n <- 100
m <- 400
k <- 6
S <- diag(k)
S[] <- -2
S[5:6,5:6] <- 9 # Comment out this line to make topics independent.
diag(S) <- 11

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

# Generate the total counts.
s <- ceiling(10^rnorm(n,3,0.2))

# Generate the topic mixture proportions.
L <- matrix(0,n,k)
for (i in 1:n) {
  u <- rmvnorm(1,sigma = S)
  u <- u - max(u)
  L[i,] <- exp(u)/sum(exp(u))
}
rm(i,u)

# Generate the counts data.
X <- matrix(0,n,m)
P <- tcrossprod(L,F)
for (i in 1:n)
  X[i,] <- rmultinom(1,s[i],P[i,])
rm(P,i)

# Remove all-zero columns.
i <- which(colSums(X > 0) > 0)
X <- X[,i]
F <- F[i,]

# Fit a Poisson non-negative matrix factorization using EM and
# extrapolated SCD updates.
fit0 <- fit_poisson_nmf(X,k,numiter = 50,method = "em",
                        control = list(numiter = 4,nc = 4))
fit1 <- fit_poisson_nmf(X,fit0 = fit0,numiter = 1000,method = "em",
                        control = list(numiter = 4,nc = 4))
fit2 <- fit_poisson_nmf(X,fit0 = fit0,numiter = 1000,method = "scd",
                        control = list(extrapolate = TRUE,numiter = 4,nc = 4))
fit1 <- poisson2multinom(fit1)
fit2 <- poisson2multinom(fit2)

# Plot the improvement in the solution over time.
print(plot_progress(list(em = fit1,scd = fit2),
                    x = "iter",add.point.every = 100))

stop()

plot(fit1$L,fit2$L,pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
i <- c(3,5)
plot(fit1$L[,-i],fit2$L[,-i],pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
plot(fit1$L[,i],fit2$L[,i],pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
