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
normalise_state_names <- function(names) {
  if (length(names) == 0) return(names)
  normed <- unname(.state_abbr)

  matches <- mapply(
    function(...) {
      m <- c(...)
      m <- as.integer(m[!is.na(m)])
      if (length(m) > 0) m[[1]] else NA_integer_
    },
    match(.state_abbr[names], normed),
    match(tolower(names), tolower(normed)),
    match(stats::setNames(.state_abbr, tolower(names(.state_abbr)))[tolower(names)],
          normed),
    match(stats::setNames(tolower(.state_abbr), tolower(names(.state_abbr)))[tolower(names)],
          tolower(normed))
  )

  names[!is.na(matches)] <- .state_abbr[matches[!is.na(matches)]]
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
