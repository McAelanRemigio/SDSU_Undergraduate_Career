echo = FALSE
summary(clean_atus_before)
sum(is.na(clean_atus_before)) # Checking for missing values
summary(clean_atus_after)
sum(is.na(clean_atus_after)) # Checking for missing values

# to show the differences between the eras, pre-pandemic is lightcoral, post-pandemic is lightgreen, and altogether is lightblue

# 1a) Age Distribution Histogram 2015-2019
ggplot(clean_atus_before, aes(x = TEAGE)) + 
  geom_histogram(binwidth = 5, fill = "lightcoral", color = "black", alpha = 0.7) +
  theme_minimal() +
  labs(title = "Age Distribution of Survey Respondents 2015-2019", x = "Age", y = "Frequency")

# 1b) Age Distribution Histogram 2019-2023
ggplot(clean_atus_after, aes(x = TEAGE)) + 
  geom_histogram(binwidth = 5, fill = "lightgreen", color = "black", alpha = 0.7) +
  theme_minimal() +
  labs(title = "Age Distribution of Survey Respondents 2019-2023", x = "Age", y = "Frequency")

# 1c) Age Distribution Histogram 2015-2023
ggplot(clean_atus_full, aes(x = TEAGE)) + 
  geom_histogram(binwidth = 5, fill = "lightblue", color = "black", alpha = 0.7) +
  theme_minimal() +
  labs(title = "Age Distribution of Survey Respondents 2015-2023", x = "Age", y = "Frequency")

### 1) The age distribution from 2015-2019 and 2019-2023 are fairly consistent, with a strong presence in ages 30-70 
#### but a dip in respondents from x<25 and x>80. 2019-2023, however, had a more even distribution which suggests 
### there was more even participation across all ages in general. Overall though, the aggregated 2015-2023 age histogram 
### suggests a Normal distribution, with slighter improvements in adult participation post 2019 due to 
### improvements in survey responses from older age groups.

# 2a) Weekly Earnings (Adjusted) Boxplot 2015-2019
ggplot(clean_atus_before, aes(x = TRERNWA.y)) + 
  geom_boxplot(fill = "lightcoral", color = "black") +
  theme_minimal() +
  labs(title = "Weekly Earnings Distribution 2015-2019", x = "Weekly Earnings (Adjusted)", y = "Frequency")

# 2b) Weekly Earnings (Adjusted) Boxplot 2019-2023
ggplot(clean_atus_after, aes(x = TRERNWA.y)) + 
  geom_boxplot(fill = "lightgreen", color = "black") +
  theme_minimal() +
  labs(title = "Weekly Earnings Distribution 2019-2023", x = "Weekly Earnings (Adjusted)", y = "Frequency")

