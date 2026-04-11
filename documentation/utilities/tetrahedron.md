# tetrahedron

```julia
FV = tetrahedron(r=1.0; radius=1.0, origin=(0.0, 0.0, 0.0))::GMTfv
```

Create an tetrahedron mesh with radius `r`. 

### Args
- `r`: the radius of the enclosing sphere.

### Kwargs
- `radius`: the keyword `radius` is an alternative to the positional argument `r`.

- `origin`: A tuple of three numbers defining the origin of the body. Default is `(0.0, 0.0, 0.0)`.

### Returns
A \myreflink{GMTfv} FacesVertices object.

Example
-------

Create a tetrahedron using the default values.

\begin{examplefig}{}
```julia
using GMT

FV = tetrahedron();
viz(FV)
```
\end{examplefig}

See Also
--------

\myreflink{cube}, \myreflink{cylinder}, \myreflink{dodecahedron}, \myreflink{icosahedron}, \myreflink{octahedron}, \myreflink{replicant}, \myreflink{sphere}, \myreflink{torus},  
