library(NNLM)
library(fastTopics)
library(R.matlab)
set.seed(1)

# Simulate data.
X <- simulate_count_data(100,200,3)$X

# Initialize the Poisson NMF model fit.
fit0 <- fit_poisson_nmf(X,k = 3,numiter = 20,method = "mu",
                        control = list(numiter = 1))

writeMat("../matlab/dat100x200.mat",X = X,L0 = fit0$L,F0 = fit0$F)
fit3 <- readMat("../matlab/ccd100x200.mat")
fit3$obj <- drop(fit3$obj)

# Run 20 multiplicative (EM) updates.
fit1 <- suppressWarnings(nnmf(X,k = 3,init = list(W = fit0$L,H = t(fit0$F)),
                              method = "lee",loss = "mkl",max.iter = 40,
                              trace = 1,rel.tol = 0,inner.max.iter = 1,
                              inner.rel.tol = 0,n.threads = 1))

# Run 20 SCD updates.
fit2 <- suppressWarnings(nnmf(X,k = 3,init = list(W = fit0$L,H = t(fit0$F)),
                              method = "scd",loss = "mkl",max.iter = 40,
                              trace = 1,rel.tol = 0,inner.max.iter = 1,
                              n.threads = 1))

y0 <- min(c(fit1$mkl,fit2$mkl,fit3$obj))
y1 <- diff(range(c(fit1$mkl,fit2$mkl,fit3$obj)))
iter <- 1:40
plot(iter,fit1$mkl - y0,type = "l",col = "darkblue",lwd = 2,
     xlab = "iteration",ylab = "loss",ylim = c(0,y1))
points(iter,fit1$mkl - y0,col = "darkblue",pch = 20,cex = 1)
lines(iter,fit2$mkl - y0,col = "darkorange",lwd = 2)
points(iter,fit2$mkl - y0,col = "darkorange",pch = 20,cex = 1)
lines(iter,fit3$obj - y0,col = "red",lwd = 1)

