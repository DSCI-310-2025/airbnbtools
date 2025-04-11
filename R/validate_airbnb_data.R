#' Convert selected columns to factor type
#'
#' This function takes a data frame and converts specified columns to factors.
#' 
#' @param df A data frame containing the columns: room_type, host_is_superhost, city, weekdays
#'
#' @return A data frame with the specified columns converted to factors
#' @export
validate_airbnb_data <- function(df) {
  # 1. Check required columns exist
  required_cols <- c("realSum", "room_type", "person_capacity", "bedrooms", 
                     "cleanliness_rating", "guest_satisfaction_overall", 
                     "lng", "lat", "city", "weekdays")
  missing <- setdiff(required_cols, colnames(df))
  if (length(missing) > 0) stop(paste("Missing required columns:", paste(missing, collapse = ", ")))
  
  # 2. Check for NAs
  if (anyNA(df)) warning("Data contains missing values.")
  
  # 3. Check realSum (price) > 0
  if (any(df$realSum <= 0, na.rm = TRUE)) stop("realSum contains non-positive values.")
  
  # 4. Check person_capacity is in reasonable range (1–16)
  if (any(df$person_capacity < 1 | df$person_capacity > 16, na.rm = TRUE)) {
    stop("person_capacity is outside expected range (1–16).")
  }
  
  # 5. Check city values are from expected set
  expected_cities <- c("berlin", "paris", "london")
  if (any(!tolower(df$city) %in% expected_cities)) {
    stop("Unexpected city values found.")
  }
  
  # 6. Check room_type levels are as expected
  expected_rooms <- c("Entire home/apt", "Private room", "Shared room")
  if (any(!df$room_type %in% expected_rooms)) {
    stop("Unexpected room_type values found.")
  }
  
  # 7. Check guest satisfaction scores are between 0–5
  if (any(df$guest_satisfaction_overall < 0 | df$guest_satisfaction_overall > 5, na.rm = TRUE)) {
    stop("guest_satisfaction_overall must be between 0 and 5.")
  }
  
  # 8. Check no duplicate rows
  if (any(duplicated(df))) warning("Duplicate rows found in dataset.")
  
  message("Airbnb dataset passed all validation checks.")
}