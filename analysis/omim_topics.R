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

# Inspecting the topics:
k <- 1
L <- poisson2multinom(tm)$L
F <- poisson2multinom(tm)$F
i <- head(order(L[,k],decreasing = TRUE),n = 20)
j <- which(F[,k] > apply(F[,-k],1,max))
j <- head(j[order(F[j,k],decreasing = TRUE)],n = 30)
keywords <- rownames(F)[j]
dat <- data.frame(L     = L[,k],
                  mim   = meta_data$mim,
                  title = substr(meta_data$title,1,60))
cat("Topic ",k,":\n",sep = "")
print(format(dat[i,],justify = "left"),
      row.names = FALSE)
cat("keywords:\n")
print(keywords,quote = FALSE)

