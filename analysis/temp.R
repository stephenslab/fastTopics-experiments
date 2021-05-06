# devtools::load_all("~/git/maptpx")
fit3 <- maptpx::topics(X,k,shape = 1,initopics = fit2$F,omega = fit2$L,
                       tol = 1e-8,tmax = 1000,ord = FALSE,verb = 2)
plot(fit2$L,fit3$omega,pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
