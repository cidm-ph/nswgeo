data_path <- "data-raw/MyHospitals_Public/NSW_LHD_Boundaries.shp"

if (!file.exists(data_path)) {
  message("You need to download the source dataset from the NSW Government portal at:")
  message("https://portal.spatial.nsw.gov.au/portal/home/item.html?id=5a1e5dd9b38245d3b976c21b56fd6185")
  message("Choose the Esri Shapefile format and disable any filters. You will be emailed a link.")
  message("Extract the archive to data-raw/MyHospitals_Public/")
  stop("Raw LHD dataset is missing")
}

library(sf)
library(dplyr)

lhd_boundaries <- sf::read_sf(data_path)

na_cols <- sapply(colnames(lhd_boundaries), function(c) {
  all(is.na(as.data.frame(lhd_boundaries)[, c]))
})
na_cols <- names(na_cols)[na_cols]

# reduce the resolution of the borders to 1km
tolerance_m <- 1000L

crs_nsw <- sf::st_crs(7844) # GDA2020
crs_working <- sf::st_crs("+proj=eqc +lat_ts=34 units=m")

lhd <- lhd_boundaries %>%
  select(-all_of(na_cols)) %>%
  st_transform(crs_working) %>%
  st_simplify(dTolerance = tolerance_m) %>%
  st_transform(crs_nsw)
object.size(lhd)

usethis::use_data(lhd, overwrite = TRUE)

lhd_outline <- lhd %>%
  sf::st_union() %>%
  nngeo::st_remove_holes() %>%
  sf::st_make_valid()
object.size(lhd_outline)

usethis::use_data(lhd_outline, overwrite = TRUE, internal = TRUE)
