
<!-- README.md is generated from README.Rmd. Please edit that file -->

# airbnbtools

<!-- badges: start -->

[![codecov](https://codecov.io/gh/DSCI-310-2025/airbnbtools/graph/badge.svg?token=M05R361SU6)](https://codecov.io/gh/DSCI-310-2025/airbnbtools)
[![R-CMD-check](https://github.com/DSCI-310-2025/airbnbtools/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/DSCI-310-2025/airbnbtools/actions/workflows/R-CMD-check.yaml)
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/)

<!-- badges: end -->

The goal of **airbnbtools** is to streamline the process of working with
Airbnb datasets, offering tools for downloading, transforming, and
modeling data. This package provides several functions to automate tasks
such as data acquisition, data cleaning, and model training and
evaluation, helping to make the data analysis workflow more efficient.

You can find the documentation for this package at the following URL:

[airbnbtools
Documentation](https://dsci-310-2025.github.io/airbnbtools/)

## Installation

You can install the development version of **airbnbtools** from GitHub
with:

``` r
# install.packages("devtools")
devtools::install_github("DSCI-310-2025/airbnbtools")
```

## Usage

The `airbnbtools` package provides several useful functions for data
manipulation and analysis. Here are some common tasks:

### Convert selected columns to factor type

The function `convert_columns_to_factor()` converts specific columns of
a data frame to factors.

``` r
df <- data.frame(
  room_type = c("Private room", "Entire home/apt"),
  host_is_superhost = c("t", "f"),
  city = c("Madrid", "Barcelona"),
  weekdays = c(TRUE, FALSE),
  price = c(100, 150)
)
convert_columns_to_factor(df)
#>         room_type host_is_superhost      city weekdays price
#> 1    Private room                 t    Madrid     TRUE   100
#> 2 Entire home/apt                 f Barcelona    FALSE   150
```

### Download and combine Airbnb data

Use `download_combine_data()` to download data from multiple sources and
combine them into a single data frame.

``` r
urls <- list(
  "Vancouver_weekdays" = "https://example.com/vancouver_weekdays.csv",
  "Toronto_weekends" = "https://example.com/toronto_weekends.csv"
)
combined_df <- download_combine_data(urls)
head(combined_df)
```

### Create a grid of histograms

The function `create_histogram_grid()` generates and saves a grid of
histograms for numeric columns in a data frame.

``` r
df <- data.frame(
  price = c(100, 150, 200, 250),
  size = c(20, 25, 30, 35),
  rating = c(4.5, 4.0, 5.0, 3.5)
)
out_path <- tempfile(fileext = ".png")
create_histogram_grid(df, vars = c("price", "size", "rating"), output_path = out_path)
```

### Evaluate a regression model

Use `evaluate_model()` to compute evaluation metrics (RMSE, MAE,
R-squared) for a regression model.

``` r
df <- data.frame(x = 1:10, y = 2 * (1:10) + rnorm(10))
model <- lm(y ~ x, data = df)
result <- evaluate_model(model, df, response_col = "y")
print(result)
#> # A tibble: 1 × 3
#>    RMSE   MAE    R2
#>   <dbl> <dbl> <dbl>
#> 1 0.865 0.703 0.972
```

### Split data into training and testing sets

The `split_train_test()` function splits a dataset into training and
testing sets using stratified sampling.

``` r
df <- data.frame(x = rnorm(100), y = rnorm(100))
split_data <- split_train_test(df, response_col = "y", train_ratio = 0.75)
str(split_data$train)
#> 'data.frame':    76 obs. of  2 variables:
#>  $ x: num  -0.1499 -0.6169 1.6517 0.0968 0.5916 ...
#>  $ y: num  1.469 -1.14 0.522 -0.847 -0.4 ...
str(split_data$test)
#> 'data.frame':    24 obs. of  2 variables:
#>  $ x: num  1.832 -0.569 2.178 -0.475 -1.533 ...
#>  $ y: num  -2.428 -0.297 -2.089 -0.72 0.221 ...
```

### Train a regression model using caret

Use `train_model()` to train a regression model using the `caret`
package.

``` r
df <- data.frame(
  price = rnorm(100, mean = 200, sd = 50),
  size = rnorm(100, mean = 80, sd = 10),
  rating = rnorm(100, mean = 4, sd = 0.5)
)
model <- train_model(df)
#> Loading required package: ggplot2
#> Warning: package 'ggplot2' was built under R version 4.2.3
#> Loading required package: lattice
summary(model)
#> 
#> Call:
#> lm(formula = .outcome ~ ., data = dat)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -112.384  -30.214   -4.179   29.174  115.875 
#> 
#> Coefficients:
#>             Estimate Std. Error t value Pr(>|t|)    
#> (Intercept) 244.9042    55.8091   4.388 2.91e-05 ***
#> size         -0.5055     0.5286  -0.956    0.341    
#> rating       -1.6094     9.6998  -0.166    0.869    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 48.82 on 97 degrees of freedom
#> Multiple R-squared:  0.009906,   Adjusted R-squared:  -0.01051 
#> F-statistic: 0.4853 on 2 and 97 DF,  p-value: 0.617
```

### Validate Airbnb data

The `validate_airbnb_data()` function checks and converts specified
columns of a data frame to factors.

``` r
df <- data.frame(
  room_type = c("Entire home/apt", "Private room"),
  host_is_superhost = c("t", "f"),
  city = c("Berlin", "Paris"),
  weekdays = c("Monday", "Tuesday")
)
validate_airbnb_data(df)
```
