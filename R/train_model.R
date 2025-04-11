#' Train a regression model using caret
#'
#' @param train_data A data frame containing the training set. Must include a column called `price`.
#' @return A trained caret model.
#' @export
train_model <- function(train_data) {
  model <- caret::train(
    price ~ ., data = train_data,
    method = "lm",
    trControl = caret::trainControl(method = "cv", number = 5)
  )

  return(model)
}