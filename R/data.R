#' Suburbs of New South Wales.
#'
#' A dataset containing the names of suburbs in NSW and their postcodes.
#' These fields are extracted as-is from the source dataset published by DCS Spatial Services, NSW Government.
#'
#' @format A data frame with 2 columns:
#' \describe{
#'   \item{suburbname}{The name of the suburb, in upper case}
#'   \item{postcode}{The main postcode of the suburb, as a character}
#' }
#' @source
#'   Spatial Services, Department of Customer Service NSW.
#'   "NSW Administrative Boundaries Theme - Suburb."
#'   \url{https://portal.spatial.nsw.gov.au/portal/home/item.html?id=38bdaa10b7cc41a3a19be6eca91f5368}, accessed 21 September 2022.
#'
#'   The original dataset is published under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) licence,
#'   © State of New South Wales ([Spatial Services](https://www.spatial.nsw.gov.au/copyright), a business unit of the Department of Customer Service NSW).
"suburbs"

#' Geospatial data of the Australian state and territory administrative boundaries.
#'
#' Excludes external territories.
#'
#' The geometries have been simplified with a tolerance of 5 km to reduce the
#' level of detail.
#'
#' @examples
#' library(ggplot2)
#' ggplot(states) + geom_sf(aes(fill = STE_NAME21))
#' @source
#'   Australian Bureau of Statistics. "Australian Statistical Geography Standard (ASGS) Edition 3." ABS, Jul2021-Jun2026,
#'   \url{https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026}, accessed 10 November 2022.
#'
#'   The original dataset is published under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) licence, © Commonwealth of Australia 2021.
#' @describeIn australia External boundaries of Australia as a multipolygon.
"australia"
#' @describeIn australia State and internal territory boundaries of Australia.
"states"

#' Geospatial data of the New South Wales administrative boundaries.
#'
#' Excludes the borders with the ACT and Jervis Bay Territory, and Lord Howe Island.
#'
#' The geometries have been simplified with a tolerance of 1 km to reduce the
#' level of detail.
#'
#' @examples
#' library(ggplot2)
#' ggplot(lga_nsw) + geom_sf(aes(fill = LGA_NAME_2021), show.legend = FALSE)
#'
#' library(sf)
#' sf_use_s2(FALSE)
#' # cut out part of the postcode dataset (it's quite large)
#' bbox <- st_bbox(c(xmin = 142, xmax = 147, ymin = -33, ymax = -30)) |>
#'  st_as_sfc(crs = crs_gda2020())
#' st_crop(poa_nsw, bbox) |>
#'   ggplot() +
#'   geom_sf() +
#'   geom_sf_text(aes(label = POA_CODE_2021), size = 4)
#' @source
#'   Australian Bureau of Statistics. "Australian Statistical Geography Standard (ASGS) Edition 3." ABS, Jul2021-Jun2026,
#'   \url{https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026}, accessed 27 September 2022.
#'
#'   The original dataset is published under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) licence, © Commonwealth of Australia 2021.
#' @describeIn nsw External boundaries of New South Wales as a multipolygon.
"nsw"
#' @describeIn nsw Local Government Area boundaries of New South Wales.
"lga_nsw"
#' @describeIn nsw Postal area boundaries of New South Wales.
"poa_nsw"

#' Local Health Districts of NSW.
#'
#' The geometries have been simplified with a tolerance of 1 km to reduce the
#' level of detail.
#'
#' @source
#'   Spatial Services, Department of Customer Service NSW.
#'   "MyHospitals_Public",
#'   \url{https://portal.spatial.nsw.gov.au/portal/home/item.html?id=78df4a3e987b4e7e8b241ee5bfeee358}, accessed 4 May 2023.
#'   Republished from
#'   NSW Ministry of Health, "Map of local health districts",
#'   \url{https://www.health.nsw.gov.au/lhd/Pages/lhd-maps.aspx}.
#'
#'   The original dataset is published under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) licence,
#'   © State of New South Wales NSW Ministry of Health 2023. For current information go to \url{https://www.health.nsw.gov.au}.
#' @examples
#' library(ggplot2)
#' ggplot(lhd) + geom_sf(aes(fill = lhd_name), show.legend = FALSE)
"lhd"

#' Postal codes and localities of New South Wales.
#'
#' Derived from several government sources with some community curation.
#' This version additionally attempts to canonicalise non-physical postcodes to
#' assist with mapping.
#'
#' @examples
#' set.seed(12345)
#' postcodes[sort(sample.int(nrow(postcodes), 5)),]
#' @format A data frame with 7 columns:
#' \describe{
#'   \item{postcode}{A postal code}
#'   \item{locality}{A suburb or locality}
#'   \item{state}{NSW}
#'   \item{SA2_NAME_2016}{Statistical Area 2 name to assist with disambiguating localities with identical names}
#'   \item{special}{Flag indicating this is a post office box, mail distribution centre or other special postal code}
#'   \item{old}{Flag indicating that this code appears to have been superseded}
#'   \item{canonical}{The closest canonical postal code, e.g. mapping post office boxes to the main suburb's postal code}
#' }
#'
#' @source
#'   Matthew Proctor. "Australian Postcodes",
#'   \url{https://www.matthewproctor.com/australian_postcodes}, accessed 6 February 2023.
#'
#'   The original dataset is released to the public domain.
"postcodes"

#' Small sample of COVID-19 cases in NSW for testing and demonstration.
#'
#' This subset covers a random selection of entries from 3 LGAs, and ignores the case count field.
#'
#' @examples
#' head(covid_cases_nsw)
#' @format A data frame with 100 rows and the following columns:
#' \describe{
#'   \item{postcode}{The postal code}
#'   \item{lhd}{The name of the Local Health District}
#'   \item{lga}{The name of the Local Government Area}
#'   \item{type}{A synthetic disease type/lineage/etc., either A or B}
#'   \item{year}{Year of the case notification}
#' }
#' @source
#'   NSW Ministry of Health.
#'   "NSW COVID-19 cases by location."
#'   \url{https://data.nsw.gov.au/data/dataset/covid-19-cases-by-location}, accessed 11 October 2022.
#'
#'   The original dataset is published under the [Creative Commons Attribution 4.0](https://creativecommons.org/licenses/by/4.0/) licence, © State of New South Wales 2020-2022.
"covid_cases_nsw"
