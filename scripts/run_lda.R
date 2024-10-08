#! /usr/bin/env Rscript
#
# Fit an LDA to one of the data sets.
#
# This script is intended to be run from the command-line shell, with
# options that are processed with the optparse package. For example,
# to run LDA on counts data test.RData, with estimates initialized
# from test.rds, run this
# command:
#
#   ./run_lda.R --counts test.RData --init test.rds
#

# Load a few packages.
library(optparse)
library(Matrix)
library(fastTopics)
library(tm)
library(topicmodels)
source("../code/smallsim_functions.R")

# Process the command-line arguments.
parser <- OptionParser()
parser <- add_option(parser,"--counts",type="character",default="counts.RData")
parser <- add_option(parser,"--init",type = "character",default="init.rds")
out    <- parse_args(parser)
countsfile <- out$counts
initfile   <- out$init
outfile    <- tail(unlist(strsplit(initfile,"/")),n = 1)
outfile    <- paste0("lda",substr(outfile,4,100))
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
cat(sprintf("Loading Poisson NMF model from %s\n",initfile))
fit0 <- readRDS(initfile)$fit
fit0 <- poisson2multinom(fit0)
k    <- ncol(fit0$F)

# RUN LDA
# -------
# Now we are ready to perform variational inference for the LDA model.
#
# For the 68k PBMC data with k = 10, this step took roughly 20 min
# per iteration.
#
t0 <- proc.time()
lda <- run_lda(counts,fit0,numiter = 100,estimate.alpha = FALSE,verbose = 1)
t1 <- proc.time()
timing <- t1 - t0
cat(sprintf("Computation took %0.2f seconds.\n",timing["elapsed"]))

# SAVE RESULTS
# ------------
cat("Saving results.\n")
saveRDS(list(lda = lda,timing = timing),outfile)

# SESSION INFO
# ------------
print(sessionInfo())
