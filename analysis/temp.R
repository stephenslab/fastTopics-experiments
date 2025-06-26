control$extrapolate <- FALSE
fit_em  <- fit_poisson_nmf(counts,fit0 = fit0,numiter = 100,method = "em",
                           control = control,verbose = "none")
