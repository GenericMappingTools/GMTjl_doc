# mapproject

Forward and inverse map transformations, datum conversions and geodesy

## Synopsis

```julia
D = mapproject(cmd0::String="", arg1=nothing; kwargs...)
```

## Description

**mapproject** reads (lon, lat) positions from tables and computes (x, y) coordinates using the specified map projection and scales. Optionally, it can read (x, y) positions and compute (lon, lat) values doing the inverse transformation.

This can be used to transform linear (x, y) points obtained by digitizing a map of known projection to geographical coordinates. May also calculate distances along track, to a fixed point, or closest approach to a line.

Alternatively, can be used to perform various datum conversions. Additional data fields are permitted after the first 2 columns which must have (longitude,latitude) or (x, y). See option `colinfo` on how to read (latitude,longitude) files.

Finally, **mapproject** can compute a variety of auxiliary output data from input coordinates that make up a track. Items like azimuth, distances, distances to other lines, and travel-times along lines can all be computed by using one or more of the options `azim`, `dist`, `dist2line`, and `travel_time`. 

**Note:** Depending on the Optional Arguments listed below, most times `proj` or `region` are not actually required.

## Required Arguments

- **table** (or provide data via first positional argument)
  
  One table file name or a \myreflink{GMTdataset} or a Matrix object holding (lon, lat) or (x, y) data.

## Optional Arguments

- **A** or **azim** or **azimuth** : -- *azim=:b* **|** *azim=:f* **|** *azim=:o* **|** *azim=(fixed_pt=(lon, lat),)* **|** *azim=(var_pt=true,)*
  
  Calculate azimuth along track or to the optional fixed point. Choose among several directives:
  - `:b` - Calculate the back-azimuth from data points to the fixed point
  - `:f` - Calculate the forward azimuth from the fixed point to each data point  
  - `:o` - Get orientations (-90/90) rather than azimuths (0/360)
  - `azim=(back=true | forward=true | orientation=true, fixed_pt=(lon, lat))` - Specify fixed point
  - `azim=(back=true | forward=true | orientation=true, var_pt=true)` - Obtain variable 2nd point via columns 3-4 in input

> Use `distcalc=:e` to compute azimuths on the ellipsoid. If no fixed point is given, computes azimuth from the previous point.
> **Note:** If `region` and `proj` are given, coordinates are projected first and then Cartesian angles are computed.

- **C** or **center** : -- *center=true* **|** *center=(dx, dy)* **|** *center=((dx, dy), merc=true)*
  
  Set center of projected coordinates to be at map projection center [Default is lower left corner]. Optionally, add offsets in the projected units to be added (or subtracted when `inverse` is set):
  - `center=true` - Center at map projection center
  - `center=(dx, dy)` - Add false easting/northing offsets
  - `center=((dx, dy), merc=true)` - For Mercator only, set origin at standard parallel
  
  The offset unit is the plot distance unit unless `unit` is used (in which case offsets are in meters).

- **D** or **lengthunit** : -- *lengthunit=:c* **|** *lengthunit=:i* **|** *lengthunit=:p*
  
  Temporarily override PROJ_LENGTH_UNIT:
  - `:c` - Use centimeters
  - `:i` - Use inches  
  - `:p` - Use points
  
  Cannot be used with `one2one`.

- **E** or **ecef** or **geod2ecef** : -- *ecef=true* **|** *ecef=datum*
  
  Convert from geodetic (lon, lat, height) to Earth Centered Earth Fixed (ECEF) (x, y, z) coordinates.
  Add `inverse=true` for the reverse. Append datum ID or ellipsoid parameters.

- **F** or **one2one** : -- *one2one=true* **|** *one2one=:e* **|** *one2one=:f* **|** *one2one=:k* **|** *one2one=:M* **|** *one2one=:n* **|** *one2one=:u* **|** *one2one=:c* **|** *one2one=:i* **|** *one2one=:p*

  Force 1:1 scaling (output data in actual projected meters). Specify desired unit:

  - `:e` - meters [Default]
  - `:f` - feet
  - `:k` - kilometers
  - `:M` - statute miles
  - `:n` - nautical miles
  - `:u` - US survey feet
  - `:c`, `:i`, `:p` - centimeters, inches, points

- **G** or **track_distances** : -- *track_distances=true* **|** *track_distances=(fixed_pt=(lon,lat), accumulated=true, incremental=true, unit="??", var_pt=true)*
  
  Calculate distances along track or to optional fixed point:
  - `track_distances=true` - Accumulated distances along track
  - `track_distances=(lon, lat)` - Incremental distances to fixed point
  - Modifiers:
    - `fixed_pt=(lon, lat)` - Incremental distances to fixed point
    - `accumulated=true` - Accumulated distances
    - `incr=true` - Incremental distances  
    - `unit=:k` - Distance unit (see Units)
    - `unit=:c` - Cartesian distance using input coordinates
    - `unit=:C` - Cartesian distance using projected coordinates (requires `region` and `proj`)
    - `var=true` - Variable 2nd point via columns 3-4

