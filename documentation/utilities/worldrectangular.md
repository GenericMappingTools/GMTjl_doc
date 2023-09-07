# worldrectangular

```julia
GI[,coast] = worldrectangular(GI; proj::String="+proj=vandg", pm=0, latlim=:auto, coast=false)
```

Try to create a rectangular map out miscellaneous and not cylindrical projections. We say *try* because
only some projections are supported and those depend on the GDAL version. So a (slow) moving target.

- `GI`: A \myreflink{GMTgrid} or \myreflink{GMTimage} data type. `GI` can also be a string with a file name of a grid or image.

- `proj`: A PROJ4 string describing the projection.

- `pm`: The projection prime meridian (Default is 0).

- `latlim or latlims`: Latitude(s) at which the rectangular map is trimmed. The default (:auto) means
   that we will try to trim such that we get a fully filled grid/image. Use `latlim=(lat_s,lat_n)` or
   `latlim=lat` to make it equivalent to `latlim=(-lat,lat)`.

- `coast`: Return also the coastlines projected with `proj`. Pass `coast=res`, where `res` is one of
   GMT coastline resolutions (*e.g.* :crude, :low, :intermediate). `coast=true` is <==> `coast=:crude`
   Pass `coast=D`, where `D` is vector of GMTdataset containing coastline polygons with a provenience
   other than the GSHHG GMT database.

Returns
-------

A grid or a image and optionally the coastlines ... or errors. Not many projections support the procedure
implemented in this function.
The working or not is controlled by PROJ's [+over option](https://proj.org/usage/projections.html#longitude-wrapping)


Example
-------

\begin{examplefig}{}
```julia
using GMT
G = worldrectangular("@earth_relief_10m");
viz(G)
```
\end{examplefig}

See Also
--------

\myreflink{coastlinesproj}, \myreflink{graticules}, \myreflink{plotgrid!}, \myreflink{worldrectgrid}, \myreflink{worldrectcoast},
\myreflink{Best rectangular world map projection}