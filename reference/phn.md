# Primary Health Network boundaries of New South Wales

The geometries have been simplified with a tolerance of 500 m to reduce
the level of detail.

## Usage

``` r
phn
```

## Format

An object of class `sf` (inherits from `tbl_df`, `tbl`, `data.frame`)
with 10 rows and 9 columns.

## Source

National Recovery and Resilience Agency, "PHN Boundaries used by the
NBRA",
<https://data.gov.au/data/dataset/phn-boundaries-used-by-the-nbra>,
accessed 9 March 2026.

The original dataset is published under the [Creative Commons
Attribution 2.5
Australia](https://creativecommons.org/licenses/by/2.5/au/) licence, ©
Commonwealth of Australia 2025.

## Examples

``` r
library(ggplot2)
ggplot(phn) + geom_sf(aes(fill = PHN_NAME), show.legend = FALSE)
```
