# Geospatial data of the Australian state and territory administrative boundaries.

Excludes external territories.

## Usage

``` r
australia

states
```

## Format

An object of class `sfc_MULTIPOLYGON` (inherits from `sfc`) of length 1.

An object of class `sf` (inherits from `tbl_df`, `tbl`, `data.frame`)
with 8 rows and 9 columns.

## Source

Australian Bureau of Statistics. "Australian Statistical Geography
Standard (ASGS) Edition 3." ABS, Jul2021-Jun2026,
<https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026>,
accessed 10 November 2022.

The original dataset is published under the [Creative Commons
Attribution 4.0
International](https://creativecommons.org/licenses/by/4.0/) licence, ©
Commonwealth of Australia 2021.

## Details

The geometries have been simplified with a tolerance of 5 km to reduce
the level of detail.

## Functions

- `australia`: External boundaries of Australia as a multipolygon.

- `states`: State and internal territory boundaries of Australia.

## Examples

``` r
library(ggplot2)
ggplot(states) + geom_sf(aes(fill = STE_NAME21))
```
