# Function: Simulate Logistic Growth
simulate_logistic_growth <- function(time, K = 100, r = 0.5, lag_min = 2, lag_max = 6, exp_min = 5, exp_max = 10) {
  # Randomize lag and exponential phases
  lag_phase <- sample(lag_min:lag_max, 1)
  exp_phase <- sample(exp_min:exp_max, 1)
  
  # Logistic growth equation
  growth <- K / (1 + ((K - 1) / 1) * exp(-r * (time - lag_phase)))
  
  # Keep population constant during the lag phase
  growth[time < lag_phase] <- 1  
  return(data.frame(Time = time, Population = growth))
}

# Function: Generate 100 different growth curves
generate_growth_data <- function(n = 100) {
  time <- seq(0, 50, 1)  # Time points from 0 to 50
  growth_data <- do.call(rbind, lapply(1:n, function(i) {
    curve <- simulate_logistic_growth(time)
    curve$Curve_ID <- i  # Assign a unique ID to each curve
    return(curve)
  }))
  return(growth_data)
}

# Generate and view the dataframe
growth_dataset <- generate_growth_data(100)
head(growth_dataset)

# Plot a subset of the growth curves
ggplot(growth_dataset %>% filter(Curve_ID <= 10), aes(x = Time, y = Population, group = Curve_ID, color = as.factor(Curve_ID))) +
  geom_line() +
  theme_minimal() +
  labs(title = "Simulated Logistic Growth Curves", x = "Time", y = "Population Size", color = "Curve ID")