# 2c) Weekly Earnings (Adjusted) Boxplot 2015-2023
ggplot(clean_atus_full, aes(x = TRERNWA.y)) + 
  geom_boxplot(fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(title = "Weekly Earnings Distribution 2015-2023", x = "Weekly Earnings (Adjusted)", y = "Frequency")

### 2) All box plots are heavily skewed right with lots of outliers, indicating most respondents are lower income 
### and that the outliers are higher income. The median, IQR, whiskers, and outliers don't shift very much,
### meaning that the income hasn't shifted much either.

# 3a) Family Time Boxplot 2015-2019
ggplot(clean_atus_before, aes(x = TRTALONE, y = TRTFAMILY)) + 
  geom_boxplot(fill = "lightcoral", color = "black") +
  theme_minimal() +
  labs(title = "Family Time by Alone Time 2015-2019", x = "Time Spent Alone (Hours)", y = "Family Time(Hours)")

# 3b) Family Time Boxplot 2019-2023
ggplot(clean_atus_after, aes(x = TRTALONE, y = TRTFAMILY)) + 
  geom_boxplot(fill = "lightgreen", color = "black") +
  theme_minimal() +
  labs(title = "Family Time by Alone Time 2019-2023", x = "Time Spent Alone (Hours)", y = "Family Time(Hours)")

# 3c) Family Time Boxplot 2015-2023
ggplot(clean_atus_before, aes(x = TRTALONE, y = TRTFAMILY)) + 
  geom_boxplot(fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(title = "Family Time by Alone Time 2015-2023", x = "Time Spent Alone (Hours)", y = "Family Time(Hours)")

### 3) Family time by alone time appears fairly stable and didn't dramatically change across any period of time.

# 4a) Gender Distribution Bar Plot 2015-2019
ggplot(clean_atus_before, aes(x = factor(TESEX))) + 
  geom_bar(fill = "lightcoral", color = "black") +
  theme_minimal() +
  labs(title = "Gender Distribution 2015-2019", x = "Gender", y = "Count")

# 4b) Gender Distribution Bar Plot 2019-2023
ggplot(clean_atus_after, aes(x = factor(TESEX))) + 
  geom_bar(fill = "lightgreen", color = "black") +
  theme_minimal() +
  labs(title = "Gender Distribution 2019-2023", x = "Gender", y = "Count")

# 4c) Gender Distribution Bar Plot 2015-2023
ggplot(clean_atus_full, aes(x = factor(TESEX))) + 
  geom_bar(fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(title = "Gender Distribution 2015-2023", x = "Gender", y = "Count")

### 4) The distribution between the 2 gender categories remains the same, with more females than males. 
### There is a skew in both boxplots, but gender participation generally stayed balanced over time.

# 5a) Education Level Distribution 2015-2019
ggplot(clean_atus_before, aes(x = factor(PEEDUCA))) + 
  geom_bar(fill = "lightcoral", color = "black") +
  theme_minimal() +
  labs(title = "Education Level Distribution 2015-2019", x = "Education Level", y = "Count")

# 5b) Education Level Distribution 2019-2023
ggplot(clean_atus_after, aes(x = factor(PEEDUCA))) + 
  geom_bar(fill = "lightgreen", color = "black") +
  theme_minimal() +
  labs(title = "Education Level Distribution 2019-2023", x = "Education Level", y = "Count")

# 5c) Education Level Distribution 2015-2023
ggplot(clean_atus_full, aes(x = factor(PEEDUCA))) + 
  geom_bar(fill = "lightblue", color = "black") +
  theme_minimal() +
  labs(title = "Education Level Distribution 2015-2023", x = "Education Level", y = "Count")

### 5) Education levels 39, 40, 43, and 44 dominate the distribution, corresponding to 
### high school graduates, associates degrees, bachelors degrees, and postgraduate degrees. 
### The distributions across both time spans are similar but there is a dip in total responses 
### for the 2019-2023 period. Educational backgrounds remained fairly stable over the years.

# 6a) Alone on Weekdays vs Weekends 2015-2019
ggplot(clean_atus_before, aes(x = TUDIARYDAY.y, y = TRTALONE, fill = TUDIARYDAY.y)) + 
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Time Spent Alone on Weekdays vs Weekends 2015-2019", 
       x = "Day of the Week", 
       y = "Time Spent Alone (Hours)")

# 6b) Alone on Weekdays vs Weekends 2019-2023
ggplot(clean_atus_after, aes(x = TUDIARYDAY.y, y = TRTALONE, fill = TUDIARYDAY.y)) + 
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Time Spent Alone on Weekdays vs Weekends 2019-2023", 
       x = "Day of the Week", 
       y = "Time Spent Alone (Hours)")

# 6c) Alone on Weekdays vs Weekends 2015-2023
ggplot(clean_atus_full, aes(x = TUDIARYDAY.y, y = TRTALONE, fill = TUDIARYDAY.y)) + 
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Time Spent Alone on Weekdays vs Weekends 2015-2023", 
       x = "Day of the Week", 
       y = "Time Spent Alone (Hours)")

### 6) People generally spend a fair amount of time alone, regardless of the day, 
### but a consistent group of individuals are spending time alone a lot more than most.

# 7a) With Family on Weekdays vs Weekends 2015-2019
ggplot(clean_atus_before, aes(x = TUDIARYDAY.y, y = TRTFAMILY, fill = TUDIARYDAY.y)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Time Spent with Family on Weekdays vs Weekends 2015-2019", 
       x = "Day of the Week", 
       y = "Time with Family (Hours)")

# 7b) With Family on Weekdays vs Weekends 2019-2023
ggplot(clean_atus_after, aes(x = TUDIARYDAY.y, y = TRTFAMILY, fill = TUDIARYDAY.y)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Time Spent with Family on Weekdays vs Weekends 2019-2023", 
       x = "Day of the Week", 
       y = "Time with Family (Hours)")

# 7c) With Family on Weekdays vs Weekends 2015-2023
ggplot(clean_atus_full, aes(x = TUDIARYDAY.y, y = TRTFAMILY, fill = TUDIARYDAY.y)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Time Spent with Family on Weekdays vs Weekends 2015-2023", 
       x = "Day of the Week", 
       y = "Time with Family (Hours)")

### 7) Across all time periods, the distribution of time spent with family shows a 
### consistent shape with lots of variation in family time. 
### Outliers reporting high family time likely indicate larger households/caregiving of some sort. 
### Despite the shift, people's routines and time spent with family have not shifted dramatically.

