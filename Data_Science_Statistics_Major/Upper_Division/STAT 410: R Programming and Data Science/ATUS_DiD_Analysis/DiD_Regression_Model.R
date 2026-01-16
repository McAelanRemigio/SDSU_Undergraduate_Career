echo = FALSE
# Treatment: Can the job be remote or not
atus_full$treatment <- ifelse(atus_full$TEMJOT.y == 1, 1, 0)  
# 1 = remote, 0 = non-remote

# Time: Was the year pre or post pandemic?
atus_full$time <- ifelse(atus_full$TUYEAR > 2019, 1, 0)
# 1 = post-pandemic, 0 = pre-pandemic. 2019 is considered a transition year so it's not used.

# Interaction Term between Treatment and Time
atus_full$treatment_time_interaction <- atus_full$treatment * atus_full$time

# DiD Regression Model with Interactions
did_model <- lm(TTWK ~ treatment + time + treatment_time_interaction + TEAGE + TESEX + PEEDUCA + TEMJOT.y + PEHSPNON + PTDTRACE + TRERNWA.y, data = atus_full)

summary(did_model)

# Based on this analysis, we reject the null hypothesis H0 because we have supporting evidence to support the HA, 
# indicating that there was a decrease in time spent working due to time flexibility after the pandemic, 
# and that people who had the option to go remote overall had more leisure time than those who did not go remote or did not have the option to go remote.

# 1) The analysis shows that remote workers spent less time working than those who did not have the option to work remotely, 
# meaning that more flexibility leads to fewer hours worked.

# 2) The interaction between remote work and the post pandemic period was significant and negative, 
# meaning the decrease in work time was stronger for remote workers after the pandemic, 
# suggesting that remote work flexibility comes with long term benefits.

# 3) Other factors like age, sex, education level, and earnings also influenced the total time worked. 
# Generally, older people, men, those with lower education, and higher earners worked more.

# In conclusion, remote work has led to a reduction in total work hours post-pandemic/"after the policy change". 
# This shift gave remote workers more leisure time compared to non-remote workers.
