# Annotations in geog maps

When we want to make annotations or draw additional symbols outside of a map in geographical
coordinates, we have a problem. Because the geographical coordinates are active one cannot
plot outside of Earth. The solution is to define a larger cartesian frame and do the
annotations using this new reference. To make this process simpler we use the option **paper**
option that is available in the ``plot``, ``text`` and ``colorbar`` modules. This option sets and unsets
the temporary cartesian frame under the hood and we only have to care to use cm (or inch) as
units.

To help even further, we can ask to plot a paper grid that will show the paper coordinates.
That is obtained by using **paper=:grid**


\begin{examplefig}{}
```julia
using GMT

# First plot in geographical coordinates
coast(region=:global, projection=:ortho, figsize=10, land="brown")

# Add annotations using paper coordinates and ask to plot also the paper grid
arrows!([1 1 6.5 6.5; -1 10 5 10; 10 19 10 15; 21 10 15 10; 19 1 13.5 6.5],
        lw=2, fill=:darkgreen, arrow=(length="20p",), endpoint=true,
		paper=:grid, noclip=true)
text!(text="Cupidos Invasion", x=14, y=15, justify=:BL, font=18, paper=true, show=1)
```
\end{examplefig}


Once we are satisfied with the annotations we redo the map but this time with **paper=true**
Note also that we can specify the arrow head size with the `markersize` (or `ms`) keyword.

\begin{examplefig}{}
```julia
using GMT
coast(region=:global, projection=:ortho, figsize=10, land="brown")
arrows!([1 1 6.5 6.5; -1 10 5 10; 10 19 10 15; 21 10 15 10; 19 1 13.5 6.5],
        lw=2, fill=:darkgreen, ms="20p", endpoint=true, paper=true, noclip=true)
text!(text="Cupidos Invasion", x=14, y=15, justify=:BL, font=18, paper=true, show=1)
```
\end{examplefig}
