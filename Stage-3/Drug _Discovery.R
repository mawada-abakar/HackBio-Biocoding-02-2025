# Load required libraries

library(tidyverse)
library(factoextra)
library(caret)
library(randomForest)

#Step-1: Load and Preprocess Data

# Import data
url <- "https://raw.githubusercontent.com/HackBio-Internship/2025_project_collection/refs/heads/main/Python/Dataset/drug_class_struct.txt"
drug_data <- read.delim(url, sep = "\t")

# Remove non-numeric columns (e.g., IDs) and the target variable 'score'
features <- drug_data %>% 
  select(-score) %>% 
  select(where(is.numeric))  # Keep only numeric features
score <- drug_data$score

# Handle missing values
drug_data_clean <- na.omit(drug_data)
features <- drug_data_clean %>% select(-score) %>% select(where(is.numeric))
score <- drug_data_clean$score

# Remove zero-variance columns (critical for PCA)
zv_cols <- caret::nearZeroVar(features)
if (length(zv_cols) > 0) {
  features <- features[, -zv_cols]
}

# Scale features to mean=0, variance=1
scaled_features <- scale(features)

#Step-2: Principal Component Analysis (PCA)

# Run PCA on scaled features
pca_result <- prcomp(scaled_features, scale. = FALSE)

# Check variance explained by top PCs
summary(pca_result)  # PC1 + PC2 typically explain ~30% of variance
fviz_eig(pca_result) # Scree plot

# Extract first two PCs for plotting
pca_scores <- data.frame(PC1 = pca_result$x[, 1], 
                         PC2 = pca_result$x[, 2],
                         score = score)


#Step-3: K-means Clustering

# Find optimal clusters using the elbow method (session terminated here )
set.seed(123)
fviz_nbclust(pca_scores[, 1:2], kmeans, method = "wss")  # Look for "elbow" at k=3

# Perform K-means clustering (k=3)
k <- 3
km <- kmeans(pca_scores[, 1:2], centers = k, nstart = 25)
pca_scores$cluster <- as.factor(km$cluster)

#Step-4: Visualize Chemical Space

# Plot clusters
cluster_plot <- ggplot(pca_scores, aes(PC1, PC2, color = cluster)) +
  geom_point(alpha = 0.6) +
  labs(title = "Chemical Space Clusters (PCA + K-means)") +
  theme_minimal()

# Plot docking scores (lower = better binding)
score_plot <- ggplot(pca_scores, aes(PC1, PC2, color = score)) +
  geom_point(alpha = 0.6) +
  scale_color_gradient(low = "blue", high = "red") +
  labs(title = "Chemical Space Colored by Docking Score") +
  theme_minimal()

# Display plots
print(cluster_plot)
print(score_plot)

# Save plots
ggsave("output/cluster_plot.png", cluster_plot)
ggsave("output/score_plot.png", score_plot)

#Step-5: Identify Clusters with Low Docking Scores

# Calculate mean docking score per cluster
cluster_scores <- aggregate(score ~ cluster, data = pca_scores, FUN = mean)
print(cluster_scores)

# Example output:
#   cluster     score
# 1       1 -8.12     # Best cluster (lowest score)
# 2       2 -6.45
# 3       3 -5.98

#Step-6:Predict Docking Scores with Regression

# Split data into training/testing sets (70:30)
set.seed(123)
train_index <- createDataPartition(score, p = 0.7, list = FALSE)
train_data <- scaled_features[train_index, ]
test_data <- scaled_features[-train_index, ]
train_score <- score[train_index]
test_score <- score[-train_index]

# Train Random Forest model
rf_model <- randomForest(x = train_data, y = train_score, ntree = 100)

# Evaluate model
predicted_scores <- predict(rf_model, test_data)
rmse <- sqrt(mean((test_score - predicted_scores)^2))
r_squared <- cor(test_score, predicted_scores)^2

cat(sprintf("Model Performance:\nRMSE = %.2f\nR² = %.2f", rmse, r_squared))

# Save feature importance plot
png("output/feature_importance.png")

# Optional: Feature importance
importance <- importance(rf_model)
varImpPlot(rf_model, main = "Feature Importance")
dev.off()




