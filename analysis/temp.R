# Top words for topic 1 in newsgroups data, K = 10.
n   <- colSums(counts)
lfc <- log10(fit$F[,1]/apply(fit$F[,-1],1,max))
i   <- which(n > 20)
print(data.frame(lfc = head(sort(lfc[i],decreasing = TRUE),n = 20)),
      digits = 2)
