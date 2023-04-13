.onLoad <- function(libname, pkgname) {
  cartographer::register_map("nswgeo.lhd", nswgeo::lhd,
                          feature_column = "lhd_name",
                          outline = nswgeo::nsw)
  cartographer::register_map("nswgeo.lga", nswgeo::lga_nsw,
                          feature_column = "LGA_NAME_2021",
                          outline = nswgeo::nsw)
  cartographer::register_map("nswgeo.postcode", nswgeo::poa_nsw,
                          feature_column = "POA_CODE_2021",
                          outline = nswgeo::nsw)
  cartographer::register_map("nswgeo.states", nswgeo::states,
                          feature_column = "STE_NAME21",
                          outline = nswgeo::australia,
                          aliases = .state_abbr)
}
