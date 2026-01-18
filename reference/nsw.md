# Outlines of New South Wales and relevant territories.

Lord Howe Island is administratively part of NSW, but as it is a small
island some 600 km off the coast, it is frequently omitted from maps of
NSW.

## Usage

``` r
nsw

act

lhi

jbt

sydney
```

## Format

An object of class `sfc_MULTIPOLYGON` (inherits from `sfc`) of length 1.

An object of class `sfc_MULTIPOLYGON` (inherits from `sfc`) of length 1.

An object of class `sfc_MULTIPOLYGON` (inherits from `sfc`) of length 1.

An object of class `sfc_MULTIPOLYGON` (inherits from `sfc`) of length 1.

An object of class `sfc_POLYGON` (inherits from `sfc`) of length 1.

## Source

Australian Bureau of Statistics. "Australian Statistical Geography
Standard (ASGS) Edition 3." ABS, Jul2021-Jun2026 (24 July 2024 update),
<https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026>,
accessed 29 July 2024.

The original dataset is published under the [Creative Commons
Attribution 4.0
International](https://creativecommons.org/licenses/by/4.0/) licence, ©
Commonwealth of Australia 2021.

## Details

The Australian Capital Territory is an enclave within NSW, and Jervis
Bay Territory is a small Australian territory on the coast, surrounded
by NSW. Neither are NSW territory, but they affect the shape of NSW's
outline and are sometimes useful to include in maps alongside NSW due to
their locations.

The geometry for `nsw` has been simplified with a tolerance of 750 m to
reduce the level of detail, whereas the territories maintain their full
resolution. `sydney` is simplified with a 500 m tolerance.

## Functions

- `nsw`: External state boundary excluding LHI but including ACT and
  JBT.

- `act`: Australian Capital Territory boundary.

- `lhi`: Lord Howe Island boundary.

- `jbt`: Jervis Bay Territory boundary.

- `sydney`: Greater Sydney boundary.

## See also

[`outline()`](https://cidm-ph.github.io/nswgeo/reference/outline.md)
