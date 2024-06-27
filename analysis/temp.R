# Given the difficulties faced by EM here, let's see whether
# maptpx---which attempts to improve over EM with a quasi-Newton
# acceleration scheme---fares better. As before, we initialize the
# maptpx optimization using the estimates obtained by running the
# Poisson NMF algorithms from above.
maptpx0 <- maptpx::topics(X,k,shape = 1,initopics = poisson2multinom(fit0)$F,
                          omega = poisson2multinom(fit0)$L,tol = 1e-15,
                          tmax = 100,ord = FALSE,verb = 0)
maptpx1 <- maptpx::topics(X,k,shape = 1,initopics = poisson2multinom(fit1)$F,
                          omega = poisson2multinom(fit1)$L,tol = 1e-15,
                          tmax = 100,ord = FALSE,verb = 0)
F <- poisson2multinom(fit2)$F
L <- poisson2multinom(fit2)$L
maptpx2 <- maptpx::topics(X,k,shape = 1,initopics = F,
                          omega = L,tol = 1e-15,
                          tmax = 100,ord = FALSE,verb = 0)

# This plot shows the improvement in the maptpx solutions over
# time. Clearly, maptpx, like EM, gets "stuck" in a state of very slow
# progress, and benefits greatly from being initialized with the SCD
# estimates to arrive at a much better solution.
pdat <- rbind(data.frame(iter = 1:length(maptpx0$progress),
                         y    = maptpx0$progress,
                         init = "em-20"),
              data.frame(iter = 1:length(maptpx1$progress),
						 y    = maptpx1$progress,
						 init = "em-100"),
              data.frame(iter = 1:length(maptpx2$progress),
						 y    = maptpx2$progress,
						 init = "scd-100"))
p <- ggplot(pdat,aes(x = iter,y = y,color = init)) +
  geom_line(size = 0.75) +
  scale_color_manual(values = c("dodgerblue","darkblue","darkorange")) +
  labs(x = "iteration",y = "log-posterior") +
  theme_cowplot(font_size = 10)
print(p)
