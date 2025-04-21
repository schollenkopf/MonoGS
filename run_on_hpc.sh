#!/bin/bash
# embedded options to bsub - start with #BSUB
# -- our name ---
#BSUB -J gpuCorePython 
#BSUB -q gpua100
### request the number of GPUs
#BSUB -gpu "num=4:mode=exclusive_process"
### request the number of CPU cores (at least 4x the number of GPUs)
#BSUB -n 16 
### we want to have this on a single node
#BSUB -R "span[hosts=1]"
### we need to request CPU memory, too (note: this is per CPU core)
#BSUB -R "rusage[mem=8GB]"

#BSUB -B
# -- Notify me by email when execution ends   --
#BSUB -N
#BSUB -u s194702@student.dtu.dk
# -- Output File --
#BSUB -o Output_%J.out
# -- Error File --
#BSUB -e Output_%J.err
# -- estimated wall clock time (execution time): hh:mm -- 
#BSUB -W 24:00 



module load colmap

pip install MonoGS/submodules/diff-gaussian-rasterization
pip install MonoGS/submodules/simple-knn


python MonoGS/slam.py --config MonoGS/configs/mono/custom/custom.yaml


