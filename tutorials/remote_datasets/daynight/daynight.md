# NASA Earth Day/Night Images


\begin{examplefig}{}
```julia
using GMT	# hide
I = gdalread("https://github.com/GenericMappingTools/remote-datasets/blob/main/docs/_static/GMT_earth_daynight.jpg?raw=true"); # hide
viz(I) # hide
```
\end{examplefig}

We serve two NASA image products: The Blue and Black marble mosaics. We have filtered and down-ampled those as
well at the same resolutions that are available for the Earth DEMs. However, all images are pixel-registered only.

The available resolutions for this image are:
- `"01d", "30m", "20m", "15m", "10m", "06m", "05m", "04m", "03m", "02m", "01m", "30s"`. Where
  the suffix `d`, `m` and `s` stand for arc-degrees, arc-minutes, and arc-seconds. See also the manual
  of \myreflink{remotegrid} for information about the grid registrations.

On first usage, the grids are downloaded to the user `./gmt/server/...` directory. On later usages,
the image(s) are loaded from that local directory.

Refer to [earth_daynight](https://www.generic-mapping-tools.org/remote-datasets/earth-daynight.html) for more details
about technical detail, available resolutions, sizes, version information and references.

### Example

```julia
I = gmtread(remotegrid("day", res="6m"))
viz(I)
```

or for the night images

```julia
I = gmtread(remotegrid("night", res="6m"))
viz(I)
```
