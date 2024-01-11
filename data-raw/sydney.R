gccsa_shapefile <- "data-raw/GCCSA_2021_AUST_SHP_GDA2020/GCCSA_2021_AUST_GDA2020.shp"

if (!file.exists(abs_geopackage)) {
  # https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3
  message("Downloading the source dataset from the ABS website...")
  asgs_3e_url <- "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/GCCSA_2021_AUST_SHP_GDA2020.zip"
  download.file(asgs_3e_url, destfile = "data-raw/GCCSA_2021_AUST_SHP_GDA2020.zip")

  unzip("data-raw/GCCSA_2021_AUST_SHP_GDA2020.zip", exdir = "data-raw/GCCSA_2021_AUST_SHP_GDA2020")
  stopifnot(file.exists(gccsa_shapefile))
}

library(sf)
library(dplyr)
library(nngeo)

# reduce the resolution of the borders to 1km
tolerance_m <- 500L

crs_nsw <- sf::st_crs(7844) # GDA2020
crs_working <- sf::st_crs("+proj=eqc +lat_ts=34 units=m")

# st_layers(gccsa_shapefile)
gccsa <- read_sf(gccsa_shapefile, layer = "GCCSA_2021_AUST_GDA2020")

sydney_hires <- filter(gccsa, GCC_NAME21 == "Greater Sydney")
sydney <- sydney_hires |>
  st_transform(crs_working) |>
  st_simplify(dTolerance = tolerance_m) |>
  st_transform(crs_nsw) |>
  st_geometry()
object.size(sydney_hires)
object.size(sydney)

usethis::use_data(sydney, overwrite = TRUE)
