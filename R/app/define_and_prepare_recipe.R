# Load the recipes package
library(recipes)

# Define a recipe for the model including handling of novel factor levels
recipe_model <- recipe(~., data = training_data)
recipe_model <- step_novel(recipe_model, all_nominal(), -all_outcomes())
recipe_model <- step_dummy(recipe_model, all_nominal(), one_hot = TRUE)

# Prepare the recipe with training data
prepared_recipe <- prep(recipe_model, training = training_data)
