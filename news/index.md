# Changelog

## nswgeo (development version)

- Fix an issue with the Lord Howe Isand geometry missing its CRS in
  [`outline()`](https://cidm-ph.github.io/nswgeo/reference/outline.md).

## nswgeo 0.5.0

CRAN release: 2024-12-17

- Updated to the 2024 ASGS release, including the 2024 LGA shapefile.
  Note that this means some field names changed (e.g. `LGA_NAME_2023` to
  `LGA_NAME_2024`).
- Fixed bug in ACT cut out for
  [`outline()`](https://cidm-ph.github.io/nswgeo/reference/outline.md).

## nswgeo 0.4.0

CRAN release: 2024-01-29

- Added some new maps:
  - [`nswgeo::phn`](https://cidm-ph.github.io/nswgeo/reference/phn.md) -
    Primary Health Networks (PHNs)
  - [`nswgeo::act`](https://cidm-ph.github.io/nswgeo/reference/nsw.md) -
    Australian Capital Territory (ACT)
  - [`nswgeo::jbt`](https://cidm-ph.github.io/nswgeo/reference/nsw.md) -
    Jervis Bay Territory
  - [`nswgeo::lhi`](https://cidm-ph.github.io/nswgeo/reference/nsw.md) -
    Lord Howe Island
  - [`nswgeo::sydney`](https://cidm-ph.github.io/nswgeo/reference/nsw.md) -
    Greater Sydney
- Added a new helper function
  [`outline()`](https://cidm-ph.github.io/nswgeo/reference/outline.md)
  for combining the NSW external boundaries with the territories.
- Add new helpers for coordinate reference systems relevant for
  Australia
  ([`crs_gda2020_cartesian()`](https://cidm-ph.github.io/nswgeo/reference/crs_gda2020.md)
  and
  [`crs_gda2020_albers()`](https://cidm-ph.github.io/nswgeo/reference/crs_gda2020.md)).
- Add concordance file for ABS postal areas and local health districts
  ([`nswgeo::poa_lhd_concordance`](https://cidm-ph.github.io/nswgeo/reference/poa_lhd_concordance.md)).
- Fixed the
  [`nswgeo::poa_nsw`](https://cidm-ph.github.io/nswgeo/reference/nsw_admin.md)
  dataset to avoid strange geometries near the state border.
- Slightly increased the resolution of most maps to 750 m instead of 1
  km.
- Updated to the 2023 ASGS release, including the 2023 LGA shapefile.
  Note that this means some field names changed (e.g. `LGA_NAME_2021` to
  `LGA_NAME_2023`).
- Declare support for older R version 4.1.

## nswgeo 0.3.3

CRAN release: 2023-05-05

- Initial CRAN release.
