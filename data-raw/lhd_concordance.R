library(sf)
library(dplyr)

abs_geopackage <- "data-raw/ASGS_Ed3_Non_ABS_Structures_GDA2020_GPKG_updated_2025/ASGS_Ed3_Non_ABS_Structures_GDA2020_updated_2025.gpkg"
data_path <- "data-raw/NSW_LHD_Boundaries/SHP No Z value/SAPHARI_Version_LHD_Areas.shp"

stopifnot(
  "Run ASGC_Ed3_Non_ABR.R first to download source dataset" = file.exists(abs_geopackage),
  "Run lhd.R first to download source dataset" = file.exists(data_path)
)

crs_nsw <- st_crs(7844) # GDA2020
crs_working <- st_crs(9473) # GDA2020 Australian Albers

poa <- read_sf(abs_geopackage, layer = "POA_2021_AUST_GDA2020") |>
  select(POA_CODE_2021, POA_NAME_2021)
lhd <- read_sf(data_path) |>
  select(LHD_CODE, LHD_NAME)

poa_albers <- st_transform(poa, crs_working)
poa_albers$poa_area <- st_area(poa)
lhd_albers <- st_transform(lhd, crs_working)
lhd_albers$lhd_area <- st_area(lhd_albers)

poa_lhd <- st_intersection(poa_albers, lhd_albers)
poa_lhd$area <- st_area(poa_lhd)
poa_lhd$FRAC_INCLUDED <- as.numeric(poa_lhd$area / poa_lhd$poa_area)

poa_lhd_concordance <- poa_lhd |>
  as.data.frame() |>
  filter(FRAC_INCLUDED >= 0.0001) |>
  select(POA_CODE_2021, POA_NAME_2021, LHD_CODE, LHD_NAME, FRAC_INCLUDED) |>
  mutate(FRAC_INCLUDED = round(FRAC_INCLUDED, digits = 4)) |>
  arrange(POA_CODE_2021, LHD_CODE)

usethis::use_data(poa_lhd_concordance, overwrite = TRUE)
poa_lhd_concordance$FRAC_INCLUDED <- format(poa_lhd_concordance$FRAC_INCLUDED, scientific = FALSE)
write.csv(poa_lhd_concordance, "data-raw/poa_lhd_concordance.csv", row.names = FALSE, quote = FALSE)
