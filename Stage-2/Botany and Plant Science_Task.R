# Load required libraries
library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)

# Step 1: Load the Dataset
url <- "https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/plant_metabolism.tsv"
data <- read_tsv(url)

# Inspect data structure
head(data)
str(data)

# Step 2: Compute the difference in metabolic response (ΔM)
data <- data %>%
  mutate(DeltaM_WT = WT_24h - WT_DMSO, 
         DeltaM_Mutant = Mutant_24h - Mutant_DMSO)

# Step 3: Generate Scatter Plot Comparing WT vs Mutant ΔM
scatter_plot <- ggplot(data, aes(x = DeltaM_WT, y = DeltaM_Mutant)) +
  geom_point(color = "blue", alpha = 0.7) +
  labs(title = "Scatter Plot of Metabolic Response Difference (ΔM)",
       x = "Wild Type ΔM",
       y = "Mutant ΔM") +
  theme_minimal()

print(scatter_plot)

# Step 4: Fit a y = x line (y-intercept = 0, slope = 1)
scatter_plot_fitted <- scatter_plot +
  geom_abline(intercept = 0, slope = 1, color = "black", linetype = "dashed")

print(scatter_plot_fitted)

# Step 5: Calculate residuals (ΔM deviation from the fitted line)
data <- data %>%
  mutate(residual = DeltaM_Mutant - DeltaM_WT)

# Step 6: Apply Residual Cutoff and Color Points
cutoff <- 0.3  # Set a cutoff threshold
data <- data %>%
  mutate(color_group = ifelse(abs(residual) <= cutoff, "Grey", "Salmon"))

# Scatter plot with color coding
scatter_plot_colored <- ggplot(data, aes(x = DeltaM_WT, y = DeltaM_Mutant, color = color_group)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_abline(intercept = 0, slope = 1, color = "black", linetype = "dashed") +
  labs(title = "Metabolic Response Scatter Plot with Residuals",
       x = "Wild Type ΔM",
       y = "Mutant ΔM") +
  scale_color_manual(values = c("Grey" = "grey", "Salmon" = "salmon")) +
  theme_minimal()

print(scatter_plot_colored)

# Step 7: Identify Metabolites Outside Cutoff Range
outlier_metabolites <- data %>%
  filter(color_group == "Salmon") %>%
  select(Metabolite, residual)

print(outlier_metabolites)

# Step 8: Pick Any 6 Outlier Metabolites for Line Plot
selected_metabolites <- sample(outlier_metabolites$Metabolite, 6)

# Step 9: Create Line Plot for Selected Metabolites
long_data <- data %>%
  pivot_longer(cols = starts_with("WT_") | starts_with("Mutant_"),
               names_to = "Condition_Time",
               values_to = "Metabolic_Response") %>%
  separate(Condition_Time, into = c("Type", "Time"), sep = "_")

# Filter for selected metabolites
filtered_data <- long_data %>%
  filter(Metabolite %in% selected_metabolites)

# Line plot for 6 selected metabolites
line_plot <- ggplot(filtered_data, aes(x = Time, y = Metabolic_Response, color = Type, group = Type)) +
  geom_line(size = 1) +
  facet_wrap(~ Metabolite, scales = "free_y") +
  labs(title = "Metabolic Response Over Time for Selected Metabolites",
       x = "Time (h)",
       y = "Metabolic Response") +
  theme_minimal()

print(line_plot)
