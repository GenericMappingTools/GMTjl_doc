# fillsinks

```julia
fillsinks(G::GMTgrid; conn=8, region=nothing, saco=false, insitu=false)
```

Fill sinks in a grid.

This function uses the \myreflink{imfill} function to find how to fill sinks in a grid. But since \myreflink{imfill}
operates on UInt8 matrices only the vertical (z) descrimination of the grid is reduced to 256 levels,
which is not that much.

### Args
- `G::GMTgrid`: The input grid to process.

### Kwargs
- `conn::Int`: Connectivity for sink filling (4 or 8). Default is 8.

- `region`: Limit the action to a region of the grid specified by `region`. See for example the \myreflink{coast}
  manual for and extended doc on this keword, but note that here only `region` is accepted and not `R`, etc...

### Returns
- A new \myreflink{GMTgrid} with sinks filled.

Examples
--------

Fill the depressions of the _peaks_ surface. Show original and sinks filled side by side.

\begin{examplefig}{}
```julia
using GMT

G = peaks(N=128);
G2 = fillsinks(G);
grdimage(G, figsize=6, shade=true)
grdimage!(G2, figsize=6, xshift=6.2, frame="wSen", shade=true, show=true)
```
\end{examplefig}

See Also
--------

\myreflink{imfill}
