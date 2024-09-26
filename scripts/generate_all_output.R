#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Carlos Rodriguez, PhD. 
# Data Analyst, DFM, CU Anschutz Medical Campus
# 09/01/2022

# Generate .docx reports or .pptx slides

# Description: This script will generate multiple reports for each individual
# clinic, and all clinics in the DFM practice equity survey data.

# This script relies on the layout_*.qmd files created to process, subset, and 
# generate tables and figures in a word or powerpoint document.
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Load libraries ----
pacman::p_load(tidyverse,
               furrr)

# Set the input clinics, output format parameters, and number of cores ----
clinics = c("AF Williams", "Boulder", "Lone Tree", "Westminster", "WISH", "All")
format = "docx"
cores = 6

# Load create_reports function----
source("./functions/create_reports.R")

# Set the options for furrr----
options(future.rng.onMisuse = "ignore")
plan(multisession, workers = cores)

# Run the create_reports() function in parallel to all input clinics----
system.time(clinics %>%
              future_walk(~ create_reports(.x, format)))