# Create reports function
create_reports <- function(clinic_name, format = c("docx", "pptx")){
  
  # Test format to determine which directory to write the output files to
  # If .docx, files should be written to deliverables/reports; If .pptx, then
  # output should be written to deliverables/slides.
  if (format == "docx"){
    dir = "reports"
  } else if (format == "pptx"){
    dir = "slides"
  }
    
  # Set the output file path, replacing spaces with underscores    
  file_out = str_c("./deliverables/", 
                   dir, 
                   "/dfm_practice_equity_survey_", 
                   sub(" ", "_", clinic_name), 
                   ".", 
                   format
                   )

    # Set the input file path, which will be a copy of the generate_one_*.qmd file
  file_in  = str_c("./scripts/layout_", 
                   format, "_", 
                   clinic_name, 
                   ".qmd"
                   )
  
  # Create a copy of the file as multiple copies will be needed for parallelization 
  file.copy(
    from = str_c("./scripts/layout_", format, ".qmd"),
    to = file_in,
    overwrite = TRUE
    )

  # Render an output given the copied input_file, clinic_name, and format
  quarto::quarto_render(
    input = file_in,
    execute_params = list(clinic = clinic_name),
    output_file = file_out
    )

  # Remove the copied files once rendering is finished  
  file.remove(
    file_in
    )
  
  # AF Williams and Lone Tree results in intermediate directories that are not
  # removed due to some issue with the space in the name of the clinic. This
  # code chunk was written to remove any leftover directories
  files_dir <- str_c("./scripts/layout_", 
                     format, "_", 
                     sub(" ", "-", clinic_name), 
                     "_files"
                     )
  
  if (dir.exists(files_dir)){
    unlink(files_dir, recursive = TRUE)
  }
}