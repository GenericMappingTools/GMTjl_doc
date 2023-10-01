# wmread

```julia
wmsread(wms::WMS; layer, kwargs...)
```

*keywords: GMT, Julia, WMS*

Read the `layer` number provided by the service from which the `wms` type was created.

### Parameters
- `wms`: A WMS type obtained from the \myreflink{wmsinfo} function.

- `layer`: The layer number or layer name of interest from those provided by the WMS service. That is,
   both of these forms are allowed: `layer=3` or `layer="Invented layer name"`

### `kwargs` is the keywords/values pairs used to set
- `region | limits`: The region limits. This can be a Tuple or Array with 4 elements defining the `(xmin, xmax, ymin, ymax)`
   or a string defining the limits in all ways that GMT can recognize. When the layer has the data projected, we can
   a Tuple or Array with 3 elements `(lon0, lat0, width)`, where first two set the center of a square in geographical
   coordinates and the third (`width`) is the width of that box in meters.

- `cellsize | pixelsize | resolution | res`: Sets the requested cell size in meters [default]. Use a string appended with a 'd'
   (e.g. `resolution="0.001d"`) if the resolution is given in degrees. This way works only when the layer is in geogs.

- `size`: Alternatively to the the `cellsize` use this option, a tuple or array with two elements, to specify
   the image dimensions. Example, `size=(1200, 100)` to get an image with 1200 rows and 100 columns.

- `time`: Some services provide data along time. Use this option to provide a time string as provided by DateTime.
   For example: `time=string(DateTime(2021,10,29))`

Returns
-------

A \myreflink{GMTimage}

Examples
--------

```julia
using GMT

wms = wmsinfo("http://tiles.maps.eox.at/wms?")
img = wmsread(wms, layer=3, region=(-10,-5,37,44), pixelsize=500);

# Retrieve and display a MODIS image
wms = wmsinfo("https://gibs-c.earthdata.nasa.gov/wms/epsg4326/best/wms.cgi");
img = wmsread(wms, layer="MODIS_Terra_CorrectedReflectance_TrueColor", region=(9,22,32,43), time="2021-10-29T00:00:00", pixelsize=750);
imshow(img, proj=:guess)
```

See the result of the above example at [Web Map Service](https://www.generic-mapping-tools.org/GMTjl_doc/examples/images/05_wms)

See Also
--------

\myreflink{wmsinfo}, \myreflink{wmstest}
