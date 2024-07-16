# Compile the LDA runs for one data set into a single .RData file.
library(tools)
library(stringr)
library(tm)
library(topicmodels)

# Combine results from all files of the form lda-*.rds in this
# directory.
out.dir <- "../output/nips/rds"
  
# List all the RDS files containing the model fits.
files <- Sys.glob(file.path(out.dir,"lda-*.rds"))
n     <- length(files)

# Set up two data structures: "fits", a list used to store all the
# results; and "dat", a data frame summarizing the model parameters
# and optimization settings used to produce these fits.
fits   <- vector("list",n)
labels <- files
labels <- str_remove(labels,paste(out.dir,"/",sep = ""))
labels <- str_remove(labels,".rds")
names(fits) <- labels
dat <- data.frame(label       = labels,
                  k           = 0,
                  method      = "",
                  extrapolate = FALSE,
                  stringsAsFactors = FALSE)

# Load the results from the RDS files.
for (i in 1:n) {
  
  out                  <- readRDS(files[i])
  fits[[i]]            <- out$lda
  dat[i,"k"]           <- out$lda@k
  dat[i,"method"]      <- unlist(strsplit(labels[i],"-"))[3]
  dat[i,"extrapolate"] <- grepl("ex",labels[i],fixed = TRUE)
}

# Reorder the results in "fits" and "dat".
dat  <- transform(dat,method = factor(method,c("em","scd")))
i    <- with(dat,order(k,extrapolate,method))
dat  <- dat[i,]
fits <- fits[i]
rownames(dat) <- NULL

# Convert the "k" column to a factor.
dat <- transform(dat,k = factor(k))

# Save the combined results to an .RData file.
save(list = c("dat","fits"),
     file = "lda.RData")
resaveRdaFiles("lda.RData")
