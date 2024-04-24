# Define training data
training_data <- data.frame(
  fuel_type = c('Electric', 'Electric', 'Petrol', 'Hybrid', 'Petrol', 'Hybrid'),
  color = c('Blue', 'Green', 'Black', 'Black', 'Blue', 'Green')
)

# Define inference data
inference_data <- data.frame(
  fuel_type = c('Electric', 'Electric', 'Hydrogen', 'Hybrid'),
  color = c('Green', 'Red', 'Black', 'Red')
)

# Save data to CSV files
write.csv(training_data, "training_data.csv", row.names = FALSE)
write.csv(inference_data, "inference_data.csv", row.names = FALSE)