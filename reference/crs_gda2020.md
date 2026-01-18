# Coordinate reference system for Australia

GDA2020 is the official CRS used by the
[Commonwealth](https://www.icsm.gov.au/gda2020) and
[NSW](https://www.spatial.nsw.gov.au/surveying/geodesy/gda2020).
Geospatial data in this package uses GDA2020.

## Usage

``` r
crs_gda2020()

crs_gda2020_cartesian()

crs_gda2020_albers()
```

## Value

A simple features CRS

## Details

`crs_gda2020` is EPSG 7844 with axes specified in degrees.

`crs_gda2020_cartesian` is EPSG 7842 with Cartesian axes in metres.

`crs_gda2020_albers` is EPSG 9473, the Albers equal area projection
used, making it suitable for area computation.
