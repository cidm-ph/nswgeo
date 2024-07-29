abs_geopackage_name <- "ASGS_Ed3_Non_ABS_Structures_GDA2020_GPKG_updated_2024"
abs_geopackage_gpkg <- "ASGS_Ed3_Non_ABS_Structures_GDA2020_updated_2024.gpkg"
abs_geopackage <- file.path("data-raw", abs_geopackage_name, abs_geopackage_gpkg)
asgs_3e_url <-
  "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/ASGS_Ed3_Non_ABS_Structures_GDA2020_updated_2024.zip"

if (!file.exists(abs_geopackage)) {
  # https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files
  message("Downloading the source dataset from the ABS website...")
  abs_geopackage_path <- file.path("data-raw", paste0(abs_geopackage_name, ".zip"))
  # options(timeout = max(2000L, getOption("timeout")))
  # download.file(asgs_3e_url, destfile = abs_geopackage_path)
  httr2::request(asgs_3e_url) |>
    httr2::req_progress() |>
    httr2::req_retry(max_tries = 3) |>
    httr2::req_options(http_version = 0, timeout = 2000L) |>
    httr2::req_perform(path = abs_geopackage_path)

  unzip(abs_geopackage_path, exdir = file.path("data-raw", abs_geopackage_name))
  stopifnot(file.exists(abs_geopackage))
}

library(sf)
library(dplyr)
library(nngeo)

sf_use_s2(FALSE)

# reduce the resolution of the borders to 1km
tolerance_m <- 750L

# list layers available
st_layers(abs_geopackage)

lga <- read_sf(abs_geopackage, layer = "LGA_2024_AUST_GDA2020")

crs_nsw <- sf::st_crs(7844) # GDA2020
crs_working <- sf::st_crs("+proj=eqc +lat_ts=34 units=m")

# NSW administrative boundaries have some quirks to account for:
#
#   - Unincorporated Far West Region
#   - Lord Howe Island
#   - Australian Capital Territory
#   - Jervis Bay Territory

# The ABS LGA region of "Unincorporated NSW" includes both Lord Howe Island
# and the Unincorporated Far West Region. Separate these.
nsw_hires_ui <- filter(lga, LGA_NAME_2024 == "Unincorporated NSW")
bb <- st_bbox(nsw_hires_ui)
bb["xmax"] <- 150
ufwr_hires <- st_intersection(
  st_transform(nsw_hires_ui, crs_working),
  st_transform(st_as_sfc(bb), crs_working)
) |> st_transform(crs_nsw)
bb <- st_bbox(nsw_hires_ui)
bb["xmin"] <- 158
lhi_hires <- st_intersection(
  st_transform(nsw_hires_ui, crs_working),
  st_transform(st_as_sfc(bb), crs_working)
) |> st_transform(crs_nsw)
lhi <- st_geometry(lhi_hires)
object.size(lhi)
usethis::use_data(lhi, overwrite = TRUE)

# The ABS LGA region of "Unincorp. Other Territories" includes both Norfolk
# Island and the Jervis Bay Territory, of which we only need the latter.
aus_hires_ui <- filter(lga, LGA_NAME_2024 == "Unincorp. Other Territories")
bb <- st_bbox(aus_hires_ui)
bb["xmax"] <- 153
jbt_hires <- st_intersection(
  st_transform(aus_hires_ui, crs_working),
  st_transform(st_as_sfc(bb), crs_working)
) |> st_transform(crs_nsw)
jbt <- st_geometry(jbt_hires)
object.size(jbt)
usethis::use_data(jbt, overwrite = TRUE)

lga_nsw <- lga |>
  filter(STATE_NAME_2021 == "New South Wales", LGA_NAME_2024 != "Unincorporated NSW") |>
  rbind(ufwr_hires) |>
  st_transform(crs_working) |>
  st_simplify(dTolerance = tolerance_m) |>
  st_transform(crs_nsw)
object.size(lga_nsw)
usethis::use_data(lga_nsw, overwrite = TRUE)

act_hires <- lga |>
  filter(STATE_NAME_2021 == "Australian Capital Territory", ! st_is_empty(geom))
act <- st_geometry(act_hires)
object.size(act)
usethis::use_data(act, overwrite = TRUE)

nsw_hires <- lga |>
  filter(STATE_NAME_2021 == "New South Wales", LGA_NAME_2024 != "Unincorporated NSW") |>
  rbind(ufwr_hires, jbt_hires) |>
  st_transform(crs_working) |>
  st_union() |>
  st_remove_holes() |>
  st_make_valid()
nsw <- nsw_hires |>
  st_simplify(dTolerance = tolerance_m) |>
  st_transform(crs_nsw)
object.size(nsw_hires)
object.size(nsw)
usethis::use_data(nsw, overwrite = TRUE)

poa <- read_sf(abs_geopackage, layer = "POA_2021_AUST_GDA2020")
# Check for overlap of the interiors of the geometries to exclude postal areas
# at the state borders. In theory st_relate with pattern = "T********" should do
# this, but there is some slight overlap between geometries in the dataset, so a
# small negative buffer approach is more reliable.
poa_in_nsw <- st_intersects(
  st_transform(poa, crs_working),
  st_buffer(nsw_hires, -100L)
) |> sapply(function(x) length(x) > 0)

poa_nsw <- poa[poa_in_nsw, ] |>
  st_transform(crs_working) |>
  st_simplify(dTolerance = tolerance_m, preserveTopology = TRUE) |>
  st_transform(crs_nsw) |>
  st_make_valid()
stopifnot(all(!st_is_empty(poa_nsw)))
stopifnot(all(st_geometry_type(poa_nsw) != "GEOMETRYCOLLECTION"))
object.size(poa_nsw)
usethis::use_data(poa_nsw, overwrite = TRUE)
