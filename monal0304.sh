#!/bin/bash
n_gpus=$1

if [ "$n_gpus" = "" ];
then
  n_gpus=4
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
    if [ "$this_gpu" = "0" ];
    then
      this_gpu_=0
    fi
    
    if [ "$this_gpu" = "1" ];
    then
      this_gpu_=2
    fi
    
    
    if [ "$this_gpu" = "2" ];
    then
      this_gpu_=1
    fi
    
    
    if [ "$this_gpu" = "3" ];
    then
      this_gpu_=3
    fi
    
    gpu_start=$((13*this_gpu_))
    gpus=$gpu_start,$(($gpu_start+1)),$(($gpu_start+2)),$(($gpu_start+3)),$(($gpu_start+4)),$(($gpu_start+5)),$(($gpu_start+6)),$(($gpu_start+7)),$(($gpu_start+8)),$(($gpu_start+9)),$(($gpu_start+10)),$(($gpu_start+11)),$(($gpu_start+12)),$(($gpu_start+13))
    echo $gpus
    taskset -p -c $gpus $pid
  fi
done
