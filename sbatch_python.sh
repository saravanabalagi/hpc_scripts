#!/bin/sh

#SBATCH --time=00:20:00
#SBATCH --nodes=2
#SBATCH -A nuim01
#SBATCH -p GpuQ

#SBATCH -o outfile  # send stdout to outfile
#SBATCH -e errfile  # send stderr to errfile
#SBATCH --job-name python-neural-network-training

module load cuda/10.1.243
module load singularity/2.6.0

export WORK='/ichec/work/nuim01/sarav'

srun singularity exec --nv --contain --home "$HOME" --bind "$WORK/data/deep_learning":/data --bind "$WORK/projects/python":/projects $HOME/singularity/tf2.img /bin/sh ~/singularity/scripts/script_python_run.sh
