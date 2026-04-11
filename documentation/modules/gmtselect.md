# gmtselect

```julia
	gmtselect(cmd0::String="", arg1=nothing, kwargs...)
```

Select data table subsets based on multiple spatial criteria


Description
-----------

**select** is a filter that reads (x, y) or (longitude, latitude) positions from the first 2 columns of *infiles*
[or standard input] and uses a combination of 1-7 criteria to pass or reject the records. Records can be
selected based on whether or not they are 1) inside a rectangular region (**region** [and **proj**]), 2) within
*dist* km of any point in *pointfile*, 3) within *dist* km of any line in *linefile*, 4) inside one of the
polygons in the *polygonfile*, 5) inside geographical features (based on coastlines), 6) has z-values
within a given range, or 7) inside bins of a grid mask whose nodes are non-zero. The sense of the tests can
be reversed for each of these 7 criteria by using the **reverse** option. See option **yx** on how to read
(y,x) or (latitude,longitude) files (this option affects all module input data).  **Note**: If no projection
information is used then you must supply **colinfo=:g** to tell **select** that your data are geographical.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

Optional Arguments
------------------

\textinput{common_opts/explain_Acoast}

- **C** or **dist2pt** : -- *dist2pt=(pts=pointfile, dist=dist)* **|** *dist2pt=(pts=(lon,lat), dist=dist)*\
    Pass all records whose location is within *dist* of any of the points in the ASCII file *pointfile*
    or a *in-memory* matrix. If *dist* is zero then the 3rd column of *pointfile* must have each point's
    individual radius of influence. If you only have a single point then you can specify
    **dist2pt=(pts=(lon,lat), dist=dist)** instead of *pointfile*. Distances are Cartesian and in user units;
    specify **colinfo=:g** to indicate spherical distances and append a distance unit, even if the distance
    specified is 0. (see \myreflink{Units}). Alternatively, if **region** and **proj** are used then
    geographic coordinates are projected to map coordinates (in cm, inch, or points, as determined by
    `PROJ_LENGTH_UNIT`) before Cartesian distances are compared to *dist*.

- **D** or **res** or **resolution** : -- *res=:full* **|** *res=:auto*\
   Selects the resolution of the data set to use *full*, *high*, *intermediate*, *low*, and *crude*.
   The resolution drops off by 80% between data sets. The default is **res=:auto**, which chooses
   to automatically select the best resolution given the chosen map scale.

- **E** or **boundary** : -- *boundary=:f|:n|:fn*\
    Specify how points exactly on a polygon boundary should be considered. By default, such points
    are considered to be inside the polygon. Append **:f** and/or **:n** to change this behavior
    for the **polygon** and/or **mask** options, respectively, so that boundary points are
    considered to be outside.

- **F** or **polygon** : -- *polygon=polygonfile* **|** *polygon=matrix*\
    Pass all records whose location is within one of the closed polygons in the multiple-segment
    file *polygonfile* (or GMTdataset with *in-memory* data). For spherical polygons (lon, lat),
    make sure no consecutive points are separated by 180 degrees or more in longitude. Note that
    *polygonfile* must be in ASCII.

- **G** or **gridmask** : -- *gridmask="grid"*\
    Pass all locations that are inside the valid data area of the *grid*R, which can be either a
    file name or an *in-memory* grid object. Nodes that are outside are either NaN or zero.

- **I** or **invert** or **reverse** : -- *invert=:c|f|l|r|s|z*\
    Reverses the sense of the test for each of the criteria specified:

    - **c** - select records NOT inside any point's circle of influence.
    - **f** - select records NOT inside any of the polygons.
    - **g** - pass records inside the cells with z equal zero of the grid mask in **gridmask**.
    - **l** - select records NOT within the specified distance of any line.
    - **r** - select records NOT inside the specified rectangular region.
    - **s** - select records NOT considered inside as specified by **mask** (and **area**, **resolution**).
    - **z** - select records NOT within the range specified by |-Z|.

\textinput{common_opts/opt_J}

- **L** or **dist2line** : -- *dist2line=(line="linefile", dist=dist [,ortho=true])* **|** *dist2line=(line=[pt1; pt2], dist=dist [,ortho=true])*\
    Pass all records whose location is within *dist* of any of the line segments in the ASCII
    multiple-segment file *linefile* or *in-memory* matrix or GMTdataset. If *dist* is zero
    then we will scan each sub-header in the *linefile* for an embedded **-D**\ *dist* setting
    that sets each line's individual distance value. Distances are Cartesian and in user units;
    specify **colinfo=:f** to indicate spherical distances append a distance unit (see \myreflink{Units}).
    Alternatively, if **region** and **proj** are used then geographic coordinates are projected to map
    coordinates (in cm, inch, m, or points, as determined by `PROJ_LENGTH_UNIT`) before Cartesian
    distances are compared to *dist*. Use  **ortho=true** to ensure only points whose orthogonal
    projections onto the nearest line-segment fall within the segments endpoints [Default considers
    points "beyond" the line's endpoints.

- **N** or **mask** : -- *mask=maskvalues*\
    Pass all records whose location is inside specified geographical features. Specify if records
    should be skipped (s) or kept (k) using 1 of 2 formats:
     - **mask=(wet,dry)**
     - **mask=(ocean,land,lake,island,pond)**

    Default is (:s,:k,:s,:k,:s) (i.e., (:s,:k)), which passes all points on dry land.

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_V}

