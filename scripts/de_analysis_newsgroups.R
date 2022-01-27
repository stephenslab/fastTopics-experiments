# TO DO: Explain here what this script does, and how to use it.
#
# sinteractive -p broadwl -c 20 --mem=8G --time=2:00:00
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
                  control = list(ns = 1000,nc = 20,nsplit = 200))
t1 <- proc.time()
timing <- t1 - t0
cat(sprintf("Computation took %0.2f seconds.\n",timing["elapsed"]))

# Save the results.
save(list = "de",file = "de-newsgroups.RData")
resaveRdaFiles("de-newsgroups.RData")
