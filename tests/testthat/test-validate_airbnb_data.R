library(testthat)
library(airbnbtools)

test_that("validate_airbnb_data passes silently with valid sample data", {
  # Create mock data
  df <- data.frame(
    realSum = c(100, 200, 300),
    room_type = c("Entire home/apt", "Private room", "Shared room"),
    person_capacity = c(2, 1, 3),
    bedrooms = c(1, 1, 2),
    cleanliness_rating = c(4.5, 4, 3.5),
    guest_satisfaction_overall = c(4, 5, 4),
    lng = c(13.4050, 2.3522, -0.1276),
    lat = c(52.5200, 48.8566, 51.5074),
    city = c("berlin", "paris", "london"),
    weekdays = c("Monday", "Tuesday", "Wednesday")
  )
  # Expecting no messages on passing validation
  expect_message(validate_airbnb_data(df), "Airbnb dataset passed all validation checks.")
})

test_that("validate_airbnb_data fails if realSum has non-positive values", {
  df <- data.frame(
    realSum = c(100, -10, 300),  # Simulating a non-positive value
    room_type = c("Entire home/apt", "Private room", "Shared room"),
    person_capacity = c(2, 1, 3),
    bedrooms = c(1, 1, 2),
    cleanliness_rating = c(4.5, 4, 3.5),
    guest_satisfaction_overall = c(4, 5, 4),
    lng = c(13.4050, 2.3522, -0.1276),
    lat = c(52.5200, 48.8566, 51.5074),
    city = c("berlin", "paris", "london"),
    weekdays = c("Monday", "Tuesday", "Wednesday")
  )
  expect_error(validate_airbnb_data(df), "realSum contains non-positive values")
})

test_that("validate_airbnb_data warns on NAs", {
  df <- data.frame(
    realSum = c(100, 200, 300),
    room_type = c("Entire home/apt", "Private room", "Shared room"),
    person_capacity = c(2, 1, 3),
    bedrooms = c(1, 1, 2),
    cleanliness_rating = c(4.5, 4, 3.5),
    guest_satisfaction_overall = c(4, 5, 4),
    lng = c(13.4050, 2.3522, -0.1276),
    lat = c(52.5200, 48.8566, 51.5074),
    city = c("berlin", "paris", "london"),
    weekdays = c("Monday", "Tuesday", "Wednesday")
  )
  df$bedrooms[1] <- NA
  expect_warning(validate_airbnb_data(df), "Data contains missing values.")
})

test_that("validate_airbnb_data fails on unexpected city values", {
  df <- data.frame(
    realSum = c(100, 200, 300),
    room_type = c("Entire home/apt", "Private room", "Shared room"),
    person_capacity = c(2, 1, 3),
    bedrooms = c(1, 1, 2),
    cleanliness_rating = c(4.5, 4, 3.5),
    guest_satisfaction_overall = c(4, 5, 4),
    lng = c(13.4050, 2.3522, -0.1276),
    lat = c(52.5200, 48.8566, 51.5074),
    city = c("berlin", "mars", "london"),  # Simulating an unexpected city value
    weekdays = c("Monday", "Tuesday", "Wednesday")
  )
  expect_error(validate_airbnb_data(df), "Unexpected city values found.")
})

test_that("validate_airbnb_data fails on unexpected room_type", {
  df <- data.frame(
    realSum = c(100, 200, 300),
    room_type = c("Entire home/apt", "Treehouse", "Shared room"),  # Simulating an unexpected room type
    person_capacity = c(2, 1, 3),
    bedrooms = c(1, 1, 2),
    cleanliness_rating = c(4.5, 4, 3.5),
    guest_satisfaction_overall = c(4, 5, 4),
    lng = c(13.4050, 2.3522, -0.1276),
    lat = c(52.5200, 48.8566, 51.5074),
    city = c("berlin", "paris", "london"),
    weekdays = c("Monday", "Tuesday", "Wednesday")
  )
  expect_error(validate_airbnb_data(df), "Unexpected room_type values found.")
})
