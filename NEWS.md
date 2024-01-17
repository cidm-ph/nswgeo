# nswgeo (development version)

* Add Primary Health Network (PHN) map data as `phn` dataset.
* Fixed the `poa_nsw` dataset to avoid strange geometries near the state border.
* Added geometries for Lord Howe Island, Australian Capital Territory, and
  Jervis Bay Territory, and a utility function `outline()` for using them.
* Add Greater Sydney boundary as `sydney` dataset.
* Slightly increase the resolution of most maps to 750 m instead of 1 km.
* Update to the 2023 ASGS release, including the 2023 LGA shapefile. Note that
  this means some field names changed (e.g. `LGA_NAME_2021` to `LGA_NAME_2023`).
* Add new coordinate system references relevant for Australia
  (`crs_gda2020_cartesian` and `crs_gda2020_albers`).
* Add concordance file for ABS postal areas and local health districts
  (`poa_lhd_concordance`).

# nswgeo 0.3.3

* Initial CRAN release.
