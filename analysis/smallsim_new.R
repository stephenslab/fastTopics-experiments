# Here we perform a small experiment with simulated data sets to
# illustrate the behaviour of the EM and SCD Poisson NMF algorithms
# for fitting topic models. This example suggests that the
# multiplicative (EM) updates can have convergence difficulty in some
# circumstances. The results also suggest that variational EM for LDA
# can experience similar convergence difficulties.

# Load the packages used in the analysis below, as well as additional
# functions that we will use to simulate the data.
library(tm)
library(topicmodels)
library(fastTopics)
library(mvtnorm)
library(ggplot2)
library(cowplot)
source("../code/smallsim_functions.R")

# Set the seed so that the results can be reproduced.
set.seed(1)

# INDEPENDENT TOPICS
# In this first example, we simulate a 100 x 400 counts matrix
# from a multinomial topic model with K = 6 topics.
n <- 100
m <- 400
k <- 6
S <- 13*diag(k) - 2
F <- simulate_factors(m,k)
L <- simulate_loadings(n,k,S)
s <- simulate_sizes(n)
X <- simulate_multinom_counts(L,F,s)
X <- X[,colSums(X > 0) > 0]

# The topic proportions for each of the 100 samples---that is, a row
# of the counts matrix---are randomly drawn according to the
# correlated topic model.
topic_colors <- c("dodgerblue","darkorange","forestgreen","darkblue",
                  "gold","skyblue")
p1 <- simdata_structure_plot(L,topic_colors)
print(p1)

# Here we compare two different updates: the EM updates and the sequential
# coordinate descent (SCD). We perform 100 iterations of each. The model
# fitting is initialized by first running 20 EM updates, with the aim of
# better ensuring that the same local maximum is recovered by both runs.
control <- list(extrapolate = FALSE,numiter = 4)
fit0 <- fit_poisson_nmf(X,k,numiter = 20,method = "em",control = control)
fit1 <- fit_poisson_nmf(X,fit0=fit0,numiter=100,method="em",control=control)
fit2 <- fit_poisson_nmf(X,fit0=fit0,numiter=100,method="scd",control=control)
fit0 <- poisson2multinom(fit0)
fit1 <- poisson2multinom(fit1)
fit2 <- poisson2multinom(fit2)

# This next plot shows the improvement in the solution over time for the
# EM and SCD updates. The Y axis shows the difference between the
# current log-likelihood and the best log-likelihood achieved by the two
# methods.
pdat <- rbind(data.frame(iter   = 1:120,
                         ll     = fit1$progress$loglik.multinom,
                         res    = fit1$progress$res,
                         method = "em"),
              data.frame(iter   = 1:120,
			 ll     = fit2$progress$loglik.multinom,
			 res    = fit2$progress$res,
			 method = "scd"))
pdat <- subset(pdat,iter >= 20)
pdat <- transform(pdat,
                  iter = iter - 20,
                  ll   = max(ll) - ll + 0.1)
p2 <- ggplot(pdat,aes(x = iter,y = ll,color = method)) +
  geom_line(size = 0.75) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values = c("dodgerblue","darkorange")) +
  labs(x = "iteration",y = "loglik difference") +
  theme_cowplot(font_size = 10)
p3 <- ggplot(pdat,aes(x = iter,y = res,color = method)) +
  geom_line(size = 0.75) +
  scale_color_manual(values = c("dodgerblue","darkorange")) +
  labs(x = "iteration",y = "max KKT residual") +
  theme_cowplot(font_size = 10)
plot_grid(p2,p3)

# Among the two methods compared, the SCD updates progress more
# rapidly toward a solution. Still, the EM updates recover the same
# solution after a reasonable number of iterations. Indeed, the EM and
# CD estimates of the topic proportions are the nearly same for all
# topics.
p4 <- loadings_scatterplot(fit1$L,fit2$L,topic_colors,"em","scd")
print(p4)

