# colorzones!

```julia
colorzones!(shapes::Vector{GMTdataset}[, fun::Function]; img::GMTimage=nothing,
	          url::AbstractString="", layer=0, pixelsize::Int=0, append::Bool=true)
```

Paint the polygons in the `shapes` with the average color that those polygons ocupy in the `img` image.
When the `shapes` are plotted the resulting image looks like a choropleth map. Alternatively, instead of
transmitting the `img` image one can provide a WMS URL, `layer` number and `pixelsize` to download images from
the Web Map Server service, covering each one the bounding box of each of the `shapes` polygons. This option
is much slower than passing the entire image at once but consumes much less memory. Important when the total area
is large (think Russia size) because even at a moderately resultion it can imply downloading a huge file.

- `shapes`: A vector of \myreflink{GMTdataset} containing the polygons to be painted. This container will be changed
  in the sense that the `header` field of each polygon (a \myreflink{GMTdataset}) will be appended with the fill
  color (but see also the `append` option that controls how this change takes place.)

- `fun`: By default, the average color is obtained by taking the square root of the average of squares of each
  of the three (RGB) bands (or just one for grayscale images). Give the name of another function to replace
  this default. For example, `median` will assign the color by computing the median of each component inside
  the polygon area in question.

- `img`: the image from which the stats (`fun`) of each color for each polygon will be computed.

- `url`: In case the `img` option is not used, pass the Web Map Server URL (see the `wmsinfo` and `wmsread` functions)
  from where the the images covering the BoundingBox of each polygon will be downloaded. Warning, this is a much slower
  method but potentially useful when the images to download risk to be very big. 

- `layer`: When the `url` option is used this one becomes mandatory and represents the layer number or layer name of
  interest from those provided by the WMS service. That is, both forms are allowed: `layer=3` or
  `layer="Invented layer name"`

- `pixelsize`: Sets the requested cell size in meters [default]. Use a string appended with a 'd'
  (e.g. `resolution="0.001d"`) if the resolution is given in degrees. This way works only when the layer is in geogs.

- `append`: By default, the color assignment  to each of the polygons in the `shapes` vector is achieved by
   appending the fill color to the possibly existing header field. Running the `colorzones` command more than once
   keeps adding (now ignored, because only the first is used) colors. Setting `append=false` forces rewriting
   the header field at each run and hence the assigned color is always the one used (but the previous header is cleared out).


Returns
-------

It does't return anything but the input `GI` is modified.


Examples
--------

Read the 2020 Sentinel2 Earth color for Portugal at 100 m resolution. Load the administrative
regions and compute their median colors.

```julia
wms = wmsinfo("http://tiles.maps.eox.at/wms?");
img = wmsread(wms, layer=3, region=(-9.6,-6,36.9,42.2), pixelsize=100);
Pt = gmtread("C:/programs/compa_libs/covid19pt/extra/mapas/concelhos/concelhos.shp");
colorzones!(Pt, median, img=img);
imshow(Pt, proj=:guess)
```

See Also
--------

\myreflink{rasterzones!}, \myreflink{gmtread}, \myreflink{wmsinfo}, \myreflink{wmsread}
