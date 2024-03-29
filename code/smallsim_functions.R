# Scale each row of A so that the entries of each row sum to 1.
normalize.rows <- function (A)
  A / rowSums(A)

# Scale each column of A so that the entries of each column sum to 1.
normalize.cols <- function (A)
  t(t(A) / colSums(A))

# Randomly generate samples sizes for the multinomial data simulation.
simulate_sizes <- function (n)
  ceiling(10^rnorm(n,3,0.20))

# Randomly generate an m x k factors matrix for a multinomial topic
# model with k topics. Each row of the factors matrix are generated
# according to the following procedure: generate u = |r| - 5, where r
# ~ N(0,3); for each k, generate the Poisson rates as exp(max(t,-5)),
# where t ~ 0.8 * N(u,s/10) + 0.2 * N(u,s)}, and s = exp(-u/3).
simulate_factors <- function (m, k) {
  F <- matrix(0,m,k)
  for (i in 1:m) {
    u <- abs(rnorm(1,0,3)) - 5
    s <- exp(-u/3)
    a <- runif(k)
    z <- (a >= 0.2) * rnorm(k,u,s/10) +
         (a < 0.2)  * rnorm(k,u,s)
    F[i,] <- exp(pmax(z,-5))
  }
  return(normalize.cols(F))
}

# Randomly generate an n x k loadings matrix (i.e., mixture
# proportions matrix) for a multinomial topic model with k topics. The
# loadings are simulated from the correlated topic model with mean
# zero and k x k covariance matrix S.
simulate_loadings <- function (n, k, S) {
  L <- matrix(0,n,k)
  for (i in 1:n) {
    u <- rmvnorm(1,sigma = S)
    u <- u - max(u)
    L[i,] <- exp(u)/sum(exp(u))
  }
  return(L)
}

# Simulate counts from the multinomial topic model with factors F,
# loadings L and sample sizes s.
simulate_multinom_counts <- function (L, F, s) {
  n <- nrow(L)
  m <- nrow(F)
  X <- matrix(0,n,m)
  P <- tcrossprod(L,F)
  for (i in 1:n)
    X[i,] <- rmultinom(1,s[i],P[i,])
  return(X)
}

# Create a Structure plot to visualize the mixture proportions L.
simdata_structure_plot <- function (L, colors) {
  k <- ncol(L)
  y <- apply(L,1,which.max)
  y <- rank(y,ties.method = "random")
  y <- qqnorm(y,plot.it = FALSE)$x
  fit <- list(L = L)
  class(fit) <- c("multinom_topic_model_fit","list")
  return(structure_plot(fit,topics = 1:k,colors = colors,perplexity = 30,
                        Y_init = matrix(y),verbose = FALSE))
}

# Compare two estimates of L (the topic proportions matrix) in a
# scatterplot.
loadings_scatterplot <- function (L1, L2, colors, xlab = "fit1",
                                  ylab = "fit2") {
  n <- nrow(L1)
  k <- ncol(L2)
  pdat <- data.frame(x = as.vector(L1),
                     y = as.vector(L2),
                     k = factor(rep(1:k,each = n)))
  return(ggplot(pdat,aes(x = x,y = y,fill = k)) +
         geom_point(color = "white",shape = 21,size = 1.75) +
         geom_abline(intercept = 0,slope = 1,color = "black",
                     linetype = "dotted") +
         scale_fill_manual(values = colors) +
         labs(x = xlab,y = ylab) +
         theme_cowplot(font_size = 10))
}

# Run variational EM for LDA in which the. The parameters of the
# multinomial topic model ("fit") are used to initialize the LDA
# parameter estimates.
run_lda <- function (X, fit, numiter = 100, alpha = 1, estimate.alpha = FALSE,
                     e = 1e-8, verbose = 0) {
  k <- ncol(fit$L)
  X <- as.DocumentTermMatrix(X,weighting = c("term frequency","tf"))
  lda <- LDA(X,k,control = list(alpha = alpha,estimate.alpha = FALSE,
                                verbose = verbose,
                                em = list(iter.max = 4,tol = 0),
                                var = list(iter.max = 10)))
  F <- normalize.cols(pmax(fit$F,e))
  L <- normalize.rows(pmax(fit$L,e))
  lda@beta  <- t(log(F))
  lda@gamma <- L
  return(LDA(X,k,model = lda,
             control = list(alpha = alpha,estimate.alpha = estimate.alpha,
                            verbose = verbose,
                            em = list(iter.max = numiter,tol = 0),
                            var = list(iter.max = 20,tol = 0),
                            keep = 1)))
}
