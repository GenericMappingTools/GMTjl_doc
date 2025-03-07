# grdinfo

```julia
    grdinfo(cmd0::String="", arg1=nothing; kwargs...)
```

Reads a 2-D grid file and reports metadata and various statistics for the (x,y,z) data in the grid file


Description
-----------

Reads a 2-D grid file and reports metadata and various statistics for the data (*v*) and coordinates
(*x,y*) in a grid (or *x,y,z* for a 3-D cube). The output information may report the minimum/maximum
values for *v* and the coordinates, where the min/max of *v* occur, the spatial increments, and the
number of nodes in each dimension, and [optionally] the mean, standard deviation, and/or the median,
median absolute deviation (MAD) of *v*, and/or the mode (Least Median of Squares; LMS), LMS scale of
*v*, and number of nodes set to NaN. We also report if the grid is pixel- or gridline-registered and
if it is a Cartesian or Geographic data set (based on metadata in the file). We can also report
information for 3-D netCDF data cubes, but note that data cubes are not compatible with options
**tiles**, **extrema**, **report_ingeog**, and **nearest=:b**.

Required Arguments
------------------

*ingrid* : -- A grid file name or a \myreflink{Grid type}

Optional Arguments
------------------

- **C** or **oneliner** or **numeric**: -- *oneliner=true* **|** **|** *numeric=true* **|** *oneliner=:n|:t*\
    Formats the report using tab-separated fields on a single line. The output is:

    - *name w e s n {b t} v0 v1 dx dy {dz} nx ny {nz}* [*x0 y0 {z0} x1 y1 {z1}*] [*med scale*]
      [*mean std rms*] [*n\_nan*] *registration gtype*

    The data in brackets are output only if the corresponding options **minmax_pos** (with no directive),
    **force_scan=1**, and **force_scan=2** are used, respectively, while the data in braces only apply
    if used with 3-D data cubes. Use **oneliner=:t** to place file *name* at the end of the output record
    or **oneliner=:n**, but preferably **numeric=true**, to only output numerical columns. The *registration*
    is either 0 (gridline) or 1 (pixel), while *gtype* is either 0 (Cartesian) or 1 (geographic). If the
    **nearest** option is used, the output format is instead *NF w e s n {b t} v0 v1*, where *NF* is the
    total number of files read and *w e s n {b t}* are rounded off (see **nearest**).

- **D** or **tiles** : -- *tiles=xoff* **|** *tiles=(xoff,yoff)* **|** *tiles="+i"*\
    Divide a single grid's domain (or the **region** domain, if no grid given)
    into tiles of size *dx* times *dy* (set via **nearest**). You can specify
    overlap between tiles by appending *xoff[/yoff]*. You may use the modifier **+i** to ignore tiles that
    have no data within each tile subregion. Default output is text
    region strings. Use **oneliner** to instead report four columns with
    *xmin xmax ymin ymax* per tile, or use **-Ct** to also have the
    region string appended as trailing text.

- **E** or **extrema** or **extreme** : -- *extrema=[:x|:y]["+l|+L|+u|+U"]*\
    Report the extreme values found on a per column (**extrema=:x**) or per row (**extrema=:y**)
    basis. By default, we look for the global maxima (**+u|+U**) for each column. Use **extrema="+l"**
    or **extrema="+L"** (or **extrema="x+l"**, etc...) to look for minima instead. Upper case **+L**
    means we find the minimum of the positive values only, while upper case **+U** means we find the
    maximum of the negative values only [use all values]. We only allow one input grid when **extrema**
    is selected.

- **F** or **report_ingeog** : -- *report_ingeog=true*\
    Report grid domain and x/y-increments in world mapping format
    [Default is generic]. Does not apply to the **oneliner** option.

- **G** or **download** : -- *download=true*\
    Force (possible) download of all tiles of tiled global remote grids in order
    to report the requested information [refuse to give the information for tiled grids].

- **I** or **nearest** : -- *nearest=dx* **|** *nearest=(dx,dy)* **|** *nearest=:b|:i|:r*\
    Report the min/max of the region to the nearest multiple of *dx* and *dy*, and output this in
    the form **-Rw/e/s/n** (unless **oneliner** is set). To report the actual grid region, select
    **nearest=:r**. For a grid produced by the img supplement (a Cartesian Mercator grid),
    the exact geographic region is given with **nearest=:i** (if not found then we return the
    actual grid region instead).  If no argument is given then we report the grid increment in
    the form **-Ixinc/yinc**. If **nearest=:b** is given we write each grid's bounding box
    polygon instead. Finally, if tiles is in effect then *dx* and *dy* are the dimensions of the desired tiles.

- **L** or **force_scan** : -- *force_scan=0|1|2* **|** *force_scan=:p|:a*\
    - **force_scan=0**
        Report range of *v* after actually scanning the data, not just reporting what the header says.
    - **force_scan=1**
        Report median and L1 scale of *v* (L1 scale = 1.4826 * Median Absolute Deviation (MAD)).
    - **force_scan=2**
        Report mean, standard deviation, and root-mean-square (rms) of *v*.
    - **force_scan=:p**
        Report mode (LMS) and LMS scale of *v*.
    - **force_scan=:a**
        All of the above.

    **Note**: If the grid is geographic then each node represents a physical
    area that decreases with increasing latitude. We therefore report
    spherically weighted statistical estimates for such grids.

- **M** or **minmax_pos** : -- *minmax_pos=true* **|** *minmax_pos=:c|:f*\
    Find and report the location of min/max *v*-values, and count and report the number of nodes
    set to NaN, if any [Default]. Use **minmax_pos=:f** to instead force an update of the *v*-value
    min/max by reading the matrix, or use **:c** for conditionally doing so if the header
    information does not contain a valid *v* range.

\textinput{common_opts/opt_R}

- **T** or **minmax** : -- *minmax=true* **|** *minmax="[dv][+a[alpha]][+s]"*\
    Determine min and max data value. If *dv* is provided then we first round these values off to
    multiples of *dv*. To exclude the two tails of the distribution when determining the min and
    max you can add **+a** to set the combined *alpha* value (in percent [2]): We then sort the
    values, exclude the data in the 0.5 * *alpha* and 100 - 0.5 * *alpha* tails, and revise the
    min and max.  Give *alpha* in the format *alphaL/alphaR* to select unequal tail areas. To force
    a symmetrical range about zero, using minus/plus the max absolute value of the two extremes,
    append **+s**. We report the result via the text string **-Tvmin/vmax** or **-Tvmin/vmax/dv**
    (if *dv* was given) as expected by \myreflink{makecpt}.

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt_o}

Examples
--------

To obtain all the information about the remote data set in file earth_relief_10m:

```julia
    grdinfo("@earth_relief_10m", force_scan=:a, minmax_pos=true)
```

Get the grid spacing in earth_relief_10m:

```julia
    dx = grdinfo("@earth_relief_10m", oneliner=:n, outcols=7)
```

To learn about the extreme values and coordinates in the 3-D data cube S362ANI_kmps.nc?vs::

```julia
    grdinfo("S362ANI_kmps.nc?vs", minmax_pos=true)
```

See Also
--------

\myreflink{grd2cpt}, \myreflink{grd2xyz}, \myreflink{grdedit}
