# grd2kml

```julia
	grd2kml(cmd0::String="", arg1=nothing, kwargs...)
```

Create KML image quadtree from single grid

Description
-----------

**grd2kml** reads a 2-D grid and makes a *quadtree* of PNG or JPG images and KML wrappers for
Google Earth using the selected tile size. We downsample the grid depending on the viewing
level in the quadtree using a Gaussian filter, but other filters can be selected as well.
Optionally, illumination may be added by providing a grid file with intensities in the (-1,+1)
range or by giving instructions to derive intensities from the input data grid automatically
(see **shading**). Values outside the (-1,+1) intensity range will be clipped. Map colors are
specified via a color palette lookup table. Contour overlays are optional. If plain tiles are
selected (i.e., no contours specified) then the PNG tiles are written directly from \myreflink{grdimage}.
Otherwise, we must first make a PostScript plot that is then converted to raster image via \myreflink{psconvert}.

Required Arguments
------------------

The 2-D gridded data set.

- **N** or **prefix** : -- *prefix=name*\
    Sets a unique name prefixed used for the top-level KML filename *and* the
    directory where all referenced KML files and raster images will be written [GMT_Quadtree].

Optional Arguments
------------------

- **A** or **mode** : -- *mode=:a|:g|s* **|** *mode="a|g|saltitude"*\
    Select one of three altitude modes recognized by Google Earth that
    determines the altitude (in m) of the tile layer: **a** absolute
    altitude, **g** altitude relative to sea surface or ground, **s**
    altitude relative to seafloor or ground. To plot the tiles at a
    fixed altitude, append an altitude *altitude* (in m). Use 0 to clamp the
    features to the chosen reference surface. [By default the tiles are clamped
    to the sea surface or ground].

\textinput{common_opts/use_cpt_grd}

- **E** or **url** : -- *url=URL*\
    Instead of hosting all files on your computer, you may prepend a remote site URL. Then,
    the top-level *prefix*.kml file will use this URL to find all other files it references.
    After building completes you must place the entire *prefix* directory at the remote
    location pointed to by the *URL* [local files only]. With this arrangement you can
    share the *prefix*.kml with others (say, via email or for download) and users can
    open the file in their Google Earth and access the remote files from your server as needed.

- **F** or **filter** : -- *filter=type*\
    Specifies the filter to use for the downsampling of the grid for more distant viewing.
    Choose among **b**oxcar, **c**osine arch, **g**aussian, or **m**edian [Gaussian].
    The filter width is set automatically depending on the level.

- **H** or **subpixel** : -- *subpixel=scale*\
    Improve the quality of rasterization by passing the sub-pixel smoothing scale
    to psconvert (same as **H** option in \myreflink{psconvert}) [no sub-pixel smoothing].
    Ignored when |-W| is not used.

- **I** or **shade** or **shading** or **intensity** : -- *shade=grid* **|** *shade=azim* **|** *shade=(azimuth=az, norm=params, auto=true)*\
   Gives the name of a grid with intensities in the (-1,+1) range, or a constant intensity to apply everywhere
   (affects the ambient light). Alternatively, derive an intensity grid from the input data grid *grd\_z* via a
   call to \myreflink{grdgradient}; use `shade=az` or ``shade=(azimuth=az, norm=params)`` to specify azimuth
   and intensity arguments for that module or just give ``shade=true`` to select the default arguments
   *(azim=-45,nom=:t1)*. If you want a more specific intensity scenario then run grdgradient separately first.

- **L** or **tilesize** : -- *tilesize=size*\
    Sets the fixed size of the image building blocks. Must be an integer that is radix 2.
    Typical values are 256 or 512 [256]. **Note**: For global grids (here meaning 360-degree
    longitude range), we will select a *tilesize* of 360 if **tilesize** is not specified.

- **S** or **extralayers** : -- *extralayers=true* **|** *extralayers=extra*\
    Add extra layers beyond that necessary to capture the full resolution of the data [none].
    This will let GMT interpolate your grid and make more tiles, versus letting Google Earth
    interpolate the last resolution raster images.

