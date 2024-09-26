library(REDCapR)
library(tidyverse)

# Pull Data --------------------------------------------------------------------
# Retrieve the token
path_credential <- "C:/Users/rodrica2/OneDrive - The University of Colorado Denver/Documents/redcap_credentials/credentials"

project_id <- 28323

.token <- retrieve_credential_local(
  path_credential,
  project_id,
  check_url = TRUE,
  check_username = FALSE,
  check_token_pattern = TRUE,
  username = NA_character_
)$token


# Define a function that will pull a report
pull_report <- function(report_id, val_type, header_type, .token) {
  # type is raw or label
  url <- "https://redcap.ucdenver.edu/api/"
  
  formData <- list("token" = .token,
                   content = 'report',
                   format = 'csv',
                   report_id = report_id,
                   csvDelimiter = '',
                   rawOrLabel = val_type,
                   rawOrLabelHeaders = header_type,
                   exportCheckboxLabel = 'true',
                   returnFormat = 'json'
  )
  
  response <- httr::POST(url, body = formData, encode = "form")
  
  data <- httr::content(response)
  
  # Remove the <br> and white space
  data <- data %>%
    mutate_if(is.character, ~ str_replace(., "<br>", replacement = '')) %>%
    mutate_if(is.character, ~ str_trim(.))
  
  return(data)
}


# Pull the 2024 report in label format and in raw format
data_2024_lab <- pull_report('128507', 'label', 'raw', .token) %>%
  select(-(contains("demographic_4_race")))

# Pull the 2024 report in raw format
data_2024_race <- pull_report('128507', 'raw', 'raw', .token) %>%
  select(contains("demographic_4_race"))

# Merge the race cols into the main data frame
data_2024_lab <- bind_cols(data_2024_lab, data_2024_race)

# Remove the race data frame
rm(data_2024_race)

# Change the column names by removing the _2024 and _v1 suffixes
new_col_names <-
  colnames(data_2024_lab) %>%
  str_replace(., '_2024', replacement = '') %>%
  str_replace(., '_v1', replacement = '')

# Set the new column names  
colnames(data_2024_lab) <- new_col_names

# Pull the column labels
col_labs <- names(pull_report('128507', 'raw', 'label', .token))

# Create a data frame with the column names and their corresponding column labels
labels <- data.frame(t(col_labs))
colnames(labels) <- new_col_names




# Temporary setting of data 
data <- data_2024_lab %>% filter(demographic_1_practice == "AF Williams")


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


# Process data -----------------------------------------------------------------
## Demographic Variables: ----
### Rename the demographic variables ----
# *** Add time at clinic
data <- data %>%
    rename(Practice = demographic_1_practice,
           Role = demographic_2_role,
           Age = demographic_3_age,
           Gender = demographic_6_gender,
           Transgender = demographic_8_transgender,
           Disability = demographic_9_disability,
           Residency = demographic_residency)

# Factor and set levels for demographic questions
# Modify Gender, Transgender, and Disability
data <- data %>%
  mutate(Gender = factor(Gender, 
                           levels = c("Woman", "Man", 
                                              "Nonbinary/Gender Non-Conforming",
                                              "Other (please specify)",
                                              "Prefer not to answer")),
         Transgender = factor(Transgender, 
                                levels = c("Yes", "No",
                                           "Prefer not to answer")),
         Disability = factor(Disability,
                               levels = c("Yes", "No",
                                          "Prefer not to answer")))

# Modify Role
data <- data %>%
  mutate(Role = ifelse(Role == "Clinician/Provider (medical, behavioral health, pharmacy)", "Clinician/Provider", Role),
         Role = fct_na_value_to_level(Role, level = "Unknown"))


# Set a vector of the Race & Ethnicity Variables:
# Use the un factored columns because they are coded as 0 or 1 which makes them
# easier to work with instead of the factored Checked/Unchecked
race_vars <- names(data %>% 
                     select(starts_with("demographic") & 
                              contains("race") & 
                              !contains(".factor") &
                              !contains("other")))
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



# Q1 In your opinion, how much of a problem are health inequities
# Q2 Among patients at your clinic, how much do you think each of the following contributes to health inequities?
data <- data %>% 
  mutate(across(hi_clinic_q1:hi_clinic_q4, 
                ~ factor(., levels = c("Not at all", "Slightly", "Moderately", 
                                       "Very much", "Extremely"))))
  
q2_vars <- names(data %>% select(contains("hi_clinic_q"), hi_clinic_implicit))

# Set the q2_names to be used in renaming the factored columns
q2_names <- as.character(labels %>% select(hi_clinic_q1:hi_clinic_q4, hi_clinic_implicit))

# Q3 How important is it to you to address health inequities within your clinic?
# [hi_individual_q1_2024]
q3_vars <- names(data %>% select(hi_individual_q1))
q3_names <- as.character(labels %>% select(hi_individual_q1))

# For that selected Not important at all or slightlyt important
# Why is it "not important at all" or "slightly important" to address health inequities within your clinic?

# Other Free text

# Q4 How important is it to your clinic leadership to address health inequities at your clinic?
# [hi_clinicleaders_q1_2024]


# Q5 Please rate how much you agree or disagree with the following statement:
# [meaningful_change_2024]

# Free response
# [meaningful_change_frsp_2024]

# Q6 Do you think your clinic focuses on health equity too little, the right amount, or too much?

# Q7 Have you taken any of the following actions in the last year? (Select all that apply)

# Specify other actions

# Q8 Your clinic has access to reports that compare healthcare quality data in our patients between different groups (racial/ethnic groups, type of insurance, and whether or not they need an interpreter). This allows our clinics to identify health inequities among their patients. Please describe your experience with these reports.
# [dash_aware_v1_2024]
# dash* columns

# For those that selected have seen the data (3 or 4)
# We would like to understand how these reports have impacted staff and providers in our family medicine clinics. Please select any statements that you agree with.
# The health equity reports have:


# Q9 Every clinic has strengths and challenges when it comes to making changes for health equity.
# Please rate whether you believe each item in the list is a strength or weakness for health equity work at your clinic:
# sw* columns


# Q10 Overall, how confident are you in your ability to provide the same quality of care to patients with disability as you provide to patients without disability.
# [confidence_disability_2024]

# Please tell us how much each of the following is a barrier for you in caring for patients with disability...?
# disability_*

# Free text

# Q11 	Please rate how much you agree or disagree with the following statements:
# org_* questions


# Q12 Are there people or organizations in the community, at UCH, or at the University of Colorado that could be partners to try to address health inequities among patients at your clinic?
# If yes, who are they?
# This is a free text response question
# Set temp for development
temp <- data
