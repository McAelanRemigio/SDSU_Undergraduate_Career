### BIC Comparison: Null vs Full Outcome Model (Exploratory)

# Goal: sanity-check whether observed covariates meaningfully explain variation
# in TTWK (total time spent working). This BIC comparison is used as an
# exploratory model-fit check (predictive), not as a definitive method for
# causal control selection.

echo = FALSE

# Null model (intercept only)
null_model <- lm(TTWK ~ 1, data = clean_atus_full)

# Full model (candidate covariates)
full_model <- lm(
  TTWK ~ TEAGE + TESEX + PEEDUCA + PEHSPNON + TESPEMPNOT.y +
    PTDTRACE + TRERNWA.y + TELFS.y + TEMJOT.y,
  data = clean_atus_full
)

bic_null <- BIC(null_model)
bic_full <- BIC(full_model)

cat("BIC (Null): ", bic_null, "\n")
cat("BIC (Full): ", bic_full, "\n")

# Interpretation:
# If BIC (Full) < BIC (Null), the covariates improve fit enough to justify
# added complexity. This supports including relevant covariates in subsequent
# analyses, while final control choice should still be guided by causal reasoning.
