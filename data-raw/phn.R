data_path <- "data-raw/phn.geojson"
if (!file.exists(data_path)) {
  message("Downloading the source dataset from data.gov.au ...")
  source_url <- "https://data.gov.au/data/dataset/ef2d28a4-1ed5-47d0-8e3a-46e25bc4f66b/resource/3fea565c-3b4e-4698-bd80-52396bb5bcd3/download/phn.geojson"

  options(timeout = max(3600, getOption("timeout")))
  download.file(source_url, destfile = data_path)

  stopifnot(file.exists(data_path))
}

library(sf)
library(dplyr)

crs_nsw <- sf::st_crs(7844) # GDA2020
crs_working <- sf::st_crs("+proj=eqc +lat_ts=34 units=m")

# reduce the resolution of the borders to 500m
tolerance_m <- 500L

phn_boundaries <- read_sf(data_path)

phn <-
  phn_boundaries |>
  filter(FIRST_STE1 == "New South Wales") |>
  st_crop(st_bbox(c(xmin = 140, ymin = -40, xmax = 155, ymax = -25))) |>
  st_transform(crs_working) |>
  st_simplify(dTolerance = tolerance_m) |>
  st_transform(crs_nsw)

object.size(phn)

usethis::use_data(phn, overwrite = TRUE)
