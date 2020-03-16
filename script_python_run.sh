cd /projects/pr_triplet

CUDA_VISIBLE_DEVICES=0,1
export CUDA_VISIBLE_DEVICES
nohup python search_hyperparams.py --exp_dir experiments/sample_search_hyperparams > logs/stdout.log 2> logs/stderr.log < /dev/null
