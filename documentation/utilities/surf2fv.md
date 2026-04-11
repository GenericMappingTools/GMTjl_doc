# surf2fv

```julia
FV = surf2fv(X::Matrix{T}, Y::Matrix{T}, Z::Matrix{T}; type=:tri, bfculling=true,
             proj="", proj4="", wkt="", epsg=0, top=nothing, bottom=nothing)::GMTfv
```

Create a three-dimensional FacesVertices object.

This function is suitable for 3D plotting either of closed bodies or 3D surfaces.
The values in matrix Z represent the heights above a grid in the x-y plane defined by X and Y

### Args
- `X,Y,Z`: Three matrices of the same size and type float.

### Kwargs
- `type`: The face type. Either ``:tri`` (the default) or ``:quad`` for triangular or quadrangular faces.

- `bfculling`: Boolean that specifies if culling of invisible faces is wished (default is ``true``)

- `proj` or `proj4`:  A proj4 string for setting the Coordinate Referencing System (optional).

- `wkt`: A WKT SRS (optional).

- `epsg`: Same as `proj` but using an EPSG code (optional).

- `top`: A Faces 1 row matrix with the top of the body (optional). Note that we have to impose that this
   is an already created faces matrix because inside this function we no longer know what the order of
   the ``X`` and ``Y`` matrices represent.

- `bottom`: A Faces 1 row matrix with the bottom of the body (optional).

### Returns
A \myreflink{GMTfv} FacesVertices object.

Example
-------

\begin{examplefig}{}
```julia
using GMT

X,Y = meshgrid(1:0.5:10,1.:20);
Z = sin.(X) .+ cos.(Y);
FV = surf2fv(X, Y, Z);
viz(FV)
```
\end{examplefig}

See Also
--------

\myreflink{extrude}, \myreflink{flatfv}, \myreflink{fv2fv}, \myreflink{loft}, \myreflink{grid2tri}, \myreflink{revolve}