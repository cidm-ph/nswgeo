if (!file.exists("data-raw/NSW_LHD_Boundaries/NSW_LHD_Boundaries.shp")) {
  message("You need to download the source dataset from the NSW Government portal at:")
  message("https://data.nsw.gov.au/search/dataset/ds-nsw-ckan-54bc2a0f-6ec6-4082-b9fd-b95d8f8451b1")
  message("Choose the Esri Shapefile format and disable any filters. You will be emailed a link.")
  message("Extract the archive to data-raw/NSW_LHD_Boundaries/")
  stop("Raw LHD dataset is missing")
}

library(sf)
library(dplyr)

NSW_LHD_Boundaries <- read_sf("data-raw/NSW_LHD_Boundaries/NSW_LHD_Boundaries.shp")

# reduce the resolution of the borders to 1km
tolerance_m <- 1000L

crs_nsw <- sf::st_crs(7844) # GDA2020
crs_working <- sf::st_crs("+proj=eqc +lat_ts=34 units=m")

lhd <- NSW_LHD_Boundaries %>%
  st_transform(crs_working) %>%
  st_simplify(dTolerance = tolerance_m) %>%
  st_transform(crs_nsw)
object.size(lhd)

usethis::use_data(lhd, overwrite = TRUE)
