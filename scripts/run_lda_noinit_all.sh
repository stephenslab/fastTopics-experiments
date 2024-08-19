#!/bin/bash

# The shell commands below will submit Slurm jobs to run LDA for all
# data sets, and for different choices of K.
MAIN_SCRIPT=run_lda_noinit.sbatch

# Run LDA on the newsgroups data.
#
#                     data        k
sbatch ${MAIN_SCRIPT} newsgroups  2
sbatch ${MAIN_SCRIPT} newsgroups  3
sbatch ${MAIN_SCRIPT} newsgroups  4
sbatch ${MAIN_SCRIPT} newsgroups  5
sbatch ${MAIN_SCRIPT} newsgroups  5
sbatch ${MAIN_SCRIPT} newsgroups  6
sbatch ${MAIN_SCRIPT} newsgroups  7
sbatch ${MAIN_SCRIPT} newsgroups  8
sbatch ${MAIN_SCRIPT} newsgroups  9
sbatch ${MAIN_SCRIPT} newsgroups 10
sbatch ${MAIN_SCRIPT} newsgroups 11
sbatch ${MAIN_SCRIPT} newsgroups 12
