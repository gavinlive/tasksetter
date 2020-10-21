#!/bin/bash
n_gpus=$1

if [ "$n_gpus" = "" ];
then
  n_gpus=16
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
    this_gpu_=$this_gpu
    
    if [ $this_gpu -ge 0 ] && [ $this_gpu -le 3 ];
    then
      this_gpu_=$this_gpu
    fi
    
    if [ $this_gpu -ge 4 ] && [ $this_gpu -le 7 ];
    then
      this_gpu_=$((this_gpu+4))
    fi
    
    
    if [ $this_gpu -ge 8 ] && [ $this_gpu -le 11 ];
    then
      this_gpu_=$((this_gpu-4))
    fi
    
    if [ $this_gpu -ge 12 ];
    then
      this_gpu_=$this_gpu
    fi
    
    
    gpu_start=$((5*this_gpu_))
    gpus=$gpu_start,$(($gpu_start+1)),$(($gpu_start+2)),$(($gpu_start+3)),$(($gpu_start+4))
    echo $gpus
    taskset -p -c $gpus $pid
  fi
done
