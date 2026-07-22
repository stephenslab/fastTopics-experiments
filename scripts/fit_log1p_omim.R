# sinteractive -p mstephens --mem=16G -c 8 --nodelist=midway2-0440 \
#   --time=12:00:00
# module load R/4.2.0
# export OMP_NUM_THREADS=8
# export OPENBLAS_NUM_THREADS=1
# .libPaths()[1]
# /home/pcarbo/R_libs_4_20
library(tools)
library(Matrix)
library(log1pNMF) # 0.1.7
load("../data/omim.RData")
set.seed(1)
k <- 40
s <- Matrix::rowSums(counts)
s <- s/mean(s)
fit_log1p <- fit_poisson_log1p_nmf(counts,k,s,cc = 1,loglik = "approx",
                                   init_method = "random",
                                   control = list(maxiter = 200,
                                                  threads = 8,
                                                  verbose = TRUE))
# Save the model fit to an .Rdata file.
save(list = "fit_log1p",file = "omim_log1p_k=40.RData")
resaveRdaFiles("omim_log1p_k=40.RData")
