library(NNLM)
library(fastTopics)
set.seed(1)

# Simulate data.
X <- simulate_count_data(100,200,3)$X

# Initialize the Poisson NMF model fit.
fit0 <- fit_poisson_nmf(X,k = 3,numiter = 20,method = "mu",
                        control = list(numiter = 1))

# Run 20 multiplicative (EM) updates.
fit1 <- suppressWarnings(nnmf(X,k = 3,init = list(W = fit0$L,H = t(fit0$F)),
                              method = "lee",loss = "mkl",max.iter = 20,
                              trace = 1,rel.tol = 0,inner.max.iter = 2,
                              inner.rel.tol = 0))

# Run 20 SCD updates.
fit2 <- suppressWarnings(nnmf(X,k = 3,init = list(W = fit0$L,H = t(fit0$F)),
                              method = "scd",loss = "mkl",max.iter = 20,
                              trace = 1,rel.tol = 0,inner.max.iter = 2))

print(with(fit1,sum(cost(X,W,H,family = "poisson"))),digits = 16)
print(with(fit2,sum(cost(X,W,H,family = "poisson"))),digits = 16)

y0 <- min(c(fit1$mkl,fit2$mkl))
y1 <- diff(range(c(fit1$mkl,fit2$mkl)))
iter <- 1:20
plot(iter,fit1$mkl - y0,type = "l",col = "darkblue",lwd = 2,
     xlab = "iteration",ylab = "loss",ylim = c(0,y1))
points(iter,fit1$mkl - y0,col = "darkblue",pch = 20,cex = 1)
lines(iter,fit2$mkl - y0,col = "darkorange",lwd = 2)
points(iter,fit2$mkl - y0,col = "darkorange",pch = 20,cex = 1)
