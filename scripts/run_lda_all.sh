#!/bin/bash

# The shell commands below will submit Slurm jobs to perform the
# Poisson NMF model fitting for all data sets, and for different
# choices of the model parameters and optimization settings.
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

# "Pre-fit" factorizations to the droplet data.
#                       data           k    n outfile
sbatch ${SCRIPT_PREFIT} droplet.RData  2 1000 prefit-droplet-k=2
sbatch ${SCRIPT_PREFIT} droplet.RData  3 1000 prefit-droplet-k=3
sbatch ${SCRIPT_PREFIT} droplet.RData  4 1000 prefit-droplet-k=4
sbatch ${SCRIPT_PREFIT} droplet.RData  5 1000 prefit-droplet-k=5
sbatch ${SCRIPT_PREFIT} droplet.RData  6 1000 prefit-droplet-k=6
sbatch ${SCRIPT_PREFIT} droplet.RData  7 1000 prefit-droplet-k=7
sbatch ${SCRIPT_PREFIT} droplet.RData  8 1000 prefit-droplet-k=8
sbatch ${SCRIPT_PREFIT} droplet.RData  9 1000 prefit-droplet-k=9
sbatch ${SCRIPT_PREFIT} droplet.RData 10 1000 prefit-droplet-k=10
sbatch ${SCRIPT_PREFIT} droplet.RData 11 1000 prefit-droplet-k=11
sbatch ${SCRIPT_PREFIT} droplet.RData 12 1000 prefit-droplet-k=12

# "Pre-fit" factorizations to the 68k pbmc data.
#                       data            k    n outfile
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData  2 1000 prefit-pbmc68k-k=2
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData  3 1000 prefit-pbmc68k-k=3
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData  4 1000 prefit-pbmc68k-k=4
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData  5 1000 prefit-pbmc68k-k=5
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData  6 1000 prefit-pbmc68k-k=6
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData  7 1000 prefit-pbmc68k-k=7
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData  8 1000 prefit-pbmc68k-k=8
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData  9 1000 prefit-pbmc68k-k=9
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData 10 1000 prefit-pbmc68k-k=10
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData 11 1000 prefit-pbmc68k-k=11
sbatch ${SCRIPT_PREFIT} pbmc_68k.RData 12 1000 prefit-pbmc68k-k=12

