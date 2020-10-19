#!/bin/bash
n_gpus=$1

if [ "$n_gpus" = "" ];
then
  n_gpus=17
fi

for this_gpu in $(seq 0 $n_gpus);
do
  pid=$(nvidia-smi -g $this_gpu | awk '$2=="Processes:" {p=1} p && $5 > 0 {print $5}')
  if [ "$pid" = "" ] || [[ "$pid" == *"running"* ]];
  then
    echo "No PID"
  else
    while IFS=' ' read -ra ADDR; do
          for i in "${ADDR[@]}"; do
              # process "$i"
              do_nothing_here=""
          done
    done <<< "$pid"
    pid=$i
    gpu_start=$((4*this_gpu))
    gpus=$gpu_start,$(($gpu_start+1)),$(($gpu_start+2)),$(($gpu_start+3))
    taskset -p -c $gpus $pid
  fi
done
