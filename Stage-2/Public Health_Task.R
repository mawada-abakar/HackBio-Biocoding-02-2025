# Load necessary libraries
library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)

# Step 1: Load the dataset
url <- "https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/nhanes.csv"
data <- read_csv(url)

# Step 2: Handle Missing Values
# Option 1: Remove rows with any NA
data_cleaned <- na.omit(data)

# Option 2: Replace NAs with zero
data_filled <- data %>% replace(is.na(.), 0)

# Step 3: Visualization - Histogram for BMI, Weight, Weight in Pounds, and Age
data_cleaned <- data_cleaned %>%
  mutate(Weight_pounds = Weight * 2.2)  # Convert Weight to Pounds

# Plot histograms
plot_hist <- function(df, column, title, xlab) {
  ggplot(df, aes(x = .data[[column]])) +
    geom_histogram(bins = 30, fill = "blue", alpha = 0.7) +
    labs(title = title, x = xlab, y = "Frequency") +
    theme_minimal()
}

plot_hist(data_cleaned, "BMI", "Distribution of BMI", "BMI")
plot_hist(data_cleaned, "Weight", "Distribution of Weight", "Weight (kg)")
plot_hist(data_cleaned, "Weight_pounds", "Distribution of Weight in Pounds", "Weight (lbs)")
plot_hist(data_cleaned, "Age", "Distribution of Age", "Age (years)")

# Step 4: Compute Summary Statistics
# Mean 60-second pulse rate
mean_pulse <- mean(data_cleaned$Pulse60, na.rm = TRUE)
print(paste("Mean 60-second pulse rate:", mean_pulse))

# Range of Diastolic Blood Pressure
min_dbp <- min(data_cleaned$DiastolicBP, na.rm = TRUE)
max_dbp <- max(data_cleaned$DiastolicBP, na.rm = TRUE)
print(paste("Range of Diastolic BP:", min_dbp, "-", max_dbp))

# Variance and Standard Deviation of Income
income_var <- var(data_cleaned$Income, na.rm = TRUE)
income_sd <- sd(data_cleaned$Income, na.rm = TRUE)
print(paste("Variance of Income:", income_var))
print(paste("Standard Deviation of Income:", income_sd))

# Step 5: Scatterplot of Weight vs Height Colored by Gender, Diabetes, and Smoking Status
ggplot(data_cleaned, aes(x = Height, y = Weight, color = Gender)) +
  geom_point(alpha = 0.6) +
  labs(title = "Weight vs Height (Colored by Gender)", x = "Height (cm)", y = "Weight (kg)") +
  theme_minimal()

ggplot(data_cleaned, aes(x = Height, y = Weight, color = Diabetes)) +
  geom_point(alpha = 0.6) +
  labs(title = "Weight vs Height (Colored by Diabetes Status)", x = "Height (cm)", y = "Weight (kg)") +
  theme_minimal()

ggplot(data_cleaned, aes(x = Height, y = Weight, color = SmokingStatus)) +
  geom_point(alpha = 0.6) +
  labs(title = "Weight vs Height (Colored by Smoking Status)", x = "Height (cm)", y = "Weight (kg)") +
  theme_minimal()

# Step 6: Conducting T-tests
# T-test between Age and Gender
t_test_age_gender <- t.test(Age ~ Gender, data = data_cleaned)
print("T-test between Age and Gender:")
print(t_test_age_gender)

# T-test between BMI and Diabetes
t_test_bmi_diabetes <- t.test(BMI ~ Diabetes, data = data_cleaned)
print("T-test between BMI and Diabetes:")
print(t_test_bmi_diabetes)

# T-test between Alcohol Year and Relationship Status
t_test_alcohol_relationship <- t.test(AlcoholYear ~ RelationshipStatus, data = data_cleaned)
print("T-test between Alcohol Year and Relationship Status:")
print(t_test_alcohol_relationship)
