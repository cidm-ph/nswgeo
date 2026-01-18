# Postal codes and localities of New South Wales.

Derived from several government sources with some community curation.
This version additionally attempts to canonicalise non-physical
postcodes to assist with mapping.

## Usage

``` r
postcodes
```

## Format

A data frame with 7 columns:

- postcode:

  A postal code

- locality:

  A suburb or locality

- state:

  NSW

- SA2_NAME_2016:

  Statistical Area 2 name to assist with disambiguating localities with
  identical names

- special:

  Flag indicating this is a post office box, mail distribution centre or
  other special postal code

- old:

  Flag indicating that this code appears to have been superseded

- canonical:

  The closest canonical postal code, e.g. mapping post office boxes to
  the main suburb's postal code

## Source

Matthew Proctor. "Australian Postcodes",
<https://www.matthewproctor.com/australian_postcodes>, accessed 6
February 2023.

The original dataset is released to the public domain.

## Examples

``` r
set.seed(12345)
postcodes[sort(sample.int(nrow(postcodes), 5)),]
#> # A tibble: 5 × 7
#>   postcode locality          state SA2_NAME_2016         special old   canonical
#>   <chr>    <chr>             <chr> <chr>                 <lgl>   <lgl> <chr>    
#> 1 1118     SYDNEY            NSW   Sydney - Haymarket -… TRUE    NA    2000     
#> 2 2161     OLD GUILDFORD     NSW   Fairfield - East      NA      NA    2161     
#> 3 2164     WETHERILL PARK BC NSW   Wetherill Park Indus… NA      NA    2164     
#> 4 2469     JOES BOX          NSW   Casino Region         NA      NA    2469     
#> 5 2849     PYANGLE           NSW   Mudgee Region - East  NA      NA    2849     
```
