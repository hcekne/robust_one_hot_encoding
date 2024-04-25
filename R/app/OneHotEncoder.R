library(data.table)

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
        set(dt, j = column_name, 
        value = factor(dt[[column_name]], 
        levels = categories[[column_name]]))
    }
    return(dt)
  }
  
  # Method to transform columns in categories list to 
  # dummy variables
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
      mm_dt <- as.data.table(mm, keep.rownames = "rn")
      mm_dt[, rn := as.integer(rn)]
      
      # Perform a merge based on these row numbers
      dt <- merge(dt, mm_dt, by = "rn", all = TRUE)
      
       # remove the original column
      dt[, (col) := NULL]

      # set any new NAs to 0
      for (ncol in names(mm_dt)) {
        set(dt, which(is.na(dt[[ncol]])), ncol, 0)
      }
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


#library(assertthat)
#assertthat::are_equal(names(transformed_training_data), names(transformed_inference_data))
