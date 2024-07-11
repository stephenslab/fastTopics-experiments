#! /usr/bin/env Rscript
#
# sinteractive -c 4 --mem=8G --time=24:00:00
# module load R/3.5.1
# R
# > .libPaths()[1]
# [1] "/home/pcarbo/R_libs"
#

# Load a few packages.
library(optparse)
library(Matrix)
library(tm)
library(topicmodels)
library(fastTopics)
source("../code/smallsim_functions.R")

# countsfile <- "../data/newsgroups.RData"
# countsfile <- "../data/nips.RData"
# initfile   <- "../output/newsgroups/rds/fit-newsgroups-scd-ex-k=10.rds"
# initfile   <- "../output/nips/rds/fit-nips-scd-ex-k=10.rds"
# outfile    <- "lda-newsgroups-em-k=10.rds"
countsfile <- "../data/droplet.RData"
initfile   <- "../output/droplet/rds/fit-droplet-scd-ex-k=10.rds"
numiter    <- 10

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
cat(sprintf("Loading Poisson NMF model from %s\n",initfile))
fit0 <- readRDS(initfile)$fit
fit0 <- poisson2multinom(fit0)
k    <- ncol(fit0$F)

# RUN LDA
# -------
# Now we are ready to perform variational inference for the LDA model.
#
# For the nips data with k = 10, this step takes roughly 40 s per
# iteration.
#
# For the newsgroups data with k = 10, this step takes roughly 70 s per
# iteration.
#
# For the droplet data with k = 10, this step takes roughly X s per
# iteration.
#
t0 <- proc.time()
lda <- run_lda(counts,fit0,numiter = numiter,estimate.alpha = FALSE,
               verbose = 1)
t1 <- proc.time()
timing <- t1 - t0
cat(sprintf("Computation took %0.2f seconds.\n",timing["elapsed"]))

# SAVE RESULTS
# ------------
# cat("Saving results.\n")
# saveRDS(lda,file = outfile)

# SESSION INFO
# ------------
# print(sessionInfo())
