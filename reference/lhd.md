# Local Health Districts of NSW.

The geometries have been simplified with a tolerance of 750 m to reduce
the level of detail.

## Usage

``` r
lhd
```

## Format

An object of class `sf` (inherits from `tbl_df`, `tbl`, `data.frame`)
with 15 rows and 11 columns.

## Source

Spatial Services, Department of Customer Service NSW.
"MyHospitals_Public",
<https://portal.spatial.nsw.gov.au/portal/home/item.html?id=5a1e5dd9b38245d3b976c21b56fd6185>,
accessed 4 May 2023. Republished from NSW Ministry of Health, "Map of
local health districts",
<https://www.health.nsw.gov.au/lhd/Pages/lhd-maps.aspx>.

The original dataset is published under the [Creative Commons
Attribution 4.0
International](https://creativecommons.org/licenses/by/4.0/) licence, ©
State of New South Wales NSW Ministry of Health 2023. For current
information go to <https://www.health.nsw.gov.au>.

## See also

[poa_lhd_concordance](https://cidm-ph.github.io/nswgeo/reference/poa_lhd_concordance.md)

## Examples

``` r
library(ggplot2)
ggplot(lhd) + geom_sf(aes(fill = lhd_name), show.legend = FALSE)
```
