# xyz2grd

```julia
	xyz2grd(cmd0::String="", arg1=nothing, kwargs...)
```

Convert data table to a GMTgrid type. 

Description
-----------

Reads one or more *x, y, z* or *z* tables and creates a grid. It will report if some of the nodes are not
filled in with data. Such unconstrained nodes are set to a value specified by the user [Default is NaN].
Nodes with more than one value will be set to the mean value. As an option (using **flags**), a 1-column *z*
table may be read assuming all nodes are present (*z* tables can be organized in a number of formats, see **flags** below.)
**Note**: **xyz2grd** does not grid the data, it simply reformats existing data to a grid structure. For gridding,
see \myreflink{surface}, \myreflink{greenspline}, \myreflink{nearneighbor}, or \myreflink{triangulate}.

Required Arguments
------------------

- *table*\
    A data table holding *z* or *x, y, z* values. The *x, y, z* triplets do not have to
    be sorted. One-column *z* tables must be sorted and the **flags** option must be set.

\textinput{common_opts/opt_I}

\textinput{common_opts/opt_R}

Optional Arguments
------------------

- **A** or **multiple_nodes** : -- *multiple_nodes=true* **|** *multiple_nodes="d|f|l|m|n|r|S|s|u|z"*\
    By default we will calculate mean values if multiple entries fall on the same node. Use this option to
    change this behavior, except it is ignored if **flags** is given. Append **f** or **s** to simply keep
    the first or last data point that was assigned to each node. Append **l** or **u** or **d** to find the
    lowest (minimum) or upper (maximum) value or the difference between the maximum and miminum value at each
    node, respectively. Append **m** or **r** or **S** to compute mean or RMS value or standard deviation at
    each node, respectively. Append **n** to simply count the number of data points that were assigned to each
    node (this only requires two input columns *x* and *y* as *z* is not consulted). Append **z** to sum
    multiple values that belong to the same node.

- **J** or **proj** or **projection** : -- *proj=<parameters>*\
    Use the **proj** syntax to save the georeferencing info as CF-1 compliant metadata in
    netCDF grids. Remember also that PROJ syntax can be used directly in **proj**. This referencing will be
    recognized by GDAL and increasingly also by GMT.

\textinput{common_opts/opt_-Grid}

- **S** or **swap** : -- *swap=true* **|** *swap=zfile*\
    Swap the byte-order of the *z* table input only. No grid is produced. You
    must also supply the **flags** option. The output is return to Julia or written to *zfile*

\textinput{common_opts/opt_V}

- **Z** or **flags** : -- *flags=flags*\
    Read a 1-column table. This assumes that all the nodes are present and sorted according to specified ordering
    convention contained in *flags* (a string). If incoming data represents rows, make *flags* start with **T**(op)
    if first row is *y = ymax* or **B**(ottom) if first row is *y = ymin*. Then, append **L** or **R** to indicate
    that first element is at left or right end of row. Likewise for column formats: start with **L** or **R** to
    position first column, and then append **T** or **B** to position first element in a row. **Note**: These two
    row/column indicators are only required for grids; for other tables they do not apply. For gridline registered grids:
    If data are periodic in *x* but the incoming data do not contain the (redundant) column at *x = xmax*, append **x**.
    For data periodic in *y* without redundant row at *y = ymax*, append **y**. Append **s** *n* to skip the first *n*
    number of bytes (probably a header). If the byte-order or the words needs to be swapped, append **w**. Select one
    of several data types (all binary except **a**):

    - **A** ASCII representation of one or more floating point values per record
    - **a** ASCII representation of a single item per record
    - **c** int8_t, signed 1-byte character
    - **u** uint8_t, unsigned 1-byte character
    - **h** int16_t, signed 2-byte integer
    - **H** uint16_t, unsigned 2-byte integer
    - **i** int32_t, signed 4-byte integer
    - **I** uint32_t, unsigned 4-byte integer
    - **l** int64_t, long (8-byte) integer
    - **L** uint64_t, unsigned long (8-byte) integer
    - **f** 4-byte floating point single precision
    - **d** 8-byte floating point double precision

    Default format is scanline orientation of numbers: **flags="TLa"**.  The difference between **A** and **a**
    is that the latter can decode both date**T**clock and *ddd:mm:ss[.xx]* formats but expects each input record
    to have a single value, while the former can handle multiple values per record but can only parse regular
    floating point values. Translate incoming *z*-values via the **-i**0 option and needed modifiers.

\textinput{common_opts/opt_bi}
[Default is 3 input columns]. This option only applies to *x, y, z* input files; see **flags** for *z* tables.

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt__r}

\textinput{common_opts/opt__w}

\textinput{common_opts/opt_xy}

\textinput{common_opts/explain_grd_coord}

Swapping Limitations
--------------------

All data types can be read, even 64-bit integers, but internally grids are stored using floats.
Hence, integer values exceeding the float type's 23-bit mantissa may not be represented exactly.
When **swap** is used no grids are implied and we read data into an intermediate double container.
This means all but 64-bit integers can be represented using the double type's 53-bit mantissa.

Examples
--------

To create a grid file from the raw binary (3-column, single-precision
scanline-oriented data raw.b, use

```julia
    G = xyz2grd("raw.b", region=(0,100,0,100), inc=1, flags=true, binary_in="3f")
```

See Also
--------

\myreflink{grd2xyz},
\myreflink{greenspline},
\myreflink{nearneighbor},
\myreflink{surface},
\myreflink{triangulate}