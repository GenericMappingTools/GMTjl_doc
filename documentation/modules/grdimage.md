# grdimage

```julia
    grdimage(cmd0::String=""; kwargs...)
```

Project grids or images and plot them on maps

Description
-----------

Reads one 2-D grid and produces a gray-shaded (or colored) map by plotting rectangles centered on each grid
node and assigning them a gray-shade (or color) based on the z-value. Alternatively, **grdimage** reads three
2-D grid files with the red, green, and blue components directly (all must be in the 0-255 range). Optionally,
illumination may be added by providing a file with intensities in the (-1,+1) range or instructions to derive
intensities from the input data grid. Values outside this range will be clipped. Such intensity files can be
created from the grid using \myreflink{grdgradient} and, optionally, modified by \myreflink{grdhisteq}. A third
alternative is available when GMT is build with GDAL support. Pass *img* which can be an image file
(geo-referenced or not). In this case the images can optionally be illuminated with the file provided via the
**shade** option. Here, if image has no coordinates then those of the intensity file will be used.

When using map projections, the grid is first resampled on a new rectangular grid with the same dimensions.
Higher resolution images can be obtained by using the **-E** option. To obtain the resampled value (and hence
shade or color) of each map pixel, its location is inversely projected back onto the input grid after which a
value is interpolated between the surrounding input grid values. By default bi-cubic interpolation is used.
Aliasing is avoided by also forward projecting the input grid nodes. If two or more nodes are projected onto
the same pixel, their average will dominate in the calculation of the pixel value. Interpolation and aliasing
is controlled with the **-n** option.

The **region** option can be used to select a map region larger or smaller than that implied by the extent of the grid. 

Required Arguments
------------------

\textinput{common_opts/opt_J}

Optional Arguments
------------------

- **A** or **img\_out** or **image\_out** : -- *img\_out=fname*\
   Save an image in a raster format instead of PostScript. Use extension .ppm for a Portable Pixel Map format.
   For GDAL-aware versions there are more choices: Use *fname* to select the image file name and extension.
   If the extension is one of .bmp, .gif, .jpg, .png, or .tif then no driver information is required. For other
   output formats you must append the required GDAL driver. The *driver* is the driver code name used by GDAL;
   see your GDAL installation's documentation for available drivers. Append a +c<options> string where *options*
   is a list of one or more concatenated number of GDAL -co options. For example, to write a GeoPDF with the
   TerraGo format use *"=PDF+cGEO\_ENCODING=OGC\_BP"*. Notes: (1) If a tiff file (.tif) is selected then we will
   write a GeoTiff image if the GMT projection syntax translates into a PROJ4 syntax, otherwise a plain tiff
   file is produced. (2) Any vector elements will be lost.

\textinput{common_opts/opt_B}

\textinput{common_opts/use_cpt_grd}

- **coast** : -- *coast=true* **|** *coast=(...)*\
   Call the \myreflink{coast} module to overlay coastlines and/or countries. The short form *coast=true* just
   plots the coastlines with a black, 0.5p thickness line. To access all options available in the *coast*
   module passe them in the named tuple (...).

- **colorbar** : -- *colorbar=true* **|** *colorbar=(...)*\
   Call the \myreflink{colorbar} module to add a colorbar. The short form *colorbar=true* automatically adds a
   color bar on the right side of the image using the current color map stored in the global scope. To
   access all options available in the *colorbar* module passe them in the named tuple (...).

- **clim** : -- *clim=(z_min,z_max)*\
   When doing an automatic colorization (*i.e.*, when a colormap is not provided explicitly), limit the automatic
   color map to be computed between *z_min,z_max*. Grid values below *z_min* and above *z_max* will be painted
   with the same color as those.

- **equalize** : -- *equalize=true* **|** *equalize=ncolors*\
   With automatic colorization, map data values to colors through the data’s cumulative distribution function (CDF),
   so that the colors are histogram equalized. Default (with `equalize=true`) chooses arbitrary values by a crazy
   scheme based on equidistant values for a Gaussian CDF. Use `equalize=ncolors` to specify the desire number of colors.

- **percent** : -- *percent=pct*\
   Exclude the two tails of the distribution (in percentage). Grid values are sorted and we exclude data in
   0.5*pct and 100 - 0.5*pct from the automatic colormap determination. This option is specially useful
   when the grid has outliers.

- **D** or **img\_in** or **image\_in** : -- *img\_in=true* **|** *img\_in=:r*\
   GMT will automatically detect standard image files (Geotiff, TIFF, JPG, PNG, GIF, etc.) and will read
   those via GDAL. For very obscure image formats you may need to explicitly set **img\_in**, which specifies
   that the grid is in fact an image file to be read via GDAL. Use *img\_in=:r* to assign the region specified
   by **region** to the image. For example, if you have used **region=global** then the image will be assigned
   a global domain. This mode allows you to project a raw image (an image without referencing coordinates).

- **E** or **dpi** : -- *dpi=xx* **|** *dpi=:i*\
   Sets the resolution of the projected grid that will be created if a map projection other than Linear or
   Mercator was selected [100]. By default, the projected grid will be of the same size (rows and columns)
   as the input file. Specify *dpi=:i* to use the PostScript image operator to interpolate the image at the
   device resolution.

- **G** : -- *G="+b"* **|** *G="+f"*\
   This option only applies when a resulting 1-bit image otherwise would consist of only two colors: black (0)
   and white (255). If so, this option will instead use the image as a transparent mask and paint the mask with
   the given *color*. Use *G="+b"* to paint the background pixels (1) or *G="+f"* for the foreground pixels
   [Default].

- **I** or **shade** or **shading** or **intensity** : -- *shade=grid* **|** *shade=azim* **|** *shade=(azimuth=az, norm=params, auto=true)*\
   Gives the name of a grid with intensities in the (-1,+1) range, or a constant intensity to apply everywhere
   (affects the ambient light). Alternatively, derive an intensity grid from the input data grid *grd\_z* via a
   call to \myreflink{grdgradient}; use `shade=az` or ``shade=(azimuth=az, norm=params)`` to specify azimuth
   and intensity arguments for that module or just give ``shade=true`` to select the default arguments
   *(azim=-45,norm=:t1)*. If you want a more specific intensity scenario then run grdgradient separately first.

- **M** or **monochrome** : -- *monochrome=true*\
    Force conversion to monochrome image using the (television) YIQ transformation. Cannot be used with **nan\_alpha**.

- **N** or **noclip** : -- *noclip=true*\
    Do not clip the image at the map boundary (only relevant for non-rectangular maps).

- **Q** or **nan\_alpha** or **alpha\_color** : -- *nan\_alpha=true* or *alpha\_color=true|(r,g,b)*\
    Make grid nodes with z = NaN transparent. If input is an image *alpha\_color* picks one color (default is
    black) and makes it transparent (requires GMT6.2 and above).

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_n}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_t}

\textinput{common_opts/opt_save_fig}

Examples
--------

To make a map of a shaded global bathymetry (automatically download it if needed) using the Winkel projection,
add coast lines, a colorbar and do an histogram equalization with 64 colors, do:

\begin{examplefig}{}
```julia
using GMT
grdimage("@earth_relief_20m.grd", proj=:Winkel, equalize=64, coast=true,
         colorbar=true, shade=true, show=true)
```
\end{examplefig}

For a quick-and-dirty illuminated color map of the data in the remote file @AK_gulf_grav.nc, try:

\begin{examplefig}{}
```julia
using GMT
grdimage("@AK_gulf_grav.nc", shade=true, coast=true, show=true)
```
\end{examplefig}
