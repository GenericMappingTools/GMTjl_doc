# sphere

```julia
FV = sphere(r=1; radius=1.0, n=1, center=(0.0, 0.0, 0.0))::GMTfv
```

Create a triangulated geodesic sphere. 

Generates a geodesic sphere triangulation based on the number of refinement iterations `n`
and the radius `r`. Geodesic spheres (aka Buckminster-Fuller spheres) are triangulations
of a sphere that have near uniform edge lenghts.  The algorithm starts with a regular
icosahedron. Next this icosahedron is refined `n` times, while nodes are pushed to a sphere
surface with radius `r` at each iteration.

### Args
- `r`: the radius of the sphere.

### Kwargs
- `radius`: the keyword `radius` is an alternative to the positional argument `r`.

- `n`: is the number of iterations used to obtain the sphere from the icosahedron.

- `center`: A tuple of three numbers defining the center of the sphere.

### Returns
A \myreflink{GMTfv} FacesVertices object.

Example
-------

Create a sphere with radius = 1, and two iterations.

\begin{examplefig}{}
```julia
using GMT

FV = sphere(n=2);
viz(FV)
```
\end{examplefig}

See Also
--------

\myreflink{cube}, \myreflink{cylinder}, \myreflink{dodecahedron}, \myreflink{icosahedron}, \myreflink{octahedron}, \myreflink{replicant}, \myreflink{tetrahedron}, \myreflink{torus},  
