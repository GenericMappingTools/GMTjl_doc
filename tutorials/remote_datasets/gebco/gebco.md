# GEBCO Earth Relief


\begin{examplefig}{}
```julia
using GMT	# hide
I = gdalread("https://github.com/GenericMappingTools/remote-datasets/blob/main/docs/_static/GMT_earth_gebco.jpg?raw=true"); # hide
viz(I) # hide
```
\end{examplefig}

This grid only contains observed relief and inferred relief via altimetric gravity. You access these grids
by specifying their names (`earth_gebco`, or just `gebco`, `gebcosi` and `synbath`) and resolution.

The available resolutions for these group of grids are:
- `"01d", "30m", "20m", "15m", "10m", "06m", "05m", "04m", "03m", "02m", "01m", "30s", "15s", "03s", "01s"`. Where
  the suffix `d`, `m` and `s` stand for arc-degrees, arc-minutes, and arc-seconds. See also the manual
  of \myreflink{remotegrid} for information about the grid registrations.

On first usage, the grids are downloaded to the user `./gmt/server/...` directory. On later usages,
the grid(s) are loaded from that local directory.

The default color palette table (CPT) for this dataset is _geo.cpt_. It’s implicitly used when passing in the
file name of the dataset to any grid plotting method if no CPT is explicitly specified.

Refer to [earth_gebco](https://www.generic-mapping-tools.org/remote-datasets/earth-gebco.html) for more details
about technical detail, available resolutions, sizes, version information and references.

### Examples

```julia
G = gmtread(remotegrid("gebco", res="10m"))
viz(G, shade=true)
```

Grids with resolutions higher than `06m` are tilled to avoid download the entire dataset, which can be **very** big,
when only a sub-region is needed. For example, this downloads a sub-region of the `1m` (one arc-minute) and visualizes it.

```julia
G = grdcut(remotegrid("gebco", res="1m"), region=(0,10,40, 50))
viz(G, shade=true)
```

