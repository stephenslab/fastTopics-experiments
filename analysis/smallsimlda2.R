library(tm)
library(topicmodels)
# fit0 <- poisson2multinom(fit0)

# Fit LDA variational approximation.
#
# TO DO: Package this implementation in a function.
#
dtm <- as.DocumentTermMatrix(X,weighting = c("term frequency","tf"))
lda0 <- LDA(dtm,k,
            control = list(alpha = 1,estimate.alpha = FALSE,
                           em = list(iter.max = 4,tol = 0),
                           var = list(iter.max = 10)))

lda0@beta  <- t(log(fit0$F))
lda0@gamma <- fit0$L

lda1       <- lda0
lda1@beta  <- t(log(fit1$F))
lda1@gamma <- fit1$L

lda2       <- lda0
lda2@beta  <- t(log(fit2$F))
lda2@gamma <- fit2$L

lda0 <- LDA(dtm,k,model = lda0,
            control = list(alpha = 1,estimate.alpha = FALSE,keep = 1,
                           em = list(iter.max = 250,tol = 0),
                           var = list(iter.max = 20,tol = 0)))

lda1 <- LDA(dtm,k,model = lda1,
            control = list(alpha = 1,estimate.alpha = FALSE,keep = 1,
                           em = list(iter.max = 250,tol = 0),
                           var = list(iter.max = 20,tol = 0)))

lda2 <- LDA(dtm,k,model = lda2,
            control = list(alpha = 1,estimate.alpha = FALSE,keep = 1,
                           em = list(iter.max = 250,tol = 0),
                           var = list(iter.max = 20,tol = 0)))

pdat <- rbind(data.frame(iter = 1:250,elbo = lda0@logLiks,init = "none"),
              data.frame(iter = 1:250,elbo = lda1@logLiks,init = "em"),
              data.frame(iter = 1:250,elbo = lda2@logLiks,init = "scd"))
pdat <- transform(pdat,elbo = max(elbo) - elbo)
print(ggplot(pdat,aes(x = iter,y = elbo,color = init)) +
      geom_line(size = 0.75) +
      scale_color_manual(values = c("darkblue","dodgerblue","darkorange")) +
      labs(x = "iteration",y = "ELBO difference") +
      theme_cowplot(font_size = 10))
