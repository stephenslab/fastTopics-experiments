library(tools)
library(fastTopics)
load("../data/omim.RData")
set.seed(1)
k <- 40
tm <- fit_poisson_nmf(counts,k = k,init.method = "random",method = "em",
                      numiter = 20,verbose = "detailed",
                      control = list(numiter = 4,nc = 4,extrapolate = FALSE))
tm <- fit_poisson_nmf(counts,fit0 = tm,method = "scd",numiter = 100,
                      control = list(numiter = 4,nc = 4,extrapolate = FALSE),
                      verbose = "detailed")
tm <- fit_poisson_nmf(counts,fit0 = tm,method = "scd",numiter = 100,
                      control = list(numiter = 4,nc = 4,extrapolate = TRUE),
                      verbose = "detailed")
save(list = "tm",file = "omim_topics_k=40.RData")
resaveRdaFiles("omim_topics_k=40.RData")
