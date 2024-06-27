# Let's now see how this relates to fitting an LDA model,
numiter <- 800
lda0 <- run_lda(X,fit0,numiter = numiter)
lda1 <- run_lda(X,fit1,numiter = numiter)
lda2 <- run_lda(X,fit2,numiter = numiter)

# These plots show the improvement in the objective (the ELBO) over time.
pdat <- rbind(data.frame(iter = 1:numiter,elbo = lda0@logLiks,init = "none"),
              data.frame(iter = 1:numiter,elbo = lda1@logLiks,init = "em"),
              data.frame(iter = 1:numiter,elbo = lda2@logLiks,init = "scd"))
pdat <- transform(pdat,elbo = elbo - max(elbo))
p <- ggplot(pdat,aes(x = iter,y = elbo,color = init)) +
  geom_line(size = 0.75) +
  scale_color_manual(values=c("darkblue","dodgerblue","darkorange"))+
  labs(x = "iteration",y = "ELBO - max(ELBO)") +
  theme_cowplot(font_size = 10)
print(p)
