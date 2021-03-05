# Scale each column of A so that the entries of each column sum to 1.
normalize.cols <- function (A)
  t(t(A) / colSums(A))

# Randomly generate total counts for the data simulation.
simulate_sizes <- function (n)
  ceiling(10^rnorm(n,3,0.2))

# Each row of the factors matrix are generated according to the
# following procedure: generate u = |r| - 5, where r ~ N(0,3); for
# each k, generate the Poisson rates as exp(max(t,-5)), where t ~ 0.8
# * N(u,s/10) + 0.2 * N(u,s)}, and s = exp(-u/3).
simulate_factors <- function (n, k) {
  F <- matrix(0,n,k)
  for (i in 1:n) {
    u <- abs(rnorm(1,0,3)) - 5
    s <- exp(-u/3)
    a <- runif(k)
    z <- (a >= 0.2) * rnorm(k,u,s/10) +
         (a < 0.2)  * rnorm(k,u,s)
    F[i,] <- exp(pmax(z,-5))
  }
  return(normalize.cols(F))
}
