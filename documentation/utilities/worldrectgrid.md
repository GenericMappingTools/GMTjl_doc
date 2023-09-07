# worldrectgrid

```julia
grat = worldrectgrid(GI; width=(30,20), grid=nothing, annot_x=nothing)

or

grat = worldrectgrid(; proj="projection", width=(30,20), grid=nothing, annot_x=nothing)
```

Create a grid of lines (graticules) in projected coordinates. The projection system is extracted from
the `GI` metadata.

- `GI`: A GMTgrid or GMTimage data type created with the \myreflink{worldrectangular} function.

- `proj`: Pass a proj4 string or Symbol describing the projection. Alternatively pass a referenced
  \myreflink{GMTdataset} from which the projection will be extracted.

- `width`: A scalar or two elements array/tuple with increments in longitude and latitude. If scalar, width_x = width_y.

- `grid`: Instead of using the `width` argument, that generates an automatic set of graticules, one may pass
  a two elements Vector{Vector{Real}} with the meridians (grid[1]) and parallels (grid[2]) to create.

- `annot_x`: By default, all meridians are annotated when `grat` is used in the \myreflink{plotgrid!} function, but
  depending on the projection and the `latlim` argument used in \myreflink{worldrectangular} we may have the longitude
  labels overlap close to the prime meridian. To minimize that pass a vector of longitudes to be annotated.
  *e.g.* ` annot_x=[-180,-150,0,150,180]` will annotate only those longitudes.

Returns
-------

A Vector of \myreflink{GMTdataset} containing the projected meridians and parallels. `grat[i]` attributes store
information about that element lon,lat. 

See Also
--------

\myreflink{coastlinesproj}, \myreflink{graticules}, \myreflink{plotgrid!}, \myreflink{worldrectangular}, \myreflink{worldrectcoast},
\myreflink{Best rectangular world map projection}
