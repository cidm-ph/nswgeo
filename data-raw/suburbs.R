library(readr)
library(dplyr)

data_path <- "data-raw/Suburb.csv"

if (!file.exists(data_path)) {
  message("You need to download the source dataset from the NSW Government portal at:")
  message("https://data.nsw.gov.au/search/dataset/ds-nsw-ckan-30a4fce0-9df9-42af-ac20-94baf079b6f8")
  message("Choose the CSV format and disable any filters. You will be emailed a link.")
  message("Extract the CSV file as data-raw/Suburb.csv")
  stop("Raw suburb dataset is missing")
}

suburbs <- read_csv(data_path, col_types = cols(
  rid = col_double(),
  suburbname = col_character(),
  postcode = col_character(),
  state = col_integer(),
  startdate = col_datetime("%Y%m%d%H%M%S"),
  enddate = col_datetime("%Y%m%d%H%M%S"),
  lastupdate = col_datetime("%Y%m%d%H%M%S"),
  msoid = col_integer(),
  centroidid = col_logical(),
  shapeuuid = col_character(),
  changetype = col_character(),
  processstate = col_logical(),
  urbanity = col_character(),
  Shape__Length = col_double(),
  Shape__Area = col_double(),
  cadid = col_character(),
  createdate = col_datetime("%Y%m%d%H%M%S"),
  modifieddate = col_datetime("%Y%m%d%H%M%S"),
  lganame = col_logical(),
  councilname = col_logical(),
  abscode = col_logical(),
  ltocode = col_logical(),
  vgcode = col_logical(),
  wbcode = col_logical()
)) |>
  select(-c(abscode, ltocode, vgcode, wbcode, centroidid, processstate, lganame, councilname)) |>
  select(suburbname, postcode) |>
  arrange(suburbname)

write_csv(suburbs, "data-raw/suburbs.csv")
usethis::use_data(suburbs, overwrite = TRUE)
