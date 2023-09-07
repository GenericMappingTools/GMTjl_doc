# worldrectcoast

```julia
cl = worldrectcoast(proj="?", res="crude", coastlines=nothing, limits=Float64[])
```

Return a project coastline, at `res` resolution, suitable to overlain in a grid created with the
\myreflink{worldrectangular} function. Note that this function, contrary to \myreflink{coastlinesproj}, returns coastline
data that spans > 360 degrees.

- `proj`: A proj4 string describing the projection (Mandatory).

- `res`: The GSHHG coastline resolution. Available options are: `crude`, `low`, `intermediate`, `high` and `full`

- `coastlines`: In alternative to the `res` option, one may pass a GMTdataset with coastlines
   previously loaded (with \myreflink{gmtread}) from another source.

- `limits`: If not empty it must be a 2 elements array with lon_min, lon_max that is used to ask for
   coastlines that expand more than 360 degrees (\myreflink{worldrectangular} uses this).

Returns
-------

A Vector of \myreflink{GMTdataset} containing the projected world GSHHG coastlines at resolution `res`.


See Also
--------

\myreflink{coastlinesproj}, \myreflink{graticules}, \myreflink{plotgrid!}, \myreflink{worldrectangular}, \myreflink{worldrectgrid}, 
\myreflink{Best rectangular world map projection}
