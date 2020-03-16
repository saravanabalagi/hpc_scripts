# Check number of cores
printf "CPU: $(cat /proc/cpuinfo | grep -m1 "model name" | awk -F': ' '{print $2}')\n"
printf "Number of Cores: $(cat /proc/cpuinfo | grep processor | wc -l)\n\n"

# Check GPUs
nvidia-smi
printf "\n"

# CHeck memory
printf "Memory Stats\n"
free -m --human

# Print environment variables
printf -- "----------------\n\n"
echo "Environment Variables"
env
printf -- "----------------\n\n"
