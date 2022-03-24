#!/bin/bash

# The shell commands below will submit Slurm jobs to run maptpx on all
# the data sets, for different choices of k (the number of topics),
# and for different initializations of the model parameters.
SCRIPT_FIT=run_maptpx.sbatch

# Fit factorizations to the newsgroups data.
#                    data       init                   outfile                   tmax
sbatch ${SCRIPT_FIT} newsgroups fit-newsgroups-em-k=10 maptpx-newsgroups-em-k=10 20
