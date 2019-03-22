#!/bin/bash
#SBATCH -t 00:02:00
#SBATCH -N 1
#SBATCH -p short
#SBATCH --mem=10G

#Copy dataset files to scratch
cp -r ./*.mat "$TMPDIR"
matlab -nosplash -nodisplay -nojvm -nodesktop -r main