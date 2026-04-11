# graticules

```julia
grat = graticules(D, width=(30,20), grid=nothing, annot_x=nothing)

or

grat = graticules(; proj="projection", width=(30,20), pm=0, grid=nothing, annot_x=nothing)
```

Create a projected graticule \myreflink{GMTdataset} with meridians and parallels at `width` intervals.

- `D`: A \myreflink{GMTdataset} (or vector of them) holding the projection info. Instead of GMTdataset type, this
  argument may also be a referenced grid or image type.

- `proj`: Alternatively pass a proj4 string or Symbol describing the projection

- `pm`: The projection prime meridian (Default is 0 or whatever is in D.proj4).

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

Example
-------

```julia
using GMT
grat = graticules(proj="+proj=ob_tran +o_proj=moll +o_lon_p=40 +o_lat_p=50 +lon_0=60");
```

See Also
--------

\myreflink{coastlinesproj}, \myreflink{plotgrid!}, \myreflink{worldrectangular}, \myreflink{worldrectgrid}, \myreflink{worldrectcoast},
\myreflink{Best rectangular world map projection}
