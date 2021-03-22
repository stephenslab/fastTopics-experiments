fit4$loss <- (sum(X*log(X + 1e-15) - X)
              - (fit4$progress[21:60,"loglik"]
                 - sum(fastTopics:::loglik_poisson_const(X))))/(100*200)
y0 <- min(c(fit1$mkl,fit2$mkl,fit3$obj,fit4$loss))
y1 <- diff(range(c(fit1$mkl,fit2$mkl,fit3$obj,fit4$loss)))
iter <- 1:40
plot(iter,fit1$mkl - y0,type = "l",col = "darkblue",lwd = 2,
     xlab = "iteration",ylab = "loss",ylim = c(0,y1))
points(iter,fit1$mkl - y0,col = "darkblue",pch = 20,cex = 1)
lines(iter,fit2$mkl - y0,col = "darkorange",lwd = 2)
points(iter,fit2$mkl - y0,col = "darkorange",pch = 20,cex = 1)
lines(iter,fit3$obj - y0,col = "dodgerblue",lwd = 1)
lines(iter,fit4$loss - y0,col = "magenta",lwd = 2)
points(iter,fit4$loss - y0,col = "magenta",pch = 20,cex = 1)
