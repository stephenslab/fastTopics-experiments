#!/bin/bash

#SBATCH --partition=broadwl
#SBATCH --account=pi-mstephens
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=36:00:00

# This script allocates computing resources (CPUs, memory), loads R,
# and runs run_lda.R. See run_lda_all.sh for examples illustrating how
# to use this script.
#
# NOTES: 
# 
# (a) .libPaths()[1] should be "/home/pcarbo/R_libs"
#
# (b) Change "mem" to 32G for pbmc_68k.RData.
#

# Get the command-line arguments.
DAT=${1}
INITFILE=${2}
echo dat=${DAT}
echo initfile=${INITFILE}
DATFILE=../data/${DAT}.RData
INITFILE=../output/${INITFILE}.rds

# For reproducibility, I add version numbers to the "module load"
# calls.
module load R/3.5.1

# Run the R script.
export OPENBLAS_NUM_THREADS=1
./run_lda.R --counts ${DATFILE} --init ${INITFILE} 
