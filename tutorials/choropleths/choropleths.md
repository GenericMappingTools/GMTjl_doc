# Choropleths

### What color is your State?

This example shows an adaptation of the [Average color of World](https://erdavis.com/2021/06/26/average-colors-of-the-world/)
examples. It differs slightly for the also shown US case likely due to the different data used. Here we retrieve
the image data (Sentinel 2) from the [EOX WMS server](https://eox.at/) and use the year 2020. And, as a side note, realize
how incredibly simpler this example is as comparing to the codes used to generate the figures in that blog.

Note how the sates polygons are read directly from source, without any previous download, uncompressing file format conversions, etc...
We will also filter the states polygons to use only those inside the US continental zone and limit them by number
of points and with that dropping those polygons of small islands (smaller in area than 10 km^2).