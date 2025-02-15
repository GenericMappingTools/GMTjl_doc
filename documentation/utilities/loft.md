# loft

```julia
FV = loft(C1, C2; n_steps::Int=0, closed=true, type=:quad)::GMTfv
```

Loft (linearly) a surface mesh between two input 3D curves.

### Args
- `C1, C2`: Two Mx3 matrices of points defining the 3D curves to _loft_. Each row is a point in 3D space.

### Kwargs
- `n_steps`: The number of steps used to build the lofted surface. If `0` (the default) the number
   of steps is computed from the curve point spacing.

- `closed`: If `true` (the default), close the lofted surface at the top and bottom with planes
   created with `C1` and `C2`.

- `type`: The type of faces used to build the lofted surface (`:quad` (default), `:tri`).

### Returns
A \myreflink{GMTfv} FacesVertices object.

Example
-------

\begin{examplefig}{}
```julia
using GMT
	
ns=75; t=linspace(0,2*pi,ns); r=5; x=r*cos.(t); y=r*sin.(t); z=zeros(size(x));
C1=[x[:] y[:] z[:]];

f(t) = r + 2.0.* sin(6.0*t)
C2 = [(f(t)*cos(t),f(t)*sin(t),3) for t in range(0, 2pi, ns)];
C2 = stack(C2)'

FV = loft(C1, C2);
viz(FV, pen=0)
```
\end{examplefig}

See Also
--------

\myreflink{extrude}, \myreflink{flatfv}, \myreflink{fv2fv}, \myreflink{grid2tri}, \myreflink{revolve}, \myreflink{surf2fv}
