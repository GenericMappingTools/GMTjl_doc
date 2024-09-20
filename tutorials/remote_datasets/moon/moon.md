# USGS Moon Relief


\begin{examplefig}{}
```julia
using GMT	# hide
I = gdalread("https://github.com/GenericMappingTools/remote-datasets/blob/main/docs/_static/GMT_moon_relief.jpg?raw=true"); # hide
viz(I) # hide
```
\end{examplefig}

The available resolutions for this grid are:
- `"01d", "30m", "20m", "15m", "10m", "06m", "05m", "04m", "03m", "02m", "01m", "30s", "15s", "14s"`. Where
  the suffix `d`, `m` and `s` stand for arc-degrees, arc-minutes, and arc-seconds. See also the manual
  of \myreflink{remotegrid} for information about the grid registrations.

On first usage, the grids are downloaded to the user `./gmt/server/...` directory. On later usages,
the grid(s) are loaded from that local directory.

The default color palette table (CPT) for this dataset is _moon.cpt_. Note, that palette is different
from the one used to create the figure displayed on this page. If you want to reproduce the fig above
you need to use the `cmap="@moon_cpt.cpt"`.  The color palette is implicitly used when passing in the
file name of the dataset to any grid plotting method if no CPT is explicitly specified.

Refer to [moon_relief](https://www.generic-mapping-tools.org/remote-datasets/moon-relief.html) for more details
about technical detail, available resolutions, sizes, version information and references.

### Examples

```julia
G = gmtread(remotegrid("moon", res="10m"))
viz(G, shade=true)
```
