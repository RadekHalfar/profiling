# R Script Profiling Tool

A comprehensive R package for profiling and analyzing the performance of R scripts. This tool provides detailed metrics on execution time and memory usage for different steps of your R code, along with interactive HTML reports.

## Features

- **Step-by-step Profiling**: Track execution time and memory usage for individual code blocks
- **Interactive HTML Reports**: Generate beautiful, interactive reports with visualizations
- **Memory Usage Analysis**: Monitor memory consumption for each step
- **Easy Integration**: Simple function calls to profile your existing R code
- **Dependency Management**: Automatically installs required packages
- **Detailed Documentation**: Comprehensive function reference and examples
- **Demo Script**: Ready-to-run example showing the tool in action

## Installation

```r
# Install from GitHub
if (!require("devtools")) install.packages("devtools")
devtools::install_github("username/profiling")

# Or use the script directly
source("profiling.R")
```

## Quick Demo

Try out the profiling tool with the included demo script:

```r
# Run the demo script
source("demo.R")
```

This will:
1. Profile several example operations
2. Generate an interactive HTML report
3. Open the report in your default browser

## Quick Start

```r
# Initialize profiling
.init_profiling(script_name = "my_analysis.R")

# Profile a code block
profile_code("data_loading", {
  # Your data loading code here
  data <- read.csv("data.csv")
})

# Profile another step
profile_code("data_processing", {
  # Your processing code here
  processed_data <- transform(data, new_col = old_col * 2)
})

# Generate report
generate_profiling_report(show_report = TRUE)
```

## Documentation

For complete documentation of all functions, parameters, and advanced usage, see [DOCUMENTATION.md](DOCUMENTATION.md).

## Main Functions

### Core Functions

- `.init_profiling(...)` - Initialize the profiling environment
- `profile_code(step_name, expr)` - Profile a code block (recommended for most use cases)
- `generate_profiling_report(...)` - Generate an HTML report

### Advanced Usage

- `.start_profiling_step(step_name)` - Manually start profiling a step
- `.end_profiling_step(step_name)` - Manually end profiling a step

For detailed parameter descriptions and examples, see the [full documentation](DOCUMENTATION.md).

## Example Report

![Example Report](https://via.placeholder.com/800x400.png?text=Profiling+Report+Preview)

The generated HTML report includes:
- **Summary Statistics**: Total time, average step time, peak memory usage
- **Interactive Visualizations**:
  - Execution time by step
  - Memory usage over time
  - Detailed metrics table
- **Export Options**: Save report as HTML or print to PDF
- **Responsive Design**: Works on desktop and mobile devices

## Demo Script

A ready-to-run demo script is included (`demo.R`) that demonstrates:
- Basic profiling of code blocks
- Nested profiling operations
- Report generation and viewing

To run the demo:

```r
source("demo.R")
```

## Getting Help

For questions or issues, please [open an issue](https://github.com/username/profiling/issues).

## Dependencies

The script will automatically install these packages if not already installed:
- pryr - Memory usage tracking
- tictoc - Precise timing
- knitr/kableExtra - Report generation
- ggplot2/plotly - Interactive visualizations
- DT - Interactive tables
- gridExtra - Layout management

## Best Practices

1. Profile early and often to identify performance bottlenecks
2. Keep step names descriptive but concise
3. Focus on profiling the most time-consuming parts of your code
4. Compare profiles before and after optimization to measure improvements

## License

MIT
