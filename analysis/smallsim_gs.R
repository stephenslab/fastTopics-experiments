# Try running LDA with method = "Gibbs" on "correlated topics" example.
run_lda_gibbs <- function (X, fit, numiter = 1000, alpha = 1,
                           delta = 1, e = 1e-8) {
  k <- ncol(fit$L)
  tm <- as.DocumentTermMatrix(X,weighting = c("term frequency","tf"))
  control <- list(alpha = alpha,delta = delta,verbose = 0,seed = 1,
                  burnin = 0,iter = 10,thin = 10,keep = 1,best = TRUE)
  lda0 <- LDA(tm,k = k,method = "Gibbs",control = control)
  F <- normalize.cols(pmax(fit$F,e))
  L <- normalize.rows(pmax(fit$L,e))
  lda0@beta      <- t(log(fit$F))
  lda0@gamma     <- fit$L
  control$best   <- FALSE
  control$iter   <- numiter
  lda <- LDA(X,k = k,model = lda0,method = "Gibbs",control = control)@fitted
  n   <- length(lda)
  return(list(lda = lda[[n]],
              logpost = sapply(lda,function (x) x@logposterior)))
}
lda_gs0 <- run_lda_gibbs(X,fit0,alpha = 1/k,delta = 1/10)
lda_gs1 <- run_lda_gibbs(X,fit1,alpha = 1/k,delta = 1/10)
lda_gs2 <- run_lda_gibbs(X,fit2,alpha = 1/k,delta = 1/10)

# This plot shows the evolution in the posterior likelihood over time.
pdat <-
  rbind(data.frame(iter = 1:100,loglik = lda_gs0$logpost,init = "none"),
        data.frame(iter = 1:100,loglik = lda_gs1$logpost,init = "em"),
        data.frame(iter = 1:100,loglik = lda_gs2$logpost,init = "scd"))
p18 <- ggplot(pdat,aes(x = iter,y = loglik,color = init)) +
  geom_line(size = 0.75) +
  scale_color_manual(values = c("darkblue","dodgerblue","darkorange"))+
  labs(x = "iteration",y = "log-likelihood") +
  theme_cowplot(font_size = 10)
print(p18)

# Compare the maximum-likelihood and posterior estimates.
loadings_scatterplot(fit2$L,lda_gs2$lda@gamma,topic_colors,"MLE","MCMC")
loadings_scatterplot(fit2$F,t(exp(lda_gs2$lda@beta)),topic_colors,"MLE","MCMC")

loadings_scatterplot(lda_gs0$lda@gamma,lda_gs2$lda@gamma,topic_colors,
                     "em","scd")
