# gmtspatial

Geospatial operations on points, lines and polygons

(Warning: Manual translate by Claude. Needs revision)

## Synopsis

**gmtspatial** [ *table* ]
[ **A** | **nn** | **nearest\_neighbor** ]
[ **C** | **clip** ]
[ **D** | **duplicates** ]
[ **E** | **handedness** ]
[ **F** | **force_polygons** ]
[ **I** | **intersections** ]
[ **L** | **tile\_lines** ]
[ **N** | **in\_polyg** | **in\_polygons** ]
[ **Q** | **area** | **length** ]
[ **R** | **region** | **limits** ]
[ **S** | **polygons** | **polyg\_process**]
[ **T** | **truncate** ]
[ **V** | **verbose** ]
[ **W** | **extend** ]
[ **a** | **aspatial** ]
[ **bi** | **binary\_in** ]
[ **di** | **nodata\_in** ]
[ **e** | **pattern** ]
[ **f** | **colinfo** ]
[ **g** | **gap** ]
[ **h** | **header** ]
[ **i** | **incol** | **incols** ]
[ **j** | **spherical\_dist** | **spherical** ]
[ **o** | **outcol** | **outcols** ]
[ **q** | **inrows** | **query** ]
[ **s** | **skipNaN** | **skip\_NaN** ]
[ **yx** ]

## Description

**gmtspatial** reads a table (which may be multisegment files) that contains closed polygons and operates on these polygons in the specified way. Operations include area calculation, handedness reversals, and polygon intersections.

## Required Arguments

*table*
:   One data table or file. Can be a file name, a GMTdataset object, or a Matrix.

## Optional Arguments

- **A** or **nn** or **nearest\_neighbor** : -- *nn=[amin\_dist][unit]*\
    Perform spatial nearest neighbor (NN) analysis: Determine the nearest neighbor of each point and report the NN distances and the point IDs involved in each pair (IDs are the input record numbers starting at 0). Use **nn=amin\_dist** to decimate a data set so that no NN distance is lower than the threshold *amin\_dist*. In this case we write out the (possibly averaged) coordinates and the updated NN distances and point IDs. A negative point number means the original point was replaced by a weighted average (the absolute ID value gives the ID of the first original point ID to be included in the average). Note: The input data are assumed to contain (lon, lat) or (x, y), optionally followed by a z and a weight [1] column. We compute a weighted average of the location and z (if weight is present).

- **C** or **clip** : -- *clip=true*\
    Clips polygons to the map region, including map boundary to the polygon as needed. The result is a closed polygon (see **truncate** for truncation instead). Requires **region**.

- **D** or **duplicates** : -- *duplicates=(modifiers...)*\
    Check for duplicates among the input lines (or polygons). We consider both exact (same number and coordinates) and approximate matches (average distance between nearest points of two features is less than a threshold). We also consider that some features may have been reversed. By default, we compute the mean line separation. Available modifiers:
    - **closeness** or **c** : *c=cmax* -- Set threshold of a pair's closeness (defined as the average distance between the features divided by their average length) [0.01].
    - **Closeness** or **C** : *C=cmin* -- Use this to compute the median line separation and therefore a robust closeness value.
    - **dist** or **d** : *d=dmax* -- Features are considered approximate matches if their minimum distance is less than *dmax* [0] and their closeness is less than *cmax*.
    - **file** or **f** : *f="file"* -- Check if the input features already exist among the features in *file*.
    - **perpendicular** or **p** : *p=true* -- Limit the comparison to points that project perpendicularly to points on the other line (and not its extension) [Default considers all distances between points on one line and another].
    - **scale** or **s** : *s=factor* -- Scale factor to apply.
    
    For each duplicate found, the output record begins with Y (exact match) or ~ (approximate match). If the two matching segments differ in length by more than a factor of 2 then we consider the duplicate to be either a subset (-) or a superset (+). Finally, we also note if two lines are the result of splitting a continuous line across the Dateline (|).

- **E** or **handedness** : -- *handedness=:p* **|** *handedness=:n* **|** *handedness=(pol="+p")* **|** *handedness=(pol="+n")*\
    Reset the handedness of all polygons to match the given modifier:
    - **+p** or **pol="+p"** : Counter-clockwise (positive).
    - **+n** or **pol="+n"** : Clockwise (negative).

- **F** or **force_polygons** : -- *force_polygons=true* **|** *force_polygons=:l*\
    Force input data to become polygons on output, i.e., close them explicitly if not already closed. Optionally, append **:l** to force line geometry.

