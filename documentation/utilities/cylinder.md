# cylinder

```julia
FV = cylinder(r, h; base=0.0, center=(0.0, 0.0, 0.0), geog=false, unit="m", np=36)::GMTfv
```

Create a cylinder with radius `r` and height `h`.

### Args
- `r`: The radius of the cylinder. For geographical cylinders, the default is meters. But see `unit` below.

- `h`: The height of the cylinder. It should be in the same unit as `r`.

### Kwargs
- `base`: The base height of the cylinder. Default is 0.

- `center`: A 3-element array or tuple of three numbers defining the origin of the body. Default is `(0.0, 0.0, 0.0)`.

- `closed`: If true (the default), close the cylinder at top and bottom.

- `geog`: If true, create a cylinder in geographical coordinates.

- `unit`: For geographical cylinders only.If radius is not in meters use one of `unit=:km`, or `unit=:Nautical` or `unit=:Miles`

- `np`: The number of vertices in the circle. Default is 36.

### Returns
A \myreflink{GMTfv} FacesVertices object.

Example
-------

Create a cylinder of radius 50 and height 100.

\begin{examplefig}{}
```julia
using GMT

FV = cylinder(50, 100)
viz(FV)
```
\end{examplefig}

See Also
--------

\myreflink{cube}, \myreflink{dodecahedron}, \myreflink{icosahedron}, \myreflink{octahedron}, \myreflink{replicant}, \myreflink{sphere}, \myreflink{tetrahedron}, \myreflink{torus},  
