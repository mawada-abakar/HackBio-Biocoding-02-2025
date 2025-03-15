# Function: Find Time to Reach 80% of Carrying Capacity
time_to_80_percent <- function(growth_data, K = 100) {
  threshold <- 0.8 * K  # 80% of carrying capacity
  
  # Find the first time point where population reaches threshold
  time_80 <- growth_data$Time[growth_data$Population >= threshold][1]
  
  return(time_80)
}

# Example Usage:
time <- seq(0, 50, 1)
growth_curve <- simulate_logistic_growth(time)
time_80 <- time_to_80_percent(growth_curve)

print(paste("Time to reach 80% of K:", time_80))
