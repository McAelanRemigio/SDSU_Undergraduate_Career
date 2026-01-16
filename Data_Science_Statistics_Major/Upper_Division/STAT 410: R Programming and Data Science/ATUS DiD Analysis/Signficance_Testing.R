echo = FALSE
### T-tests (continous variables)

# 1) Age and Sex
t_test_age_sex <- t.test(TEAGE ~ TESEX, data = clean_atus_full)
print(t_test_age_sex)

# T-test Age and Sex: p-value 2.2e-16 < 0.05
# We have significant evidence to support the conclusion that there is a significant difference in average age between men and women.
# TEAGE and TESEX will be used in determining the future DiD model.

### Chi-squared Tests (categorical variables)

# 2) Sex and Race
chi_square_sex_race <- chisq.test(table(clean_atus_full$TESEX, clean_atus_full$PTDTRACE))
print(chi_square_sex_race)

# Chi-Square Test Sex and Race: p-value 2.2e-16 < 0.05 
# There is a warning about approximation.
# We have significant evidence to support the conclusion that there is a strong association between sex and race.
# Would normally keep both, but the alternative hypothesis means knowing someones sex gives some information about their race distribution, 
# which is not a valid conclusion. Will not be including these 2 together since there is a warning about approximation.

# 3) Education level and Major job
chi_square_education_major <- chisq.test(table(clean_atus_full$PEEDUCA, clean_atus_full$TEMJOT.y))
print(chi_square_education_major)

# Chi-Square Test Education Level and Major Job: p-value 2.2e-16 < 0.05
# We have significant evidence to support the conclusion that education level is highly associated with job type.
# PEEDUCA and TEMJOT.y will be used in determining the future DiD model.

# 4) Hispanic origin and Employer type
chi_square_hispanic_employer <- chisq.test(table(clean_atus_full$PEHSPNON, clean_atus_full$TESPEMPNOT.y))
print(chi_square_hispanic_employer)

# Chi-Square Test Hispanic Origin and Employer Type: p-value 4.02e-10 < 0.05
# There is significant evidence to indicate that ethnicity is related to the type of employer.
# PEHSPNON and TESPEMPNOT.y will be used in determining the future DiD model.

# 5) Full-Time/Part-Time Status and Day of the Week
chi_square_ftptstatus_weekday <- chisq.test(table(clean_atus_full$TRDPFTPT.y, clean_atus_full$TUDIARYDAY.y))
print(chi_square_ftptstatus_weekday)

# Chi-Square Test Full-Time/Part-Time and Day of Week: p-value 0.2984 > 0.05
# We do not have significant evidence to support that there is a relationship between someone's work status and the weekday or weekend.
# Will not be including TRDPFTPT.y or TUDIARYDAY.y in determining the future DiD model.

#ANOVA (comparing multiple groups)

# 6) Total time by Education level
anova_total_time_education <- aov(TTOT ~ PEEDUCA, data = clean_atus_full)
summary(anova_total_time_education)

# ANOVA Test Total Time and Education Level: p-value 0.0375 < 0.05
# We have significant evidence to support the conclusion that there is a difference in total time reported by education level.
# Though this is significant, it is marginally significant compared to all other very significant p-values.
# Will not be including PEEDUCA in determining the future DiD model.

# 7) Weekly Earnings by Race
anova_weekly_earnings_race <- aov(TRERNWA.y ~ PTDTRACE, data = clean_atus_full)
summary(anova_weekly_earnings_race)

# ANOVA Test Weekly Earnings by Race: p-value 2e-16 < 0.05
# We have significant evidence to support the conclusion that race has an effect on earnings.
# Will be including PDTRACE and TRERNWA.y in determining the future DiD model.

# 8) Time spent working by Labor force status
anova_time_working_labor_status <- aov(TTWK ~ TELFS.y, data = clean_atus_full)
summary(anova_time_working_labor_status)

# ANOVA Test Weekly Earnings by Race: p-value 2e-16 < 0.05
# We have significant evidence to support the conclusion that race has an effect on earnings.
# Will be including PDTRACE and TRERNWA.y in determining the future DiD model.
