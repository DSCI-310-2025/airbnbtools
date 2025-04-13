
<!-- README.md is generated from README.Rmd. Please edit that file -->

# airbnbtools

![R-CMD-check](https://github.com/DSCI-310-2025/airbnbtools/actions/workflows/R-CMD-check.yaml/badge.svg)

<!-- badges: start -->

<!-- badges: end -->

The goal of **airbnbtools** is to streamline the process of working with
Airbnb datasets, offering tools for downloading, transforming, and
modeling data. This package provides several functions to automate tasks
such as data acquisition, data cleaning, and model training and
evaluation, helping to make the data analysis workflow more efficient.

## Installation

You can install the development version of **airbnbtools** from GitHub
with:

``` r
# install.packages("devtools")
devtools::install_github("DSCI-310-2025/airbnbtools")
```

## Usage

Here’s a simple example of how to use the `download_combine_data()`
function, which downloads Airbnb data from given URLs, adds metadata
(city and weekdays/weekends columns), and combines them into a single
data frame.

``` r
# Load the airbnbtools package
library(airbnbtools)

# Define URLs for the datasets
urls <- list(
  berlin_weekdays  = "https://zenodo.org/records/4446043/files/berlin_weekdays.csv",
  berlin_weekends  = "https://zenodo.org/records/4446043/files/berlin_weekends.csv",
  london_weekdays  = "https://zenodo.org/records/4446043/files/london_weekdays.csv",
  london_weekends  = "https://zenodo.org/records/4446043/files/london_weekends.csv"
)

# Download and combine the data
combined_data <- download_combine_data(urls)

# To view the combined data
head(combined_data)
```
