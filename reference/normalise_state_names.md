# Normalise state names from abbreviations

Expand abbreviations like `"NSW"` to `"New South Wales"`, and normalise
to title capitalisation. Entries that don't match any state name or
abbreviation are left untouched.

## Usage

``` r
normalise_state_names(names)
```

## Arguments

- names:

  Character vector of state names.

## Value

Vector of the same size as the input, but with the normalised state
names.

## Examples

``` r
normalise_state_names(c("nsw", "VIC", "overseas", "Queensland"))
#> [1] "New South Wales" "Victoria"        "overseas"        "Queensland"     
```
