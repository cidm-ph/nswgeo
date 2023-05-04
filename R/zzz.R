.onLoad <- function(libname, pkgname) {
  cartographer::register_map("nswgeo.lhd", nswgeo::lhd,
                          feature_column = "lhd_name",
                          outline = sf::st_sf(geometry = lhd_outline))
  cartographer::register_map("nswgeo.lga", nswgeo::lga_nsw,
                          feature_column = "LGA_NAME_2021",
                          outline = sf::st_sf(geometry = nswgeo::nsw))
  cartographer::register_map("nswgeo.postcode", nswgeo::poa_nsw,
                          feature_column = "POA_CODE_2021",
                          outline = sf::st_sf(geometry = nswgeo::nsw),
                          aliases = {
                            aliases <- (nswgeo::postcodes$postcode != nswgeo::postcodes$canonical) &
                              (! nswgeo::postcodes$postcode %in% nswgeo::poa_nsw$POA_CODE_2021) &
                              (nswgeo::postcodes$canonical %in% nswgeo::poa_nsw$POA_CODE_2021)
                            stats::setNames(nswgeo::postcodes$postcode[aliases],
                                            nswgeo::postcodes$canonical[aliases])
                          })
  cartographer::register_map("nswgeo.states", nswgeo::states,
                          feature_column = "STE_NAME21",
                          outline = sf::st_sf(geometry = nswgeo::australia),
                          aliases = .state_abbr)
}