# 8a) Family by Gender 2015-2019
ggplot(clean_atus_before, aes(x = factor(TESEX), y = TRTFAMILY, fill = factor(TESEX))) + geom_boxplot() +
  theme_minimal() +
  labs(title = "Time Spent with Family by Gender 2015-2019", 
       x = "Gender", 
       y = "Time with Family (Hours)") +
  scale_fill_manual(values = c("lightcoral", "pink"))

# 8b) Family by Gender 2019-2023
ggplot(clean_atus_after, aes(x = factor(TESEX), y = TRTFAMILY, fill = factor(TESEX))) + geom_boxplot() +
  theme_minimal() +
  labs(title = "Time Spent with Family by Gender 2019-2023", 
       x = "Gender", 
       y = "Time with Family (Hours)") +
  scale_fill_manual(values = c("lightgreen", "green"))

# 8c) Family by Gender 2015-2023
ggplot(clean_atus_full, aes(x = factor(TESEX), y = TRTFAMILY, fill = factor(TESEX))) + geom_boxplot() +
  theme_minimal() +
  labs(title = "Time Spent with Family by Gender 2015-2023", 
       x = "Gender", 
       y = "Time with Family (Hours)") +
  scale_fill_manual(values = c("lightblue", "blue"))

### 8) Gender plays a role in family time where females generally spend more time with family on average than males. 
### This gap generally has stayed consistent and there were not many changes.

# 9a) Labor Force Status 2015-2019
ggplot(clean_atus_before, aes(x = factor(TELFS.y))) +
  geom_bar(fill = "lightcoral") +
  labs(title = "Labor Force Status 2015-2019", x = "Status", y = "Count")

# 9b) Labor Force Status 2019-2023
ggplot(clean_atus_after, aes(x = factor(TELFS.y))) +
  geom_bar(fill = "lightgreen") +
  labs(title = "Labor Force Status 2019-2023", x = "Status", y = "Count")

# 9c) Labor Force Status 2015-2023
ggplot(clean_atus_full, aes(x = factor(TELFS.y))) +
  geom_bar(fill = "lightblue") +
  labs(title = "Labor Force Status 2015-2023", x = "Status", y = "Count")

### 9) Status 1 means employed, dominated both periods but saw a drop from 2015-2019 to 2019-2023, 
## and Status 5 means not in labor force, decreased slightly. 
### Status 2-4 remained much less frequent but relatively stable, meaning that the data is overall 
### skewed toward employed and not in the labor force.

# 10a) Hourly Earnings 2015-2019
ggplot(clean_atus_before, aes(x = TEERN)) +
  geom_histogram(fill = "lightcoral", bins = 30) +
  labs(title = "Hourly Earnings Distribution 2015-2019", x = "Hourly Earnings", y = "Frequency")

# 10b) Hourly Earnings 2019-2023
ggplot(clean_atus_after, aes(x = TEERN)) +
  geom_histogram(fill = "lightgreen", bins = 30) +
  labs(title = "Hourly Earnings Distribution 2019-2023", x = "Hourly Earnings", y = "Frequency")

# 10c) Hourly Earnings 2015-2023
ggplot(clean_atus_full, aes(x = TEERN)) +
  geom_histogram(fill = "lightblue", bins = 30) +
  labs(title = "Hourly Earnings Distribution 2015-2023", x = "Hourly Earnings", y = "Frequency")

### 10) All histograms are heavily right skewed, meaning that most works earn relatively low hourly wages.
### There are big outliers going as far as $100,000 an hour, meaning this could also be a data entry error. 
### The skew suggests income inequality where a small number earn more than the majority.

# 11a) Time Use by Employer Type 2015-2019
ggplot(clean_atus_before, aes(x = factor(TESPEMPNOT.y), y = TRTFAMILY)) +
  geom_boxplot(fill = "lightcoral") +
  labs(title = "Family Time by Employer Type 2015-2019", x = "Employer Type", y = "Family Time (Hours)")

# 11b) Time Use by Employer Type 2019-2023
ggplot(clean_atus_after, aes(x = factor(TESPEMPNOT.y), y = TRTFAMILY)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Family Time by Employer Type 2019-2023", x = "Employer Type", y = "Family Time (Hours)")

# 11c) Time Use by Employer Type 2015-2023
ggplot(clean_atus_full, aes(x = factor(TESPEMPNOT.y), y = TRTFAMILY)) +
  geom_boxplot(fill = "lightblue") +
  labs(title = "Family Time by Employer Type 2015-2023", x = "Employer Type", y = "Family Time (Hours)")

### 11) Distribution shapes for all employer types stay consistent the most, 
### but family time seems to increase from 2015-2019 to 2019 to 2023. 
### However, unemployed/informal work show the widest variation due to their massive amount of outliers. 
### This means that structured employment like the sectors likely have more stable routines and 
### informal/unemployed have a greater variability in lifestyle, which could explain the data spread.
