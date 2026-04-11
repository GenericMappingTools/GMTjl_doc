# World Digital Magnetic Anomaly Map

\begin{examplefig}{}
```julia
using GMT	# hide
I = gdalread("https://github.com/GenericMappingTools/remote-datasets/blob/main/docs/_static/GMT_earth_wdmam.jpg?raw=true"); # hide
viz(I) # hide
```
\end{examplefig}

The WDMAM (World Digital Magnetic Anomaly Map) is an international scientific project under the auspices of IAGA
(International Association of Geomagnetism and Aeronomy) and CGMW (Commission for the Geological Map of the World),
aiming to compile and make available magnetic anomalies caused by the Earth lithosphere, on continental and oceanic
areas, in a comprehensive way, all over the World.  

The available resolutions for this grid are:
- `"01d", "30m", "20m", "15m", "10m", "06m", "05m", "04m", "03m"`. Where
  the suffix `d`, `m` and `s` stand for arc-degrees, arc-minutes, and arc-seconds. See also the manual
  of \myreflink{remotegrid} for information about the grid registrations.

On first usage, the grids are downloaded to the user `./gmt/server/...` directory. On later usages,
the grid(s) are loaded from that local directory.

The default color palette table (CPT) for this dataset is _earth_wdmam.cpt_. It’s implicitly used when passing in the
file name of the dataset to any grid plotting method if no CPT is explicitly specified.

Refer to [earth_wdmam](https://www.generic-mapping-tools.org/remote-datasets/earth-wdmam.html) for more details
about technical detail, available resolutions, sizes, version information and references.

### Example

```julia
G = gmtread(remotegrid("wdmam", res="6m"))
viz(G, shade=true)
```
