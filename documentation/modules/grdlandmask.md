# grdlandmask

```julia
	grdlandmask(area=, resolution=, border=, save=, maskvalues=, registration=, cores=)
```

Create a "wet-dry" mask grid from shoreline data base

Description
-----------

Reads the selected shoreline database and uses that information to decide which nodes in
the specified grid are over land or over water. The nodes defined by the selected region
and lattice spacing will be set according to one of two criteria: (1) land vs water, or (2)
the more detailed (hierarchical) ocean vs land vs lake vs island vs pond. The resulting mask
may be used in subsequent operations involving `grdmath` to mask out data from land [or water] areas.

Required Arguments
------------------

\textinput{common_opts/opt_I}

\textinput{common_opts/opt_R}

Optional Arguments
------------------

\textinput{common_opts/explain_Acoast}

- **D** or **res** or **resolution** : -- *res=:full* **|** *res=:high* **|** *res=:auto*\
   Selects the resolution of the data set to use *full*, *high*, *intermediate*, *low*,
   and *crude*. The resolution drops off by 80% between data sets. Alternatively, chooses
   **res=auto**, to automatically select the best resolution given the chosen region.
   Note that because the coastlines differ in details a node in a mask file using one
   resolution is not guaranteed to remain inside [or outside] when a different resolution is selected.

**-E** or **border** : -- *border=true* **|** *border=bordervalues*\
    Nodes that fall exactly on a polygon boundary should be
    considered to be outside the polygon [Default considers them to be inside].
    Alternatively, append either the four values *cborder/lborder/iborder/pborder*
    or just the single value *bordervalue* (for the case when they should all be the same value).
    This turns on the line-tracking mode. Now, after setting the mask values
    specified via |-N| we trace the lines and change the node values for all
    cells traversed by a line to the corresponding border value.  Here, *cborder*
    is used for cells traversed by the coastline, *lborder* for cells traversed
    by a lake outline, *iborder* for islands-in-lakes outlines, and *pborder* for
    ponds-in-islands-in-lakes outlines [Default is no line tracing].

\textinput{common_opts/opt_-Grid}

- **N** or **maskvalues** : -- *maskvalues=(wet,dry)* **|** *maskvalues=(ocean,land,lake,island,pond)*\
    Sets the values that will be assigned to nodes. Values can be any number, including
    NaN. Also select **border** to let nodes exactly on feature boundaries be
    considered outside [Default is inside]. Specify this information using 1 of 2 formats:

    - **maskvalues=(wet,dry)**

    - **maskvalues=(ocean,land,lake,island,pond)**

    [Default is (0,1,0,1,0) (i.e., 0,1)].

\textinput{common_opts/opt_V}

\textinput{common_opts/opt__r}

\textinput{common_opts/opt__x}

Notes
-----

A grid produced by grdlandmask is a *categorical* dataset. As such, one has to be careful
not to interpolate it with standard methods, such as splines. However, if you make a map
of this grid using a map projection the grid will be reprojected to yield a rectangular
matrix in the projected coordinates. This interpolation is done using splines by default
and thus may yield artifacts in your map. We recommend you use \myreflink{grdimage}
**interp=:n** to instead use a nearest neighbor interpolation for such cases.

Global Landmask Grids
---------------------

Before you make your own masks, be aware that the GMT data server offers global landmask
files in multiple grid resolutions. These can be accessed using the remote file names
@earth_mask_rru[_*reg*], where *rru* and the optional *reg* indicate the resolution and registration
that you desire. See [Global Earth Mask Grids](https://www.generic-mapping-tools.org/remote-datasets/earth-mask.html)
for more information on the availability of resolutions.

Examples
--------

To set all nodes on land to NaN, and nodes over water to 1, using the
high resolution data set, do

```julia
    G = grdlandmask(region=(-60,-40,-40,-30), res=:high, inc="5m", maskvalues(1,NaN))
```

To make a 1x1 degree global grid with the hierarchical levels of the
nodes based on the low resolution data:

```julia
G = grdlandmask(region=:global360, res=:low, inc=1, maskvalues=(0,1,2,3,4))
```

\textinput{common_opts/explain_gshhg}

See Also
--------

\myreflink{grdclip}, \myreflink{mask}, \myreflink{clip}, \myreflink{coast}
