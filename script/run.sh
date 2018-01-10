#!/bin/sh
#PBS -l nodes=1:ppn=1,walltime=00:1:00
#PBS -q batch
#PBS -S /bin/bash
#PBS -V

cd /home/codegen/Dev/IEDB/IEDB_MHC_I-2.17/mhc_i

./src/predict_binding.py IEDB_recommended "HLA-A*02:01" 9 mtor.txt > run2.out
