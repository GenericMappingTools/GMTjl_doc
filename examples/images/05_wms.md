# Web Map Service

{{doc wmsread}}

## Download and display a Sentinel 2 image

First we have to start by fetching the information provided by this [Web Map Server](http://maps.eox.at/)

```julia
julia> wms = wmsinfo("http://tiles.maps.eox.at/wms?")
serverURL:      http://tiles.maps.eox.at/wms?
OnlineResource: http://tiles.maps.eox.at/?
version:        1.1.1
request:        GetMap
layernames:     ["s2cloudless-2018_3857", "coastline", "s2cloudless-2020", "osm_3857", "s2cloudless_3857", "terrain_3857", "overlay_base_bright_3857", "hydrography", "graticules", "overlay_3857", "bluemarble", "coastline_black", "s2cloudless-2017_3857", "streets_3857", "overlay_bright", "s2cloudless-2019_3857", "overlay", "blackmarble_3857", "hydrography_3857", "s2cloudless-2017", "streets", "s2cloudless-2018", "s2cloudless-2019", "osm", "blackmarble", "terrain-light_3857", "s2cloudless-2020_3857_512", "bluemarble_3857", "overlay_base_3857", "s2cloudless", "terrain", "overlay_bright_3857", "coastline_3857", "s2cloudless-2020_3857", "magnetic_graticules", "terrain-light", "overlay_base_bright", "overlay_base"]

layer:  38 Layers. Use layer[k] to see the contents of layer k
```

Next, let's look at the contents of the layer 3

```julia
julia> wms.layer[3]
name:   s2cloudless-2020
title:  Sentinel-2 cloudless layer for 2020 by EOX - 4326
srs:    EPSG:4326
crs:
bbox:   (-180.0, 180.0, -90.0, 90.0)
imgformat:      image/jpeg
tilesize:       256
overviewcount:  17
resolution:     5.3644180298e-6
tiled:  true
transparent:    false
```

And finaly download and display a low-resolution image of that layer 3 at 1500 m/pixel.

\begin{examplefig}{}
```julia
using GMT
wms = wmsinfo("http://tiles.maps.eox.at/wms?");
img = wmsread(wms, layer=3, region=(-10,-5,37,44), pixelsize=1500);
imshow(img, proj=:guess, title="Sentinel 2")
```
\end{examplefig}

## Download and display a MODIS image

Use the a WMS from NASA and download a MODIS Terra reflectance image from 29 October 2021

\begin{examplefig}{}
```julia
using GMT
wms = wmsinfo("https://gibs-c.earthdata.nasa.gov/wms/epsg4326/best/wms.cgi");
img = wmsread(wms, layer="MODIS_Terra_CorrectedReflectance_TrueColor", region=(9,22,32,43), time="2021-10-29T00:00:00", pixelsize=1500);
imshow(img, proj=:guess, title="MODIS Terra")
```
\end{examplefig}
