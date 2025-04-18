#' Evaluate a regression model
#'
#' This function computes common evaluation metrics (RMSE, MAE, R-squared) for a regression model.
#'
#' @param model A regression model object that can be used with predict()
#' @param data A data frame containing the data to evaluate the model on
#' @param response_col A string specifying the name of the actual response column in the data
#'
#' @return A tibble with RMSE, MAE, and R-squared values
#' @export
#' @importFrom tibble tibble
#' @importFrom stats predict cor
#' @examples
#' # Example with a simple linear model
#' df <- data.frame(
#'   x = 1:10,
#'   y = 2 * (1:10) + rnorm(10)
#' )
#' model <- lm(y ~ x, data = df)
#' result <- evaluate_model(model, df, response_col = "y")
#' print(result)

evaluate_model <- function(model, data, response_col) {
  predictions <- predict(model, newdata = data)
  actual <- data[[response_col]]

  rmse <- sqrt(mean((predictions - actual)^2))
  mae <- mean(abs(predictions - actual))
  r2 <- cor(predictions, actual)^2

  return(tibble(RMSE = rmse, MAE = mae, R2 = r2))
}
