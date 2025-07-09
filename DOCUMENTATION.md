# R Profiling Tool - Function Documentation

## Table of Contents
1. [Core Functions](#core-functions)
2. [Helper Functions](#helper-functions)
3. [Example Usage](#example-usage)
4. [Report Generation](#report-generation)

## Core Functions

### `.init_profiling(...)`
Initialize the profiling environment.

**Parameters:**
- `...`: Named arguments for script metadata (optional)
  - `script_name`: (string) Name of the script being profiled
  - `description`: (string) Optional description of the script
  - `author`: (string) Optional author name
  - `version`: (string) Optional version number

**Returns:**
- Invisibly returns `TRUE` if successful

**Side Effects:**
- Creates global variables for storing profiling data
- Initializes timing and memory tracking
- Loads required packages

---

### `profile_code(step_name, expr)`
Profile a code block with automatic start/end handling.

**Parameters:**
- `step_name`: (string) Name of the code block being profiled
- `expr`: (expression) The R code block to profile

**Returns:**
- The result of the evaluated expression

**Side Effects:**
- Records timing and memory usage for the code block
- Updates the global profiling data

---

### `.start_profiling_step(step_name)`
Start profiling a new code block.

**Parameters:**
- `step_name`: (string) Name of the step to start profiling

**Side Effects:**
- Records start time and memory usage
- Creates a timer for the step

---

### `.end_profiling_step(step_name)`
End profiling for the current code block.

**Parameters:**
- `step_name`: (string) Name of the step to end profiling

**Returns:**
- A data frame row with the profiling results for this step

**Side Effects:**
- Records end time and memory usage
- Updates the global profiling data
- Removes step-specific variables

---

### `generate_profiling_report(output_dir, file_name, show_report, save_report)`
Generate an HTML report with profiling results.

**Parameters:**
- `output_dir`: (string) Directory to save the report (default: "profiling_reports")
- `file_name`: (string) Name of the HTML file (default: auto-generated with timestamp)
- `show_report`: (logical) Whether to open the report in browser (default: FALSE)
- `save_report`: (logical) Whether to save the report to disk (default: TRUE)

**Returns:**
- The file path to the generated report

**Side Effects:**
- Creates an HTML file with profiling results
- May open the report in a web browser

## Helper Functions

### `.ensure_packages()`
Ensure all required packages are installed and loaded.

**Side Effects:**
- Installs missing packages if necessary
- Loads all required packages

### `.generate_summary_stats(profiling_data)`
Generate summary statistics from profiling data.

**Parameters:**
- `profiling_data`: Data frame containing profiling metrics

**Returns:**
- A data frame with summary statistics

### `.generate_profiling_plots(profiling_data)`
Generate plots for the profiling report.

**Parameters:**
- `profiling_data`: Data frame containing profiling metrics

**Returns:**
- Base64 encoded image of the plots

## Example Usage

```r
# Initialize profiling with metadata
.init_profiling(
  script_name = "analysis.R",
  description = "Customer segmentation analysis",
  author = "Data Science Team",
  version = "1.0.0"
)

# Profile data loading
profile_code("load_data", {
  data <- read.csv("data.csv")
  # Additional data loading code...
})

# Profile data processing
profile_code("process_data", {
  # Data processing code...
  processed_data <- data %>%
    filter(!is.na(value)) %>%
    group_by(category) %>%
    summarize(avg = mean(value))
})

# Generate and view report
report_path <- generate_profiling_report(
  output_dir = "reports",
  file_name = "profiling_report.html",
  show_report = TRUE
)
```

## Report Generation

The profiling report includes:

1. **Header Section**
   - Script metadata (name, author, timestamp)
   - Total execution time

2. **Summary Statistics**
   - Total execution time
   - Number of steps profiled
   - Average step duration
   - Peak memory usage

3. **Execution Timeline**
   - Bar chart of step durations
   - Memory usage over time

4. **Detailed Metrics**
   - Table with metrics for each step:
     - Step name
     - Start/end times
     - Duration
     - Memory usage
     - Memory delta from previous step

5. **Interactive Features**
   - Sortable columns
   - Search functionality
   - Responsive design for different screen sizes

## Best Practices

1. **Naming Conventions**
   - Use descriptive, consistent step names
   - Keep step names short but meaningful
   - Use snake_case for step names

2. **Code Organization**
   - Profile logical units of work
   - Keep individual steps focused
   - Use nested profiling for complex operations

3. **Performance Considerations**
   - Be aware of the overhead of profiling
   - For very fast operations, consider batching them together
  - Focus on profiling the most time-consuming parts of your code

4. **Memory Management**
   - Be aware that memory measurements have some overhead
   - For more accurate memory profiling, use larger datasets
   - Clean up large objects when they're no longer needed
