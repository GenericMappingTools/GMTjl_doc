# leepacific

```julia
GI[,coast] = leepacific(fname::String|GI::GItype; latlims=nothing, lonlims=nothing, coast=true)
```

Project a geographical grid/image in the Lee Oblated Stereographic projection centered on the Pacific Ocean.

- `GI`: A GMTgrid or GMTimage data type. `GI` can also be a string with a file name of a grid or image.
   NOTE: This grid/image should (ideally) have longitudes covering the range 76 to 319 degrees (here lon in [0 360] is better)

- `latlims`: Latitudes used in `region` when reading the grid/image. The default is (-87, 75).

- `lonlims`: Longitudes used in `region` when reading the grid/image. You cannot deviate mutch from (90,300).
   Actually, while a bug in GDAL is not fixed, you should not change the default values.

- `coast`: Return also the coastlines projected with `proj`. Pass `coast=res`, where `res` is one of
   GMT coastline resolutions (*e.g.* :crude, :low, :intermediate). `coast=true` is <==> `coast=:crude`
   Pass `coast=D`, where `D` is vector of GMTdataset containing coastline polygons with a provenience
   other than the GSHHG GMT database. If `coast=false` the funtion returns only the projected grid/image.

Note: This function uses \myreflink{worldrectangular} with the `+proj=lee_os` projection. If one wants to add
other elements to the map (points, lines, etc) one must projectem first with the `+proj=lee_os` projection
(use \myreflink{lonlat2xy} or \myreflink{mapproject} to that purpose).

Returns
-------

A grid or a image and optionally the coastlines .

Example
-------

\begin{examplefig}{}
```julia
using GMT
resetGMT()  # hide
G,cl = leepacific("@earth_relief_20m_g");
grdimage(G, shade=true, plot=(data=cl,), cmap=:geo, B=:none)
plotgrid!(G, show=true)
```
\end{examplefig}

See Also
--------

\myreflink{coastlinesproj}, \myreflink{graticules}, \myreflink{plotgrid!}, \myreflink{worldrectangular}, \myreflink{worldrectgrid}, \myreflink{worldrectcoast},
\myreflink{Best rectangular world map projection}