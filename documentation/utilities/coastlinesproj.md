# coastlinesproj

```julia
cl = coastlinesproj(proj="?", res="crude", coastlines=nothing, limits=Float64[])
```

Extract the coastlines from GMT's GSHHG database and project them using PROJ (NOT the GMT projection machinery).
This allows the use of many of the PROJ projections that are not available from pure GMT.

- `proj`: A proj4 string describing the projection (Mandatory).

- `res`: The GSHHG coastline resolution. Available options are: `crude`, `low`, `intermediate`, `high` and `full`

- `coastlines`: In alternative to the `res` option, one may pass a GMTdataset with coastlines
   previously loaded (with \myreflink{gmtread}) from another source.

- `limits`: If not empty it must be a 2 elements array with lon_min, lon_max that is used to ask for
   coastlines that expand more than 360 degrees (\myreflink{worldrectangular} uses this).


Returns
-------

A Vector of \myreflink{GMTdataset} containing the projected world GSHHG coastlines at resolution `res`.


Example
-------

```julia
using GMT
cl = coastlinesproj(proj="+proj=ob_tran +o_proj=moll +o_lon_p=40 +o_lat_p=50 +lon_0=60");
```

See Also
--------

\myreflink{graticules}, \myreflink{plotgrid!}, \myreflink{worldrectangular}, \myreflink{worldrectgrid}, \myreflink{worldrectcoast},
\myreflink{Best rectangular world map projection}
