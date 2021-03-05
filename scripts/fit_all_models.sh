#!/bin/bash

# The shell commands below will submit Slurm jobs to perform the
# Poisson NMF model fitting for all single-cell RNA-seq data sets, and
# for different choices of the model parameters and optimization
# settings.
SCRIPT_PREFIT=prefit_poisson_nmf.sbatch
SCRIPT_FIT=fit_poisson_nmf.sbatch

# "Pre-fit" factorizations to the nips data.
#                       data        k    n outfile
sbatch ${SCRIPT_PREFIT} nips.RData  2 1000 prefit-nips-k=2
sbatch ${SCRIPT_PREFIT} nips.RData  3 1000 prefit-nips-k=3
sbatch ${SCRIPT_PREFIT} nips.RData  4 1000 prefit-nips-k=4
sbatch ${SCRIPT_PREFIT} nips.RData  5 1000 prefit-nips-k=5
sbatch ${SCRIPT_PREFIT} nips.RData  6 1000 prefit-nips-k=6
sbatch ${SCRIPT_PREFIT} nips.RData  7 1000 prefit-nips-k=7
sbatch ${SCRIPT_PREFIT} nips.RData  8 1000 prefit-nips-k=8
sbatch ${SCRIPT_PREFIT} nips.RData  9 1000 prefit-nips-k=9
sbatch ${SCRIPT_PREFIT} nips.RData 10 1000 prefit-nips-k=10
sbatch ${SCRIPT_PREFIT} nips.RData 11 1000 prefit-nips-k=11
sbatch ${SCRIPT_PREFIT} nips.RData 12 1000 prefit-nips-k=12

# "Pre-fit" factorizations to the newsgroups data.
#                       data              k    n outfile
sbatch ${SCRIPT_PREFIT} newsgroups.RData  2 1000 prefit-newsgroups-k=2
sbatch ${SCRIPT_PREFIT} newsgroups.RData  3 1000 prefit-newsgroups-k=3
sbatch ${SCRIPT_PREFIT} newsgroups.RData  4 1000 prefit-newsgroups-k=4
sbatch ${SCRIPT_PREFIT} newsgroups.RData  5 1000 prefit-newsgroups-k=5
sbatch ${SCRIPT_PREFIT} newsgroups.RData  6 1000 prefit-newsgroups-k=6
sbatch ${SCRIPT_PREFIT} newsgroups.RData  7 1000 prefit-newsgroups-k=7
sbatch ${SCRIPT_PREFIT} newsgroups.RData  8 1000 prefit-newsgroups-k=8
sbatch ${SCRIPT_PREFIT} newsgroups.RData  9 1000 prefit-newsgroups-k=9
sbatch ${SCRIPT_PREFIT} newsgroups.RData 10 1000 prefit-newsgroups-k=10
sbatch ${SCRIPT_PREFIT} newsgroups.RData 11 1000 prefit-newsgroups-k=11
sbatch ${SCRIPT_PREFIT} newsgroups.RData 12 1000 prefit-newsgroups-k=12
