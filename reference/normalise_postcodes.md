# Normalise postal codes

Some special postcodes are used in addresses, such as codes for post
office boxes. This helper converts those to the postcode for the closest
normal suburb if there is a reasonable clear match. If there is no good
match, the postcodes are left unchanged.

## Usage

``` r
normalise_postcodes(codes)
```

## Arguments

- codes:

  Character vector of postcodes (or coercible to one).

## Value

Character vector of the same size as the input, but with the normalised
postcodes.

## Details

Note that this goes a little further than the aliases that are
registered with cartographer (which only account for postcodes with no
geospatial data in the ABS dataset).

## Examples

``` r
normalise_postcodes(c(1685, 2000, 1010, 2129, 2145))
#> [1] "2114" "2000" "2000" "2140" "2145"
```
