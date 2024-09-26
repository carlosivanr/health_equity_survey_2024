
# Load libraries ----
pacman::p_load(tidyverse,
               here)

# Set the input clinics, output format parameters, and number of cores ----
clinics = c("AF Williams", "Boulder", "Lone Tree", "Westminster", "WISH", "All")
format = "docx"
cores = 6

# Load create_reports function----
# Create reports function
create_reports <- function(clinic_name){
  
  # Set the input file path, which will be a copy of the *.qmd file
  layout = "./scripts/layout_by_clinic_v2.qmd"
  
  # Make a copy of the layout .qmd file in the scripts directory as the
  # reference document has a relative path from this directory
  file.copy(
    from = layout,
    to = here("scripts", str_c(clinic_name, ".qmd")),
    overwrite = TRUE
  )
  
  # Set the file_in to the copied .qmd file
  file_in = here("scripts", str_c(clinic_name, ".qmd"))
  
  # Render an output given the copied input_file and clinic_name
  quarto::quarto_render(
    input = file_in,
    execute_params = list(clinic = clinic_name),
    output_format = "docx"
  )
  
  # Move the file to the reports directory
  file.copy(
    from = file_in,
    to = here("deliverables/reports", str_c(clinic_name, ".docx")),
    overwrite = TRUE
  )
  
  # Remove the file_in .qmd file and the docx file
  file.remove(here("scripts", str_c(clinic_name, ".docx")))
  file.remove(here("scripts", str_c(clinic_name, ".qmd")))
  
  
  # AF Williams and Lone Tree results in intermediate directories that are not
  # removed due to some issue with the space in the name of the clinic. This
  # code chunk was written to remove any leftover directories
  # files_dir <- str_c("./scripts/layout_", 
  #                    format, "_", 
  #                    sub(" ", "-", clinic_name), 
  #                    "_files"
  # )
  # 
  # if (dir.exists(files_dir)){
  #   unlink(files_dir, recursive = TRUE)
  # }
}

# Set the options for furrr----
# options(future.rng.onMisuse = "ignore")
# plan(multisession, workers = cores)

# Run the create_reports() function in parallel to all input clinics----
# system.time(clinics %>%
#               future_walk(~ create_reports(.x))
# )

# # Run in serial
system.time(clinics %>%
              walk(~ create_reports(.x))
)