- **I** or **intersections** : -- *intersections=true* **|** *intersections=:i* **|** *intersections=:e*\
    Determine the intersection locations between all pairs of polygons. Modifiers:
    - **i** or **:i** : Only compute internal (self-intersecting polygons) crossovers.
    - **e** or **:e** : Only compute external (between pairs of polygons) crossovers.
    - Default is both.
    
    Output records list the coordinates of the crossing, the relative times along the two segments (i.e., floating point record numbers at the crossing), and the names of the two segments (as trailing text).

- **L** or **tilelines** : -- *tilelines=(dist, noise, offset)*\
    Remove tile lines. These are superfluous lines that were digitized with a polygon but that all fall along the rectangular **region** border and should be removed. Append *dist* (in m) [0], coordinate *noise* [1e-10], and max *offset* from gridlines [1e-10].

- **N** or **in\_polyg** or **in\_polygons** : -- *in\_polyg=pfile* **|** *in\_polyg=(poly="pfile", modifiers...)*\
    Determine if one (or all) points of each feature in the input data are inside any of the polygons given in *pfile*. If inside, then report which polygon it is. The polygon ID is taken from the aspatial value assigned to Z or the segment header. By default, the input segments that are found to be inside a polygon are written to standard output with the polygon ID encoded in the segment header as *-ZID*. Available modifiers:
    - **all** or **a** : *all=true* -- All points of a feature must be inside the polygon.
    - **individual** or **i** : *individual=true* -- Point clouds: determine the polygon ID for every individual input point and add it as the last output column.
    - **running\_id** or **start** or **p** : *start=n* -- Instead of segment headers, assign a running ID number that is initialized to begin from *n* [0].
    - **report** or **r** : *report=true* -- Just report which polygon contains a feature.
    - **id\_column** or **z** : *z=true* -- Add the IDs as an extra data column on output.
    
    Segments that fail to be inside a polygon are not written out. If more than one polygon contains the same segment, we skip the second (and further) scenarios.

- **Q** or **area** or **length** : -- *area=true* **|** *area=unit* **|** *area=(unit="k", modifiers...)*\
    Measure the area of all polygons or length of all line segments. For polygons, we also compute the centroid location while for lines we compute the mid-point (half-length) position. For geographical data, optionally append a distance *unit* to select the unit used [k]. Note that the area will depend on the current setting of PROJ\_ELLIPSOID; this should be a recent ellipsoid to get accurate results. The centroid is computed using the mean of the 3-D Cartesian vectors making up the polygon vertices, while the area is obtained via a sum of areas for spherical triangles. Normally, all input segments will be reflected on output. By default, we consider open polygons as lines and closed polygons as polygons. Available modifiers:
    - **limits** or **c** : *limits=(min, max)* **|** *c="min/max"* -- Restrict processing to those features whose length (or area for polygons) fall inside the specified range. If *max* is not set it defaults to infinity.
    - **header** or **h** : *header=true* -- Append the area to each polygon's segment header [Default simply writes the area to standard output].
    - **lines** or **l** : *lines=true* -- Consider all input features as lines, even if closed.
    - **polygons** or **p** : *polygons=true* -- Close open polygons and thus consider all input as polygons.
    - **sort** or **s** : *sort=:a* **|** *sort=:d* -- Sort the segments based on their lengths or area. Append **:a** for ascending [Default] and **:d** for descending order.

- **R** or **region** or **limits** : -- *region=(xmin, xmax, ymin, ymax)* **|** *region="west/east/south/north"* **|** *region="gridfile"* **|** *region=country\_code*\
    Specify the region of interest. Clips polygons to the map region, including map boundary to the polygon as needed. The result is a closed polygon. [More at region]

- **S** or **polygons** or **polyg\_process** : -- *polygons=:bwidth* **|** *polygons=:h* **|** *polygons=:s* **|** *polygons=(buffer=width,)*\
    Spatial processing of polygons. Choose from several directives:
    - **buffer** or **b** : *buffer=width* -- Computes a buffer polygon around lines with the specified *width*. Note: This is a purely Cartesian operation, so *width* must be in data units. For geographical coordinates, *width* must be in degrees or, preferably, project data into an equal-area projection with **mapproject**, compute the buffer, and then convert back to geographical.
    - **h** : Identifies perimeter and hole polygons (and flags/reverses them).
    - **s** : Split polygons that straddle the Dateline.

