# Note: k should be 3 or greater.
simulate_correlated_loadings <- function (n, k) {
  L <- matrix(0,n,k)
  L[,1] <- runif(n,0,2)
  for (i in 1:n) {
    js <- sample(2:k,2)
    j1 <- js[1]
    j2 <- js[2]
    L[i,j1] <- 1
    L[i,j2] <- 0.1
  }
  return(normalize.rows(L))
}

# CORRELATED TOPICS SCENARIO
set.seed(1)
n <- 100
L <- simulate_correlated_loadings(n,k)
X <- simulate_multinom_counts(L,F,s)
X <- X[,colSums(X > 0) > 0]

# Compare this Structure plot to the one above---there is more mixing of
# topics 3 and 4.
p9 <- simdata_structure_plot(L,topic_colors)
print(p9)

fit0 <- fit_poisson_nmf(X,k,numiter = 20,method = "em",control = control)
fit1 <- fit_poisson_nmf(X,fit0=fit0,numiter=180,method="em",control=control)
fit2 <- fit_poisson_nmf(X,fit0=fit0,numiter=180,method="scd",control=control)
fit0 <- poisson2multinom(fit0)
fit1 <- poisson2multinom(fit1)
fit2 <- poisson2multinom(fit2)
p <- loadings_scatterplot(fit1$L,fit2$L,topic_colors,"em","scd")
print(p)

# As before, we run the EM and SCD updates to fit the multinomial topic
# model, with a twist that we perform another round of SCD updates after
# running the EM updates. This will be explained shortly.
fit0 <- fit_poisson_nmf(X,k,numiter = 20,method = "em",control = control)
fit1 <- fit_poisson_nmf(X,fit0=fit0,numiter=780,method="em",control=control)
fit2 <- fit_poisson_nmf(X,fit0=fit0,numiter=980,method="scd",control=control)
fit3 <- fit_poisson_nmf(X,fit0=fit1,numiter=200,method="scd",control=control)
fit1 <- fit_poisson_nmf(X,fit0=fit1,numiter=200,method="em",control=control)
fit0 <- poisson2multinom(fit0)
fit1 <- poisson2multinom(fit1)
fit2 <- poisson2multinom(fit2)
fit3 <- poisson2multinom(fit3)

# In this second example, after initially making good progress, the EM
# estimates remain far from the solution achieved by SCD even after
# hundreds of EM updates. This isn't a case where the EM updates have
# settled on a different local solution---the SCD updates quickly
# "rescue" the EM estimates.
pdat <- rbind(data.frame(iter   = 1:1000,
                         loglik = fit1$progress$loglik.multinom,
                         res    = fit1$progress$res,
                         method = "em"),
              data.frame(iter   = 1:1000,
                         loglik = fit2$progress$loglik.multinom,
                         res    = fit2$progress$res,
                         method = "scd"),
              data.frame(iter   = 800:1000,
                         loglik = fit3$progress[800:1000,"loglik.multinom"],
                         res    = fit3$progress[800:1000,"res"],
   	                 method = "em+scd"))
pdat <- subset(pdat,iter >= 20)
pdat <- transform(pdat,
		  iter   = iter - 20,
                  loglik = max(loglik) - loglik + 0.1)
p10 <- ggplot(pdat,aes(x = iter,y = loglik,color = method)) +
  geom_line(size = 0.75) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values = c("dodgerblue","darkorange","magenta")) +
  labs(x = "iteration",y = "loglik difference") +
  theme_cowplot(font_size = 10)
p11 <- ggplot(pdat,aes(x = iter,y = res,color = method)) +
  geom_line(size = 0.75) +
  scale_color_manual(values = c("dodgerblue","darkorange","magenta")) +
  ylim(0,10) +
  labs(x = "iteration",y = "max KKT residual") +
  theme_cowplot(font_size = 10)
print(plot_grid(p10,p11))

stop()

# This large difference in likelihood is not due to a trivial difference
# in solution---for example, there are many large differences in the
# topic proportion estimates.
p12 <- loadings_scatterplot(fit1$L,fit2$L,topic_colors,"em","scd")
print(p12)
