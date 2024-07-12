#! /usr/bin/env Rscript
#
# Fit an LDA to one of the data sets.
#
# This script is intended to be run from the command-line shell, with
# options that are processed with the optparse package. For example,
# to fit a Poisson non-negative matrix factorization to counts data
# test.RData by running 500 SCD updates with extrapolation, 2 threads,
# with estimates initialized from test_prefit.rds, and with results
# saved to test_fit.rds, run this command:
#
#   ./fit_poisson_nmf.R --counts test.RData --prefit test_prefit.rds \
#     --method scd -n 500 --extrapolate --nc 2 -o test_fit.rds
#
# Running the script without specifying any options will fit a Poisson
# non-negative matrix factorization by running 1,000 EM updates
# without extrapolation, without multithreading, initialized to
# prefit.rds, and with results saved to out.rds.
#
# The input .RData file specified by --counts should contain a matrix,
# "counts", containing the count data that will be provided as input
# to fit_poisson_nmf. The input .rds file specified by --prefit should
# contain an object "fit", an output from a previous call to
# fit_poisson_nmf or init_poisson_nmf.
#

#
# sinteractive -c 4 --mem=8G --time=24:00:00 (for 68k PBMC data set)
# sinteractive -c 4 --mem=32G --time=24:00:00 (for other data sets)
# module load R/3.5.1
# R
# > .libPaths()[1]
# [1] "/home/pcarbo/R_libs"
#

# Load a few packages.
library(optparse)
library(Matrix)
library(fastTopics)
library(tm)
library(topicmodels)
source("../code/smallsim_functions.R")

# Process the command-line arguments.
# parser <- OptionParser()
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

# countsfile <- "../data/newsgroups.RData"
# countsfile <- "../data/nips.RData"
# countsfile <- "../data/droplet.RData"
# countsfile <- "../data/pbmc_68k.RData"
# initfile   <- "../output/newsgroups/rds/fit-newsgroups-scd-ex-k=10.rds"
# initfile   <- "../output/nips/rds/fit-nips-scd-ex-k=10.rds"
# initfile   <- "../output/droplet/rds/fit-droplet-scd-ex-k=10.rds"
# initfile   <- "../output/pbmc68k/rds/fit-pbmc68k-scd-ex-k=10.rds"

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
# For the nips data with k = 10, this step took roughly 40 s per
# iteration.
#
# For the newsgroups data with k = 10, this step took roughly 70 s per
# iteration.
#
# For the droplet data with k = 10, this step took roughly 6 min per
# iteration.
#
# For the 68k PBMC data with k = 10, this step took roughly 20 min
# per iteration.
#
t0 <- proc.time()
lda <- run_lda(counts,fit0,numiter = 10,estimate.alpha = FALSE,verbose = 1)
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
