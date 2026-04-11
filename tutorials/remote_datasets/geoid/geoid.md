# EGM2008 Earth Geoid

\begin{examplefig}{}
```julia
using GMT	# hide
I = gdalread("https://github.com/GenericMappingTools/remote-datasets/blob/main/docs/_static/GMT_earth_geoid.jpg?raw=true"); # hide
viz(I) # hide
```
\end{examplefig}

Load the EGM2008 Earth geoid dataset in various resolutions.

The available resolutions for this grid are:
- `"01d", "30m", "20m", "15m", "10m", "06m", "05m", "04m", "03m", "02m", "01m"`. Where
  the suffix `d`, `m` and `s` stand for arc-degrees, arc-minutes, and arc-seconds. See also the manual
  of \myreflink{remotegrid} for information about the grid registrations.

On first usage, the grids are downloaded to the user `./gmt/server/...` directory. On later usages,
the grid(s) are loaded from that local directory.

Refer to [earth_geoid](https://www.generic-mapping-tools.org/remote-datasets/earth-geoid.html) for more details
about technical detail, available resolutions, sizes, version information and references.

### Example

```julia
G = gmtread(remotegrid("geoid", res="6m"))
viz(G, shade=true)
```