# The maptpx R package uses a quasi-Newton-accelerated EM algorithm,
# together with sequential programming techniques, to compute *maximum a
# posteriori* estimates of the topic model parameters. (Note that here
# we use a slightly modified version of the maptpx package that allows
# initialization of the topic proportions as well as the word
# frequencies. This modified version of the maptpx package can be
# downloaded [here](https://github.com/stephenslab/maptpx).) Although
# maptpx is not solving the same problem, it is close enough that it
# benefits from a good initialization.
maptpx0 <- maptpx::topics(X,k,shape = 1,initopics = fit0$F,omega = fit0$L,
                          tol = 1e-15,tmax = 1000,ord = FALSE,verb = 0)
maptpx1 <- maptpx::topics(X,k,shape = 1,initopics = fit1$F,omega = fit1$L,
                          tol = 1e-15,tmax = 1000,ord = FALSE,verb = 0)
maptpx2 <- maptpx::topics(X,k,shape = 1,initopics = fit2$F,omega = fit2$L,
                          tol = 1e-15,tmax = 1000,ord = FALSE,verb = 0)

# This next plot shows how well the estimates improve the log-posterior
# at each iteration.
pdat <- rbind(data.frame(iter = 1:length(maptpx0$progress),
                         y    = maptpx0$progress,
                         init = "em-20"),
              data.frame(iter = 1:length(maptpx1$progress),
						 y    = maptpx1$progress,
						 init = "em-120"),
              data.frame(iter = 1:length(maptpx2$progress),
						 y    = maptpx2$progress,
						 init = "scd"))
pdat <- transform(pdat,y = max(y) - y + 0.1)
pdat <- subset(pdat,iter <= 50)
p5 <- ggplot(pdat,aes(x = iter,y = y,color = init)) +
  geom_line(size = 0.75) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values = c("dodgerblue","darkblue","darkorange")) +
  labs(x = "iteration",y = "log-posterior difference") +
  theme_cowplot(font_size = 10)
print(p5)

# All three runs arrive at very similiar solutions, but maptpx finds
# the solution more quickly with the SCD better initialization, or
# after running more (120) iterations of EM for Poisson NMF.
# 
# Next, we turn to the problem of fitting an LDA model to the same
# data. 
# 
# We perform 250 iterations of variational EM, initializing the LDA
# model fits using the MLEs computed above.
lda0 <- run_lda(X,fit0,numiter = 400)
lda1 <- run_lda(X,fit1,numiter = 400)
lda2 <- run_lda(X,fit2,numiter = 400)

# Although the LDA fitting problem is different---we are now fitting a
# (approximate) posterior distribution, and so the estimates are
# approximate posterior means rather than MLE---initializing the LDA
# fit using the MLEs greatly improves the LDA model fitting, as we
# will see from this next plot: even after 400 iterations, variational
# EM without a good initialization does not quite achieve the quality
# of the LDA model fits initialized using the EM and SCD estimates.
pdat <- rbind(data.frame(iter = 1:400,elbo = lda0@logLiks,init = "em-20"),
              data.frame(iter = 1:400,elbo = lda1@logLiks,init = "em-120"),
              data.frame(iter = 1:400,elbo = lda2@logLiks,init = "scd"))
pdat <- transform(pdat,elbo = max(elbo) - elbo + 0.1)
p6 <- ggplot(pdat,aes(x = iter,y = elbo,color = init)) +
  geom_line(size = 0.75) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values = c("darkblue","dodgerblue","darkorange")) +
  labs(x = "iteration",y = "ELBO difference") +
  theme_cowplot(font_size = 10)
print(p6)

stop()

# Fit the LDA model, this time while simultaneously estimating the
# Dirichlet prior on the topic proportions.
lda_eb0 <- run_lda(X,fit0,numiter = 400,estimate.alpha = TRUE)
lda_eb1 <- run_lda(X,fit1,numiter = 400,estimate.alpha = TRUE)
lda_eb2 <- run_lda(X,fit2,numiter = 400,estimate.alpha = TRUE)

# The initial fit provided by the SCD estimates are initially much
# worse than before, when we fixed alpha = 1, but putting more initial
# effort into computing maximum-likelihood estimates, either using EM
# and SCD, pays off because the variational EM rapidly identifies much
# better fits.
pdat <- rbind(data.frame(iter = 1:400,elbo = lda_eb0@logLiks,init = "em-20"),
              data.frame(iter = 1:400,elbo = lda_eb1@logLiks,init = "em-120"),
              data.frame(iter = 1:400,elbo = lda_eb2@logLiks,init = "scd"))
