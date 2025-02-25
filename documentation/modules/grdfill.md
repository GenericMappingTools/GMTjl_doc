# grdfill

```julia
	grdfill(cmd0::String="", arg1=nothing, kwargs...)
```

Interpolate across holes in a grid.

Description
-----------

Reads a grid that presumably has unfilled holes that the user wants to fill in some fashion.
Holes are identified by NaN values but this criteria can be changed via **nodata**. There
are several different algorithms that can be used to replace the hole values. **Note**:
One of **mode** or **list** is required, and if no holes are found we output the original
unchanged grid.

Required Arguments
------------------

The 2-D gridded data set.

Optional Arguments
------------------

- **A** or **mode** : -- *mode=:c|:g|:n|:s[arg]*\
    Specify the hole-filling algorithm to use. Choose among **c** for constant
    fill (and append the constant fill *value*), **g** to sample the (possibly coarser)
    grid *arg* at the nodes making up the holes, **n** for nearest neighbor (and optionally
    append a search *radius* in pixels [default radius is $r = \sqrt{n^2 + m^2}$,
    where (*n,m*) are the node dimensions of the grid]), or
    **s** for bicubic spline (optionally append a *tension* parameter [no tension]).

\textinput{common_opts/opt_save_grd}

- **N** or **nodata** or **hole** : -- *nodata=true* **|** *nodata=value*\
    Sets the node value used to identify a point as a member of a hole [Default is NaN].

\textinput{common_opts/opt_R}

- **L** or **list** : -- *list=true* **|** *list=:p*\
    Just list the rectangular subregions west east south north of each hole.
    No grid fill takes place. Optionally, use **list=:p**
    to instead write closed polygons for all subregions.

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_f}

\textinput{common_opts/explain_grd_coord}

Examples
--------

To identify all regions with NaNs in the grid data.grd and create a listing of the
bounding coordinates of rectangular regions that would cover these NaN areas, try:

```julia
    D = grdfill("data.grd", list=true)
```

To identify the same areas but this time write a multisegment file with polygons
corresponding to the rectangular subregions, use:

```julia
    D = grdfill("data.grd", list=:p)
```

To replace all NaN values in the file data.grd with the value 999.0, use:

```julia
    G = grdfill("data.grd", mode="c999")
```

To replace all NaN values in the file data.grd with the values at the
nearest non-NaN neighbor, try:

```julia
    G = grdfill("data.grd", mode=:n)
```

To replace all NaN values in the file data.grd with a spline interpolation using a tension of 0.2, try:

```julia
    G = grdfill("data.grd", mode="s0.2")
```

To replace all NaN values in the file data.grd by sampling another grid named background.grd, try:

```julia
    G = grdfill("data.grd", mode="gbackground.grd")
```

See Also
--------

\myreflink{grdcut},
\myreflink{grdclip},
\myreflink{grdedit},
\myreflink{grdinfo}
