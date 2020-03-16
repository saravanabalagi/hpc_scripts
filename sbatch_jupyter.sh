#!/bin/sh

#SBATCH --time=00:20:00
#SBATCH --nodes=1
#SBATCH -A nuim01
#SBATCH -p GpuQ

#SBATCH -o outfile  # send stdout to outfile
#SBATCH -e errfile  # send stderr to errfile
#SBATCH --job-name jupyter-notebook-playground

CLUSTER_USERNAME=$(whoami)
CURRENT_NODE=$(hostname)
JUPYTER_PORT=8889
export CURRENT_NODE JUPYTER_PORT

# print tunneling instructions
echo -e "
Command to create ssh tunnel:
ssh -NfL localhost:${JUPYTER_PORT}:${CURRENT_NODE}:${JUPYTER_PORT} ${CLUSTER_USERNAME}@kay.ichec.ie
"

module load cuda/10.1.243
module load singularity/2.6.0
export WORK='/ichec/work/nuim01/sarav'

singularity exec --nv --contain --home "$HOME" --bind "$WORK/data/deep_learning":/data --bind "$WORK/projects/python":/jupyter ~/singularity/jupyter_tf2.img /bin/sh $HOME/singularity/scripts/script_jupyter_lab.sh