- **T** or **title** : --*title=XXX*\
    Sets the title of the top-level document (i.e., its description).

\textinput{common_opts/opt_V}

- **W** or **contours** : -- *contours="cfile|pen[+sscale/limit]"*\
    Supply a file with records each holding a contour value and a contour pen.
    We then overlay the selected contour lines on top of the image [no contours].
    Consequently, **contours** triggers the tile creation via PostScript and thus is slower.
    If *cfile* is not a valid file we assume you instead gave a *pen* and want
    to draw all the contours implied by the *cpt* specified in **cmap**. The contours
    are overlain via calls to \myreflink{grdcontour}. **Note**: The contour pen width(s)
    refer to the highest tile level and are reduced by a factor of *scale* [sqrt(2)] for each
    lower level. Contours with scaled pen widths < *limit* [0.1] points are skipped (except
    for pen widths that exactly equal 0 or "faint"). Use **+s** to change these values.

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_n}

Quadtree building
-----------------

We extend the input grid vi \myreflink{grdcut} to obtain a square dimension that can be repeatedly divided
by 2 until we arrive at tiles with the original grid increments. For global grids this mean we
extend the grid to a 360 x 360 Cartesian region and an initial grid increment of one
degree. This is the first global tile. As the quartering of tiles and halving of grid
increment continue we may not end exactly at the original grid spacing but at the largest
increment less than or equal to the original increment. For non-global grids, e.g., smaller
(local or regional) grids, we extend the domain to a radix-2 multiple of the *tilesize*
times the grid increment. This initial tile is then quartered and the grid increment halved
until we reach the original grid increment. Tiles that have all NaNs are not produced.
THe tiles are inherently pixel-registered. Thus, if a global grid has gridline-registration then
we are down-sampling the extended grid onto a pixel-registered coarser grid. Because these
nodes do not coincide with the original nodes we widen the filter width by a factor of sqrt(2).
We detect if NaNs are present in any tile and if so produce a transparent PNG tile; otherwise we
make an opaque JPG tile.

Contour overlays
----------------

Because each tile is a fixed size image (e.g., 512x512 pixels) but the amount of data represented
changes by factors of 4 for each new level, we cannot use a constant thickness contour pen for all
levels. Thus, the pen you supply must be considered the final pen applied to the highest resolution
map overlays. Furthermore, because the *dpi* here is very small compared to regular GMT plots, it is
important to improve the appearance of the contours by using sub-pixel smoothing (**subpixel**). Both
generating PostScript tiles and using sub-pixel smoothing adds considerable processing time over
plain tiles.

Notes
-----

The intensity grid can be created from the data grid using \myreflink{grdgradient} and, optionally,
modified by \myreflink{grdmath} or \myreflink{grdhisteq}. Custom intensity grids built with several
different illumination angles can be combined with \myreflink{grdmath}. For a single illumination
angle the automatic illumination can be used instead.

Examples
--------

To test a quadtree image representation of the coarse topography grid earth_relief_06m, using
the optimally determined tile size, auto color, and supplying a suitable title, try::

```julia
    grd2kml("@earth_relief_06m", prefix="Earth6m", title="Earth Relief 6x6 arc minutes", cmap=:earth)
```

To make a quadtree image representation of the large topography grid file ellice_basin.nc,
supplying automatic shading based on the topography, and using 512x512 tiles,
supplying a suitable title, and using color masking for unmapped area, try::

```julia
    grd2kml("ellice_basin.nc", shade="+d", prefix="ellice", -L512, title="Ellice Basin Bathymetry")
```

See Also
--------

\myreflink{gmt2kml},
\myreflink{grdgradient},
\myreflink{grdhisteq},
\myreflink{grdimage},
\myreflink{grdmath},
\myreflink{kml2gmt},
\myreflink{psconvert}
