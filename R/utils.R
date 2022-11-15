#' Expand state names from abbreviations
#'
#' The state geometry expects full names like \code{"New South Wales"}. Apply
#' this helper to your location column first if you have values like
#' \code{"NSW"} or \code{"nsw"} instead.
#'
#' @param names Character vector of state names using the standard 2-3 letter
#'   abbreviations.
#'
#' @return Vector of the same size as the input, but with the full state names.
#'   Any unmatched values are left alone.
#'
#' @export
expand_state_names <- function (names) {
  n <- toupper(names)
  names[n == "NSW"] <- "New South Wales"
  names[n == "VIC"] <- "Victoria"
  names[n == "QLD"] <- "Queensland"
  names[n == "SA"] <- "South Australia"
  names[n == "WA"] <- "Western Australia"
  names[n == "TAS"] <- "Tasmania"
  names[n == "NT"] <- "Northern Territory"
  names[n == "ACT"] <- "Australian Capital Territory"
  names
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
