library(testthat)
source("../../R/validate_airbnb_data.R")

test_that("validate_airbnb_data passes silently with valid data", {
  df <- read.csv("data/cleaned/cleaned_airbnb.csv")
  expect_silent(validate_airbnb_data(df))
})

test_that("validate_airbnb_data fails if realSum has non-positive values", {
  df <- read.csv("data/cleaned/cleaned_airbnb.csv")
  df$realSum[1] <- -10
  expect_error(validate_airbnb_data(df), "realSum contains non-positive values")
})

test_that("validate_airbnb_data warns on NAs", {
  df <- read.csv("data/cleaned/cleaned_airbnb.csv")
  df$bedrooms[1] <- NA
  expect_warning(validate_airbnb_data(df), "missing values")
})

test_that("validate_airbnb_data fails on unexpected city values", {
  df <- read.csv("data/cleaned/cleaned_airbnb.csv")
  df$city[1] <- "mars"
  expect_error(validate_airbnb_data(df), "Unexpected city values")
})

test_that("validate_airbnb_data fails on unexpected room_type", {
  df <- read.csv("data/cleaned/cleaned_airbnb.csv")
  df$room_type[1] <- "Treehouse"
  expect_error(validate_airbnb_data(df), "Unexpected room_type")
})