library(data.table)
# Define the parent function
# this function will one-hot encode all the columns given in the columns parameter
# first it needs to be fitted to the training data to learn the categories
# then during transform the categories are used to transform the data into factors
# and then into dummy variables
OneHotEncoder <- function() {
  # Local variables
  categories <- list()
  
  
  # Method to fit data and extract categories
  fit <- function(dt, columns) {
    for (column in columns) {
      categories[[column]] <<- unique(dt[[column]])
    }
  }
  
  # Method to turn columns into factors and 
  factorize <- function(dt) {
    for (column_name in names(categories)) {
      # Convert the column to factor directly within the data.table environment
      set(dt, j = column_name, value = factor(dt[[column_name]], 
                                      levels = categories[[column_name]]))
    }
    return(dt)
  }
  
  transform <- function(dt) {
    dt = factorize(dt)
    # add row number for joins later
    dt[, rn := .I]
    
    for (col in names(categories)) {
      print(col)
      # Construct the formula dynamically
      formula_str <- paste("~", col, "- 1")
      formula_obj <- as.formula(formula_str)
      mm = model.matrix(formula_obj, dt)
      mm_dt <- as.data.table(mm, keep.rownames = "row_id")
      setnames(mm_dt, "row_id", "rn")
      mm_dt[, rn := as.integer(rn)]
      
      # Perform a merge based on these row numbers
      dt <- merge(dt, mm_dt, by = "rn", all = TRUE)
      
      # set any new NAs to 0
      for (ncol in names(mm_dt)) {
        set(dt, which(is.na(dt[[ncol]])), ncol, 0)
      }
      
      # remove the original column
      dt[, (col) := NULL]
    }
    dt[, rn := NULL]
    return(dt)
  }
  
  
  # Method to get categories
  get_categories <- function() {
    return(categories)
  }
  
  # Return a list of methods
  list(
    get_categories = get_categories,
    fit = fit,
    transform = transform
  )
}


# Create an instance of my_class
encoder <- OneHotEncoder()

# Dummy data.table for demonstration
dummy_training_data <- data.table(numerical_1 = c(1, 2, 3, 4, 5, 6, 7, 8),
                 numerical_2 = c(11, 21, 31, 41, 51, 61, 71, 81),
                 inside_color = c("black", "black", "red", "green", "green", "black", "red", "blue"),
                 outside_color = c("black", "blue", "pink", "purple", "black", "blue", "pink", "purple"))


# Dummy data.table for demonstration
dummy_inference_data <- data.table(numerical_1 = c(11, 12, 13, 14, 15, 16, 17, 18),
                  numerical_2 = c(17, 27, 37, 47, 57, 67, 77, 87),
                  inside_color = c("black", "black","yellow", "green", "green", "black","black" ,"blue"),
                  outside_color = c("orange", "orange", "black", "orange","black", "orange", "orange", "orange"))

print(dummy_inference_data)

fit_columns = c("inside_color", "outside_color")
# Use the fit method
encoder$fit(dt=dummy_training_data, columns=fit_columns)

# Print categories
print(encoder$get_categories())

# transform training

transformed_training_data = encoder$transform(dummy_training_data)

# transform inference

transformed_inference_data = encoder$transform(dummy_inference_data)
print(transformed_inference_data)

assertthat::are_equal(names(transformed_training_data), names(transformed_inference_data))