- **I** or **inverse** : -- *inverse=true*
  
  Do inverse transformation: get (longitude, latitude) from (x, y) data.

\textinput{common_opts/opt_J}
  
- **L** or **dist2line** : -- *dist2line=table"* **|** *dist2line=("table.txt", unit="??", cartesian=true, project=true, fractional_pt=true)*
  
  Determine shortest distance from input data points to line(s) in the multisegment file. Appends distance and nearest point coordinates:
  - `dist2line=Matrix|Datset|"table.txt"` - Basic usage
  - Modifiers:
    - `fractional_pt=true` - Report segment id and fractional point number instead of lon/lat
    - `unit=:k` - Distance unit (see Units)
    - `cartesian=true` - Cartesian distances
    - `project=true`   - Cartesian distances using projected coordinates (requires `region` and `proj`)

> **Note:** Calculation mode for geographic data is spherical; `distcalc=:e` cannot be used with `dist2line`.

- **N** or **geod2aux** : -- *geod2aux=:a* **|** *geod2aux=:c* **|** *geod2aux=:g* **|** *geod2aux=:m*
  
  Convert from geodetic latitudes to auxiliary latitudes (longitudes unaffected):
  - `:a` - Authalic latitudes
  - `:c` - Conformal latitudes
  - `:g` - Geocentric latitudes [Default]
  - `:m` - Meridional latitudes
  
  Use `inverse=true` to convert from auxiliary to geodetic latitudes.

- **Q** or **list** : -- *list=true* **|** *list=:d* **|** *list=:e*
 
  List all projection parameters:
  - `list=:d` - List only datums
  - `list=:e` - List only ellipsoids

\textinput{common_opts/opt_R}
  
- **S** or **suppress** : -- *suppress=true*
  
  Suppress points that fall outside the region.

- **T** or **datum** : -- *datum="from/to"* **|** *datum=("from", "to", height=true)*
  
  Coordinate conversions between datums using standard Molodensky transformation:
  - `datum="from/to"` - Convert between datums
  - `datum=("from", "to", height=true)` - Use when 3rd input column has height above ellipsoid
  
  Specify datums using datum ID or ellipsoid parameters. May be used with `region` and `proj` to change datum
  before projection (add `inverse=true` for datum conversion after inverse projection).

\textinput{common_opts/opt_V}
  
- **W** or **mapsize** or **map_size** : -- *mapsize=true* **|** *mapsize=:b* **|** *mapsize=:e* **|** *mapsize=:g* **|** *mapsize=:h* **|** *mapsize=:w* **|** *mapsize=:r **|** *mapsize="r+n200*
  
  Report plot dimensions or map regions. No input files are read:
  - `mapsize=true` - Report map width and height
  - `mapsize=:b` - Bounding box in lon/lat
  - `mapsize=:B` - Same, in region string format  
  - `mapsize=:e` - Rectangular area encompassing non-rectangular domain
  - `mapsize=:E` - Same, in region string format
  - `mapsize=(:g, lon, lat)` - Plot coordinates of map point
  - `mapsize=:h` - Only height
  - `mapsize=:w` - Only width
  - `mapsize=(:j, code)` - Map coords of reference point (e.g., `:TL`)
  - `mapsize=(:n, (rx, ry))` - Normalized reference point (0-1 range)
  - `mapsize=:o` - Diagonal corner coords for oblique domain
  - `mapsize=:O` - Same, in region string format
  - `mapsize=:m` - Rectangular region in projected plot coords
  - `mapsize=:M` - Same, in region string format
  - `mapsize=:r` - Rectangular domain covering oblique area
  - `mapsize=:R` - Same, in region string format
  - `mapsize=(:x, (px, py))` - Map coords of specific plot reference point

- **Z** or **travel_time** : -- *travel_time=speed* **|** *travel_time=(speed=speed, accum=true, incr=true, iso=true, epoch=t0)*
  
  Calculate travel times along track as specified with `dist`:
  - `travel_time=12` - Constant speed (in distance units per TIME_UNIT)
  - Modifiers:
    - `incr=true` - Incremental travel times
    - `accum=true` - Accumulated travel times
    - `iso=true` - Format accumulated time per ISO 8601 convention
    - `epoch=t0` - Report absolute times (ETA) for successive points
  
  If speed is omitted, expects to read variable speed from column 3. Requires `dist` option with `incr=true` modifier when using `epoch`.

\textinput{common_opts/opt_bi}
  
\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__j}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_o}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt_xy}

## Units

