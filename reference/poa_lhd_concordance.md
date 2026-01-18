# Concordance between postal areas and local health districts.

Contains the other administrative geometries which intersect with the
local health district boundaries, along with the size of the
intersection.

## Usage

``` r
poa_lhd_concordance
```

## Format

An object of class `data.frame` with 825 rows and 5 columns.

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
  filter(lhd_name == "Murrumbidgee", FRAC_INCLUDED > 0.005) |>
  arrange(desc(FRAC_INCLUDED)) |>
  pull(POA_NAME_2021)
#>  [1] "2644" "2646" "2649" "2653" "2659" "2660" "2712" "2713" "2643" "2645"
#> [11] "2647" "2650" "2651" "2655" "2656" "2658" "2661" "2710" "2716" "2729"
#> [21] "2730" "2731" "2732" "2590" "2663" "2678" "2700" "2701" "2702" "2707"
#> [31] "2722" "2726" "2733" "2734" "2735" "2587" "2588" "2652" "2665" "2680"
#> [41] "2703" "2705" "2706" "2725" "2666" "2668" "2681" "2586" "2669" "2714"
#> [51] "2727" "2720" "2675" "2803" "2585" "2736" "2642" "2672" "2594" "2671"
#> [61] "2640" "2711" "2721" "2808" "2611" "3644" "2807" "2629" "2627" "2794"
#> [71] "2582" "2878" "2583" "3707" "2715"

# extract the main LHD for each postcode
poa_lhd_concordance |>
  arrange(desc(FRAC_INCLUDED)) |>
  slice_head(n = 1, by = POA_NAME_2021) |>
  mutate(postcode = POA_NAME_2021, lhd = lhd_name, .keep = "none") |>
  as_tibble()
#> # A tibble: 671 × 2
#>    postcode lhd         
#>    <chr>    <chr>       
#>  1 2549     Southern NSW
#>  2 2632     Southern NSW
#>  3 2548     Southern NSW
#>  4 2550     Southern NSW
#>  5 2551     Southern NSW
#>  6 2625     Southern NSW
#>  7 2631     Southern NSW
#>  8 2545     Southern NSW
#>  9 2546     Southern NSW
#> 10 2630     Southern NSW
#> # ℹ 661 more rows
```
