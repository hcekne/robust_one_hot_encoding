# Create an instance of the encoder
source("OneHotEncoder.R")


# Create an instance of my_class
encoder <- OneHotEncoder()

# Dummy data.table for demonstration
training_data <- data.table(numerical_1 = c(1, 2, 3, 4, 5, 6, 7, 8),
                 color_1_ = c("black", "black", "red", "green", "green", "black", "red", "blue"),
                 color_2_ = c("black", "blue", "pink", "purple", "black", "blue", "pink", "purple"))


# Dummy data.table for demonstration
inference_data <- data.table(numerical_1 = c(11, 12, 13, 14, 15, 16, 17, 18),
                  color_1_ = c("black", "blue","black", "green", "green", "black","black" ,"blue"),
                  color_2_ = c("orange", "orange", "black", "orange","black", "orange", "orange", "orange"))

print(inference_data)

fit_columns = c("color_1_", "color_2_")
# Use the fit method
encoder$fit(dt=training_data, columns=fit_columns)

# Print categories
print(encoder$get_categories())

# transform training

transformed_training_data = encoder$transform(training_data)

# transform inference

transformed_inference_data = encoder$transform(inference_data)
print(transformed_inference_data)