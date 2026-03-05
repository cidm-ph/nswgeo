library(dplyr)
library(httr2)
library(readr)

features_per_page <- 1000L

# https://portal.spatial.nsw.gov.au/server/rest/services/NSW_Administrative_Boundaries_Theme_multiCRS/FeatureServer/2
suburbs <-
  request("https://portal.spatial.nsw.gov.au/server/rest/services/") |>
  req_url_path_append(
    "NSW_Administrative_Boundaries_Theme_multiCRS/FeatureServer/2/query"
  ) |>
  req_url_query(
    where = "State = 2",
    outFields = "suburbname,postcode",
    returnGeometry = "false",
    f = "json",
    resultRecordCount = features_per_page
  ) |>
  req_perform_iterative(
    next_req = iterate_with_offset(
      start = 0,
      offset = 1000,
      param_name = "resultOffset",
      resp_complete = function(resp) {
        length(resp_body_json(resp)$features) < features_per_page
      }
    ),
  ) |>
  resps_successes() |>
  resps_data(function(resp) {
    resp_body_json(resp)$features |>
      purrr::map(function(row) {
        lapply(row$attributes, \(y) if (is.null(y)) NA else y) |>
          tibble::as_tibble_row()
      }) |>
      purrr::list_rbind()
  }) |>
  arrange(suburbname)

write_csv(suburbs, "data-raw/suburbs.csv")
usethis::use_data(suburbs, overwrite = TRUE)
