# octahedron

```julia
FV = octahedron(r=1.0; radius=1.0, origin=(0.0, 0.0, 0.0))::GMTfv
```

Create an octahedron mesh with radius `r`. 

### Args
- `r`: the radius of the enclosing sphere.

### Kwargs
- `radius`: the keyword `radius` is an alternative to the positional argument `r`.

- `origin`: A tuple of three numbers defining the origin of the body. Default is `(0.0, 0.0, 0.0)`.

### Returns
A \myreflink{GMTfv} FacesVertices object.

Example
-------

Create a octahedron using the default values.

\begin{examplefig}{}
```julia
using GMT

FV = octahedron();
viz(FV)
```
\end{examplefig}

See Also
--------

\myreflink{cube}, \myreflink{cylinder}, \myreflink{dodecahedron}, \myreflink{icosahedron}, \myreflink{replicant}, \myreflink{sphere}, \myreflink{tetrahedron}, \myreflink{torus},  
