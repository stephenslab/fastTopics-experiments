# Small script to generate a synthetic data set that should present
# more of a challenge for the optimization methods.
library(fastTopics)
library(mvtnorm)
library(cowplot)
source("../code/smallsim_functions.R")

# Simulate the data set.
set.seed(1)
n <- 100
m <- 400
k <- 6
S <- 5*diag(k) - 1
upper.tri(S)
for (i in 1:5) {
  S[i,i+1] <- 1
  S[i+1,i] <- 1
}
F <- simulate_factors(m,k)
L <- simulate_loadings(n,k,S)
s <- simulate_sizes(n)
X <- simulate_multinom_counts(L,F,s)
X <- X[,colSums(X > 0) > 0]

# Visualize the topic proportions in a Structure plot.
topic_colors <- c("dodgerblue","darkorange","forestgreen","darkblue",
                  "gold","skyblue")
fit <- list(L = L)
class(fit) <- c("multinom_topic_model_fit","list")
y <- apply(L,1,which.max)
y <- rank(y,ties.method = "random")
y <- qqnorm(y,plot.it = FALSE)$x
p1 <- structure_plot(fit,loadings_order = order(y),topics = 1:k,
                     colors = topic_colors)

# Fit the multinomial topic model to the simulated data using the EM
# updates, and using the SCD updates.
numiter <- 1000
control <- list(extrapolate = FALSE,numiter = 4)
fit0 <- fit_poisson_nmf(X,k,numiter = 20,method = "em")
fit1 <- fit_poisson_nmf(X,fit0 = fit0,numiter = numiter,method = "em",
                        control = list(extrapolate = FALSE,numiter = 4))
fit2 <- fit_poisson_nmf(X,fit0 = fit0,numiter = numiter,method = "scd",
                        control = list(extrapolate = TRUE,numiter = 4))

# Plot the improvement in the solution over time; these two plots show
# the evolution of the log-likelihood and the KKT residuals.
p2 <- plot_progress(list(em = fit1,scd = fit2),x = "iter",y = "loglik",
                    add.point.every = 50)
p3 <- plot_progress(list(em = fit1,scd = fit2),x = "iter",y = "res",
                    add.point.every = 50)
print(plot_grid(p2,p3))

# Save the count data, and the parameters of the multinomial topic
# model used to simulate these data.
save(list = c("F","L","s","X"),file = "sim_hard.RData")
