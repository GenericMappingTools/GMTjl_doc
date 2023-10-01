# grdedit

```julia
    grdedit(cmd0::String="", arg1=nothing, kwargs...)
```

Modify header or content of a grid

*keywords: GMT, Julia, grid edit*

Description
-----------

**grdedit** reads the header information in a binary 2-D grid file and
replaces the information with values provided on the command line [if
any]. As an option, global, geographical grids (with 360 degrees
longitude range) can be rotated in the east-west direction, and
individual nodal values can be replaced from a table of *x*, *y*, *z*
values. **grdedit** only operates on files containing a grid header. **Note**:
If it is important to retain the original data you should use **outgrid**
to save the modified grid to a new file.

Required Arguments
------------------

*ingrid* : -- A grid file name or a \myreflink{Grid type}

Optional Arguments
------------------

- **A** or **adjust_inc** : -- *adjust_inc=true*\
    If necessary, adjust the file's *x_inc*, *y_inc* to be compatible with its domain(or a new domain
    set with **region**). Older grid files (i.e., created prior to GMT 3.1) often had excessive slop
    in *x_inc*, *y_inc* and an adjustment is necessary. Newer files are created correctly.

- **E** or **flip** : -- *flip=:a|:e|:h|:l|:r|:t|:v*\
    Transform the grid in one of six ways and (for **l|r|t**) interchange the *x* and *y* information:
    - **flip=:a** will flip the grid both horizontally and vertically,
    - **flip=:e** will exchange the x (longitude) and y (latitude) dimensions,
    - **flip=:h** will flip the grid horizontally (left-to-right),
    - **flip=:l** will rotate the grid 90 degrees counter-clockwise (left),
    - **flip=:r** will rotate the grid 90 degrees clockwise (right),
    - **flip=:t** will transpose the grid [Default],
    - **flip=:v** will flip the grid vertically (top-to-bottom).
    Incompatible with the other options (except **outgrid**).

\textinput{common_opts/opt_-Grid}
Normally, **grdedit** will overwrite the existing grid with the modified grid.
    Use this option to write the modified grid to the file *outgrid* instead.

- **L** or **adjust_lon** : -- *adjust_lon=true* **|** *adjust_lon="+n|+p"*\
    Adjust the longitude values in the grid (only applies to geographic grids). By default we will
    try to adjust *west* and *east* so that *west* >= -180 or *east* <= +180, but this depends on
    the range of the longitudes. Use **adjust_lon="+n"** to force negative longitude values and **+p** to
    force positive longitude values.

- **N** or **replace** : -- *replace=table* **|** *replace="tablename"*\
    Use a Mx3 matrix with *x,y,z* values (or read them from file "tablename") and replace the corresponding
    nodal values in the grid with these values.

\textinput{common_opts/opt_R}

- **S** or **wrap** : -- *wrap=true*\
    For global, geographical grids only. Grid values will be shifted longitudinally according to the
    new borders given in **region** (if given, othersise use grid limits).

- **T** or **toggle_reg** or **toggle** : -- *toggle=true*\
    Make necessary changes in the header to convert a gridline-registered grid to a pixel-registered grid,
    or vice-versa. Basically, gridline-registered grids will have their domain extended by half the x- and
    y-increments whereas pixel-registered grids will have their domain shrunk by the same amount. This is a
    *non-destructive* grid change; see [Switching registrations](https://docs.generic-mapping-tools.org/latest/cookbook/options.html#switch-registrations).

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/explain_grd_coord}

Examples
--------

Let us assume the file data.nc covers the area 300/310/10/30. We want to change the boundaries from
geodetic longitudes to geographic and put a new title in the header. We accomplish this by:

    grdedit("data.nc", region=(-60,-50,10,30), D="+t\"Gravity Anomalies\"")

The grid *world.nc* has the limits 0/360/-72/72. To shift the data so that the limits
would be -180/180/-72/72, use:

    grdedit world.nc -R-180/180/-72/72 -S

The file junk.nc was created prior to GMT 3.1 with incompatible **region** and **increment** arguments.
To reset the x- and y-increments we run:

    grdedit("junk.nc", adjust_inc=true)

The file junk.nc was created prior to GMT 4.1.3 and does not contain
the required information to indicate that the grid is geographic. To add
this information, run:

    grdedit("junk.nc", colinfo=:g)

To rotate the grid oblique.nc 90 degrees counter-clockwise and write out
the rotated grid to a new file, run::

    gmt grdedit oblique.nc -El -Goblique_rot.nc


To ensure that the grid depths.nc only has positive longitude values, run::

    gmt grdedit depths.nc -L+p

The grid bad.nc has latitude as x-coordinates an longitude as y-coordinates.
We can exchange the two dimension by running::

    gmt grdedit bad.nc -Ee -Gnew.nc

Notes
-----

This module is not a general editor for netCDF files. If your netCDF file
contains more than one 2-D (or higher dimension) data layer, then only the
selected layer will be written out if changes are requested. Likewise,
if you have additional netCDF attributes then those will also be lost in
any revised output.

See Also
--------

:doc:`grd2xyz`,
:doc:`grdfill`,
:doc:`grdinfo`,
:doc:`xyz2grd`