# Fit factorizations to nips data, with and without extrapolation.
#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  2 em     1000  no fit-nips-em-k=2
sbatch ${SCRIPT_FIT} nips  2 scd    1000  no fit-nips-scd-k=2
sbatch ${SCRIPT_FIT} nips  2 em     1000 yes fit-nips-em-ex-k=2
sbatch ${SCRIPT_FIT} nips  2 scd    1000 yes fit-nips-scd-ex-k=2
sbatch ${SCRIPT_FIT} nips  3 em     1000  no fit-nips-em-k=3
sbatch ${SCRIPT_FIT} nips  3 scd    1000  no fit-nips-scd-k=3
sbatch ${SCRIPT_FIT} nips  3 em     1000 yes fit-nips-em-ex-k=3
sbatch ${SCRIPT_FIT} nips  3 scd    1000 yes fit-nips-scd-ex-k=3
sbatch ${SCRIPT_FIT} nips  4 em     1000  no fit-nips-em-k=4
sbatch ${SCRIPT_FIT} nips  4 scd    1000  no fit-nips-scd-k=4
sbatch ${SCRIPT_FIT} nips  4 em     1000 yes fit-nips-em-ex-k=4
sbatch ${SCRIPT_FIT} nips  4 scd    1000 yes fit-nips-scd-ex-k=4
sbatch ${SCRIPT_FIT} nips  5 em     1000  no fit-nips-em-k=5
sbatch ${SCRIPT_FIT} nips  5 scd    1000  no fit-nips-scd-k=5
sbatch ${SCRIPT_FIT} nips  5 em     1000 yes fit-nips-em-ex-k=5
sbatch ${SCRIPT_FIT} nips  5 scd    1000 yes fit-nips-scd-ex-k=5

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  6 em     1000  no fit-nips-em-k=6
sbatch ${SCRIPT_FIT} nips  6 scd    1000  no fit-nips-scd-k=6
sbatch ${SCRIPT_FIT} nips  6 em     1000 yes fit-nips-em-ex-k=6
sbatch ${SCRIPT_FIT} nips  6 scd    1000 yes fit-nips-scd-ex-k=6
sbatch ${SCRIPT_FIT} nips  7 em     1000  no fit-nips-em-k=7
sbatch ${SCRIPT_FIT} nips  7 scd    1000  no fit-nips-scd-k=7
sbatch ${SCRIPT_FIT} nips  7 em     1000 yes fit-nips-em-ex-k=7
sbatch ${SCRIPT_FIT} nips  7 scd    1000 yes fit-nips-scd-ex-k=7
sbatch ${SCRIPT_FIT} nips  8 em     1000  no fit-nips-em-k=8
sbatch ${SCRIPT_FIT} nips  8 scd    1000  no fit-nips-scd-k=8
sbatch ${SCRIPT_FIT} nips  8 em     1000 yes fit-nips-em-ex-k=8
sbatch ${SCRIPT_FIT} nips  8 scd    1000 yes fit-nips-scd-ex-k=8
sbatch ${SCRIPT_FIT} nips  9 em     1000  no fit-nips-em-k=9
sbatch ${SCRIPT_FIT} nips  9 scd    1000  no fit-nips-scd-k=9
sbatch ${SCRIPT_FIT} nips  9 em     1000 yes fit-nips-em-ex-k=9
sbatch ${SCRIPT_FIT} nips  9 scd    1000 yes fit-nips-scd-ex-k=9

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips 10 em     1000  no fit-nips-em-k=10
sbatch ${SCRIPT_FIT} nips 10 scd    1000  no fit-nips-scd-k=10
sbatch ${SCRIPT_FIT} nips 10 em     1000 yes fit-nips-em-ex-k=10
sbatch ${SCRIPT_FIT} nips 10 scd    1000 yes fit-nips-scd-ex-k=10
sbatch ${SCRIPT_FIT} nips 11 em     1000  no fit-nips-em-k=11
sbatch ${SCRIPT_FIT} nips 11 scd    1000  no fit-nips-scd-k=11
sbatch ${SCRIPT_FIT} nips 11 em     1000 yes fit-nips-em-ex-k=11
sbatch ${SCRIPT_FIT} nips 11 scd    1000 yes fit-nips-scd-ex-k=11
sbatch ${SCRIPT_FIT} nips 12 em     1000  no fit-nips-em-k=12
sbatch ${SCRIPT_FIT} nips 12 scd    1000  no fit-nips-scd-k=12
sbatch ${SCRIPT_FIT} nips 12 em     1000 yes fit-nips-em-ex-k=12
sbatch ${SCRIPT_FIT} nips 12 scd    1000 yes fit-nips-scd-ex-k=12

