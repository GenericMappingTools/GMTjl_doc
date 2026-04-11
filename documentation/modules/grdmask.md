# grdmask

```julia
	grdmask(cmd0::String="", arg1=nothing, kwargs...)
```

Create mask grid from polygons or point coverage.

Description
-----------

**grdmask** can operate in two different modes. 1. It reads one or more
*pathfiles* that each define a closed polygon. The nodes defined by the
specified region and lattice spacing will be set equal to one of three
possible values depending on whether the node is outside, on the polygon
perimeter, or inside the polygon, with the assigned *z* value selected
via **out\_edge\_in**. If multiple polygons overlap the same nodes then the polygon
selected depends on the **clobber** selection. The resulting mask may be used in
subsequent operations involving `grdmath` to mask out data from
polygonal areas. 2. The *pathfiles* simply represent data point locations
and the mask is set to the inside or outside value depending on whether
a node is within a maximum distance from the nearest data point. If the
distance specified is zero then only the nodes nearest each data point
are considered "inside".

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

\textinput{common_opts/opt_I}

\textinput{common_opts/opt_R}

Optional Arguments
------------------

\textinput{common_opts/opt_Asteps}

- **C** or **clobber** : -- *clobber=:f|l|o|u*\
    Clobber mode: Selects the polygon whose *z*-value will determine the grid nodes. Choose from
    the following modes: **clobber=:f** for the first polygon to overlap a node; **o** for the
    last polygon to overlap a node; **l** for the polygon with the lowest *z*-value, and **u**
    for the polygon with the uppermost *z*-value [Default is **o**]. **Note**: Does not apply to
    **search_radius**. For polygon *z*-values, see **out_edge_in**.

\textinput{common_opts/opt_-Grid}

- **N** or **out\_edge\_in** : -- *out\_edge\_in=values* **|** *out\_edge\_in="z|Z|p|Pvalues"*\
    Sets the *out/edge/in* that will be assigned to nodes that are *out*side the polygons,
    on the *edge*, or *in*side. Values can be any number, including the textstring NaN
    [Default is 0/0/1]. Optionally, use **Nz** to set polygon insides to the z-value obtained
    from the data (either segment header **Z**zval, **L**header or via **a**Z=*name*);
    use **NZ** to consider the polygon boundary as part of the inside. Alternatively,
    use **Np** to use a running number as polygon ID; optionally append start of the sequence [0].
    Here, **NP** includes the polygon perimeter as inside. **Note**: **out\_edge\_in="z|Z|p|P"**
    cannot be used in conjunction with **seach_radius**; they also all optionally accept /*out* [0].

- **S** or **search_radius** : -- *search_radius=rad* **|** *search_radius=(xlim,ylim)*\
    Set nodes to inside, on edge, or outside depending on their distance to the nearest data point.
    Nodes within *radius* [0] from the nearest data point are considered inside; append a distance
    unit (see \myreflink{Units}). If *radius* is given as **z** then we instead read individual
    radii from the 3rd input column. Unless Cartesian data, specify the unit of these radii by
    appending it after **-Sz**. If **search_radius** is not set then we consider the input data to
    define one or more closed polygon(s) instead. For Cartesian data with different units you can
    instead use *search_radius=(xlim,ylim)* which will perform a rectangular search where all nodes
    within ±\ *xlim* and ±\ *ylim* of a data point will be considered inside. One can also achieve
    the rectangular selection effect by using the **search_radius=**n_cells**c** form. Here *n_cells*
    means the number of cells around each data point. As an example, **search_radius="0c"** means
    that only the cell where point lies is masked, **search_radius="1c"** masks one cell beyond
    that (i.e. makes a 3x3 neighborhood), and so on.

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_a}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt__j}

\textinput{common_opts/opt_n}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt__r}

\textinput{common_opts/opt__w}

\textinput{common_opts/opt__x}

\textinput{common_opts/opt__distunits}

\textinput{common_opts/explain_inside}

Notes
-----

A grid produced by grdmask is a *categorical* dataset. As such, one has to be careful not
to interpolate it with standard methods, such as splines. However, if you make a map of
this grid using a map projection the grid will be reprojected to yield a rectangular matrix
in the projected coordinates. This interpolation is done using splines by default and thus may
yield artifacts in your map. We recommend you use \myreflink{grdimage} **interp=:n** to instead use
a nearest neighbor interpolation for such cases.

Save storage space
------------------

Since most uses of grdmask revolves around creating mask grids that hold just a few integer
values (and perhaps NaN), we choose to write them to disk as byte grids by appending the
suffix **=nb** to the desired grid filename. Some situations may store integers that exceed
the range available in a byte and for those we specify a short integer grid with **=ns**.
For larger integers you may consider **=ni**, otherwise use the default float grid format.

Examples
--------

To set all nodes inside and on the polygons coastline_*.xy to 0, and
outside points to 1, do

```julia
    G = grdmask("coastline_*.xy", region=(-60,-40,-40,-30), inc="5m", out_edge_in=(1,0,0))
```

To set nodes within 50 km of data points to 1 and other nodes to NaN, do

```julia
    G = grdmask("data.xyz", region=(-60,-40,-40,-30), inc="5m", out_edge_in=(NaN,1,1), search_radius="50k")
```

To assign polygon IDs to the gridnodes using the insides of the polygons
in plates.gmt, based on the attribute POL_ID, do

```julia
    G = grdmask("plates.gmt", region=(-40,-40,-40,-40), inc="2m", out_edge_in=:z, aZ=POL_ID)
```

Same exercise, but instead compute running polygon IDs starting at 100, do

```julia
    G = grdmask("plates.gmt", region=(-40,-40,-40,-40), inc="2m", out_edge_in="p100")
```

See Also
--------

\myreflink{grdlandmask},
\myreflink{grdclip},
\myreflink{mask}, \myreflink{clip}
