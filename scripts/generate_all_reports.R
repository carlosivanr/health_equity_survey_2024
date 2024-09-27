# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Carlos Rodriguez Ph.D. CU Anschutz Department of Family Medicine
# 09/26/2024
# Render .qmd files in parallel
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Load libraries ---------------------------------------------------------------
pacman::p_load(tidyverse,
               here,
               furrr)

# Set the input clinics, output format parameters, and number of cores ---------
clinics = c("AF Williams", "Boulder", "Lone Tree", "Westminster", "WISH", "All")
format = "docx"
cores = 5

# Create reports function ------------------------------------------------------
create_reports <- function(clinic_name){
  
  # Relative to the root project directory, set the path to the master layout
  # .qmd file 
  layout <-  "./scripts/layout_by_clinic_v3.qmd"
  
  # Create a clinic-specific .qmd file. Copy and rename the master layout .qmd
  # file in the scripts directory removing spaces in the clinic_name to avoid
  # rendering issues, and allow parallel processing because the same file can't 
  # be read in multiple future sessions in parallel.
  file.copy(
    from = layout,
    to = here("scripts", str_c(sub(" ", "", clinic_name), ".qmd")),
    overwrite = TRUE
  )
  
  # Set file_in to the copied and renamed clinic-specific .qmd file. Serves as
  # an input to the quarto_render() function
  file_in <- here("scripts", str_c(sub(" ", "", clinic_name), ".qmd"))
  
  # Set file_out to the file name of the rendered report. Serves as a parameter
  # in the output-file option of the clinic-specific .qmd file.
  file_out <- str_c(clinic_name, "." ,format)
  
  # Render the report
  quarto::quarto_render(
    input = file_in,
    execute_params = list(clinic = clinic_name),
    output_format = "docx",
    output_file = file_out
  )
  
  # The reports are initially placed in the root project directory. Copy the 
  # output .docx file to the reports directory
  file.copy(
    from = here(file_out),
    to = here("deliverables/reports", str_c(clinic_name, ".", format)),
    overwrite = TRUE
  )
  
  # Remove the output .docx file from the root project directory. Uses a
  # relative path
  file.remove(here(file_out))
  
  # Remove the copy of the master layout .qmd file. Uses an absolute Path
  file.remove(file_in)
  
}

# Set furrr options ------------------------------------------------------------
options(future.rng.onMisuse = "ignore")
plan(multisession, workers = cores)

# Render reports in parallel ---------------------------------------------------
system.time(clinics %>%
              future_walk(~ create_reports(.x))
)