#!/bin/bash

# The shell commands below will submit Slurm jobs to run LDA for all
# data sets, and for different choices of K and initialization.
MAIN_SCRIPT=run_lda.sbatch

# Run LDA on the newsgroups data.
#
#                     data       initfile
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=2
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=3
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=4
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=5
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=6
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=7
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=8
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=9
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=10
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=11
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-k=12
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=2
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=3
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=4
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=5
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=6
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=7
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=8
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=9
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=10
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=11
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-em-ex-k=12
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=9
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=2
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=3
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=4
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=5
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=6
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=7
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=8
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=9
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=10
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=11
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-k=12
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=2
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=3
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=4
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=5
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=6
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=7
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=8
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=10
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=11
sbatch ${MAIN_SCRIPT} newsgroups newsgroups/rds/fit-newsgroups-scd-ex-k=12
