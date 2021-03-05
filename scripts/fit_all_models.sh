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

# Fit factorizations to nips data, with and without extrapolation.
#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  2 em     1000  no fit-nips-em-k=2
sbatch ${SCRIPT_FIT} nips  2 ccd    1000  no fit-nips-ccd-k=2
sbatch ${SCRIPT_FIT} nips  2 scd    1000  no fit-nips-scd-k=2
sbatch ${SCRIPT_FIT} nips  2 em     1000 yes fit-nips-em-ex-k=2
sbatch ${SCRIPT_FIT} nips  2 ccd    1000 yes fit-nips-ccd-ex-k=2
sbatch ${SCRIPT_FIT} nips  2 scd    1000 yes fit-nips-scd-ex-k=2

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  3 em     1000  no fit-nips-em-k=3
sbatch ${SCRIPT_FIT} nips  3 ccd    1000  no fit-nips-ccd-k=3
sbatch ${SCRIPT_FIT} nips  3 scd    1000  no fit-nips-scd-k=3
sbatch ${SCRIPT_FIT} nips  3 em     1000 yes fit-nips-em-ex-k=3
sbatch ${SCRIPT_FIT} nips  3 ccd    1000 yes fit-nips-ccd-ex-k=3
sbatch ${SCRIPT_FIT} nips  3 scd    1000 yes fit-nips-scd-ex-k=3

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  4 em     1000  no fit-nips-em-k=4
sbatch ${SCRIPT_FIT} nips  4 ccd    1000  no fit-nips-ccd-k=4
sbatch ${SCRIPT_FIT} nips  4 scd    1000  no fit-nips-scd-k=4
sbatch ${SCRIPT_FIT} nips  4 em     1000 yes fit-nips-em-ex-k=4
sbatch ${SCRIPT_FIT} nips  4 ccd    1000 yes fit-nips-ccd-ex-k=4
sbatch ${SCRIPT_FIT} nips  4 scd    1000 yes fit-nips-scd-ex-k=4

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  5 em     1000  no fit-nips-em-k=5
sbatch ${SCRIPT_FIT} nips  5 ccd    1000  no fit-nips-ccd-k=5
sbatch ${SCRIPT_FIT} nips  5 scd    1000  no fit-nips-scd-k=5
sbatch ${SCRIPT_FIT} nips  5 em     1000 yes fit-nips-em-ex-k=5
sbatch ${SCRIPT_FIT} nips  5 ccd    1000 yes fit-nips-ccd-ex-k=5
sbatch ${SCRIPT_FIT} nips  5 scd    1000 yes fit-nips-scd-ex-k=5

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  6 em     1000  no fit-nips-em-k=6
sbatch ${SCRIPT_FIT} nips  6 ccd    1000  no fit-nips-ccd-k=6
sbatch ${SCRIPT_FIT} nips  6 scd    1000  no fit-nips-scd-k=6
sbatch ${SCRIPT_FIT} nips  6 em     1000 yes fit-nips-em-ex-k=6
sbatch ${SCRIPT_FIT} nips  6 ccd    1000 yes fit-nips-ccd-ex-k=6
sbatch ${SCRIPT_FIT} nips  6 scd    1000 yes fit-nips-scd-ex-k=6

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  7 em     1000  no fit-nips-em-k=7
sbatch ${SCRIPT_FIT} nips  7 ccd    1000  no fit-nips-ccd-k=7
sbatch ${SCRIPT_FIT} nips  7 scd    1000  no fit-nips-scd-k=7
sbatch ${SCRIPT_FIT} nips  7 em     1000 yes fit-nips-em-ex-k=7
sbatch ${SCRIPT_FIT} nips  7 ccd    1000 yes fit-nips-ccd-ex-k=7
sbatch ${SCRIPT_FIT} nips  7 scd    1000 yes fit-nips-scd-ex-k=7

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  8 em     1000  no fit-nips-em-k=8
sbatch ${SCRIPT_FIT} nips  8 ccd    1000  no fit-nips-ccd-k=8
sbatch ${SCRIPT_FIT} nips  8 scd    1000  no fit-nips-scd-k=8
sbatch ${SCRIPT_FIT} nips  8 em     1000 yes fit-nips-em-ex-k=8
sbatch ${SCRIPT_FIT} nips  8 ccd    1000 yes fit-nips-ccd-ex-k=8
sbatch ${SCRIPT_FIT} nips  8 scd    1000 yes fit-nips-scd-ex-k=8

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips  9 em     1000  no fit-nips-em-k=9
sbatch ${SCRIPT_FIT} nips  9 ccd    1000  no fit-nips-ccd-k=9
sbatch ${SCRIPT_FIT} nips  9 scd    1000  no fit-nips-scd-k=9
sbatch ${SCRIPT_FIT} nips  9 em     1000 yes fit-nips-em-ex-k=9
sbatch ${SCRIPT_FIT} nips  9 ccd    1000 yes fit-nips-ccd-ex-k=9
sbatch ${SCRIPT_FIT} nips  9 scd    1000 yes fit-nips-scd-ex-k=9

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips 10 em     1000  no fit-nips-em-k=10
sbatch ${SCRIPT_FIT} nips 10 ccd    1000  no fit-nips-ccd-k=10
sbatch ${SCRIPT_FIT} nips 10 scd    1000  no fit-nips-scd-k=10
sbatch ${SCRIPT_FIT} nips 10 em     1000 yes fit-nips-em-ex-k=10
sbatch ${SCRIPT_FIT} nips 10 ccd    1000 yes fit-nips-ccd-ex-k=10
sbatch ${SCRIPT_FIT} nips 10 scd    1000 yes fit-nips-scd-ex-k=10

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips 11 em     1000  no fit-nips-em-k=11
sbatch ${SCRIPT_FIT} nips 11 ccd    1000  no fit-nips-ccd-k=11
sbatch ${SCRIPT_FIT} nips 11 scd    1000  no fit-nips-scd-k=11
sbatch ${SCRIPT_FIT} nips 11 em     1000 yes fit-nips-em-ex-k=11
sbatch ${SCRIPT_FIT} nips 11 ccd    1000 yes fit-nips-ccd-ex-k=11
sbatch ${SCRIPT_FIT} nips 11 scd    1000 yes fit-nips-scd-ex-k=11

