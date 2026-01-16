# ============================================================
# MPIE Analysis (Clean Version)
# Author: McAelan Remigio
# Notes:
# - This script assumes `data`, `tidy_data`, and
#   `tidy_mpie_data_with_instructor` are already loaded.
# - No student-level data is included in the repo.
# ============================================================

library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(readr)
library(scales)
library(here)

# helpers
is_pass_grade <- function(x) {
  x %in% c("A", "B", "C", "P")
}

clean_course_name <- function(x) {
  # Removes section-like suffixes such as "-A12", "-B3", "-001", etc.
  str_remove(x, "-[A-Za-z0-9]+$")
}

# Instructor Status: Post-MPIE vs Never-MPIE (Student Counts)

tidy_mpie_data_with_instructor <- tidy_mpie_data_with_instructor %>%
  mutate(
    Instructor_Status = case_when(
      Post_MPIE ~ "Post_MPIE",
      MPIE_AllTerm == "N" ~ "Never_MPIE",
      TRUE ~ NA_character_
    )
  )

student_counts <- tidy_mpie_data_with_instructor %>%
  filter(Instructor_Status %in% c("Post_MPIE", "Never_MPIE")) %>%
  group_by(EnrollmentTerm, Instructor_Status) %>%
  summarise(StudentCount = n(), .groups = "drop")

