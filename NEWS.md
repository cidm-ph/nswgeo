# nswgeo 0.5.1

* Fix an issue with the Lord Howe Isand geometry missing its CRS in `outline()`.

# nswgeo 0.5.0

* Updated to the 2024 ASGS release, including the 2024 LGA shapefile. Note that
  this means some field names changed (e.g. `LGA_NAME_2023` to `LGA_NAME_2024`).
* Fixed bug in ACT cut out for `outline()`.

# nswgeo 0.4.0

* Added some new maps:
  - `nswgeo::phn` - Primary Health Networks (PHNs)
  - `nswgeo::act` - Australian Capital Territory (ACT)
  - `nswgeo::jbt` - Jervis Bay Territory
  - `nswgeo::lhi` - Lord Howe Island
  - `nswgeo::sydney` - Greater Sydney
* Added a new helper function `outline()` for combining the NSW external boundaries
  with the territories.
* Add new helpers for coordinate reference systems relevant for Australia
  (`crs_gda2020_cartesian()` and `crs_gda2020_albers()`).
* Add concordance file for ABS postal areas and local health districts
  (`nswgeo::poa_lhd_concordance`).
* Fixed the `nswgeo::poa_nsw` dataset to avoid strange geometries near the state
  border.
* Slightly increased the resolution of most maps to 750 m instead of 1 km.
* Updated to the 2023 ASGS release, including the 2023 LGA shapefile. Note that
  this means some field names changed (e.g. `LGA_NAME_2021` to `LGA_NAME_2023`).
* Declare support for older R version 4.1.

# nswgeo 0.3.3

* Initial CRAN release.
