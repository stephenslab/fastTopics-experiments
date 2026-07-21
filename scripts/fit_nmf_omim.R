library(tools)
library(Matrix)
library(ebnm)
library(flashier)
library(singlecelljamboreeR)
load("../data/omim.RData")
set.seed(1)
k <- 40

# Get the shifted log counts.
a <- 1
s <- rowSums(counts)
s <- s/mean(s)
shifted_log_counts <- log1p(counts/(a*s))
rm(counts)

# Set a lower bound on the variances.
n <- nrow(shifted_log_counts)
x <- rpois(1e7,1/n)
s1 <- sd(log(x + 1))

# Fit an NMF to the shifted log counts using flashier.
fl_nmf <- flashier_nmf(shifted_log_counts,k = k,greedy_init = TRUE,
                       var_type = 2,S = s1,verbose = 2,maxiter = 200)

# Save the model fit to an .Rdata file.
fl_nmf_ldf <- ldf(fl_nmf,type = "i")
save(list = "fl_nmf_ldf",file = "omim_nmf_k=40.RData")
resaveRdaFiles("omim_nmf_k=40.RData")
