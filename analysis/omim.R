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

