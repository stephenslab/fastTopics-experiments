#!/bin/bash

#SBATCH --partition=jnovembre
#SBATCH --account=pi-jnovembre
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=4:00:00

# This script allocates computing resources (CPUs, memory), loads R,
# and executes the R script run_maptpx.R. See run_maptpx_all.sh for
# examples illustrating how to use this script.

# Get the command-line arguments.
DAT=${1}
INITFILE=${2}
OUTFILE=${3}
TMAX=${4}
echo dat=${DAT}
echo initfile=${INITFILE}
echo outfile=${OUTFILE}
echo tmax=${NUMITER}

DATFILE=../data/${DAT}.RData
INITFILE=../output/${DAT}/rds/${INITFILE}.rds

# For reproducibility, I add version numbers to the "module load" calls.
module load R/3.5.1

# Run the R script.
echo "Running run_maptpx.R"
export OPENBLAS_NUM_THREADS=4
./run_maptpx.R --counts ${DATFILE} --init ${INITFILE} --tmax ${TMAX} \ 
  -o ${OUTFILE}.rds > ${OUTFILE}.Rout
