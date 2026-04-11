# fv2fv

```julia
FV = fv2fv(F, V; proj="", proj4="", wkt="", epsg=0)::GMTfv
```

Create a FacesVertices object from a matrix of faces indices and another matrix of vertices (a Mx3 matrix).

### Args
- `F`:  A matrix of faces indices or a vector of matrices when defining bodies made of multiple
   surfaces (cylinders for example).

- `V`:  A Mx3 matrix of vertices.

### Kargs
- `proj` or `proj4`:  A proj4 string for setting the Coordinate Referencing System

- `wkt`:  A WKT SRS.

- `epsg`: Same as `proj` but using an EPSG code

----------

When using Meshing.jl we can use the output of the ``isosurface`` function, "verts, faces" as input to this function.

- `F`:  A vector of Tuple{Int, Int, Int} with the body faces indices

- `V`:  A vector of Tuple{Float64, Float64, Float64} with the body vertices

### Returns
A \myreflink{GMTfv} FacesVertices object.

Example
-------

```julia
using GMT, Meshing

gyroid(v) = cos(v[1])*sin(v[2])+cos(v[2])*sin(v[3])+cos(v[3])*sin(v[1]);
gyroid_shell(v) = max(gyroid(v)-0.4,-gyroid(v)-0.4);
xr,yr,zr = ntuple(_ -> LinRange(0,pi*4,50), 3);
A = [gyroid_shell((x,y,z)) for x in xr, y in yr, z in zr];
A[1,:,:] .= 1e10; A[:,1,:] .= 1e10; A[:,:,1] .= 1e10; A[end,:,:] .= 1e10; A[:,end,:] .= 1e10; A[:,:,end] .= 1e10;
vts, fcs = isosurface(A, MarchingCubes());
FV = fv2fv(fcs, vts)
viz(FV, cmap=makecpt(T="0/1", cmap="darkgreen,lightgreen"))
```

~~~
<img src="/assets/gyroid.jpg" width="800" class="center"/>
~~~

See Also
--------

\myreflink{extrude}, \myreflink{flatfv}, \myreflink{loft}, \myreflink{grid2tri}, \myreflink{revolve}, \myreflink{surf2fv}