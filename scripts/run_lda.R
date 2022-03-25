#! /usr/bin/env Rscript
#
# TO DO: Explain here briefly what this script is for.
#

# Load a few packages.
library(optparse)
library(Matrix)
library(tm)
library(topicmodels)
library(fastTopics)
source("../code/smallsim_functions.R")

# Initialize the sequence of pseudorandom numbers.
set.seed(1)

countsfile <- "../data/newsgroups.RData"
initfile   <- "../output/newsgroups/rds/fit-newsgroups-em-k=10.rds"
outfile    <- "lda-newsgroups-em-k=10.rds"
numiter    <- 20
est_alpha  <- FALSE

# LOAD DATA
# ---------
# Load the previously prepared count data.
cat(sprintf("Loading data from %s.\n",countsfile))
load(countsfile)
cat(sprintf("Loaded %d x %d counts matrix.\n",nrow(counts),ncol(counts)))

# LOAD POISSON NMF FIT
# --------------------
# Load the Poisson NMF model previously fitted using fastTopics.
cat(sprintf("Loading Poisson NMF model from %s\n",initfile))
fit0 <- readRDS(initfile)$fit
fit0 <- poisson2multinom(fit0)
k    <- ncol(fit0$F)

# RUN LDA
# -------
# Now we are ready to perform variational inference for the LDA model.
t0 <- proc.time()
lda <- run_lda(counts,fit0,numiter = numiter,estimate.alpha = est_alpha,
               verbose = 1)
t1 <- proc.time()
timing <- t1 - t0
cat(sprintf("Computation took %0.2f seconds.\n",timing["elapsed"]))

# SAVE RESULTS
# ------------
cat("Saving results.\n")
saveRDS(lda,file = outfile)

# SESSION INFO
# ------------
print(sessionInfo())
