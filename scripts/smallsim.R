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
# Fit a Poisson non-negative matrix factorization using EM and
# extrapolated SCD updates.
fit0 <- fit_poisson_nmf(X,k,numiter = 50,method = "em",
                        control = list(extrapolate = FALSE,numiter = 4,nc = 4))
fit1 <- fit_poisson_nmf(X,fit0 = fit0,numiter = 1000,method = "em",
                        control = list(extrapolate = FALSE,numiter = 4,nc = 4))
fit2 <- fit_poisson_nmf(X,fit0 = fit0,numiter = 1000,method = "scd",
                        control = list(extrapolate = FALSE,numiter = 4,nc = 4))
fit3 <- fit_poisson_nmf(X,fit0 = fit1,numiter = 50,method = "scd",
                        control = list(extrapolate = FALSE,numiter = 4,nc = 4))
fit1 <- poisson2multinom(fit1)
fit2 <- poisson2multinom(fit2)
fit3 <- poisson2multinom(fit3)

# Plot the improvement in the solution over time.
print(plot_progress(list(em       = fit1,
                         scd      = fit2,
                         "em+scd" = fit3),
                    x = "iter",add.point.every = 100,e = 0.1))

plot(fit1$L,fit2$L,pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
i <- c(3,5)
plot(fit1$L[,-i],fit2$L[,-i],pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
plot(fit1$L[,i],fit2$L[,i],pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