# Fit factorizations to newsgroups data, with and without extrapolation.
#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  2 em     1000  no fit-newsgroups-em-k=2
sbatch ${SCRIPT_FIT} newsgroups  2 scd    1000  no fit-newsgroups-scd-k=2
sbatch ${SCRIPT_FIT} newsgroups  2 em     1000 yes fit-newsgroups-em-ex-k=2
sbatch ${SCRIPT_FIT} newsgroups  2 scd    1000 yes fit-newsgroups-scd-ex-k=2
sbatch ${SCRIPT_FIT} newsgroups  3 em     1000  no fit-newsgroups-em-k=3
sbatch ${SCRIPT_FIT} newsgroups  3 scd    1000  no fit-newsgroups-scd-k=3
sbatch ${SCRIPT_FIT} newsgroups  3 em     1000 yes fit-newsgroups-em-ex-k=3
sbatch ${SCRIPT_FIT} newsgroups  3 scd    1000 yes fit-newsgroups-scd-ex-k=3
sbatch ${SCRIPT_FIT} newsgroups  4 em     1000  no fit-newsgroups-em-k=4
sbatch ${SCRIPT_FIT} newsgroups  4 scd    1000  no fit-newsgroups-scd-k=4
sbatch ${SCRIPT_FIT} newsgroups  4 em     1000 yes fit-newsgroups-em-ex-k=4
sbatch ${SCRIPT_FIT} newsgroups  4 scd    1000 yes fit-newsgroups-scd-ex-k=4
sbatch ${SCRIPT_FIT} newsgroups  5 em     1000  no fit-newsgroups-em-k=5
sbatch ${SCRIPT_FIT} newsgroups  5 scd    1000  no fit-newsgroups-scd-k=5
sbatch ${SCRIPT_FIT} newsgroups  5 em     1000 yes fit-newsgroups-em-ex-k=5
sbatch ${SCRIPT_FIT} newsgroups  5 scd    1000 yes fit-newsgroups-scd-ex-k=5

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  6 em     1000  no fit-newsgroups-em-k=6
sbatch ${SCRIPT_FIT} newsgroups  6 scd    1000  no fit-newsgroups-scd-k=6
sbatch ${SCRIPT_FIT} newsgroups  6 em     1000 yes fit-newsgroups-em-ex-k=6
sbatch ${SCRIPT_FIT} newsgroups  6 scd    1000 yes fit-newsgroups-scd-ex-k=6
sbatch ${SCRIPT_FIT} newsgroups  7 em     1000  no fit-newsgroups-em-k=7
sbatch ${SCRIPT_FIT} newsgroups  7 scd    1000  no fit-newsgroups-scd-k=7
sbatch ${SCRIPT_FIT} newsgroups  7 em     1000 yes fit-newsgroups-em-ex-k=7
sbatch ${SCRIPT_FIT} newsgroups  7 scd    1000 yes fit-newsgroups-scd-ex-k=7
sbatch ${SCRIPT_FIT} newsgroups  8 em     1000  no fit-newsgroups-em-k=8
sbatch ${SCRIPT_FIT} newsgroups  8 scd    1000  no fit-newsgroups-scd-k=8
sbatch ${SCRIPT_FIT} newsgroups  8 em     1000 yes fit-newsgroups-em-ex-k=8
sbatch ${SCRIPT_FIT} newsgroups  8 scd    1000 yes fit-newsgroups-scd-ex-k=8
sbatch ${SCRIPT_FIT} newsgroups  9 em     1000  no fit-newsgroups-em-k=9
sbatch ${SCRIPT_FIT} newsgroups  9 scd    1000  no fit-newsgroups-scd-k=9
sbatch ${SCRIPT_FIT} newsgroups  9 em     1000 yes fit-newsgroups-em-ex-k=9
sbatch ${SCRIPT_FIT} newsgroups  9 scd    1000 yes fit-newsgroups-scd-ex-k=9

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups 10 em     1000  no fit-newsgroups-em-k=10
sbatch ${SCRIPT_FIT} newsgroups 10 scd    1000  no fit-newsgroups-scd-k=10
sbatch ${SCRIPT_FIT} newsgroups 10 em     1000 yes fit-newsgroups-em-ex-k=10
sbatch ${SCRIPT_FIT} newsgroups 10 scd    1000 yes fit-newsgroups-scd-ex-k=10
sbatch ${SCRIPT_FIT} newsgroups 11 em     1000  no fit-newsgroups-em-k=11
sbatch ${SCRIPT_FIT} newsgroups 11 scd    1000  no fit-newsgroups-scd-k=11
sbatch ${SCRIPT_FIT} newsgroups 11 em     1000 yes fit-newsgroups-em-ex-k=11
sbatch ${SCRIPT_FIT} newsgroups 11 scd    1000 yes fit-newsgroups-scd-ex-k=11
sbatch ${SCRIPT_FIT} newsgroups 12 em     1000  no fit-newsgroups-em-k=12
sbatch ${SCRIPT_FIT} newsgroups 12 scd    1000  no fit-newsgroups-scd-k=12
sbatch ${SCRIPT_FIT} newsgroups 12 em     1000 yes fit-newsgroups-em-ex-k=12
sbatch ${SCRIPT_FIT} newsgroups 12 scd    1000 yes fit-newsgroups-scd-ex-k=12

