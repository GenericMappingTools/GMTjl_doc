## Map scales

Example of two map scales for a Mercator projection evaluated at 53 degrees north.

\begin{examplefig}{}
```julia
using GMT

basemap(region=(0,40,50,56), proj=:Mercator, figsize=13,
        map_scale=(anchor=:ML, scale_at_lat=53, length="1000k", label="Scale at 53@.N", fancy=true),
        box=(fill=:lightcyan, clearance=0, pen=1))

basemap!(map_scale=(anchor=:BR, scale_at_lat=53, length="1000k", label=true, fancy=true),
        box=(fill=:white, clearance=0.25, pen=1, inner=true), show=true)
```
\end{examplefig}
