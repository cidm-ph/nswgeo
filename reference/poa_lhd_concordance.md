# Concordance between postal areas and local health districts.

Contains the other administrative geometries which intersect with the
local health district boundaries, along with the size of the
intersection.

## Usage

``` r
poa_lhd_concordance
```

## Format

An object of class `data.frame` with 779 rows and 5 columns.

## Source

Computed using the same source datasets as `lhd` and `poa_nsw`.

## Details

For geographic regions used by the Australian Bureau of Statistics
(ABS), the ABS publishes [correspondence
files](https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/correspondences).
These files compare how two different types of regions align with each
other. The Australian Government Department of Health and Aged Care
published analogous [concordance
files](https://www.health.gov.au/resources/collections/primary-health-networks-phns-collection-of-concordance-files)
for primary health networks (PHNs). These are useful for mapping between
different types of administrative districts. There does not appear to be
a publicly available set of concordance files for New South Wales local
health district geographies.

The concordance was computed here by intersecting the ABS geometries
with the local health district geometries. The fraction of the ABS
geometry's area included in the intersection is reported in the column
`FRAC_INCLUDED`. Any intersection with `FRAC_INCLUDED` at least 0.01%
was retained. Area computations were performed in
[`crs_gda2020_albers()`](https://cidm-ph.github.io/nswgeo/reference/crs_gda2020.md)
(EPSG 9473 equal area Albers) coordinates at the original reolution of
the source data.

Note that [postal
areas](https://www.abs.gov.au/ausstats/abs@.nsf/Lookup/by%20Subject/1270.0.55.003~July%202016~Main%20Features~Postal%20Areas%20(POA)~8)
are not precisely the same as postcodes used by Australia Post, however
they are very similar.

## Examples

``` r
library(dplyr)
#> 
#> Attaching package: ‘dplyr’
#> The following objects are masked from ‘package:stats’:
#> 
#>     filter, lag
#> The following objects are masked from ‘package:base’:
#> 
#>     intersect, setdiff, setequal, union

# postcodes that overlap with Murrumbidgee LHD
poa_lhd_concordance |>
  filter(LHD_NAME == "Murrumbidgee Local Health District", FRAC_INCLUDED > 0.005) |>
  arrange(desc(FRAC_INCLUDED)) |>
  pull(POA_NAME_2021)
#>  [1] "2585" "2587" "2588" "2590" "2640" "2641" "2642" "2643" "2644" "2645"
#> [11] "2646" "2647" "2649" "2650" "2651" "2652" "2653" "2655" "2656" "2658"
#> [21] "2659" "2660" "2661" "2663" "2665" "2666" "2668" "2669" "2678" "2680"
#> [31] "2681" "2700" "2701" "2702" "2703" "2705" "2706" "2707" "2710" "2712"
#> [41] "2713" "2714" "2716" "2720" "2722" "2725" "2726" "2727" "2729" "2730"
#> [51] "2731" "2732" "2733" "2734" "2735" "2736" "2803" "2586" "2675" "2672"
#> [61] "2594" "2671" "2711" "2721" "2808" "2611" "3644" "2807" "2629" "2627"
#> [71] "2794" "2582" "2878" "2583" "3707" "2715" "3691"

# extract the main LHD for each postcode
poa_lhd_concordance |>
  arrange(desc(FRAC_INCLUDED)) |>
  slice_head(n = 1, by = POA_NAME_2021) |>
  mutate(postcode = POA_NAME_2021, lhd = LHD_NAME, .keep = "none") |>
  as_tibble()
#> # A tibble: 646 × 2
#>    postcode lhd                                       
#>    <chr>    <chr>                                     
#>  1 2016     Sydney Local Health District              
#>  2 2019     South Eastern Sydney Local Health District
#>  3 2021     South Eastern Sydney Local Health District
#>  4 2022     South Eastern Sydney Local Health District
#>  5 2023     South Eastern Sydney Local Health District
#>  6 2025     South Eastern Sydney Local Health District
#>  7 2031     South Eastern Sydney Local Health District
#>  8 2032     South Eastern Sydney Local Health District
#>  9 2033     South Eastern Sydney Local Health District
#> 10 2035     South Eastern Sydney Local Health District
#> # ℹ 636 more rows
```