#                    data  k method    n  ex outfile
sbatch ${SCRIPT_FIT} nips 12 em     1000  no fit-nips-em-k=12
sbatch ${SCRIPT_FIT} nips 12 ccd    1000  no fit-nips-ccd-k=12
sbatch ${SCRIPT_FIT} nips 12 scd    1000  no fit-nips-scd-k=12
sbatch ${SCRIPT_FIT} nips 12 em     1000 yes fit-nips-em-ex-k=12
sbatch ${SCRIPT_FIT} nips 12 ccd    1000 yes fit-nips-ccd-ex-k=12
sbatch ${SCRIPT_FIT} nips 12 scd    1000 yes fit-nips-scd-ex-k=12

# Fit factorizations to newsgroups data, with and without extrapolation.
#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  2 em     1000  no fit-newsgroups-em-k=2
sbatch ${SCRIPT_FIT} newsgroups  2 ccd    1000  no fit-newsgroups-ccd-k=2
sbatch ${SCRIPT_FIT} newsgroups  2 scd    1000  no fit-newsgroups-scd-k=2
sbatch ${SCRIPT_FIT} newsgroups  2 em     1000 yes fit-newsgroups-em-ex-k=2
sbatch ${SCRIPT_FIT} newsgroups  2 ccd    1000 yes fit-newsgroups-ccd-ex-k=2
sbatch ${SCRIPT_FIT} newsgroups  2 scd    1000 yes fit-newsgroups-scd-ex-k=2

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  3 em     1000  no fit-newsgroups-em-k=3
sbatch ${SCRIPT_FIT} newsgroups  3 ccd    1000  no fit-newsgroups-ccd-k=3
sbatch ${SCRIPT_FIT} newsgroups  3 scd    1000  no fit-newsgroups-scd-k=3
sbatch ${SCRIPT_FIT} newsgroups  3 em     1000 yes fit-newsgroups-em-ex-k=3
sbatch ${SCRIPT_FIT} newsgroups  3 ccd    1000 yes fit-newsgroups-ccd-ex-k=3
sbatch ${SCRIPT_FIT} newsgroups  3 scd    1000 yes fit-newsgroups-scd-ex-k=3

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  4 em     1000  no fit-newsgroups-em-k=4
sbatch ${SCRIPT_FIT} newsgroups  4 ccd    1000  no fit-newsgroups-ccd-k=4
sbatch ${SCRIPT_FIT} newsgroups  4 scd    1000  no fit-newsgroups-scd-k=4
sbatch ${SCRIPT_FIT} newsgroups  4 em     1000 yes fit-newsgroups-em-ex-k=4
sbatch ${SCRIPT_FIT} newsgroups  4 ccd    1000 yes fit-newsgroups-ccd-ex-k=4
sbatch ${SCRIPT_FIT} newsgroups  4 scd    1000 yes fit-newsgroups-scd-ex-k=4

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  5 em     1000  no fit-newsgroups-em-k=5
sbatch ${SCRIPT_FIT} newsgroups  5 ccd    1000  no fit-newsgroups-ccd-k=5
sbatch ${SCRIPT_FIT} newsgroups  5 scd    1000  no fit-newsgroups-scd-k=5
sbatch ${SCRIPT_FIT} newsgroups  5 em     1000 yes fit-newsgroups-em-ex-k=5
sbatch ${SCRIPT_FIT} newsgroups  5 ccd    1000 yes fit-newsgroups-ccd-ex-k=5
sbatch ${SCRIPT_FIT} newsgroups  5 scd    1000 yes fit-newsgroups-scd-ex-k=5

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  6 em     1000  no fit-newsgroups-em-k=6
sbatch ${SCRIPT_FIT} newsgroups  6 ccd    1000  no fit-newsgroups-ccd-k=6
sbatch ${SCRIPT_FIT} newsgroups  6 scd    1000  no fit-newsgroups-scd-k=6
sbatch ${SCRIPT_FIT} newsgroups  6 em     1000 yes fit-newsgroups-em-ex-k=6
sbatch ${SCRIPT_FIT} newsgroups  6 ccd    1000 yes fit-newsgroups-ccd-ex-k=6
sbatch ${SCRIPT_FIT} newsgroups  6 scd    1000 yes fit-newsgroups-scd-ex-k=6

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  7 em     1000  no fit-newsgroups-em-k=7
sbatch ${SCRIPT_FIT} newsgroups  7 ccd    1000  no fit-newsgroups-ccd-k=7
sbatch ${SCRIPT_FIT} newsgroups  7 scd    1000  no fit-newsgroups-scd-k=7
sbatch ${SCRIPT_FIT} newsgroups  7 em     1000 yes fit-newsgroups-em-ex-k=7
sbatch ${SCRIPT_FIT} newsgroups  7 ccd    1000 yes fit-newsgroups-ccd-ex-k=7
sbatch ${SCRIPT_FIT} newsgroups  7 scd    1000 yes fit-newsgroups-scd-ex-k=7

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  8 em     1000  no fit-newsgroups-em-k=8
sbatch ${SCRIPT_FIT} newsgroups  8 ccd    1000  no fit-newsgroups-ccd-k=8
sbatch ${SCRIPT_FIT} newsgroups  8 scd    1000  no fit-newsgroups-scd-k=8
sbatch ${SCRIPT_FIT} newsgroups  8 em     1000 yes fit-newsgroups-em-ex-k=8
sbatch ${SCRIPT_FIT} newsgroups  8 ccd    1000 yes fit-newsgroups-ccd-ex-k=8
sbatch ${SCRIPT_FIT} newsgroups  8 scd    1000 yes fit-newsgroups-scd-ex-k=8

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups  9 em     1000  no fit-newsgroups-em-k=9
sbatch ${SCRIPT_FIT} newsgroups  9 ccd    1000  no fit-newsgroups-ccd-k=9
sbatch ${SCRIPT_FIT} newsgroups  9 scd    1000  no fit-newsgroups-scd-k=9
sbatch ${SCRIPT_FIT} newsgroups  9 em     1000 yes fit-newsgroups-em-ex-k=9
sbatch ${SCRIPT_FIT} newsgroups  9 ccd    1000 yes fit-newsgroups-ccd-ex-k=9
sbatch ${SCRIPT_FIT} newsgroups  9 scd    1000 yes fit-newsgroups-scd-ex-k=9

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups 10 em     1000  no fit-newsgroups-em-k=10
sbatch ${SCRIPT_FIT} newsgroups 10 ccd    1000  no fit-newsgroups-ccd-k=10
sbatch ${SCRIPT_FIT} newsgroups 10 scd    1000  no fit-newsgroups-scd-k=10
sbatch ${SCRIPT_FIT} newsgroups 10 em     1000 yes fit-newsgroups-em-ex-k=10
sbatch ${SCRIPT_FIT} newsgroups 10 ccd    1000 yes fit-newsgroups-ccd-ex-k=10
sbatch ${SCRIPT_FIT} newsgroups 10 scd    1000 yes fit-newsgroups-scd-ex-k=10

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups 11 em     1000  no fit-newsgroups-em-k=11
sbatch ${SCRIPT_FIT} newsgroups 11 ccd    1000  no fit-newsgroups-ccd-k=11
sbatch ${SCRIPT_FIT} newsgroups 11 scd    1000  no fit-newsgroups-scd-k=11
sbatch ${SCRIPT_FIT} newsgroups 11 em     1000 yes fit-newsgroups-em-ex-k=11
sbatch ${SCRIPT_FIT} newsgroups 11 ccd    1000 yes fit-newsgroups-ccd-ex-k=11
sbatch ${SCRIPT_FIT} newsgroups 11 scd    1000 yes fit-newsgroups-scd-ex-k=11

#                    data        k method    n  ex outfile
sbatch ${SCRIPT_FIT} newsgroups 12 em     1000  no fit-newsgroups-em-k=12
sbatch ${SCRIPT_FIT} newsgroups 12 ccd    1000  no fit-newsgroups-ccd-k=12
sbatch ${SCRIPT_FIT} newsgroups 12 scd    1000  no fit-newsgroups-scd-k=12
sbatch ${SCRIPT_FIT} newsgroups 12 em     1000 yes fit-newsgroups-em-ex-k=12
sbatch ${SCRIPT_FIT} newsgroups 12 ccd    1000 yes fit-newsgroups-ccd-ex-k=12
sbatch ${SCRIPT_FIT} newsgroups 12 scd    1000 yes fit-newsgroups-scd-ex-k=12
