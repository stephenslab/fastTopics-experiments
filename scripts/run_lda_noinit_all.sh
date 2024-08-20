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

# Run LDA on the nips data.
#
#                     data  k
sbatch ${MAIN_SCRIPT} nips  2
sbatch ${MAIN_SCRIPT} nips  3
sbatch ${MAIN_SCRIPT} nips  4
sbatch ${MAIN_SCRIPT} nips  5
sbatch ${MAIN_SCRIPT} nips  5
sbatch ${MAIN_SCRIPT} nips  6
sbatch ${MAIN_SCRIPT} nips  7
sbatch ${MAIN_SCRIPT} nips  8
sbatch ${MAIN_SCRIPT} nips  9
sbatch ${MAIN_SCRIPT} nips 10
sbatch ${MAIN_SCRIPT} nips 11
sbatch ${MAIN_SCRIPT} nips 12

# Run LDA on the droplet data.
#
#                     data     k
sbatch ${MAIN_SCRIPT} droplet  2
sbatch ${MAIN_SCRIPT} droplet  3
sbatch ${MAIN_SCRIPT} droplet  4
sbatch ${MAIN_SCRIPT} droplet  5
sbatch ${MAIN_SCRIPT} droplet  5
sbatch ${MAIN_SCRIPT} droplet  6
sbatch ${MAIN_SCRIPT} droplet  7
sbatch ${MAIN_SCRIPT} droplet  8
sbatch ${MAIN_SCRIPT} droplet  9
sbatch ${MAIN_SCRIPT} droplet 10
sbatch ${MAIN_SCRIPT} droplet 11
sbatch ${MAIN_SCRIPT} droplet 12
