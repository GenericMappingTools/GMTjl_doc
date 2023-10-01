# trisurf

```julia
trisurf(in, kw...)
```

*keywords: GMT, Julia, surface, triangles*

Plots the 3-D triangular surface defined by the points in a Mx3 matrix or a GMTdataset with data 
x, y, z in the 3 first columns. The triangles are computed with a Delaunay triangulation done internaly.
Since this is a \myreflink{plot3}  *avatar* all options in this function are those of the `plot3d` program.

---
trisurf([x y z], kwargs...) plots the 3-D triangular surface defined by the points in vectors x, y, and z.

---
trisurf(D, kwargs...) The same but now the input data (the *x,y,z* triplets) is stored in the `D` GMTdataset object.

Examples
--------

Create a set of 3-D points and plot the surface defined by the triangulation.

\begin{examplefig}{}
```julia
using GMT
x,y,z = GMT.peaks(N=45, grid=false);
trisurf([x[:] y[:] z[:]], pen=0.5, show=true)
```
\end{examplefig}