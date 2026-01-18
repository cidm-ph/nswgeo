# Small sample of COVID-19 cases in NSW for testing and demonstration.

This subset covers a random selection of entries from 3 LGAs, and
ignores the case count field.

## Usage

``` r
covid_cases_nsw
```

## Format

A data frame with 100 rows and the following columns:

- postcode:

  The postal code

- lhd:

  The name of the Local Health District

- lga:

  The name of the Local Government Area

- type:

  A synthetic disease type/lineage/etc., either A or B

- year:

  Year of the case notification

## Source

NSW Ministry of Health. "NSW COVID-19 cases by location."
<https://data.nsw.gov.au/data/dataset/covid-19-cases-by-location>,
accessed 11 October 2022.

The original dataset is published under the [Creative Commons
Attribution 4.0](https://creativecommons.org/licenses/by/4.0/) licence,
© State of New South Wales 2020-2022.

## Examples

``` r
head(covid_cases_nsw)
#> # A tibble: 6 × 5
#>   postcode lga       lhd                 year type 
#>   <chr>    <chr>     <chr>              <int> <chr>
#> 1 2427     Mid-Coast Hunter New England  2022 B    
#> 2 2761     Blacktown Western Sydney      2021 A    
#> 3 2426     Mid-Coast Hunter New England  2022 B    
#> 4 2148     Blacktown Western Sydney      2022 B    
#> 5 2768     Blacktown Western Sydney      2021 A    
#> 6 2766     Blacktown Western Sydney      2021 B    
```
