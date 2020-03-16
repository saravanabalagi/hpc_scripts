#!/bin/sh

#SBATCH --time=00:20:00
#SBATCH --nodes=1
#SBATCH -A nuim01
#SBATCH -p GpuQ

#SBATCH -o outfile  # send stdout to outfile
#SBATCH -e outfile  # send stderr to errfile
#SBATCH --job-name python-test-run

srun /bin/sh ~/singularity/scripts/script_check_stats.sh
