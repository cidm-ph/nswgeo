.onLoad <- function(libname, pkgname) {
  state_abbr <- c(
    "NSW" = "New South Wales",
    "VIC" = "Victoria",
    "QLD" = "Queensland",
    "SA" = "South Australia",
    "WA" = "Western Australia",
    "TAS" = "Tasmania",
    "NT" = "Northern Territory",
    "ACT" = "Australian Capital Territory"
  )

  ggautomap::register_map("nswgeo.lhd", nswgeo::lhd, "lhd_name",
                          outline = nswgeo::nsw)
  ggautomap::register_map("nswgeo.lga", nswgeo::lga_nsw, "LGA_NAME_2021",
                          outline = nswgeo::nsw)
  ggautomap::register_map("nswgeo.postcode", nswgeo::poa_nsw, "POA_CODE_2021",
                          outline = nswgeo::nsw)
  ggautomap::register_map("nswgeo.states", nswgeo::states, "STE_NAME21",
                          outline = nswgeo::australia, aliases = state_abbr)
}
