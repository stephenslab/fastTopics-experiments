# Top genes for topic 6 in 68k PBMC data, K = 7.
n  <- colSums(counts)
i  <- which(n > 1000)
fc <- fit$F[,6]/apply(fit$F[,-6],1,max)
names(fc) <- genes$symbol
print(data.frame(fc = head(sort(fc[i],decreasing = TRUE),n = 40)),
      digits = 2)
