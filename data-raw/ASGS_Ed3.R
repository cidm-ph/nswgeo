abs_geopackage <- "data-raw/ASGS_Ed3_Non_ABS_Structures_GDA2020_GPKG_updated_2022/ASGS_Ed3_Non_ABS_Structures_GDA2020_updated_2022.gpkg"

if (!file.exists(abs_geopackage)) {
  # https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3
  message("Downloading the source dataset from the ABS website...")
  asgs_3e_url <- "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_Ed3_Non_ABS_Structures_GDA2020_GPKG_updated_2022.zip"
  download.file(asgs_3e_url, destfile = "data-raw/ASGS_Ed3_Non_ABS_Structures_GDA2020_GPKG_updated_2022.zip")

  unzip("data-raw/ASGS_Ed3_Non_ABS_Structures_GDA2020_GPKG_updated_2022.zip", exdir = "data-raw/ASGS_Ed3_Non_ABS_Structures_GDA2020_GPKG_updated_2022")
  stopifnot(file.exists(abs_geopackage))
}

library(sf)
library(dplyr)
library(nngeo)

sf_use_s2(FALSE)

# reduce the resolution of the borders to 1km
tolerance_m <- 1000L

# list layers available
st_layers(abs_geopackage)

lga <- read_sf(abs_geopackage, layer = "LGA_2021_AUST_GDA2020")

crs_nsw <- sf::st_crs(7844) # GDA2020
crs_working <- sf::st_crs("+proj=eqc +lat_ts=34 units=m")

# Unincorporated NSW includes Lord Howe Island but also the Unincorporated Far
# West Region. Remove LHI by culling everything east of 150.
nsw_hires_ui <- filter(lga, LGA_NAME_2021 == "Unincorporated NSW")
bb <- st_bbox(nsw_hires_ui)
bb["xmax"] <- 150
nsw_hires_ui <- st_intersection(
  st_transform(nsw_hires_ui, crs_working),
  st_transform(st_as_sfc(bb), crs_working)
) %>% st_transform(crs_nsw)

lga_nsw <- lga %>%
  filter(STATE_NAME_2021 == "New South Wales", LGA_NAME_2021 != "Unincorporated NSW") %>%
  rbind(nsw_hires_ui) %>%
  st_transform(crs_working) %>%
  st_simplify(dTolerance = tolerance_m) %>%
  st_transform(crs_nsw)
object.size(lga_nsw)
usethis::use_data(lga_nsw, overwrite = TRUE)

nsw_hires <- lga %>%
  filter(STATE_NAME_2021 == "New South Wales", LGA_NAME_2021 != "Unincorporated NSW") %>%
  rbind(nsw_hires_ui) %>%
  st_transform(crs_working) %>%
  st_union() %>%
  st_remove_holes() %>%
  st_make_valid()
nsw <- nsw_hires %>%
  st_simplify(dTolerance = tolerance_m) %>%
  st_transform(crs_nsw)
object.size(nsw_hires)
object.size(nsw)
usethis::use_data(nsw, overwrite = TRUE)

# sal <- read_sf(abs_geopackage, layer = "SAL_2021_AUST_GDA2020")
# sal_nsw <- sal %>%
#   st_transform(crs_working) %>%
#   filter(STATE_NAME_2021 == "New South Wales") %>%
#   st_simplify(dTolerance = tolerance_m) %>%
#   st_transform(crs_nsw)
# object.size(sal_nsw)

poa <- read_sf(abs_geopackage, layer = "POA_2021_AUST_GDA2020")
poa_nsw <- poa %>%
  st_transform(crs_working) %>%
  st_intersection(st_transform(nsw_hires, crs_working)) %>%
  st_simplify(dTolerance = tolerance_m, preserveTopology = TRUE) %>%
  st_transform(crs_nsw) %>%
  st_make_valid()
if (any(st_is_empty(poa_nsw))) {
  print(poa_nsw$POA_NAME_2021[st_is_empty(poa_nsw)])
  stop(sprintf("%d postcodes have been completely removed by simplification",
               sum(st_is_empty(poa_nsw))))
}
object.size(poa_nsw)
usethis::use_data(poa_nsw, overwrite = TRUE)
