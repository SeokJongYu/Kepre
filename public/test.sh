#!/bin/sh

#

#This is an example script example.sh
#
#These commands set up the Grid Environment for your job:

#PBS -N Kepre_Job
#PBS -l nodes=1,walltime=00:01:00
#PBS -q batch
#PBS -M codegen@manjaro-codegen

#print the time and date
date
#wait 10 seconds
sleep 10
#print the time and date again
date
