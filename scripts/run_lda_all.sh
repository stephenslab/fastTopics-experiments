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

# Run LDA on the nips data.
#
#                     data initfile
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=2
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=3
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=4
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=5
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=6
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=7
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=8
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=9
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=10
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=11
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-k=12
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=2
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=3
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=4
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=5
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=6
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=7
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=8
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=9
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=10
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=11
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-em-ex-k=12
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=2
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=3
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=4
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=5
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=6
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=7
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=8
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=9
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=10
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=11
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-k=12
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=2
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=3
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=4
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=5
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=6
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=7
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=8
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=9
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=10
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=11
sbatch ${MAIN_SCRIPT} nips nips/rds/fit-nips-scd-ex-k=12

# Run LDA on the droplet data.
#
#                     data    initfile
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=2
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=2
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=3
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=4
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=5
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=6
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=7
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=8
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=9
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=10
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=11
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-k=12
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=2
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=3
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=4
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=5
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=6
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=7
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=8
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=9
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=10
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=11
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-em-ex-k=12
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=2
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=3
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=4
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=5
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=6
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=7
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=8
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=9
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=10
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=11
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-k=12
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=2
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=3
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=4
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=5
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=6
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=7
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=8
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=9
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=10
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=11
sbatch ${MAIN_SCRIPT} droplet droplet/rds/fit-droplet-scd-ex-k=12

# Run LDA on the 68k pbmc data.
#                     data     initfile
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=2
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=3
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=4
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=5
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=6
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=7
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=8
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=9
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=10
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=11
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-k=12
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=2
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=3
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=4
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=5
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=6
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=7
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=8
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=9
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=10
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=11
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-em-ex-k=12
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=2
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=3
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=4
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=5
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=6
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=7
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=8
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=9
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=10
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=11
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-k=12
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=2
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=3
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=4
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=5
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=6
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=7
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=8
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=9
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=10
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=11
sbatch ${MAIN_SCRIPT} pbmc_68k pbmc68k/rds/fit-pbmc68k-scd-ex-k=12
