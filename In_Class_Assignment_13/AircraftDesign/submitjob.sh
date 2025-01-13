#!/bin/bash
#SBATCH --time=
#SBATCH --nodes=
#SBATCH --ntasks-per-node=
#SBATCH --mem=
#SBATCH --job-name="Aircraft Design"
#SBATCH --mail-user=Username@iastate.edu   #change to your username to receive email notification
#SBATCH --output="OUTPUT_%j.log"
#SBATCH --error="ERROR_%j.log"
#SBATCH --partition=instruction
#SBATCH --account=f2024.aere.362.1

cd $SLURM_SUBMIT_DIR

module load matlab/R2023a

matlab  -batch runscipt_optimization > matlab_output.log