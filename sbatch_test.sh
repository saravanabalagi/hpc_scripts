#!/bin/sh

#SBATCH --time=00:20:00
#SBATCH --nodes=2
#SBATCH -A nuim01
#SBATCH -p GpuQ

#SBATCH -o outfile  # send stdout to outfile
#SBATCH -e outfile  # send stderr to errfile
#SBATCH --job-name python_test_run

srun -n8 /bin/sh ~/singularity/scripts/script_test.sh