# Fit factorizations to droplet data, with and without extrapolation.
#                    data     k method    n  ex outfile
sbatch ${SCRIPT_FIT} droplet  2 em     1000  no fit-droplet-em-k=2
sbatch ${SCRIPT_FIT} droplet  2 scd    1000  no fit-droplet-scd-k=2
sbatch ${SCRIPT_FIT} droplet  2 em     1000 yes fit-droplet-em-ex-k=2
sbatch ${SCRIPT_FIT} droplet  2 scd    1000 yes fit-droplet-scd-ex-k=2
sbatch ${SCRIPT_FIT} droplet  3 em     1000  no fit-droplet-em-k=3
sbatch ${SCRIPT_FIT} droplet  3 scd    1000  no fit-droplet-scd-k=3
sbatch ${SCRIPT_FIT} droplet  3 em     1000 yes fit-droplet-em-ex-k=3
sbatch ${SCRIPT_FIT} droplet  3 scd    1000 yes fit-droplet-scd-ex-k=3
sbatch ${SCRIPT_FIT} droplet  4 em     1000  no fit-droplet-em-k=4
sbatch ${SCRIPT_FIT} droplet  4 scd    1000  no fit-droplet-scd-k=4
sbatch ${SCRIPT_FIT} droplet  4 em     1000 yes fit-droplet-em-ex-k=4
sbatch ${SCRIPT_FIT} droplet  4 scd    1000 yes fit-droplet-scd-ex-k=4
sbatch ${SCRIPT_FIT} droplet  5 em     1000  no fit-droplet-em-k=5
sbatch ${SCRIPT_FIT} droplet  5 scd    1000  no fit-droplet-scd-k=5
sbatch ${SCRIPT_FIT} droplet  5 em     1000 yes fit-droplet-em-ex-k=5
sbatch ${SCRIPT_FIT} droplet  5 scd    1000 yes fit-droplet-scd-ex-k=5

#                    data     k method    n  ex outfile
sbatch ${SCRIPT_FIT} droplet  6 em     1000  no fit-droplet-em-k=6
sbatch ${SCRIPT_FIT} droplet  6 scd    1000  no fit-droplet-scd-k=6
sbatch ${SCRIPT_FIT} droplet  6 em     1000 yes fit-droplet-em-ex-k=6
sbatch ${SCRIPT_FIT} droplet  6 scd    1000 yes fit-droplet-scd-ex-k=6
sbatch ${SCRIPT_FIT} droplet  7 em     1000  no fit-droplet-em-k=7
sbatch ${SCRIPT_FIT} droplet  7 scd    1000  no fit-droplet-scd-k=7
sbatch ${SCRIPT_FIT} droplet  7 em     1000 yes fit-droplet-em-ex-k=7
sbatch ${SCRIPT_FIT} droplet  7 scd    1000 yes fit-droplet-scd-ex-k=7
sbatch ${SCRIPT_FIT} droplet  8 em     1000  no fit-droplet-em-k=8
sbatch ${SCRIPT_FIT} droplet  8 scd    1000  no fit-droplet-scd-k=8
sbatch ${SCRIPT_FIT} droplet  8 em     1000 yes fit-droplet-em-ex-k=8
sbatch ${SCRIPT_FIT} droplet  8 scd    1000 yes fit-droplet-scd-ex-k=8
sbatch ${SCRIPT_FIT} droplet  9 em     1000  no fit-droplet-em-k=9
sbatch ${SCRIPT_FIT} droplet  9 scd    1000  no fit-droplet-scd-k=9
sbatch ${SCRIPT_FIT} droplet  9 em     1000 yes fit-droplet-em-ex-k=9
sbatch ${SCRIPT_FIT} droplet  9 scd    1000 yes fit-droplet-scd-ex-k=9

