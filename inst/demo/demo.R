# Demo script for R Profiling Tool
# This script demonstrates how to use the profiling functions

# 1. Load the profiling package
library(profiling)

# 2. Initialize profiling with script metadata
.init_profiling(
  script_name = "demo_analysis.R",
  description = "Demonstration of profiling functionality",
  author = "Data Scientist"
)

# Function to simulate a complex calculation
simulate_heavy_computation <- function(size) {
  # Create a large matrix
  m <- matrix(rnorm(size * size), nrow = size)
  # Perform some computations
  result <- eigen(m, symmetric = TRUE)$values
  return(mean(result))
}

# 3. Example 1: Using profile_code() (recommended for most cases)
cat("=== Example 1: Using profile_code() ===\n")
profile_code("data_loading", {
  # Simulate data loading
  Sys.sleep(0.5)
  data <- data.frame(
    id = 1:10000,
    value = rnorm(10000)
  )
  
  # Nested profiling example
  profile_code("nested_operation", {
    # This will be profiled as a sub-step
    Sys.sleep(0.3)
    data$initial_transform <- log1p(abs(data$value))
  })
})

# 4. Example 2: Manual profiling with start/end steps
cat("\n=== Example 2: Manual start/end profiling ===\n")

# Start profiling a complex operation
.start_profiling_step("complex_computation")

# Simulate a complex computation
cat("  Running complex computation...\n")
result1 <- simulate_heavy_computation(500)
result2 <- simulate_heavy_computation(600)

# End profiling this step
.end_profiling_step("complex_computation")

# 5. Example 3: Profiling error handling with manual steps
cat("\n=== Example 3: Profiling with error handling ===\n")

# First, ensure the step is started
step_name <- "risky_operation"
.start_profiling_step(step_name)

tryCatch({
  # Simulate an operation that might fail
  if (runif(1) > 0.3) {
    stop("Simulated error during processing")
  }
  
  # This will only run if no error occurred
  Sys.sleep(0.4)
  
  # End profiling normally if successful
  .end_profiling_step(step_name)
  cat("  Operation completed successfully \n")
}, error = function(e) {
  # In case of error, record the failure
  cat("  Error:", e$message, "\n")
  # Check if the step was started before trying to end it
  if (exists(paste0("step_", step_name), envir = .GlobalEnv)) {
    .end_profiling_step(step_name)
  } else {
    cat("  Step was not properly initialized, skipping end profiling\n")
  }
})

# 6. Example 4: Profiling data processing
cat("\n=== Example 4: Data processing pipeline ===\n")

# First, create the squared column in the original data
.start_profiling_step("initial_squaring")
data$squared <- data$value^2
.end_profiling_step("initial_squaring")

# Profile a data processing pipeline
profile_code("data_processing", {
  # Start with the data that now has the squared column
  processed_data <- data
  
  .start_profiling_step("log_transform")
  processed_data$log_value <- log(abs(processed_data$value) + 1)
  .end_profiling_step("log_transform")
  
  # More complex operation with manual profiling
  .start_profiling_step("complex_calculation")
  processed_data$complex_calc <- {
    # This is a more complex operation
    x <- sin(processed_data$value)
    y <- cos(processed_data$squared)
    x * y  # Final result
  }
  .end_profiling_step("complex_calculation")
  
  # Store the processed data in the global environment for later use
  assign("processed_data", processed_data, envir = .GlobalEnv)
  
  # Return the processed data
  processed_data
})

# 7. Example 5: Profiling modeling workflow
cat("\n=== Example 5: Modeling workflow ===\n")

# Make sure we have the processed data
if (!exists("processed_data")) {
  stop("Processed data not found. Please run Example 4 first.")
}

# Start profiling the entire modeling phase
.start_profiling_step("modeling_workflow")

# Model training
.start_profiling_step("model_training")
cat("  Training model...\n")
Sys.sleep(0.8)
model <- lm(squared ~ value + log_value, data = processed_data)
.end_profiling_step("model_training")

# Model prediction
.start_profiling_step("model_prediction")
cat("  Making predictions...\n")
Sys.sleep(0.5)
predictions <- predict(model, newdata = processed_data)
.end_profiling_step("model_prediction")

# Model evaluation
.start_profiling_step("model_evaluation")
cat("  Evaluating model...\n")
Sys.sleep(0.3)
rmse <- sqrt(mean((predictions - processed_data$squared)^2, na.rm = TRUE))
cat(sprintf("  Model RMSE: %.4f\n", rmse))
.end_profiling_step("model_evaluation")

# End the entire modeling workflow
.end_profiling_step("modeling_workflow")

# Clean up
rm(model, predictions, rmse)

# 8. Generate and view the report
cat("\n=== Generating Report ===\n")
generate_profiling_report(
  output_dir = "profiling_reports",
  file_name = "demo_profiling_report.html",
  show_report = TRUE,
  save_report = FALSE
)

cat("\nKey takeaways from this demo:\n")
cat("- Example 1: Shows the recommended way to profile code blocks\n")
cat("- Example 2: Demonstrates manual profiling of specific sections\n")
cat("- Example 3: Shows error handling in manual profiling\n")
cat("- Example 4: Illustrates profiling a data processing pipeline\n")
cat("- Example 5: Demonstrates profiling a complete workflow with nested steps\n")
