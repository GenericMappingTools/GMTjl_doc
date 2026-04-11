# extrude

```julia
FV = extrude(shape::Matrix{<:AbstractFloat}, h; base=0.0, closed=true)::GMTfv
```

Create an extruded 2D/3D shape.

### Args
- `shape`: The shape to extrude. It can be a 2D polygon or a 3D polygon defined by a Mx2 or Mx3 matrix or a `GMTdataset`

- `h`: The height of the extrusion. Same units as in `shape`.

### Kwargs
- `base`: The base height of the 2D shape to extrude. Default is 0. Ignored if the shape is a 3D polygon.

- `closed`: If true (the default), close the shape at top and bottom.

### Returns
A \myreflink{GMTfv} FacesVertices object.

Example
-------

Extrude the Swisserland.

\begin{examplefig}{}
```julia
using GMT

Dsw = coast(dump=true, DCW=(country=:CH, file=:ODS));	# Get the Swiss border
FV = extrude(Dsw, 0.2)
viz(FV, zsize=1)
```
\end{examplefig}


And a much nicer example combining extrusion and painting top surface with \myreflink{flatfv}.

\begin{examplefig}{}
```julia
using GMT

# Low resolution country polygons
Dit = coast(M=true, DCW=(country=:IT, file=:ODS));

# Extrude and paint the quadrangulated mesh
FV = flatfv("@earth_day_01m", shape=Dit, thickness=0.5);

viz(FV, zsize=0.5, frame=:none, view=(200, 45))
```
\end{examplefig}

See Also
--------

\myreflink{flatfv}, \myreflink{fv2fv}, \myreflink{loft}, \myreflink{grid2tri}, \myreflink{revolve}, \myreflink{surf2fv}