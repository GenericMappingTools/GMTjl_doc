# CNES Earth Mean Dynamic Topography


\begin{examplefig}{}
```julia
using GMT	# hide
I = gdalread("https://github.com/GenericMappingTools/remote-datasets/blob/main/docs/_static/GMT_earth_mdt.jpg?raw=true"); # hide
viz(I) # hide
```
\end{examplefig}


The available resolutions for this grid are:
- `"01d", "30m", "20m", "15m", "10m", "07m"`. Where
  the suffix `d`, `m` and `s` stand for arc-degrees, arc-minutes, and arc-seconds. See also the manual
  of \myreflink{remotegrid} for information about the grid registrations.

On first usage, the grids are downloaded to the user `./gmt/server/...` directory. On later usages,
the grid(s) are loaded from that local directory.

The default color palette table (CPT) for this dataset is _earth_mdt.cpt_. It’s implicitly used when passing in the
file name of the dataset to any grid plotting method if no CPT is explicitly specified.

Refer to [earth_mdt](https://www.generic-mapping-tools.org/remote-datasets/earth-mdt.html) for more details
about technical detail, available resolutions, sizes, version information and references.

### Example

```julia
G = gmtread(remotegrid("mdt", res="7m"))
viz(G, shade=true)
```