- **T** or **truncate** : -- *truncate=true* **|** *truncate=polygon\_file*\
    Truncate polygons and lines against the specified polygon, possibly resulting in open polygons. If no argument is given, we create a clipping polygon from **region** which then is required. Note that when the **region** clipping is in effect we will also look for polygons of length 4 or 5 that exactly match the **region** clipping polygon.

\textinput{common_opts/opt_V}

- **W** or **extend** : -- *extend=dist* **|** *extend=(dist=val, unit="k", modifiers...)*\
    Extend all segments with a new first and last point such that these points are *dist* away from their neighbor point in the direction implied by the two points at each end of the segment. For geographic data you may append a unit. To give separate distances for the two ends, give *distf/distl* instead. Available modifiers:
    - **first** or **f** : *first=true* -- Only extend the first point.
    - **last** or **l** : *last=true* -- Only extend the last point.
    
    The mode of geographical calculations depends on **spherical\_dist**.

- **a** or **aspatial** : -- *aspatial=??*\
    Control how aspatial data are handled in GMT during input and output. [More at aspatial]

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt__j}

\textinput{common_opts/opt_o}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt_xy}

## Units

For map distance unit, append unit **d** for arc degree, **m** for arc minute, and **s** for arc second, or **e** for meter [Default unless stated otherwise], **f** for foot, **k** for km, **M** for statute mile, **n** for nautical mile, and **u** for US survey foot. By default we compute such distances using a spherical approximation with great circles (**spherical=:greatcirc**) using the authalic radius (see PROJ\_MEAN\_RADIUS). You can use **spherical=:flat** to perform "Flat Earth" calculations (quicker but less accurate) or **spherical=:ellipsoidal** to perform exact geodesic calculations (slower but more accurate; see PROJ\_GEODESIC for method used).

## Inside/Outside Status

To determine if a point is inside, outside, or exactly on the boundary of a polygon we need to balance the complexity (and execution time) of the algorithm with the type of data and shape of the polygons. For any Cartesian data we use a non-zero winding algorithm, which is quite fast. For geographic data we will also use this algorithm as long as (1) the polygons do not include a geographic pole, and (2) the longitude extent of the polygons is less than 360. If this is the situation we also carefully adjust the test point longitude for any 360 degree offsets, if appropriate. Otherwise, we employ a full spherical ray-shooting method to determine a point's status.

## Examples

To determine the centroid of the remote GSHHH high-resolution polygon for Australia, as well as the land area in km squared, try:

```julia
using GMT
D = gmtspatial("@GSHHS_h_Australia.txt", colinfo=:g, area="k")
```

To turn all lines in the multisegment file lines.txt into closed polygons, run:

```julia
D = gmtspatial("lines.txt", force_polygons=true)
```

To append the polygon ID of every individual point in cloud.txt that is inside the polygons in the file poly.txt and write that ID as the last column per output row, run:

```julia
D = gmtspatial("cloud.txt", in_polyg=(poly="poly.txt", individual=true))
```

To compute the area of all geographic polygons in the multisegment file polygons.txt, run:

```julia
D = gmtspatial("polygons.txt", area=true)
```

Same data, but now orient all polygons to go counter-clockwise and write their areas to the segment headers, run:

```julia
D = gmtspatial("polygons.txt", area=(header=true,), handedness=:p)
```

To determine the areas of all the polygon segments in the file janmayen\_land\_full.txt, add this information to the segment headers, sort the segments from largest to smallest in area but only keep polygons with area larger than 1000 sq. meters, run:

```julia
D = gmtspatial("janmayen_land_full.txt", area=(unit="e", header=true, polygons=true, 
                limits=(1000, Inf), sort=:d), verbose=true)
```

To determine the intersections between the polygons A.txt and B.txt, run:

```julia
D = gmtspatial(["A.txt", "B.txt"], intersections=:e)
```

To truncate polygons A.txt against polygon B.txt, resulting in an open line segment, run:

```julia
D = gmtspatial("A.txt", truncate="B.txt")
```

If you want to plot a polygon with holes (donut polygon) from a multiple segment file which contains both perimeters and holes, it could be necessary first to reorganize the file so it can be plotted with plot. To do this, run:

```julia
D = gmtspatial("file.txt", polygons=:h)
```

## See Also

\myreflink{gmtselect}, \myreflink{gmtsimplify}, \myreflink{mapproject}