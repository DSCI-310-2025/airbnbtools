#' This function downloads Airbnb data from given URLs, adds metadata, and combines them.
#'
#' @param urls A named list where names indicate the city and time period (weekdays/weekends)
#'            and values are the corresponding dataset URLs.
#'
#' @return A combined data frame with an added city and weekdays column.
#' @export
#' @examples
#' # Not run because this requires internet and real URLs:
#' \dontrun{
#' urls <- list(
#'   "Vancouver_weekdays" = "https://example.com/vancouver_weekdays.csv",
#'   "Toronto_weekends" = "https://example.com/toronto_weekends.csv"
#' )
#' combined_df <- download_combine_data(urls)
#' head(combined_df)
#' }
#'
download_combine_data <- function(urls) {

  airbnb_list <- purrr::map2(urls, names(urls), function(url, name) {
    df <- readr::read_csv(url, show_col_types = FALSE) %>%
      dplyr::mutate(
        weekdays = grepl("weekdays", name),
        city = stringr::word(name, 1, sep = "_")
      )
    return(df)
  })

  airbnb_combined <- dplyr::bind_rows(airbnb_list)

  return(airbnb_combined)
}