#                    data     k method    n  ex outfile
sbatch ${SCRIPT_FIT} droplet 10 em     1000  no fit-droplet-em-k=10
sbatch ${SCRIPT_FIT} droplet 10 scd    1000  no fit-droplet-scd-k=10
sbatch ${SCRIPT_FIT} droplet 10 em     1000 yes fit-droplet-em-ex-k=10
sbatch ${SCRIPT_FIT} droplet 10 scd    1000 yes fit-droplet-scd-ex-k=10
sbatch ${SCRIPT_FIT} droplet 11 em     1000  no fit-droplet-em-k=11
sbatch ${SCRIPT_FIT} droplet 11 scd    1000  no fit-droplet-scd-k=11
sbatch ${SCRIPT_FIT} droplet 11 em     1000 yes fit-droplet-em-ex-k=11
sbatch ${SCRIPT_FIT} droplet 11 scd    1000 yes fit-droplet-scd-ex-k=11
sbatch ${SCRIPT_FIT} droplet 12 em     1000  no fit-droplet-em-k=12
sbatch ${SCRIPT_FIT} droplet 12 scd    1000  no fit-droplet-scd-k=12
sbatch ${SCRIPT_FIT} droplet 12 em     1000 yes fit-droplet-em-ex-k=12
sbatch ${SCRIPT_FIT} droplet 12 scd    1000 yes fit-droplet-scd-ex-k=12

# Fit factorizations to 68k pbmc data, with and without extrapolation.
#                    data      k method    n  ex outfile
sbatch ${SCRIPT_FIT} pbmc_68k  2 em     1000  no fit-pbmc68k-em-k=2
sbatch ${SCRIPT_FIT} pbmc_68k  2 scd    1000  no fit-pbmc68k-scd-k=2
sbatch ${SCRIPT_FIT} pbmc_68k  2 em     1000 yes fit-pbmc68k-em-ex-k=2
sbatch ${SCRIPT_FIT} pbmc_68k  2 scd    1000 yes fit-pbmc68k-scd-ex-k=2
sbatch ${SCRIPT_FIT} pbmc_68k  3 em     1000  no fit-pbmc68k-em-k=3
sbatch ${SCRIPT_FIT} pbmc_68k  3 scd    1000  no fit-pbmc68k-scd-k=3
sbatch ${SCRIPT_FIT} pbmc_68k  3 em     1000 yes fit-pbmc68k-em-ex-k=3
sbatch ${SCRIPT_FIT} pbmc_68k  3 scd    1000 yes fit-pbmc68k-scd-ex-k=3
sbatch ${SCRIPT_FIT} pbmc_68k  4 em     1000  no fit-pbmc68k-em-k=4
sbatch ${SCRIPT_FIT} pbmc_68k  4 scd    1000  no fit-pbmc68k-scd-k=4
sbatch ${SCRIPT_FIT} pbmc_68k  4 em     1000 yes fit-pbmc68k-em-ex-k=4
sbatch ${SCRIPT_FIT} pbmc_68k  4 scd    1000 yes fit-pbmc68k-scd-ex-k=4
sbatch ${SCRIPT_FIT} pbmc_68k  5 em     1000  no fit-pbmc68k-em-k=5
sbatch ${SCRIPT_FIT} pbmc_68k  5 scd    1000  no fit-pbmc68k-scd-k=5
sbatch ${SCRIPT_FIT} pbmc_68k  5 em     1000 yes fit-pbmc68k-em-ex-k=5
sbatch ${SCRIPT_FIT} pbmc_68k  5 scd    1000 yes fit-pbmc68k-scd-ex-k=5

