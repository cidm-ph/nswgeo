aus_shapefile <- "data-raw/STE_2021_AUST_SHP_GDA2020/STE_2021_AUST_GDA2020.shp"

if (!file.exists(aus_shapefile)) {
  # https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3
  message("Downloading the source dataset from the ABS website...")
  aus_url <- "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/STE_2021_AUST_SHP_GDA2020.zip"
  download.file(aus_url, destfile = "data-raw/STE_2021_AUST_SHP_GDA2020.zip")

  unzip("data-raw/STE_2021_AUST_SHP_GDA2020.zip", exdir = "data-raw/STE_2021_AUST_SHP_GDA2020")
  stopifnot(file.exists(aus_shapefile))
}

library(sf)
library(dplyr)
library(nngeo)

# reduce the resolution of the borders to 5km
tolerance_m <- 5000L

crs_au <- sf::st_crs(7844) # GDA2020
crs_working <- sf::st_crs("+proj=eqc +lat_ts=34 units=m")

# st_layers(aus_shapefile)
aus <- read_sf(aus_shapefile, layer = "STE_2021_AUST_GDA2020")

states <- aus %>%
  filter(STE_CODE21 %in% as.character(1:8)) %>%
  st_transform(crs_working) %>%
  st_simplify(dTolerance = tolerance_m) %>%
  st_transform(crs_au)

object.size(states)
usethis::use_data(states, overwrite = TRUE)

australia <- aus %>%
  filter(STE_CODE21 %in% as.character(1:8)) %>%
  st_transform(crs_working) %>%
  st_union() %>%
  st_remove_holes() %>%
  st_make_valid() %>%
  st_simplify(dTolerance = tolerance_m) %>%
  st_transform(crs_au)

object.size(australia)
usethis::use_data(australia, overwrite = TRUE)
