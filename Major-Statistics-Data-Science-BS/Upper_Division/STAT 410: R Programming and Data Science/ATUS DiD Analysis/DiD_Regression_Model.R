echo = FALSE
# DiD Setup

# exclude 2019, treat as "transition" year
did_data <- clean_atus_full %>%
  filter(Year != 2019) %>%
  mutate(
    # Treatment group: job is remote-capable (based on TEMJOT.y coding)
    treatment = if_else(TEMJOT.y == 1, 1L, 0L),

    # Post period: 2020+ (post-pandemic / post-shift period)
    post = if_else(Year >= 2020, 1L, 0L)
  )

# DiD regression model:
# - treatment = group indicator
# - post = time indicator
# - treatment:post = DiD estimate (interaction term)
did_model <- lm(
  TTWK ~ treatment + post + I(treatment * post) +
    TEAGE + TESEX + PEHSPNON + PTDTRACE + TRERNWA.y + TELFS.y,
  data = did_data
)

summary(did_model)

# Model Interpretation (Summary)

# The interaction term I(treatment * post) represents the
# difference-in-differences estimate: the change in total
# work time for remote-capable workers after 2020 relative
# to non-remote-capable workers.

# A negative coefficient on this interaction is consistent
# with a larger post-period reduction in work time among
# remote-capable workers, conditional on included covariates.

# Interpretation of this estimate relies on the standard
# DiD parallel trends assumption.
