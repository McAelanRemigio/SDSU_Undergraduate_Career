# Exploratory Data Analysis (EDA)

# Purpose:
# Assess demographic balance, labor characteristics, and time-use
# distributions across pre- and post-periods to support DiD validity.

# Age distribution
ggplot(clean_atus_pre, aes(x = TEAGE)) +
  geom_histogram(binwidth = 5, fill = "lightcoral", color = "black", alpha = 0.7) +
  theme_minimal() +
  labs(title = "Age Distribution (Pre-Period)", x = "Age", y = "Count")

ggplot(clean_atus_post, aes(x = TEAGE)) +
  geom_histogram(binwidth = 5, fill = "lightgreen", color = "black", alpha = 0.7) +
  theme_minimal() +
  labs(title = "Age Distribution (Post-Period)", x = "Age", y = "Count")

# Earnings distribution
ggplot(clean_atus_full, aes(x = TRERNWA.y)) +
  geom_boxplot(fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(title = "Weekly Earnings Distribution (All Years)",
       x = "Weekly Earnings (Adjusted)", y = "")

# Gender composition 
ggplot(clean_atus_full, aes(x = factor(TESEX))) +
  geom_bar(fill = "steelblue") +
  theme_minimal() +
  labs(title = "Gender Composition (All Years)",
       x = "Gender", y = "Count")

# Education levels 
ggplot(clean_atus_full, aes(x = factor(PEEDUCA))) +
  geom_bar(fill = "steelblue") +
  theme_minimal() +
  labs(title = "Education Level Distribution (All Years)",
       x = "Education Level", y = "Count")

# Time use: alone vs family
ggplot(clean_atus_full, aes(x = TRTALONE, y = TRTFAMILY)) +
  geom_point(alpha = 0.3) +
  theme_minimal() +
  labs(title = "Family Time vs Alone Time",
       x = "Time Spent Alone (Hours)",
       y = "Time Spent with Family (Hours)")

# Labor force status
ggplot(clean_atus_full, aes(x = factor(TELFS.y))) +
  geom_bar(fill = "steelblue") +
  theme_minimal() +
  labs(title = "Labor Force Status Distribution",
       x = "Status", y = "Count")
