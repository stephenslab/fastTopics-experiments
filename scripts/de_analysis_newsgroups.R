# A short script used to perform the differential expression (DE)
# analysis using the multinomial topic model fitted to the newsgroups
# data, with k = 10 topics. These were the steps taken to load R and
# allocate computing resources for this analysis:
#
# sinteractive -p broadwl -c 10 --mem=8G --time=1:00:00
# module load R/3.5.1
#
library(tools)
library(Matrix)
library(fastTopics)
set.seed(1)

# Load the newsgroups data, and the K = 10 topic model fit.
# on the newsgroups data.
load("../data/newsgroups.RData")
load("../output/newsgroups/fits-newsgroups.RData")
fit <- fits[["fit-newsgroups-scd-ex-k=10"]]
fit <- poisson2multinom(fit)

# Perform the DE analysis.
t0 <- proc.time()
de <- de_analysis(fit,counts,pseudocount = 0.1,
                  control = list(ns = 10000,nc = 10,nsplit = 200))
t1 <- proc.time()
timing <- t1 - t0
cat(sprintf("Computation took %0.2f seconds.\n",timing["elapsed"]))

# Save the results.
save(list = "de",file = "de-newsgroups.RData")
resaveRdaFiles("de-newsgroups.RData")
