# gmtwrite

```julia
gmtwrite(fname::AbstractString, data; kwargs...)
```

*keywords: GMT, Julia, write raster vector*

Write a GMT object to file. The object is one of `grd` or `grid`, `image` or `img`,
`dataset` or `table`, `cmap` or `cpt` and `ps` (for postscript).
For the datasets case if the file name ends in .arrow, .shp, .json, .feather, .geojson,
.gmt, .gpkg, .gpx, .gml or .parquet then it automatically selects ``gdalwrite`` and saves the
GMT dataset in that OGR vector format. The .kml is treated as a special case because there are GMT modules
(e.g. `gmt2kml`) that produce KML formatted data and so we write it directly as a text file.

When saving grids we have a panoply of formats at our disposal.

Parameters
----------

- `binary`: Applyes only when saving a ``stl`` file. By default it is true. Use `binary=false` to save in ascii.

- `id`: Use an `id` code when not not saving a grid into a standard COARDS-compliant netCDF grid. This `id`
  is made up of two characters like ``ef`` to save in ESRI Arc/Info ASCII Grid Interchange format (ASCII float).
  See the full list of ids at [grdconvert](https://docs.generic-mapping-tools.org/latest/grdconvert.html#format-identifier)

- `scale` | `offset`: You may optionally ask to scale the data and then offset them with the specified amounts.
  These modifiers are particularly practical when storing the data as integers, by first removing an offset
  and then scaling down the values. The `scale` factor can also be applied when saving to stl (scales the z values).

- `nan` | `novalue` | `invalid` | `missing`: Lets you supply a value that represents an invalid grid entry, i.e., NaN.

- `gdal`: Boolean. Force the use of the GDAL library to write the grid (to be used only with grids).

- `driver`: When saving in other than the netCDF format we must tell the GDAL library what is the wished format.
  That is done by specifying the driver name used by GDAL itself (e.g., "netCDF", "GTiFF", etc...).

- `datatype`: When saving with GDAL we can specify the data type from "u8|u16|i16|u32|i32|float32" where ‘i’ and ‘u’ denote
  signed and unsigned integers respectively.

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_f}

Examples
--------

write the GMTgrid 'G' object into a netCDF file called 'lixo.grd'

```julia
gmtwrite("lixo.grd", G)
```

To save the Norway country borders in shapefile format, do:

```julia
No = coast(DCW=:NO, dump=true);
gmtwrite("Norway.shp", No)
```


See Also
--------

\myreflink{gmtread}, \myreflink{gdalread}