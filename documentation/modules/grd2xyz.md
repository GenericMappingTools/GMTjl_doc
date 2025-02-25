# grd2xyz

```julia
	grd2xyz(cmd0::String="", arg1=nothing, kwargs...)
```

Convert grid to data table

Description
-----------

Reads a grid (from file or a Grid type object) and writes out
xyz-triplets in ASCII [or binary] format to file or return them as a Julia variable. Modify the
precision of the ASCII output format by editing the
`FORMAT_FLOAT_OUT` parameter in your `gmt.conf` file or use
**par=(FORMAT_FLOAT_OUT=format,)** or choose binary
output using single or double precision storage. As an option you may
output z-values without the (x,y) coordinates (see **onecol** below) or you can
save the grid in the STL format for 3-D printers.

Required Arguments
------------------

*ingrid* : -- A grid file name or a \myreflink{Grid type}

Optional Arguments
------------------

- **C** or **rowcol** or **row_col** : -- *rowcol=true* **|** *rowcol=:f|:i*\
    Replace the x- and y-coordinates on output with the corresponding column and row numbers.
    These start at 0 (C-style counting); use **rowcol=:f** to start at 1 (Fortran-style counting).
    Alternatively, use **rowcol=:i** to write just the two columns *index* and *z*, where
    *index* is the 1-D indexing that GMT uses when referring to grid nodes.

- **L** or **hvline** : -- *hvline=:c|:r|:x|:yvalue*\
    Limit the output of records to a single row or column. Identify the desired vector either by
    *row* or *column* number (via directives **:c** or **:r**), or by the constant *x* or *y*
    value (via directives **:x** or **:y**). If your selection is outside the valid range then
    no output will result and a warning is issued. **Note**: For directives **:x** and **:y**
    we find the nearest column or row, respectively.

\textinput{common_opts/opt_R}

- **T** or **stl** or **STL** : -- *STL=true* **|** *STL=[:b][base]*\
    Write STL triangulation for 3-D printing to standard output. By default we write an STL ASCII file.
    Append **b** to instead write the STL binary (little-endian) format. For more information on STL, see the
    [STL overview on Wikipedia](https://en.wikipedia.org/wiki/STL_(file_format)). **Note**: All coordinates are
    adjusted so that *xmin = ymin = zmin = 0*. For other adjustments, see \myreflink{grdedit} and \myreflink{grdproject}
    Optionally, append a lower *base* other than the grid's minimum value [Default]. **Note**: The grid must be free
    of NaN values. If your grid contains NaNs then we automatically replace these with the minimum value in the grid.

\textinput{common_opts/opt_V}

- **W** or **weight** : -- *weight=true* **|** *weight=:a[+uunit]* **|** *weight=weight*\
    Write out *x,y,z,w*, where *w* is the supplied *weight* (or 1 if not supplied) [Default writes
    *x,y,z* only]. Choose **weight=:a** to compute weights equal to the area each node represents.
    For Cartesian grids this is simply the product of the *x* and *y* increments (except for
    gridline-registered grids at all sides [half] and corners [quarter]). For geographic grids we
    default to a length unit of **k** (hence area is in km^2). Change this by appending **+u**unit
    (see \myreflink{Units}). For such grids, the area varies with latitude and also sees special cases
    for gridline-registered layouts at sides, corners, and poles.

- **Z** or **onecol** or **one_col** : -- *onecol="flags"*\
    Write (or return) a 1-column table. Output will be organized according to the specified ordering
    convention contained in *flags*. If data should be written by rows, make *flags* start with
    **T** (op) if first row is y = ymax or **B** (ottom) if first row is y = ymin. Then, append **L**
    or **R** to indicate that first element should start at left or right end of row. Likewise for
    column formats: start with **L** or **R** to position first column, and then append **T** or **B**
    to position first element in a row. For gridline registered grids: If grid is periodic in x but the
    written data should not contain the (redundant) column at x = xmax, append **x**. For grid periodic
    in y, skip writing the redundant row at y = ymax by appending **y**. If the byte-order needs to be
    swapped, append **w**. Select one of several data types (all binary except **a**):

    * **a** ASCII representation of a single item per record
    * **c** int8_t, signed 1-byte character
    * **u** uint8_t, unsigned 1-byte character
    * **h** int16_t, short 2-byte integer
    * **H** uint16_t, unsigned short 2-byte integer
    * **i** int32_t, 4-byte integer
    * **I** uint32_t, unsigned 4-byte integer
    * **l** int64_t, long (8-byte) integer
    * **L** uint64_t, unsigned long (8-byte) integer
    * **f** 4-byte floating point single precision
    * **d** 8-byte floating point double precision

    Default format is scanline orientation of ASCII numbers: **onecol=:TLa**.

    **NOTE**, to write on a disk file one must use the **save="file"** option, otherwise data is return to
    Julia and the type options above are ignored. In that case, data is always Float64. 

- **name** or **save** : -- *save="file"*\
   Save data to disk *file* with **save="file"**.

\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt_o}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt__distunits}

Non-equidistant x/y Coordinates
-------------------------------

In general, GMT modules cannot accept grids with variable *x* and/or *y* coordinates as most
algorithms and plotting options expect equidistant grids. However, you can use **grd2xyz**
to dump the original *x y z* triplets and then reprocess the data onto an equidistant
lattice via \myreflink{greenspline}, \myreflink{nearneighbor} or \myreflink{surface}, for instance.

Time Coordinates
----------------

Time coordinates in netCDF grids, be it the x, y, or z coordinate, will be recognized as such.
The variable's **unit** attribute is parsed to determine the unit and epoch of the time
coordinate in the grid. Values are then converted to the internal time system specified by
`TIME_UNIT` and `TIME_EPOCH` in the `gmt.conf` file or on the command line. The default output
is relative time in that time system, or absolute time when using the option **colinfo="0T"**,
**colinfo="1T"**, or **colinfo="2T"** for x, y, or z coordinate, respectively.

Row Order
---------

The **hvline=:r** option allows you to output a specific row in the grid. Note that while
a grid's y-coordinates are positive up, internal row numbers are scanline numbers
and hence positive down. Therefore, the first row (0) coincides with the largest *y*-value.
This means that **hvline=:r0** and **hvline=:y<ymax>** (for the correct maximum y-value)
will yield the same result. In contrast, both *x* and column numbers are positive to the right,
with **hvline=:c0** and **hvline=:x<xmin>** (for the correct minimum x-value) yielding the same output.

Examples
--------

To edit individual values in the 2' by 2' remote AFR.nc file, dump the .nc to \myreflink{Dataset type}.
That is, return data in a Julia variable, do

```julia
    D = grd2xyz("@AFR.nc")
```

To write a single precision binary file without the x,y positions from
the remote file @AFR.nc file, using scanline orientation, run:

```julia
    grd2xyz("@AFR.nc", onecol=:TLf, save="AFR.b")
```

To write out *lon, lat, topo, area* from the @AFR.nc file, selecting meter^2 as the area unit,
and where *area* reflects the size of each grid box, run:

```julia
    grd2xyz("@AFR.nc", weight="a+ue", save="AFR.txt")
```

See Also
--------

\myreflink{grdedit}, \myreflink{grdconvert}, \myreflink{xyz2grd}
