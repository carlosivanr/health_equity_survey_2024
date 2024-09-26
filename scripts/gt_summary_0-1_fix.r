# Load packages
library(tidyverse)
library(gtsummary)

# Create a dataframe
all_0_vars <- data.frame(race_var = rep(0, 10))

# Convert the columns to factor and set levels as 0 or 1
all_0_vars <- all_0_vars %>%
  mutate(race_var = factor(race_var, levels = c("0", "1")))

# Set value to "1" which will become what will be displayed
all_0_vars %>%
  tbl_summary(
    value = list(race_var ~ "1")
  )