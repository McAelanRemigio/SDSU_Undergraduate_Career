# Exploratory Association Tests

# Purpose:
# Examine associations among key demographic and labor variables
# to better understand their relationships and potential overlap.
# These tests are exploratory and are not used as definitive
# criteria for causal control selection.

echo = FALSE

# Continuous vs binary association
t_test_age_sex <- t.test(TEAGE ~ TESEX, data = clean_atus_full)

# Categorical associations
chi_sex_race <- chisq.test(table(clean_atus_full$TESEX, clean_atus_full$PTDTRACE))
chi_education_job <- chisq.test(table(clean_atus_full$PEEDUCA, clean_atus_full$TEMJOT.y))
chi_ethnicity_employer <- chisq.test(table(clean_atus_full$PEHSPNON, clean_atus_full$TESPEMPNOT.y))
chi_ftpt_weekday <- chisq.test(table(clean_atus_full$TRDPFTPT.y, clean_atus_full$TUDIARYDAY.y))

# Multi-group comparisons
anova_time_by_education <- aov(TTOT ~ PEEDUCA, data = clean_atus_full)
anova_earnings_by_race <- aov(TRERNWA.y ~ PTDTRACE, data = clean_atus_full)
anova_work_time_by_lfs <- aov(TTWK ~ TELFS.y, data = clean_atus_full)

# Summaries retained for reference
list(
  t_test_age_sex = summary(t_test_age_sex),
  chi_sex_race = chi_sex_race,
  chi_education_job = chi_education_job,
  chi_ethnicity_employer = chi_ethnicity_employer,
  chi_ftpt_weekday = chi_ftpt_weekday,
  anova_time_by_education = summary(anova_time_by_education),
  anova_earnings_by_race = summary(anova_earnings_by_race),
  anova_work_time_by_lfs = summary(anova_work_time_by_lfs)
)
