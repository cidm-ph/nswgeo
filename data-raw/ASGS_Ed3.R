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
tolerance_m <- 750L

# list layers available
st_layers(abs_geopackage)

lga <- read_sf(abs_geopackage, layer = "LGA_2021_AUST_GDA2020")

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
nsw_hires_ui <- filter(lga, LGA_NAME_2021 == "Unincorporated NSW")
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
aus_hires_ui <- filter(lga, LGA_NAME_2021 == "Unincorp. Other Territories")
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
  filter(STATE_NAME_2021 == "New South Wales", LGA_NAME_2021 != "Unincorporated NSW") |>
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
  filter(STATE_NAME_2021 == "New South Wales", LGA_NAME_2021 != "Unincorporated NSW") |>
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

# sal <- read_sf(abs_geopackage, layer = "SAL_2021_AUST_GDA2020")
# sal_nsw <- sal |>
#   st_transform(crs_working) |>
#   filter(STATE_NAME_2021 == "New South Wales") |>
#   st_simplify(dTolerance = tolerance_m) |>
#   st_transform(crs_nsw)
# object.size(sal_nsw)

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
