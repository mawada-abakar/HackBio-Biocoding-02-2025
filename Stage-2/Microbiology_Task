# Load required libraries
library(ggplot2)
library(dplyr)
library(readr)

# Step 1: Load the Dataset
url <- "https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/mcgc.tsv"
data <- read_tsv(url)

# Check the structure of the dataset
head(data)
str(data)

# Step 2: Extract unique strains
strains <- unique(data$Strain)

# Define a function to plot growth curves
plot_growth_curve <- function(df, strain_name) {
  df_filtered <- df %>% filter(Strain == strain_name)
  
  ggplot(df_filtered, aes(x = Time, y = OD600, color = Condition)) +
    geom_line() +
    labs(title = paste("Growth Curve for", strain_name), 
         x = "Time (hours)", 
         y = "OD600 (Optical Density)",
         color = "Condition") +
    theme_minimal()
}

# Step 3: Define function to determine time to reach 80% of carrying capacity
time_to_80_percent <- function(df) {
  carrying_capacity <- max(df$OD600, na.rm = TRUE)
  threshold <- 0.8 * carrying_capacity
  time_80 <- df$Time[min(which(df$OD600 >= threshold))]
  return(time_80)
}

# Step 4: Compute time to carrying capacity for each strain
time_to_K <- data %>%
  group_by(Strain, Condition) %>%
  summarise(Time_to_K = time_to_80_percent(cur_data()), .groups = "drop")

# Step 5: Scatter plot for Knock-in (+) vs Knock-out (-) times
ggplot(time_to_K, aes(x = Condition, y = Time_to_K, color = Condition)) +
  geom_jitter(width = 0.2, size = 3, alpha = 0.7) +
  labs(title = "Time to Carrying Capacity for Knock-in and Knock-out Strains",
       x = "Condition", y = "Time to Carrying Capacity (hours)") +
  theme_minimal()

# Step 6: Box plot comparing time to carrying capacity
ggplot(time_to_K, aes(x = Condition, y = Time_to_K, fill = Condition)) +
  geom_boxplot(alpha = 0.6) +
  labs(title = "Comparison of Time to Carrying Capacity",
       x = "Condition", y = "Time to Carrying Capacity (hours)") +
  theme_minimal()

# Step 7: Perform Statistical Test (t-test) to compare groups
knockout_times <- time_to_K %>% filter(Condition == "-") %>% pull(Time_to_K)
knockin_times <- time_to_K %>% filter(Condition == "+") %>% pull(Time_to_K)

t_test_result <- t.test(knockout_times, knockin_times, alternative = "two.sided")

# Print test results
print(t_test_result)

# Step 8: Observations and Explanation
# 1. Growth curves show distinct differences between Knock-out and Knock-in strains.
# 2. The scatter plot indicates variability in the time to reach carrying capacity.
# 3. The box plot visually represents the distribution of times for both conditions.
# 4. The t-test results help determine if the observed difference is statistically significant.
