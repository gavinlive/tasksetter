#!/bin/bash
n_gpus=$1

if [ "$n_gpus" = "" ];
then
  n_gpus=9
fi

for this_gpu in $(seq 0 $n_gpus);
do
  pid=$(nvidia-smi -g $this_gpu | awk '$2=="Processes:" {p=1} p && $3 > 0 {print $3}')
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
    this_gpu_=$this_gpu
    if [ $this_gpu -ge 0 ] && [ $this_gpu -le 3 ];
    then
      this_gpu_=$this_gpu
      gpu_start=$((3*this_gpu_))
      gpus=$gpu_start,$(($gpu_start+1)),$(($gpu_start+2))
    fi
    
    
    if [ "$this_gpu" = "4" ];
    then
      gpus="12,13,28"
    fi
    
    
    if [ $this_gpu -ge 5 ] && [ $this_gpu -le 7 ];
    then
      this_gpu_=$((this_gpu+4))
      gpu_start=$((3*this_gpu_))
      gpus=$(($gpu_start+2)),$(($gpu_start+3)),$(($gpu_start+4))
    fi
    
    
    if [ "$this_gpu" = "8" ];
    then
      gpus="38,39"
      gpus="38,39,46,47,48,49"
    fi
    
    if [ "$this_gpu" = "9" ];
    then
      gpus="40,41"
      gpus="40,41,42,43,44,45"
    fi
    
    
    echo $gpus
    taskset -p -c $gpus $pid
  fi
done
