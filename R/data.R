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

#' Outlines of New South Wales and relevant territories.
#'
#' Lord Howe Island is administratively part of NSW, but as it is a small
#' island some 600 km off the coast, it is frequently omitted from maps of NSW.
#'
#' The Australian Capital Territory is an enclave within NSW, and Jervis Bay
#' Territory is a small Australian territory on the coast, surrounded by NSW.
#' Neither are NSW territory, but they affect the shape of NSW's outline and are
#' sometimes useful to include in maps alongside NSW due to their locations.
#'
#' The geometry for `nsw` has been simplified with a tolerance of 750 m to
#' reduce the level of detail, whereas the territories maintain their full
#' resolution. `sydney` is simplified with a 500 m tolerance.
#'
#' @seealso [outline()]
#' @source
#'   Australian Bureau of Statistics. "Australian Statistical Geography Standard (ASGS) Edition 3." ABS, Jul2021-Jun2026,
#'   \url{https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026}, accessed 27 September 2022.
#'
#'   The original dataset is published under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) licence, © Commonwealth of Australia 2021.
#' @describeIn nsw External state boundary excluding LHI but including ACT and JBT.
"nsw"
#' @describeIn nsw Australian Capital Territory boundary.
"act"
#' @describeIn nsw Lord Howe Island boundary.
"lhi"
#' @describeIn nsw Jervis Bay Territory boundary.
"jbt"
#' @describeIn nsw Greater Sydney boundary.
"sydney"

#' Geospatial data of the New South Wales administrative boundaries.
#'
#' These include the Unincorporated Far West Region.
#' `lga_nsw` excludes Jervis Bay Territory and the ACT.
#' `poa_nsw` includes both territories and some postal areas extend past the
#' state boundary.
#'
#' The geometries have been simplified with a tolerance of 750 m to reduce the
#' level of detail.
#'
#' @examples
#' library(ggplot2)
#' ggplot(lga_nsw) + geom_sf(aes(fill = LGA_NAME_2023), show.legend = FALSE)
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
#' @describeIn nsw_admin Local Government Area boundaries of New South Wales.
"lga_nsw"
#' @describeIn nsw_admin [Postal area](https://www.abs.gov.au/ausstats/abs@.nsf/Lookup/by%20Subject/1270.0.55.003~July%202016~Main%20Features~Postal%20Areas%20(POA)~8) boundaries of New South Wales.
"poa_nsw"

#' Local Health Districts of NSW.
#'
#' The geometries have been simplified with a tolerance of 750 m to reduce the
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

#' Primary Health Network boundaries of New South Wales
#'
#' The geometries have been simplified with a tolerance of 500 m to reduce the
#' level of detail.
#'
#' @source
#'   National Recovery and Resilience Agency, "PHN Boundaries used by the NBRA",
#'   \url{https://data.gov.au/data/dataset/phn-boundaries-used-by-the-nbra}, accessed 25 May 2023.
#'
#'   The original dataset is published under the [Creative Commons Attribution 2.5 Australia](https://creativecommons.org/licenses/by/2.5/au/) licence,
#'   © Commonwealth of Australia 2021.
"phn"

#' Concordance between postal areas and local health districts.
#'
#' Contains the other administrative geometries which intersect with the local
#' health district boundaries, along with the size of the intersection.
#'
#' For geographic regions used by the Australian Bureau of Statistics (ABS), the
#' ABS publishes [correspondence files](https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/correspondences).
#' These files compare how two different types of regions align with each other.
#' The Australian Government Department of Health and Aged Care published
#' analogous [concordance files](https://www.health.gov.au/resources/collections/primary-health-networks-phns-collection-of-concordance-files)
#' for primary health networks (PHNs).
#' These are useful for mapping between different types of administrative
#' districts.
#' There does not appear to be a publicly available set of concordance files for
#' New South Wales local health district geographies.
#'
#' The concordance was computed here by intersecting the ABS geometries with the
#' local health district geometries. The fraction of the ABS geometry's area
#' included in the intersection is reported in the column `FRAC_INCLUDED`.
#' Any intersection with `FRAC_INCLUDED` at least 0.01% was retained.
#' Area computations were performed in `crs_gda2020_albers()` (EPSG 9473 equal
#' area Albers) coordinates at the original reolution of the source data.
#'
#' Note that [postal areas](https://www.abs.gov.au/ausstats/abs@.nsf/Lookup/by%20Subject/1270.0.55.003~July%202016~Main%20Features~Postal%20Areas%20(POA)~8)
#' are not precisely the same as postcodes used by Australia Post, however they
#' are very similar.
#' @source Computed using the same source datasets as `lhd` and `poa_nsw`.
#' @examples
#' library(dplyr)
#'
#' # postcodes that overlap with Murrumbidgee LHD
#' poa_lhd_concordance |>
#'   filter(lhd_name == "Murrumbidgee", FRAC_INCLUDED > 0.005) |>
#'   arrange(desc(FRAC_INCLUDED)) |>
#'   pull(POA_NAME_2021)
"poa_lhd_concordance"

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