- **Z** or **in_range** : -- *in_range=(min,max)* **|** *in_range=min*\
    Pass all records whose 3rd column lies within the given range or is NaN (use **-s** to skip NaN records).
    If *max* is omitted then we test if *z* equals *min* instead. This means equality within 5 ULPs
    [unit of least precision](http://en.wikipedia.org/wiki/Unit_in_the_last_place). Input file must have
    at least three columns. To indicate no limit on min or max, specify a hyphen (-). If your 3rd column
    is absolute time then remember to supply **colinfo="2T"**. To specify another column, append **"+ccol"**.
    Be warned, these last options imply that the arguments to this option are all passed as a string. 
    Note: repeating this option with different tests is not yet implemented.

\textinput{common_opts/opt_a}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_o}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt__w}

\textinput{common_opts/opt_xy}

\textinput{common_opts/opt__distunits}

Note On Processing ASCII Input Records
--------------------------------------

Unless you are using the **yx** option, selected ASCII input records are copied verbatim to output.
That means that options like **colinfo=:oT** and settings like `FORMAT_FLOAT_OUT` and `FORMAT_GEO_OUT`
will not have any effect on the output. On the other hand, it allows selecting records with diverse
content, including character strings, quoted or not, comments, and other non-numerical content.

Note On Distances
-----------------

If options **dist2pt** or **dist2line** are selected then distances are Cartesian and in user units;
use **colinfo=:g** to imply spherical distances in km and geographical (lon, lat) coordinates.
Alternatively, specify **region** and **proj** to measure projected Cartesian distances in map
units (cm, inch, or points, as determined by `PROJ_LENGTH_UNIT`).

This program has evolved over the years. Originally, the **region** and **proj** were mandatory in
order to handle geographic data, but now there is full support for spherical calculations. Thus,
**proj** should only be used if you want the tests to be applied on projected data and not the
original coordinates. If **proj** is used the distances given via **dist2pt** and **dist2line**
are projected distances.

Note On Segments
----------------

Segment headers in the input files are copied to output if one or more records from a segment passes
the test. Selection is always done point by point, not by segment. That means only points from a
segment that pass the test will be included in the output. If you wish to clip the lines and include
the new boundary points at the segment ends you must use \myreflink{gmtspatial} instead.

Examples
--------

To only return the data points from the remote file @ship_15.txt that lie
within the region between longitudes 246 and 247 and latitudes 20 and 21, try:

\begin{examplefig}{}
```julia
using GMT
D = gmtselect("@ship_15.txt", region=(246,247,20,21));
plot(D, marker=:point, show=true)
```
\end{examplefig}

To return all the points *except* those inside that square, use:
 
```julia
    D = gmtselect("@ship_15.txt", region=(246,247,20,21), reverse=:r)
```

To extract the subset of data set that is within 300 km of any of the
points in pts.txt but more than 100 km away from the lines in lines.txt, run

```julia
    D = gmtselect(lonlat, colinfo=:g, dist2pts=(pts="pts.txt", dist="300k"),
                  dist2lines=(lines="lines.txt", dist="100k"), reverse=:l)
```

Here, you must specify **colinfo=:g** so the program knows you are processing geographical data.

To keep all points in data.txt within the specified region, except the
points on land (as determined by the high-resolution coastlines), use

```julia
    D = gmtselect("data.txt", region=(246,247,20,21), res=:high, mask=(:k,:s))
```

To return all points in quakes.txt that are inside or on the spherical polygon lonlatpath.txt, try

```julia
    D = gmtselect("quakes.txt", polygon="lonlatpath.txt", colinfo=:g)
```

To return all points in stations.txt that are within 5 cm of the point in
origin.txt for a certain projection, try

```julia
    gmtselect("stations.txt", dist2pts=(pts="origin.txt", dist=5), region=(20,50,-10,20), proj=:Merc, figsize=20)
```

To return all points in quakes.txt that are inside the grid topo.nc
where the values are nonzero, try

```julia
    D = gmtselect("quakes.txt", gridmask="topo.nc")
```

\textinput{common_opts/explain_gshhg}

\textinput{common_opts/explain_inside}


See Also
--------

\myreflink{gmtconvert},
\myreflink{gmtsimplify},
\myreflink{gmtspatial},
\myreflink{grdlandmask},
\myreflink{coast}
