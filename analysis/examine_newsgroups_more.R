k <- 1
dat <- data.frame(word = colnames(counts),
                    x  = exp(apply(lda2@beta[-k,],2,max)),
                    y1 = exp(lda1@beta[k,]),
                    y2 = exp(lda2@beta[k,]))
subset(transform(dat,r = y2/y1),
       x > 1e-6 & y2/x > 5)

k <- 9
dat <- data.frame(word = colnames(counts),
                    x  = exp(apply(lda2@beta[-k,],2,max)),
                    y1 = exp(lda1@beta[k,]),
                    y2 = exp(lda2@beta[k,]))
subset(transform(dat,r = y2/y1),
       x < 1e-5 & y2 > 1e-3)

k <- 8
dat <- data.frame(word = colnames(counts),
                    x  = exp(apply(lda2@beta[-k,],2,max)),
                    y1 = exp(lda1@beta[k,]),
                    y2 = exp(lda2@beta[k,]))
subset(dat,x < 1e-5 & y2 > 5e-4)
