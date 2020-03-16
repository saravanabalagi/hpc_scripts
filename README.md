## SLURM srun

In a SLURM managed cluster, we need to create a sbatch script like the one given below , so we can schedule our job using `sbatch sbatch_script.sh`

```shell
#!/bin/sh

#SBATCH --time=00:20:00
#SBATCH --nodes=2
#SBATCH -A nuim01
#SBATCH -p GpuQ

#SBATCH -o outfile  # send stdout to outfile
#SBATCH -e outfile  # send stderr to errfile
#SBATCH --job-name python_test_run

# Here goes your commands
<command_prefix> /bin/sh ~/script_test.sh
```

```
# script_test.sh
echo "Node $SLURM_NODEID here: $(hostname)"
```

Note: If we directly use `echo "Node $SLURM_NODEID here: $(hostname)"` in the sbatch_script, then all nodes will print the same $SLURM_NODEID on which the sbatch_script is being processed.

| Command Prefix | outfile |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  | Node 0 here: n360 |
| srun | Node 0 here: n360<br>Node 1 here: n361 |
| srun -n1 | Node 0 here: n360<sup>#</sup> |
| srun -n2 | Node 0 here: n360<br>Node 1 here: n361 |
| srun -n3 | Node 0 here: n360<br>Node 0 here: n360<br>Node 1 here: n361 |
| srun -n8 | Node 0 here: n360<br>Node 0 here: n360<br>Node 0 here: n360<br>Node 0 here: n360<br>Node 1 here: n361<br>Node 1 here: n361<br>Node 1 here: n361<br>Node 1 here: n361 |

<sup>#</sup>srun: Warning: can't run 1 processes on 2 nodes, setting nnodes to 1

## View Allocated Resources

```
scontrol show job -d {{SLURM_JOB_ID}}
```
```
UserId=USER(UID) GroupId=GROUP(GID) MCS_label=N/A
Priority=1 Nice=0 Account=nuim01 QOS=nuim01
JobState=RUNNING Reason=None Dependency=(null)
Requeue=1 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0
DerivedExitCode=0:0
RunTime=00:00:28 TimeLimit=00:20:00 TimeMin=N/A
SubmitTime=2020-03-16T12:36:16 EligibleTime=2020-03-16T12:36:16
StartTime=2020-03-16T12:36:17 EndTime=2020-03-16T12:56:17 Deadline=N/A
PreemptTime=None SuspendTime=None SecsPreSuspend=0
LastSchedEval=2020-03-16T12:36:17
Partition=GpuQ AllocNode:Sid=login2:23007
ReqNodeList=(null) ExcNodeList=(null)
NodeList=n[360-361]
BatchHost=n360
NumNodes=2 NumCPUs=80 NumTasks=2 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
TRES=cpu=80,node=2,billing=184
Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
  Nodes=n[360-361] CPU_IDs=0-39 Mem=0 GRES_IDX=
MinCPUsNode=1 MinMemoryNode=0 MinTmpDiskNode=0
Features=(null) DelayBoot=00:00:00
Gres=(null) Reservation=(null)
OverSubscribe=NO Contiguous=0 Licenses=(null) Network=(null)
Command=/path/to/workdir/scripts/sbatch_test.sh
WorkDir=/path/to/workdir
StdErr=/path/to/stderr
StdIn=/dev/null
StdOut=/path/to/stdout
Power=
```

## Useful SLURM Environment variables

| Slurm Variable Name | Description | Example values |
|----------------------|-----------------------------------------------------------|-------------------------------------------|
| SLURM_JOB_ID | Job ID | 5741192 |
| SLURM_JOBID | Deprecated. Same as SLURM_JOB_ID | 5741192  |
| SLURM_JOB_NAME | Job Name | myjob |
| SLURM_SUBMIT_DIR | Submit Directory | /lustre/payerle/work |
| SLURM_JOB_NODELIST | Nodes assigned to job | compute-b24-[1-3,5-9],compute-b25-[1,4,8] |
| SLURM_SUBMIT_HOST | Host submitted from | login-1.deepthought2.umd.edu |
| SLURM_JOB_NUM_NODES | Number of nodes allocated to job | 2 |
| SLURM_CPUS_ON_NODE | Number of cores/node | 8,3 |
| SLURM_NTASKS | Total number of cores for job??? | 11 |
| SLURM_NODEID | Index to node running onrelative to nodes assigned to job | 0 |
| PBS_O_VNODENUM | Index to core running onwithin node | 4 |
| SLURM_PROCID | Index to task relative to job | 0 |

## Additional References and FAQs

1. [Submitting a basic Job](https://www.ichec.ie/academic/national-hpc/FAQ#2-how-do-i-submit-a-job-to-kay)
1. [Selecting the number of CPUs and threads in SLURM sbatch](https://stackoverflow.com/a/51141287/3125070)
1. [What does the --ntasks or -n tasks does in SLURM?](https://stackoverflow.com/a/53759961/3125070)
1. [CÉCI FAQ](https://support.ceci-hpc.be/doc/_contents/SubmittingJobs/SlurmFAQ.html#Q05)
1. [Running Interactive Jobs](http://geco.mines.edu/files/userguides/slurm/interactive.html)
1. [Check node usages](https://www.ichec.ie/academic/national-hpc/documentation/check-node-utilization)
1. [Task Farming](https://www.ichec.ie/academic/national-hpc/documentation/task-farming)