For map distance unit, append unit:
- `d` - arc degree
- `m` - arc minute
- `s` - arc second
- `e` - meter [Default unless stated otherwise]
- `f` - foot
- `k` - kilometer
- `M` - statute mile
- `n` - nautical mile
- `u` - US survey foot

By default, distances use spherical approximation with great circles (`distcalc=:g`) using the authalic radius. Use `distcalc=:f` for "Flat Earth" calculations (quicker but less accurate) or `distcalc=:e` for exact geodesic calculations (slower but more accurate).

## Examples

**Transform remote file with (latitude, longitude) to (x, y) in cm on Mercator grid:**

```julia
D = mapproject("@waypoints.txt", region=(-180,180,-72,72), proj="M0.5c", yx=:i)
```

**Convert UTM coordinates to geographic locations:**

```julia
D = mapproject("utm.txt", proj=(utm=11,), center=true, inverse=true, unit=true)
```

**Transform binary files with (latitude, longitude) to (x, y) on Transverse Mercator:**

```julia
D = mapproject("tracks.bin", region=(-80,-70,20,40), proj=(tmerc=-75, scale="1:500000"),
               swap_xy=:i, suppress=true, lengthunit=:i, binary_in=2, binary_out=2)
```

**Convert NAD27 to WGS84 datum:**

```julia
D = mapproject("old.txt", datum="131")  # From NAD27 CONUS (datum 131) to WGS84
```

**Compute closest distance between points and line segments:**

```julia
D = mapproject("quakes.txt", line_dist=("coastline.txt", unit=:k))
```

**Compute accumulated distance along Cartesian track:**

```julia
D = mapproject("pos.txt", dist=(unit=:c,))
```

**Compute distances and travel times with fixed speed:**

```julia
D = mapproject("track.txt", dist=(unit=:n, accum=true, incr=true),
               travel_time=(12, accum=true), par=(TIME_UNIT=:h,))
# Speed is 12 nm/hour, times reported in hours
```

**Get geographic coordinates of map mid-point:**

```julia
D = mapproject(region=(-80,-70,20,40), proj=(tmerc=-75, scale="1:500000"), W=(:j, :CM))
```

**Determine rectangular region encompassing oblique region:**

```julia
D = mapproject(region="270/20/305/25+r", proj=(obl_merc=(280,25.5,22,69), width=2), W=:R)
```

**Get oblique region string from rectangular projected region:**

```julia
D = mapproject(region="-2800/2400/-570/630+uk", proj=(obl_merc=(190,25,266,68), scale="1:1"), W=:O)
```

**Get closed polygon of oblique area in geographic coords:**

```julia
D = mapproject(region="-2800/2400/-570/630+uk", proj=(obl_merc=(190,25,266,68), scale="1:1"),
               W=(:r, npts=100))
```

**Get bounding box for stereographic projection:**

```julia
D = mapproject(proj=(stereo=(36,90), width=30), region=(-15,60,68,90), W=:E)
```

**Obtain azimuth of railroad using entry/exit points:**

```julia
# Input: lon1 lat1 lon2 lat2
result = mapproject([(-87.7447873 42.1192976; -87.7725841 42.1523955)],
                    azim=(:f, var=true), colinfo=:g, outcols="4")
```

## Important Notes

### Centering Output Region

The rectangular input region set with `region` will generally be mapped into a non-rectangular grid. Unless `center` is set, the leftmost point has x=0.0 and lowermost point has y=0.0. Before digitizing a map, run extreme coordinates through mapproject to see their (x, y) values for proper setup.

### Ellipsoidal vs Spherical Solution

GMT uses ellipsoidal formulae when implemented and an ellipsoid is selected. Be aware:

1. Some projections (Transverse Mercator, Albers, Lambert's conformal conic) use ellipsoidal expressions for
   small areas and switch to spherical for larger maps:
   - Transverse Mercator: All points within 10° of central meridian
   - Conic projections: Longitudinal range < 90°
   - Cassini: All points within 4° of central meridian

2. Historical data discrepancies may arise from:
   - Different precision in calculations
   - Different reference datums
   - Different PROJ_SCALE_FACTOR values

3. Some projections may use spherical solution despite ellipsoid selection when the region exceeds valid domain for ellipsoidal series expansions.

### Output Order

The production order for geodetic and temporal columns from `azim`, `dist`, `line_dist`, and `travel_time` is fixed (alphabetical by option). Command-line order is irrelevant. Use `outcols` to modulate the final output order.

## See Also

[project](https://www.generic-mapping-tools.org/GMTjl_doc/documentation/modules/project/)

## References

- Bomford, G., 1952, Geodesy, Oxford U. Press.
- Snyder, J. P., 1987, Map Projections - A Working Manual, U.S. Geological Survey Prof. Paper 1395.
- Vanicek, P. and Krakiwsky, E, 1982, Geodesy - The Concepts, North-Holland Publ., ISBN: 0 444 86149 1.