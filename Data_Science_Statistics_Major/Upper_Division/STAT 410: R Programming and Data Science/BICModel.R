### BIC Null Model and BIC Full Model

# The goal of this project is to use causal inference to determine how remote work affects time use. 
# We are trying to understand what variables matter and why. 
# I want to isolate the effect of a treatment (the 2019-2023 period) on the outcome, 
# being the total time spent working. I want to find out what variables don't bias the estimate, 
# so I will choose the best fit between BIC models to select only the relevant control variables.

echo = FALSE
# null model (intercept only) where TTWK means Total Time Spent Working
null_model <- lm(TTWK ~ 1, data = clean_atus_full)

# full model with all predictors
full_model <- lm(TTWK ~ TEAGE + TESEX + PEEDUCA + TEMJOT.y + PEHSPNON + TESPEMPNOT.y + PTDTRACE + TRERNWA.y + TELFS.y, data = clean_atus_full)

bicn = BIC(null_model)
bicf = BIC(full_model)

cat("BICN: ", bicn, "\n")
cat("BICF: ", bicf, "\n")

# The full model has a lower BIC compared to the null model, suggesting that the full model 
# with all the predictors fits the data significantly better than the null model. 
# Lower BIC means there is a better balance between model fit and complexity. 
# For the DiD Linear Regression Model with Interactions, we will be using the full model based on BIC.
