# blendimg!

```julia
blendimg!(img1::GMTimage, img2::GMTimage; new=false, transparency=0.5)
```

Blend the RGB `color` \myreflink{GMTimage} with the `shade` intensity image (normally obtained with
\myreflink{gdaldem}). The `new` argument determines if we return a new RGB image or update the `color` argument.

Or, blend two 2D UInt8 or 2 RGB images using transparency. 

The blending method is the one explained in https://gis.stackexchange.com/questions/255537/merging-hillshade-dem-data-into-color-relief-single-geotiff-with-qgis-and-gdal/255574#255574

- `img1`, `img2`: A RGB (GMTimage{UInt8, 3}) or an indexed images (GMTimage{UInt8, 2}).
  If `img1` is RGB and `img2` is not, than transparency is ignored. However, if `img1` and `img2`
  are of the same type (both RGB or both indexed), that the `transparency` determines the
  relative weight of each of them.

- `transparency` The default value, 0.5, gives equal weight to both images. 0.75 will make
  `img2` weight 3/4 of the total sum, and so forth.

- `new` If true returns a new GMTimage object, otherwise it changes the `img1` content.

Returns ``nothing`` if `new` option has not been used or a \myreflink{GMTimage}, either RGB or indexed
depending on the options used.
