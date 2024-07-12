#!/bin/bash

# The shell commands below will submit Slurm jobs to run LDA for all
# data sets, and for different choices of K and initialization.
SCRIPT=run_lda.sbatch

# Run LDA on newsgroups data.
#
#                data       initfile
sbatch ${SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=10
