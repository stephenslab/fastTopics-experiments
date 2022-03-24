#! /usr/bin/env Rscript
#
# Run maptpx on a data set in which the maptpx model parameters are
# initialized using a topic model fit using fastTopics.
#
# NOTES:
# - For newsgroups, try with 8 GB and 4 CPUs.
#
# countsfile <- "../data/newsgroups.RData"
# pnmf_file  <- "../output/newsgroups/rds/fit-newsgroups-em-k=10.rds"
# outfile    <- "maptpx-newsgroups-em-k=10.rds"
# tmax       <- 2500
#

# Load a few packages.
library(optparse)
library(Matrix)
library(maptpx)
library(fastTopics)

# Process the command-line arguments.
parser <- OptionParser()
parser <- add_option(parser,"--counts",type="character",default="counts.RData")
parser <- add_option(parser,"--fit",type = "character",default="fit.rds")
parser <- add_option(parser,c("--out","-o"),type="character",default="out.rds")
parser <- add_option(parser,"--tmax",type="integer",default=1000)
out    <- parse_args(parser)
countsfile <- out$counts
pnmf_file  <- out$fit
outfile    <- out$out
tmax       <- out$tmax
rm(parser,out)

# Initialize the sequence of pseudorandom numbers.
set.seed(1)

# LOAD DATA
# ---------
# Load the previously prepared count data.
cat(sprintf("Loading data from %s.\n",countsfile))
load(countsfile)
cat(sprintf("Loaded %d x %d counts matrix.\n",nrow(counts),ncol(counts)))

# LOAD POISSON NMF FIT
# --------------------
# Load the Poisson NMF model previously fitted using fastTopics.
cat(sprintf("Loading Poisson NMF model from %s\n",pnmf_file))
fit0 <- readRDS(pnmf_file)$fit
fit0 <- poisson2multinom(fit0)
k    <- ncol(fit0$F)

# RUN MAPTPX
# ----------
# Now we are ready to perform MAP estimation of F, L using maptpx.
t0 <- proc.time()
maptpx <- topics(counts,k,shape = 1,initopics = fit0$F,omega = fit0$L,
                 tol = 1e-15,tmax = tmax,ord = FALSE,verb = 1)
t1 <- proc.time()
timing <- t1 - t0
cat(sprintf("Computation took %0.2f seconds.\n",timing["elapsed"]))

# SAVE RESULTS
# ------------
cat("Saving results.\n")
saveRDS(maptpx,file = outfile)

# SESSION INFO
# ------------
print(sessionInfo())