pdat <- transform(pdat,elbo = max(elbo) - elbo + 0.1)
p7 <- ggplot(pdat,aes(x = iter,y = elbo,color = init)) +
  geom_line(size = 0.75) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values = c("darkblue","dodgerblue","darkorange")) +
  labs(x = "iteration",y = "ELBO difference") +
  theme_cowplot(font_size = 10)
print(p7)

# The LDA fit initialized using the SCD estimates actually yields the
# most sparsity-enducing prior (smaller values of the Dirichlet
# parameter alpha encourage more sparsity in the topic proportions).
print(lda_eb0@alpha)
print(lda_eb1@alpha)
print(lda_eb2@alpha)

# Although the "em-20" variational EM run hasn't quite obtained as
# good as solution as the other runs after 400 iterations, it appears
# to be approaching the same solution, and indeed we confirm that the
# estimates of the topic proportions are nearly the same from all
# three runs.
p8 <- loadings_scatterplot(lda_eb0@gamma,lda_eb2@gamma,topic_colors,
                           "em-20 init","scd init")
print(p8)

# Next we will see an example in which the EM updates fail to make
# reasonable progress.
#
# CORRELATED TOPICS SCENARIO
# The count data in this second example are simulated as before, with
# one difference: by setting s_56 = s_56 = 8, the mixture proportions
# for topics 5 and 4 are no longer close to orthogonal.
set.seed(1)
S[5,6] <- 8
S[6,5] <- 8
L <- simulate_loadings(n,k,S)
X <- simulate_multinom_counts(L,F,s)
X <- X[,colSums(X > 0) > 0]

# Compare this Structure plot to the one above---there is more mixing of
# topics 3 and 4.
p9 <- simdata_structure_plot(L,topic_colors)
print(p9)

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
plot_grid(p10,p11)

# This large difference in likelihood is not due to a trivial difference
# in solution---for example, there are many large differences in the
# topic proportion estimates.
p12 <- loadings_scatterplot(fit1$L,fit2$L,topic_colors,"em","scd")
print(p12)

# Most of the samples contributing to the large difference in likehood
# are samples generated from combinations of topics 5 and 6 (the X and Y
# axes in this scatterplot show the per-sample log-likelihoods).
pdat <- data.frame(x = loglik_multinom_topic_model(X,fit1),
                   y = loglik_multinom_topic_model(X,fit2))
ggplot(pdat,aes(x = x,y = y,fill = L[,5] + L[,6])) +
  geom_point(color = "white",shape = 21,size = 1.75) +
  geom_abline(intercept = 0,slope = 1,color = "black",linetype = "dotted") +
  scale_fill_gradient(low = "skyblue",high = "orangered") +
  xlim(-700,-100) +
  ylim(-700,-100) +
  labs(x = "em",y = "scd",fill = "topic 5 + 6") +
  theme_cowplot(font_size = 10)

# These results suggest that the EM algorithm may perform poorly in
# settings where the topics are correlated, even if the correlations are
# modest.

# Given the difficulties faced by EM here, let's see whether
# maptpx---which attempts to improve over EM with a quasi-Newton
# acceleration scheme---fares better. As before, we initialize the
# maptpx optimization using the estimates obtained by running the
# Poisson NMF algorithms from above.
maptpx0 <- maptpx::topics(X,k,shape = 1,initopics = fit0$F,omega = fit0$L,
                          tol = 1e-15,tmax = 500,ord = FALSE,verb = 0)
maptpx1 <- maptpx::topics(X,k,shape = 1,initopics = fit1$F,omega = fit1$L,
                          tol = 1e-15,tmax = 500,ord = FALSE,verb = 0)
maptpx2 <- maptpx::topics(X,k,shape = 1,initopics = fit2$F,omega = fit2$L,
                          tol = 1e-15,tmax = 500,ord = FALSE,verb = 0)

