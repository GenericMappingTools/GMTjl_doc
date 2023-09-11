# wmsinfo

```julia
wmsinfo(server::String)
```

Read the xml information from the WebMapServer service and create a WMS data type that holds the information
necessary to download the data. The `show` method will display the contents of the WMS data type.

- `server`: The server URL address.


Examples
--------

```julia
using GMT
wms = wmsinfo("http://tiles.maps.eox.at/wms?")
```

As an option, use the form

```julia
using GMT
wmsinfo(wms::WMS; layer)
```

to get further information, in particular the number of bands and sizes, of the layer number or layer name
`layer`. `wms` is returned by the first form.

See Also
--------

\myreflink{wmsread}, \myreflink{wmstest}
