## Perspective view

We will make a perspective, color-coded view of the US Rockies from the southeast.

\begin{examplefig}{}
```julia
using GMT
topo = makecpt(color=:rainbow, range=(1000,5000,500), continuous=true);
grdview("@tut_relief.nc", proj=:Mercator, zsize=1, shade=(azim=100, norm="e0.8"), view=(135,30),
        frame=:a, Q="i100", show=true)
```
\end{examplefig}