#                    data      k method    n  ex outfile
sbatch ${SCRIPT_FIT} pbmc_68k  6 em     1000  no fit-pbmc68k-em-k=6
sbatch ${SCRIPT_FIT} pbmc_68k  6 scd    1000  no fit-pbmc68k-scd-k=6
sbatch ${SCRIPT_FIT} pbmc_68k  6 em     1000 yes fit-pbmc68k-em-ex-k=6
sbatch ${SCRIPT_FIT} pbmc_68k  6 scd    1000 yes fit-pbmc68k-scd-ex-k=6
sbatch ${SCRIPT_FIT} pbmc_68k  7 em     1000  no fit-pbmc68k-em-k=7
sbatch ${SCRIPT_FIT} pbmc_68k  7 scd    1000  no fit-pbmc68k-scd-k=7
sbatch ${SCRIPT_FIT} pbmc_68k  7 em     1000 yes fit-pbmc68k-em-ex-k=7
sbatch ${SCRIPT_FIT} pbmc_68k  7 scd    1000 yes fit-pbmc68k-scd-ex-k=7
sbatch ${SCRIPT_FIT} pbmc_68k  8 em     1000  no fit-pbmc68k-em-k=8
sbatch ${SCRIPT_FIT} pbmc_68k  8 scd    1000  no fit-pbmc68k-scd-k=8
sbatch ${SCRIPT_FIT} pbmc_68k  8 em     1000 yes fit-pbmc68k-em-ex-k=8
sbatch ${SCRIPT_FIT} pbmc_68k  8 scd    1000 yes fit-pbmc68k-scd-ex-k=8
sbatch ${SCRIPT_FIT} pbmc_68k  9 em     1000  no fit-pbmc68k-em-k=9
sbatch ${SCRIPT_FIT} pbmc_68k  9 scd    1000  no fit-pbmc68k-scd-k=9
sbatch ${SCRIPT_FIT} pbmc_68k  9 em     1000 yes fit-pbmc68k-em-ex-k=9
sbatch ${SCRIPT_FIT} pbmc_68k  9 scd    1000 yes fit-pbmc68k-scd-ex-k=9

#                    data      k method    n  ex outfile
sbatch ${SCRIPT_FIT} pbmc_68k 10 em     1000  no fit-pbmc68k-em-k=10
sbatch ${SCRIPT_FIT} pbmc_68k 10 scd    1000  no fit-pbmc68k-scd-k=10
sbatch ${SCRIPT_FIT} pbmc_68k 10 em     1000 yes fit-pbmc68k-em-ex-k=10
sbatch ${SCRIPT_FIT} pbmc_68k 10 scd    1000 yes fit-pbmc68k-scd-ex-k=10
sbatch ${SCRIPT_FIT} pbmc_68k 11 em     1000  no fit-pbmc68k-em-k=11
sbatch ${SCRIPT_FIT} pbmc_68k 11 scd    1000  no fit-pbmc68k-scd-k=11
sbatch ${SCRIPT_FIT} pbmc_68k 11 em     1000 yes fit-pbmc68k-em-ex-k=11
sbatch ${SCRIPT_FIT} pbmc_68k 11 scd    1000 yes fit-pbmc68k-scd-ex-k=11
sbatch ${SCRIPT_FIT} pbmc_68k 12 em     1000  no fit-pbmc68k-em-k=12
sbatch ${SCRIPT_FIT} pbmc_68k 12 scd    1000  no fit-pbmc68k-scd-k=12
sbatch ${SCRIPT_FIT} pbmc_68k 12 em     1000 yes fit-pbmc68k-em-ex-k=12
sbatch ${SCRIPT_FIT} pbmc_68k 12 scd    1000 yes fit-pbmc68k-scd-ex-k=12