ggplot(student_counts, aes(x = EnrollmentTerm, y = StudentCount, fill = Instructor_Status)) +
  geom_col(position = "dodge") +
  theme_minimal() +
  labs(
    title = "Students Taught by Post-MPIE vs Never-MPIE Instructors",
    x = "Enrollment Term",
    y = "Number of Students",
    fill = "Instructor Status"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Pass Rates by Course

data_clean <- data %>%
  mutate(
    pass = as.integer(is_pass_grade(Grade)),
    course_name = clean_course_name(course_name)
  )

course_pass_rates <- data_clean %>%
  group_by(course_name) %>%
  summarise(
    total = n(),
    passed = sum(pass, na.rm = TRUE),
    pass_rate_pct = 100 * passed / total,
    .groups = "drop"
  ) %>%
  arrange(desc(pass_rate_pct))

print(course_pass_rates)

ggplot(course_pass_rates, aes(x = reorder(course_name, pass_rate_pct), y = pass_rate_pct)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Pass Rates by Course",
    x = "Course Name",
    y = "Pass Rate (%)"
  ) +
  ylim(0, 100) +
  theme_minimal()

# Pass Rates by Instructor (Overall)

if ("InstructorName" %in% names(data_clean)) {
  instructor_pass_rates <- data_clean %>%
    filter(!is.na(InstructorName), InstructorName != "") %>%
    group_by(InstructorName) %>%
    summarise(
      total_students = n(),
      total_passed = sum(pass, na.rm = TRUE),
      pass_rate_pct = 100 * total_passed / total_students,
      .groups = "drop"
    ) %>%
    arrange(desc(pass_rate_pct))

  print(instructor_pass_rates)

  p_instructor <- ggplot(instructor_pass_rates,
                         aes(x = reorder(InstructorName, pass_rate_pct), y = pass_rate_pct)) +
    geom_col() +
    coord_flip() +
    labs(
      title = "Pass Rate by Instructor",
      x = "Instructor Name",
      y = "Pass Rate (%)"
    ) +
    ylim(0, 100) +
    theme_minimal() +
    theme(axis.text.y = element_text(size = 8))

  print(p_instructor)

  ggsave(
    filename = here("outputs", "instructor_passrate.png"),
    plot = p_instructor,
    width = 14, height = 8, dpi = 300
  )
}

# Pass Rates by Instructor by MPIE (A/B Columns Version)

ab_cols_needed <- c(
  "InstructorName_A", "InstructorName_B",
  "EnrolledCourseGrade_A", "EnrolledCourseGrade_B",
  "MPIE_YN_A", "MPIE_YN_B"
)

if (all(ab_cols_needed %in% names(tidy_data))) {

  instructor_long <- tidy_data %>%
    select(all_of(ab_cols_needed)) %>%
    pivot_longer(
      cols = ends_with("_A") | ends_with("_B"),
      names_to = c(".value", "section"),
      names_pattern = "^(InstructorName|EnrolledCourseGrade|MPIE_YN)_(A|B)$"
    ) %>%
    filter(!is.na(EnrolledCourseGrade), EnrolledCourseGrade != "",
           !is.na(InstructorName), InstructorName != "") %>%
    mutate(
      pass = as.integer(EnrolledCourseGrade %in% c("A", "B", "C", "P")),
      MPIE = case_when(
        MPIE_YN %in% c("Y", "YN") ~ 1L,
        MPIE_YN %in% c("N") ~ 0L,
        TRUE ~ NA_integer_
      )
    ) %>%
    filter(!is.na(MPIE))

  mpie_instructor_pass_rates <- instructor_long %>%
    group_by(InstructorName, MPIE) %>%
    summarise(
      total_students = n(),
      total_passed = sum(pass, na.rm = TRUE),
      pass_rate_pct = 100 * total_passed / total_students,
      .groups = "drop"
    ) %>%
    arrange(desc(pass_rate_pct))

  print(mpie_instructor_pass_rates)

  write_csv(mpie_instructor_pass_rates, here("outputs", "MPIE_instructor_passrate.csv"))
}

# Placement Score Normalization + Correlations + Distributions

score_cols_needed <- c("PlacementScore_BSTEM", "PlacementScore_SLAM",
                       "PlacementScore_MDTP", "PlacementScore_ESL")

if (all(score_cols_needed %in% names(data_clean))) {

  data_scores <- data_clean %>%
    mutate(
      PlacementScore_BSTEM_norm = PlacementScore_BSTEM / 9,
      PlacementScore_SLAM_norm  = PlacementScore_SLAM / 3,
      PlacementScore_MDTP_norm  = PlacementScore_MDTP / 27,
      PlacementScore_ESL_norm   = PlacementScore_ESL / 6
    )

  cor_bstem <- cor(data_scores$PlacementScore_BSTEM_norm, data_scores$pass, use = "complete.obs")
  cor_slam  <- cor(data_scores$PlacementScore_SLAM_norm,  data_scores$pass, use = "complete.obs")
  cor_mdtp  <- cor(data_scores$PlacementScore_MDTP_norm,  data_scores$pass, use = "complete.obs")
  cor_esl   <- cor(data_scores$PlacementScore_ESL_norm,   data_scores$pass, use = "complete.obs")

  print(cor_bstem); print(cor_slam); print(cor_mdtp); print(cor_esl)

  # Hist helper
  plot_hist <- function(df, col, title) {
    ggplot(df) +
      geom_histogram(aes(x = .data[[col]]), bins = 30, alpha = 0.6) +
      labs(title = title, x = "Normalized Score (0-1)", y = "Frequency") +
      theme_minimal()
  }

  print(plot_hist(data_scores, "PlacementScore_BSTEM_norm", "Distribution of BSTEM Placement Scores (Normalized)"))
  print(plot_hist(data_scores, "PlacementScore_SLAM_norm",  "Distribution of SLAM Placement Scores (Normalized)"))
  print(plot_hist(data_scores, "PlacementScore_MDTP_norm",  "Distribution of MDTP Placement Scores (Normalized)"))
  print(plot_hist(data_scores, "PlacementScore_ESL_norm",   "Distribution of ESL Placement Scores (Normalized)"))
}

# Pass Rates Over Time (By Term)

terms_pass_rates <- data_clean %>%
  group_by(EnrollmentTerm) %>%
  summarise(
    total_students = n(),
    total_passed = sum(pass, na.rm = TRUE),
    pass_rate_pct = 100 * total_passed / total_students,
    .groups = "drop"
  ) %>%
  arrange(EnrollmentTerm)

print(terms_pass_rates)

ggplot(terms_pass_rates, aes(x = EnrollmentTerm, y = pass_rate_pct, group = 1)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Pass Rate Trends Over Time",
    x = "Enrollment Term",
    y = "Pass Rate (%)"
  ) +
  ylim(0, 100) +
  theme_minimal()
