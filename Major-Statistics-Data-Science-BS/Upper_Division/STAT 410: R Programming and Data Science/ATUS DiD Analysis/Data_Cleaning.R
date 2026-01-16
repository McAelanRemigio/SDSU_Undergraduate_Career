# Loading & Transforming Data

library(dplyr)
library(ggplot2)
library(readr)
library(stringr)
echo = FALSE
# res = respondent file
# act = activity file
# sum = activity summary file

# Before the Policy Shift

dat_2015_act <-read.csv("atusact_2015.csv", header = TRUE)
dat_2015_res <-read.csv("atusresp_2015.csv", header = TRUE)
dat_2015_sum <-read.csv("atussum_2015.csv", header = TRUE)

dat_2016_act <-read.csv("atusact_2016.csv", header = TRUE)
dat_2016_res <-read.csv("atusresp_2016.csv", header = TRUE)
dat_2016_sum <-read.csv("atussum_2016.csv", header = TRUE)

dat_2017_act <-read.csv("atusact_2017.csv", header = TRUE)
dat_2017_res <-read.csv("atusresp_2017.csv", header = TRUE)
dat_2017_sum <-read.csv("atussum_2017.csv", header = TRUE)

dat_2018_act <-read.csv("atusact_2018.csv", header = TRUE)
dat_2018_res <-read.csv("atusresp_2018.csv", header = TRUE)
dat_2018_sum <-read.csv("atussum_2018.csv", header = TRUE)

# Transition
dat_2019_act <-read.csv("atusact_2019.csv", header = TRUE)
dat_2019_res <-read.csv("atusresp_2019.csv", header = TRUE)
dat_2019_sum <-read.csv("atussum_2019.csv", header = TRUE)

# After Policy Shift
dat_2020_act <-read.csv("atusact_2020.csv", header = TRUE)
dat_2020_res <-read.csv("atusresp_2020.csv", header = TRUE)
dat_2020_sum <-read.csv("atussum_2020.csv", header = TRUE)

dat_2021_act <-read.csv("atusact_2021.csv", header = TRUE)
dat_2021_res <-read.csv("atusresp_2021.csv", header = TRUE)
dat_2021_sum <-read.csv("atussum_2021.csv", header = TRUE)

dat_2022_act <-read.csv("atusact_2022.csv", header = TRUE)
dat_2022_res <-read.csv("atusresp_2022.csv", header = TRUE)
dat_2022_sum <-read.csv("atussum_2022.csv", header = TRUE)

dat_2023_act <-read.csv("atusact_2023.csv", header = TRUE)
dat_2023_res <-read.csv("atusresp_2023.csv", header = TRUE)
dat_2023_sum <-read.csv("atussum_2023.csv", header = TRUE)

merge_atus_summary <- function(res, sum, year) {
  merged <- res %>%
    inner_join(sum, by = "TUCASEID") %>%
    mutate(Year = year)
  return (merged)
}

df_2015 <- merge_atus_summary(dat_2015_res, dat_2015_sum, 2015)
df_2016 <- merge_atus_summary(dat_2016_res, dat_2016_sum, 2016)
df_2017 <- merge_atus_summary(dat_2017_res, dat_2017_sum, 2017)
df_2018 <- merge_atus_summary(dat_2018_res, dat_2018_sum, 2018)
df_2019 <- merge_atus_summary(dat_2019_res, dat_2019_sum, 2019)
df_2020 <- merge_atus_summary(dat_2020_res, dat_2020_sum, 2020)
df_2021 <- merge_atus_summary(dat_2021_res, dat_2021_sum, 2021)
df_2022 <- merge_atus_summary(dat_2022_res, dat_2022_sum, 2022)
df_2023 <- merge_atus_summary(dat_2023_res, dat_2023_sum, 2023)

# all in one dataset
atus_before <- bind_rows(df_2015, df_2016, df_2017, df_2018, df_2019)
atus_after <- bind_rows(df_2019, df_2020, df_2021, df_2022, df_2023)
atus_full <- bind_rows(df_2015, df_2016, df_2017, df_2018,
                       df_2019, df_2020, df_2021, df_2022, df_2023)
# View(atus_before)
# View(atus_after)
# View(atus_full)

clean_atus_before <- atus_before %>%
  select(
    TEAGE, TESEX, PEEDUCA, PTDTRACE, PEHSPNON,  # Demographics
    TELFS.y, TEMJOT.y, TESPEMPNOT.y, TRERNWA.y, TEERN, TRDPFTPT.y,  # Employment Information
    TUFINLWGT.y,  # Weights
    TTOT, TTHR, TTWK, TRTALONE, TRTFAMILY, TRTFRIEND, TRTHH.y, TRTCHILD, TRTSPONLY,  # Time Use Totals
    TUDIARYDATE, TUDIARYDAY.y, TRHOLIDAY.y  # Diary Information, repeated for the other 3
  )

clean_atus_after <- atus_after %>%
  select(
    TEAGE, TESEX, PEEDUCA, PTDTRACE, PEHSPNON,
    TELFS.y, TEMJOT.y, TESPEMPNOT.y, TRERNWA.y, TEERN, TRDPFTPT.y,
    TUFINLWGT.y,
    TTOT, TTHR, TTWK, TRTALONE, TRTFAMILY, TRTFRIEND, TRTHH.y, TRTCHILD, TRTSPONLY,
    TUDIARYDATE, TUDIARYDAY.y, TRHOLIDAY.y
  )

clean_atus_full <- atus_full %>%
  select(
    TEAGE, TESEX, PEEDUCA, PTDTRACE, PEHSPNON,
    TELFS.y, TEMJOT.y, TESPEMPNOT.y, TRERNWA.y, TEERN, TRDPFTPT.y,
    TUFINLWGT.y,
    TTOT, TTHR, TTWK, TRTALONE, TRTFAMILY, TRTFRIEND, TRTHH.y, TRTCHILD, TRTSPONLY,
    TUDIARYDATE, TUDIARYDAY.y, TRHOLIDAY.y
  )

# View(clean_atus_before)
# View(clean_atus_after)
# View(clean_atus_full)
