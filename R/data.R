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
#'   Spatial Services, Department of Customer Service.
#'   "NSW Administrative Boundaries Theme - Suburb."
#'   \url{https://portal.spatial.nsw.gov.au/portal/home/item.html?id=38bdaa10b7cc41a3a19be6eca91f5368}, accessed 21 September 2022.
#'
#'   The original dataset is published under the Creative Commons Attribution 4.0 Australia licence, © Spatial Services 2021.
"suburbs"

#' Geospatial data of the Australian state and territory administrative boundaries.
#'
#' Excludes external territories.
#'
#' The geometries have been simplified with a tolerance of 5 km to reduce the
#' level of detail.
#'
#' @source
#'   Australian Bureau of Statistics. "Australian Statistical Geography Standard (ASGS) Edition 3." ABS, Jul2021-Jun2026,
#'   \url{https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026}, accessed 10 November 2022.
#'
#'   The original dataset is published under the [Creative Commons Attribution 4.0 International](http://creativecommons.org/licenses/by/4.0/) licence, © Commonwealth of Australia 2021.
#'
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
#' @source
#'   Australian Bureau of Statistics. "Australian Statistical Geography Standard (ASGS) Edition 3." ABS, Jul2021-Jun2026,
#'   \url{https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026}, accessed 27 September 2022.
#'
#'   The original dataset is published under the [Creative Commons Attribution 4.0 International](http://creativecommons.org/licenses/by/4.0/) licence, © Commonwealth of Australia 2021.
#'
#' @describeIn nsw External boundaries of New South Wales as a multipolygon.
"nsw"
#' @describeIn nsw Local Health District boundaries of New South Wales
"lhd"
#' @describeIn nsw Local Government Area boundaries of New South Wales.
"lga_nsw"
#' @describeIn nsw Postal area boundaries of New South Wales.
"poa_nsw"

#' Small sample of COVID-19 cases in NSW for testing and demonstration.
#'
#' This subset covers a random selection of entries from 3 LGAs, and ignores the case count field.
#'
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
