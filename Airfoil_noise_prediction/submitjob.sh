#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=10G
#SBATCH --job-name="Airfoil_noise_prediction"
#SBATCH --mail-user=your_email@iastate.edu #change to your email
#SBATCH --output="OUTPUT_%j.log"
#SBATCH --error="ERROR_%j.log"
#SBATCH --partition=instruction
#SBATCH --account=f2024.aere.362.1

cd $SLURM_SUBMIT_DIR

module load matlab/R2023a

matlab -batch ml_analysis > matlab_output.log
