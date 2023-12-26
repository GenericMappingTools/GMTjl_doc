# mask

```julia
mask(cmd0::String="", arg1=[]; kwargs...)

or

mask(GI:GItype, shapes::GMTdataset, touches=false, inverse::Bool=false, maskvalues=??)
```

Clip or mask map areas with no data table coverage

*keywords: GMT, Julia, grid clip*

Description
-----------

Reads (*x*, *y*, *z*) tables (or a file) and uses this information to find out which grid cells are reliable.
Only grid cells which have one or more data points are considered reliable. As an option, you may specify a 
radius of influence. Then, all grid cells that are within *radius* of a data point are considered reliable.
Furthermore, an option is provided to reverse the sense of the test.  Having found the reliable/not reliable
points, the module will either paint tiles to mask these nodes (with the **tiles** switch), or use contouring
to create polygons that will clip out regions of no interest. When clipping is initiated, it will stay in effect
until turned off by a second call to the module using the **endclip** option.

A second method expects a \myreflink{GMTgrid} or an \myreflink{GMTimage} as first argument and a
\myreflink{GMTdataset} in second and will clip the grid/image to the selected region(s) defined
in polygons of the second argument. Grids are clipped to the global BoundingBox of the polygons and
images are copped to that limit and set to transparent in the regions outside of the polygons.
This method uses GDAL to compute the clipping mask. Used together with the ``DCW`` option of
\myreflink{coast} this is very handy to clip rasters to country or \myreflink{earthregions} boundaries.
Note that this method is in a way similar to one of the \myreflink{grdlandmask} methods. The
difference is that here use a external polygon description that may be read from any _OGR_ vector file
whilst \myreflink{grdlandmask} uses the GSHHG dataset.

Required Arguments (1st method)
-------------------------------

- *table*\
    One or more data tables holding a number of data columns.

\textinput{common_opts/opt_I}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_R_3D}

Required Arguments (2nd method)
-------------------------------

- `GI`: A grid (GMTgrid) or image (GMTimage) to be clipped.

- `shapes`: A GMTdataset or a vector of them containing the polygons outside which the elements of `GI` will be clipped

Optional Arguments
------------------

\textinput{common_opts/opt_B}

- **C** or **endclip** or **end_clip_path** : -- *endclip=true*\
    Mark end of existing clip path. No input file is needed. Also supply **xshift** and **yshift**
    settings if you have moved since the clip started.

- **D** or **dump** : -- *dump=fname*\
    Dump the (x,y) coordinates of each clipping polygon to one or more output files (or in-memory array).
    No plotting will take place. If *template* contains the C-format specifier %d (including modifications
    like %05d) then polygons will be written to different files; otherwise all polygons are written to the
    specified file (*template*). The files are ASCII unless **binary_out** is used. See **cut_number**
    to exclude small polygons from consideration.

- **F** or **oriented** : -- *oriented=:left* **|** *oriented=true* **|** *oriented=:right*\
    Force clip contours (polygons) to be oriented so that data points are to the
    left ([Default]) or right (**oriented=:right**) as we move along the perimeter
    [Default is arbitrary orientation]. Requires **dump**.

- **G** or **fill** : -- *fill=color*\
    Paint the clip polygons (or tiles) with a selected fill [Default is no fill].

- **Jz** or **JZ** or *zscale* or *zsize* : *zscale=scale* **|** *zsize=size*\
   Set z-axis scaling or or z-axis size. ``zsize=size`` sets the size to the fixed value *size*
   (for example *zsize=10* or *zsize=4i*). ``zscale=scale`` sets the vertical scale to UNIT/z-unit.

- **L** or **nodegrid** : -- *nodegrid="gridname"* **|** *nodegrid="gridname+i"* **|** *nodegrid="gridname+o"\
    Save the internal grid with ones (data constraint) and zeros (no data) to the named *gridname*. Append **+o**
    to convert the outside (no data) nodes to NaNs before writing the grid, while appending **+i** will instead
    convert the inside (data) flags to NaNs. Omitting the *gridname*, as in **nodegrid=true** or **nodegrid="+i"**
    returns a grid as a GMTgrid object.

- **N** or **inverse** : -- *inverse=true*\
    Invert the sense of the test, i.e., clip regions where there is data coverage.

- **Q** or **cut** or **cut_number** : -- *cut=n*
    Do not dump polygons with less than *cut* number of points [Dumps all polygons]. Only applicable if
    **dump** has been specified.

- **S** or **search_radius** : -- *search_radius=rad*\
    Sets radius of influence. Grid nodes within *radius* of a data point are considered reliable. [Default is 0,
    which means that only grid cells with data in them are reliable]. Append the distance unit (see \myreflink{Units}).

- **T** or **tiles** : -- *tiles=true*\
    Plot tiles instead of clip polygons. Use **fill** to set tile color or pattern. Cannot be used with **dump**.

- `touches`: For the grid/image method, include all cells/pixels that are touched by the polygons. The default is
  to include only the cells whose centers that are inside the polygons.

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt__r}

\textinput{common_opts/opt_t}

\textinput{common_opts/opt__w}

\textinput{common_opts/opt_xy}

\textinput{common_opts/opt__distunits}

\textinput{common_opts/opt_save_fig}

Examples
--------

To make a mask that has a 5 degree radius around points spaced every 10 degree
along the prime meridian, and just paint those areas yellow we try::

\begin{examplefig}{}
```julia
using GMT
t = [repeat([0],19) -90:10:90]      # Some fake data
mask(t, fill=:yellow, inc="30m", region=(-75,75,-90,90), proj=:eqc, search_radius="5d", tiles=true,
     title="Mask for points with r = 5 degrees", xaxis=(annot=:auto, ticks=:auto, grid=180),
     yaxis=(annot=:auto, ticks=:auto, grid=10), show=true)
```
\end{examplefig}

To make an overlay that will mask out the regions of a
contour map where there is no control data using clip polygons, use:

```julia
    gmt mask africa_grav.xyg -R20/40/20/40 -I5m -JM10i -pdf mask
```

We do it again, but this time we wish to save the clipping polygons to file all_pols.txt:

```julia
    gmt mask africa_grav.xyg -R20/40/20/40 -I5m -Dall_pols.txt
```

A repeat of the first example but this time we use white tiling:

```julia
    gmt mask africa_grav.xyg -R20/40/20/40 -I5m -JM10i -T -Gwhite -pdf mask
```


\begin{examplefig}{}
```julia
using GMT

D = coast(DCW=:HR, dump=true);      # Extract the Croatia border from the DCW
I = gmtread("@earth_day_30s", region=D, V=:q);  # Load Earth image containing Croatia
Ic = mask(I, D);                    # Mask outside (make image transparent there)

gmtwrite("Ic.tiff", Ic)             # For now we need to save and reload to see
Ic = gmtread("Ic.tiff");            # the tranparency in action.

viz(Ic, title="Croatia")
```
\end{examplefig}


See Also
--------

\myreflink{grdmask}, \myreflink{surface}, \myreflink{basemap}, \myreflink{clip}
