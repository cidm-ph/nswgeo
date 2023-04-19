.state_abbr <- c(
  "NSW" = "New South Wales",
  "VIC" = "Victoria",
  "QLD" = "Queensland",
  "SA" = "South Australia",
  "WA" = "Western Australia",
  "TAS" = "Tasmania",
  "NT" = "Northern Territory",
  "ACT" = "Australian Capital Territory"
)

#' Normalise state names from abbreviations
#'
#' Expand abbreviations like \code{"NSW"} to \code{"New South Wales"}, and
#' normalise to title capitalisation. Entries that don't match any state name or
#' abbreviation are left untouched.
#'
#' @param names Character vector of state names.
#'
#' @return Vector of the same size as the input, but with the normalised state names.
#'
#' @export
#' @examples
#' normalise_state_names(c("nsw", "VIC", "overseas", "Queensland"))
normalise_state_names <- function(names) {
  cartographer::resolve_feature_names(names, feature_type = "nswgeo.states",
                                      unmatched = "pass")
}

#' Normalise postal codes
#'
#' Some special postcodes are used in addresses, such as codes for post office boxes.
#' This helper converts those to the postcode for the closest normal suburb if there
#' is a reasonable clear match. If there is no good match, the postcodes are left
#' unchanged.
#'
#' Note that this goes a little further than the aliases that are registered with
#' cartographer (which only account for postcodes with no geospatial data in the ABS
#' dataset).
#'
#' @param codes Character vector of postcodes (or coercible to one).
#'
#' @return Character vector of the same size as the input, but with the normalised postcodes.
#'
#' @export
#' @examples
#' normalise_postcodes(c(1685, 2000, 1010, 2129, 2145))
normalise_postcodes <- function(codes) {
  codes <- as.character(codes)
  dict <- stats::setNames(nswgeo::postcodes$canonical, nswgeo::postcodes$postcode)
  normed <- unname(dict[codes])
  ifelse(is.na(normed), codes, normed)
}

#' Coordinate reference system for Australia
#'
#' GDA2020 is the official CRS used by the
#' [Commonwealth](https://www.icsm.gov.au/gda2020) and
#' [NSW](https://www.spatial.nsw.gov.au/surveying/geodesy/gda2020).
#' Geospatial data in this package uses GDA2020.
#'
#' @return A simple features CRS
#'
#' @export
crs_gda2020 <- function() {
  sf::st_crs("EPSG:7844")
}
