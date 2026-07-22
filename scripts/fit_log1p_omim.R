library(tools)
library(Matrix)
library(log1pNMF)
load("../data/omim.RData")
set.seed(1)
k <- 10
s <- Matrix::rowSums(counts)
s <- s/mean(s)
fit_log1p <- fit_poisson_log1p_nmf(counts,k,s,cc = 1,loglik = "approx",
                                   init_method = "rank1",
                                   control = list(maxiter = 20,
                                                  verbose = TRUE))
# Save the model fit to an .Rdata file.
save(list = "fit_log1p",file = "omim_log1p_k=40.RData")
resaveRdaFiles("omim_log1p_k=40.RData")
