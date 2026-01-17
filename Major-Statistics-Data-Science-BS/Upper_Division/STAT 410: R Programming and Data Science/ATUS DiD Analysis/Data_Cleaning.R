# Loading & Transforming Data (ATUS)

echo = FALSE

library(dplyr)
library(readr)

# NOTE:
# The DiD analysis in this project uses respondent + summary files.
# Activity files are loaded only if needed for extended analyses.

# helpers

read_atus_year <- function(year, data_dir = ".") {
  res_path <- file.path(data_dir, paste0("atusresp_", year, ".csv"))
  sum_path <- file.path(data_dir, paste0("atussum_",  year, ".csv"))

  res <- read_csv(res_path, show_col_types = FALSE)
  sum <- read_csv(sum_path, show_col_types = FALSE)

  res %>%
    inner_join(sum, by = "TUCASEID") %>%
    mutate(Year = year)
}

# load years

years <- 2015:2023

atus_full <- bind_rows(lapply(years, read_atus_year))

# create pre/post subsets 
atus_pre  <- atus_full %>% filter(Year <= 2018)
atus_2019 <- atus_full %>% filter(Year == 2019)
atus_post <- atus_full %>% filter(Year >= 2020)

# analysis variable selection

analysis_cols <- c(
  # Demographics
  "TEAGE", "TESEX", "PEEDUCA", "PTDTRACE", "PEHSPNON",

  # Employment info
  "TELFS.y", "TEMJOT.y", "TESPEMPNOT.y", "TRERNWA.y", "TEERN", "TRDPFTPT.y",

  # Weights
  "TUFINLWGT.y",

  # Time use totals
  "TTOT", "TTHR", "TTWK", "TRTALONE", "TRTFAMILY", "TRTFRIEND",
  "TRTHH.y", "TRTCHILD", "TRTSPONLY",

  # Diary info
  "TUDIARYDATE", "TUDIARYDAY.y", "TRHOLIDAY.y",

  # Added column
  "Year"
)

clean_atus_full  <- atus_full  %>% select(any_of(analysis_cols))
clean_atus_pre   <- atus_pre   %>% select(any_of(analysis_cols))
clean_atus_post  <- atus_post  %>% select(any_of(analysis_cols))
clean_atus_2019  <- atus_2019  %>% select(any_of(analysis_cols))

# View(clean_atus_full)
