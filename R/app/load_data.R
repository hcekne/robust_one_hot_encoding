# Load necessary library
library(data.table)

# Read data from CSV files
training_data <- fread("training_data.csv")
inference_data <- fread("inference_data.csv")

# Convert columns to factors with specified levels based on the training data
training_levels <- unique(c(training_data$fuel_type, training_data$color))
training_data[, (names(training_data)) := lapply(.SD, factor, levels = training_levels)]
inference_data[, (names(inference_data)) := lapply(.SD, factor, levels = training_levels)]
