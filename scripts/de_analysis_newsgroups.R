# TO DO: Explain here what this script does, and how to use it.
library(Matrix)
library(fastTopics)
library(ggplot2)
library(cowplot)
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
                  control = list(ns = 10000,nc = 20,nsplit = 200))
t1 <- proc.time()
timing <- t1 - t0
cat(sprintf("Computation took %0.2f seconds.\n",timing["elapsed"]))

