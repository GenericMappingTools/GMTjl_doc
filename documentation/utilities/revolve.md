# revolve

```julia
FV = revolve(curve::Matrix{Real}; extent = 360, ang1=0, ang2=360, dir=:positive, n=[0.0,0.0,1.0], n_steps=0, closed=true, type=:quad)::GMTfv
```

Revolve curves to build surfaces.

This function rotates the curve `curve` by the angle `extent`, in the direction 
defined by `direction` (`:positive`, `:negative`, `:both`), around the vector 
`n`, to build the output mesh defined as a Faces-Vertices type.

### Credit
This function is a modified version on the `revolvecurve` function from the `Comodo.jl` package.

### Args
- `curve`: A Mx3 matrix of points defining the curve to revolve. Each row is a point in 3D space.

### Kwargs
- `extent`: The extent of the revolved curve in degrees. Default is 360 degrees. But a finer control
   is possible using the `ang1` and `ang2` arguments.

- `ang1`: The starting angle in degrees. Use this if start and end angles do not define a full revolution.

- `ang2`: The ending angle in degrees.

- `dir`: The direction of the revolved curve (`:positive`, `:negative`, `:both`).

- `n`: The normal vector of the revolved curve.

- `n_steps`: The number of steps used to build the revolved curve. If `0` (the default) the number
   of steps is computed from the curve point spacing.

- `closed`: If `true` (the default), close the revolved curve at the start and end slice.

- `type`: The type of faces used to build the revolved curve (`:quad` (default), `:tri`).

### Returns
A \myreflink{GMTfv} FacesVertices object.

Example
-------

Create a surface by revolving a curve.

\begin{examplefig}{}
```julia
using GMT
	
ns=15; x=linspace(0,2*pi,ns).+1; y=zeros(size(x)); z=-cos.(x); curve=[x[:] y[:] z[:]];
FV = revolve(curve)
viz(FV)
```
\end{examplefig}

See Also
--------

\myreflink{extrude}, \myreflink{flatfv}, \myreflink{fv2fv}, \myreflink{loft}, \myreflink{grid2tri}, \myreflink{surf2fv}