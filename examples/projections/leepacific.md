# Lee Oblated Stereographic projection

The Lee map projection is one that can be used to make maps over the Pacific Ocean with
much less distortion than many of the normal map projections. This projection is not one that lieves
in the GMT C library, but one whose interface is defined in the GMT Julia package. So the
its using syntax is slightly different. For example we cannot add grid lines and annotations with the
`frame` option. Instead, we use the ``plotgrid!`` function. 

\begin{examplefig}{}
```julia
using GMT
resetGMT()		# hide
G, cl = leepacific("@earth_relief_20m_p");
grdimage(G, shade=true, plot=(data=cl,), title="Lee Pacific", cmap=:geo, B=:none)
plotgrid!(G, show=true)
```
\end{examplefig}

Starting with GMT.jl version 1.32, we can use the `inner` option to make the annotations at the end of
grid lines, in the inner side of the map.

\begin{examplefig}{}
```julia
using GMT
resetGMT()		# hide
G, cl = leepacific("@earth_relief_20m_p");
grdimage(G, shade=true, plot=(data=cl,), title="Lee Pacific", cmap=:geo, B=:none)
plotgrid!(G, inner=true, show=true)
```
\end{examplefig}