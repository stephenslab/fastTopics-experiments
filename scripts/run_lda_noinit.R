#! /usr/bin/env Rscript
#
# Fit an LDA to one of the data sets.
#
# This script is intended to be run from the command-line shell, with
# options that are processed with the optparse package. For example,
# to run LDA on counts data test.RData, with k = 4, run this command:
#
#   ./run_lda_noinit.R --counts test.RData --k 4
#

# countsfile <- "../data/newsgroups.RData"
# outfile <- "lda-newsgroups-k=10.rds"
# k <- 10

# Load a few packages.
library(Matrix)
library(optparse)
library(tm)
library(topicmodels)

# Process the command-line arguments.
parser <- OptionParser()
parser <- add_option(parser,"--counts",type="character",default="counts.RData")
parser <- add_option(parser,"--k",type = "integer",default = 3)
out    <- parse_args(parser)
countsfile <- out$counts
k          <- out$k
outfile    <- tail(unlist(strsplit(countsfile,"/")),n = 1)
outfile    <- substr(outfile,1,nchar(outfile) - 6)
outfile    <- paste0("lda-",outfile,"-noinit-k=",k,".rds")
rm(parser,out)

# Initialize the sequence of pseudorandom numbers.
set.seed(1)

# LOAD DATA
# ---------
# Load the previously prepared count data.
cat(sprintf("Loading data from %s.\n",countsfile))
load(countsfile)
cat(sprintf("Loaded %d x %d counts matrix.\n",nrow(counts),ncol(counts)))

# RUN LDA
# -------
# Now we are ready to perform variational inference for the LDA model.
counts <- as.DocumentTermMatrix(counts,weighting = c("term frequency","tf"))
t0 <- proc.time()
lda <- LDA(counts,k,
           control = list(alpha = 1,
                          estimate.alpha = FALSE,
                          verbose = 1,
                          em = list(iter.max = 100,tol = 0),
                          var = list(iter.max = 20,tol = 0),
                          keep = 1))
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
