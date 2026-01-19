# New South Wales outline with or without related territories

The default outline
[`nswgeo::nsw`](https://cidm-ph.github.io/nswgeo/reference/nsw.md)
includes Jervis Bay Territory, excludes Lord Howe Island, and does not
have a cut out for the ACT. This utility allows each of these to be
adjusted.

## Usage

``` r
outline(lord_howe_island = FALSE, act_cutout = FALSE, jervis_bay = TRUE)
```

## Arguments

- lord_howe_island:

  Include Lord Howe Island.

- act_cutout:

  Cut out the area of the Australian Capital Territory.

- jervis_bay:

  Cover the area of the Jervis Bay Territory.

## Value

A simple features data frame with the requested geometries.

## See also

[nsw](https://cidm-ph.github.io/nswgeo/reference/nsw.md)

## Examples

``` r
library(ggplot2)

outline(lord_howe_island = TRUE) |> ggplot() + geom_sf()
```
