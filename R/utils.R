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
  cartographer::resolve_feature_names(
    names,
    feature_type = "nswgeo.states",
    unmatched = "pass"
  )
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
#' `crs_gda2020` is EPSG 7844 with axes specified in degrees.
#'
#' `crs_gda2020_cartesian` is EPSG 7842 with Cartesian axes in metres.
#'
#' `crs_gda2020_albers` is EPSG 9473, the Albers equal area projection used,
#'   making it suitable for area computation.
#'
#' @return A simple features CRS
#'
#' @export
crs_gda2020 <- function() {
  sf::st_crs("EPSG:7844")
}
#' @rdname crs_gda2020
#' @export
crs_gda2020_cartesian <- function() {
  sf::st_crs("EPSG:7842")
}
#' @rdname crs_gda2020
#' @export
crs_gda2020_albers <- function() {
  sf::st_crs("EPSG:9473")
}

#' New South Wales outline with or without related territories
#'
#' The default outline `nswgeo::nsw` includes Jervis Bay Territory, excludes
#' Lord Howe Island, and does not have a cut out for the ACT. This utility
#' allows each of these to be adjusted.
#'
#' @seealso [nsw]
#'
#' @param lord_howe_island Include Lord Howe Island.
#' @param act_cutout Cut out the area of the Australian Capital Territory.
#' @param jervis_bay Cover the area of the Jervis Bay Territory.
#'
#' @return A simple features data frame with the requested geometries.
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' outline(lord_howe_island = TRUE) |> ggplot() + geom_sf()
outline <- function(lord_howe_island = FALSE, act_cutout = FALSE, jervis_bay = TRUE) {
  base <- nswgeo::nsw
  crs_working <- sf::st_crs("+proj=eqc +lat_ts=34 units=m")
  crs_nsw <- sf::st_crs(nswgeo::nsw)

  if (act_cutout) {
    act <- sf::st_transform(nswgeo::act, crs_working)
    base <- base |>
      sf::st_transform(crs_working) |>
      sf::st_difference(act) |>
      sf::st_transform(crs_nsw)
  }

  if (!jervis_bay) {
    # Since the default includes JBT and is simplified (reduced resolution), the
    # shape of JBT needs to be enlarged a bit to avoid leaving odd pieces of
    # geometry behind when intersecting.
    jbt <- nswgeo::jbt |>
      sf::st_transform(crs_working) |>
      sf::st_simplify(dTolerance = 750L) |>
      sf::st_buffer(250L)
    base <- base |>
      sf::st_transform(crs_working) |>
      sf::st_difference(jbt) |>
      sf::st_transform(crs_nsw) |>
      sf::st_make_valid()
  }

  if (lord_howe_island) {
    sf::st_sf(geometry = rbind(base, nswgeo::lhi), name = c("NSW", "Lord Howe Island"), crs = sf::st_crs(base))
  } else {
    sf::st_sf(geometry = base, name = "NSW")
  }
}
