# Best rectangular world map projection

This was born from a [question](https://forum.generic-mapping-tools.org/t/best-projection-for-rectangular-world-map/3715)
in the GMT forum on how to do a *fully fledged, wall-sized map of the world - completely done in GMT.*
That post serves also to document the implementation details upon which is based the inner workings of the
\myreflink{worldrectangular} function that now permits to make such kind of maps. And we have to confess that the achieved implementation relies also in features provided by GDAL. But no more talk, appreciate the *global rectangular Vand der Grinten*
projection.


\begin{examplefig}{}
```julia
using GMT
G, cl = worldrectangular("@earth_relief_30m_p", proj="vandg", latlim=(-70,85), coast=true);
grid = worldrectgrid(G);
grdimage(G, shade=true, plot=(data=cl,), cmap=:geo, B=:none, title="Van der Grinten")
plotgrid!(G, grid, show=true)
```
\end{examplefig}