# This plot shows the improvement in the maptpx solutions over
# time. Clearly, maptpx, like EM, gets "stuck" in a state of very slow
# progress, and benefits greatly from being initialized with the SCD
# estimates to arrive at a much better solution.
pdat <- rbind(data.frame(iter = 1:length(maptpx0$progress),
                         y    = maptpx0$progress,
                         init = "em-20"),
              data.frame(iter = 1:length(maptpx1$progress),
						 y    = maptpx1$progress,
						 init = "em-1000"),
              data.frame(iter = 1:length(maptpx2$progress),
						 y    = maptpx2$progress,
						 init = "scd"))
pdat <- transform(pdat,y = max(y) - y + 0.1)
p13 <- ggplot(pdat,aes(x = iter,y = y,color = init)) +
  geom_line(size = 0.75) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values = c("dodgerblue","darkblue","darkorange")) +
  labs(x = "iteration",y = "log-posterior difference") +
  theme_cowplot(font_size = 10)
print(p13)

# Let's now see how this relates to fitting an LDA model,
lda0 <- run_lda(X,fit0,numiter = 400)
lda1 <- run_lda(X,fit1,numiter = 400)
lda2 <- run_lda(X,fit2,numiter = 400)

# These plots show the improvement in the objective (the ELBO) over time.
pdat <- rbind(data.frame(iter = 1:400,elbo = lda0@logLiks,init = "none"),
              data.frame(iter = 1:400,elbo = lda1@logLiks,init = "em"),
              data.frame(iter = 1:400,elbo = lda2@logLiks,init = "scd"))
pdat1 <- subset(pdat,init != "scd")
pdat2 <- transform(pdat,elbo = max(elbo) - elbo + 0.1)
p14 <- ggplot(pdat1,aes(x = iter,y = elbo,color = init)) +
  geom_line(size = 0.75) +
  scale_color_manual(values=c("darkblue","dodgerblue","darkorange"))+
  labs(x = "iteration",y = "ELBO") +
  theme_cowplot(font_size = 10)
p15 <- ggplot(pdat2,aes(x = iter,y = elbo,color = init)) +
  geom_line(size = 0.75) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values=c("darkblue","dodgerblue","darkorange"))+
  labs(x = "iteration",y = "ELBO difference") +
  theme_cowplot(font_size = 10)
print(plot_grid(p14,p15))

# In this second example, the SCD estimates provide by far the best
# initialization of the LDA model fit.

# Does initializing with the SCD estimates also work well when we want
# to estimate alpha? Let's see.
lda_eb0 <- run_lda(X,fit0,numiter = 400,estimate.alpha = TRUE)
lda_eb1 <- run_lda(X,fit1,numiter = 400,estimate.alpha = TRUE)
lda_eb2 <- run_lda(X,fit2,numiter = 400,estimate.alpha = TRUE)

# This plot shows the improvement in the objective (the ELBO) over time.
pdat <- rbind(data.frame(iter = 1:400,elbo = lda_eb0@logLiks,init = "none"),
              data.frame(iter = 1:400,elbo = lda_eb1@logLiks,init = "em"),
              data.frame(iter = 1:400,elbo = lda_eb2@logLiks,init = "scd"))
pdat1 <- subset(pdat,init != "scd")
pdat2 <- transform(pdat,elbo = max(elbo) - elbo + 0.1)
p16 <- ggplot(pdat1,aes(x = iter,y = elbo,color = init)) +
  geom_line(size = 0.75) +
  scale_color_manual(values=c("darkblue","dodgerblue","darkorange"))+
  labs(x = "iteration",y = "ELBO") +
  theme_cowplot(font_size = 10)
p17 <- ggplot(pdat2,aes(x = iter,y = elbo,color = init)) +
  geom_line(size = 0.75) +
  scale_y_continuous(trans = "log10") +
  scale_color_manual(values=c("darkblue","dodgerblue","darkorange"))+
  labs(x = "iteration",y = "ELBO difference") +
  theme_cowplot(font_size = 10)
print(plot_grid(p16,p17))

# Again, we see that putting more initial effort into computing
# maximum-likelihood estimates pays off because the variational EM
# rapidly identifies a much better fit.

# The LDA fit initialized using the SCD estimates yields a more
# sparsity-enducing prior (smaller values of the Dirichlet parameter
# alpha encourage more sparsity in the topic proportions).
print(lda_eb0@alpha)
print(lda_eb1@alpha)
print(lda_eb2@alpha)
