# triangulate

```julia
	triangulate(cmd0::String="", arg1=nothing; kwargs...)
```

Delaunay triangulation or Voronoi partitioning and gridding of Cartesian data

Description
-----------

Reads x,y[,z] from file or table and performs Delaunay triangulation, i.e., it finds how the
points should be connected to give the most equilateral triangulation possible. If a map
projection (give **region** and **proj**) is chosen then it is applied before the triangulation
is calculated. By default, the output is triplets of point id numbers that make up each triangle
and is written to standard output. The id numbers refer to the points position (line number,
starting at 0 for the first line) in the input file. As an option, you may choose to create a
multiple segment file that can be send to \myreflink{plot} to draw the triangulation network.
If **region** and **inc** are set a grid will be calculated based on the surface defined by the
planar triangles. The actual algorithm used in the triangulations is either that of Watson [1982]
or Shewchuk [1996] (Default. Type **gmt("gmtget GMT_TRIANGULATE")** to see which method is
selected). This choice is made during the GMT (**not** `GMT.jl`) build step. Furthermore, if
the Shewchuk algorithm is installed then you can also perform the calculation of Voronoi
polygons and optionally grid your data via the natural nearest neighbor algorithm. **Note**:
For geographic data with global or very large extent you should consider \myreflink{sphtriangulate}
instead since **triangulate** is a Cartesian or small-geographic area operator and is unaware
of periodic or polar boundary conditions.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

Optional Arguments
------------------

- **A** or **area** : -- *area=true*\
    Compute the area of the Cartesian triangles and append the areas in the output segment
    headers [no areas calculated]. Requires **triangles** and is not compatible with **voronoi** (GMT >= 6.4).

- **C** or **slope_grid** : -- *slope_grid=slpfile*\
    Read a slope grid (in degrees), either a file or a \myreflink{GMTgrid}, and compute the
    propagated uncertainty in the bathymetry using the CURVE algorithm [Zambo et al, 2016].
    Requires the **outgrid** option to specify the output grid. Note that the **slope_grid**
    sets the domain for the output grid so **region**, **inc**, **registration** are not required.
    Cannot be used in conjunction with **derivatives**, **network**, **ids**, **voronoi**,
    **triangles** and **edges**.

- **D** or **derivatives** : *derivatives=:x|y*\
    Take either the *x*- or *y*-derivatives of surface represented by the planar facets
    (only used when **outgrid** is set).

- **E** or **empty** : -- *empty=??*\
    Set the value assigned to empty nodes when **outgrid** is set [NaN].

- **G** or **save** or **outgrid** or **outfile** : -- *outgrid=[=ID][+ddivisor][+ninvalid][+ooffset|a][+sscale|a][:driver[dataType][+coptions]]*\
    Use triangulation to grid the data onto an even grid. **NOTE:** by specifying the **region** and
    **inc** options this one is automatically selected. Now, if you want to save the result in a grid
    file explicitly use this option and append the name of the output grid file. The interpolation is
    performed in the original coordinates, so if your triangles are close to the poles you are better
    off projecting all data to a local coordinate system before using **triangulate** (this is true
    of all gridding routines) or instead use \myreflink{sphtriangulate}. For natural nearest neighbor
    gridding you must add **voronoi=:pol**. See other modules that also write files, such as
    \myreflink{surface}, to see further options to this.

\textinput{common_opts/opt_I}

\textinput{common_opts/opt_J}

- **L** or **index** : -- *index=indexfile[*+b*]*\
    Give name of file or a \myreflink{GMTdataset} with previously computed Delaunay information.
    Each record must contain triplets of node numbers for a triangle in the input *table*
    [Default computes these using Delaunay triangulation]. If the *indexfile* is binary and can
    be read the same way as the binary input *table* then you can append **+b** to spead up the reading (GMT6.4).

- **M** or **network** : -- *network=true*\
    Output triangulation network as multiple line segments separated by a segment header record.

- **N** or **ids** : -- *ids=true*\
    Used in conjunction with **outgrid** to also write the triplets of the ids of all the Delaunay vertices [Default only writes the grid].

- **Q** or **voronoi** : -- *voronoi=true* **|** *voronoi=:polygon*\
    Output the edges of the Voronoi cells instead [Default is Delaunay triangle edges].
    Requires **region** and is only available if linked with the Shewchuk [1996] library.
    Note that **xyz** is ignored on output. Optionally, use **voronoi=:polygon** (or just `=:pol`)
    for combining the edges into closed Voronoi polygons.

\textinput{common_opts/opt_R}

- **S** or **triangles** : -- *triangles=true*\
    Output triangles as polygon segments separated by a segment header record. Requires Delaunay triangulation.

- **T** or **edges** : -- *edges=true*\
    Output edges or polygons even if gridding has been selected with the **outgrid** option
    [Default will not output the triangulation or Voronoi polygons is gridding is selected].

\textinput{common_opts/opt_V}

- **Z** or **xyz** or **triplets** : -- *xyz=true*\
    Controls whether we read (x,y) or (x,y,z) data and if z should be output when **network**
    or **triangles** are used [Read (x,y) only].

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt__r}  (Only valid with **outgrid**).

\textinput{common_opts/opt_s}

\textinput{common_opts/opt__w}

\textinput{common_opts/opt_xy}

\textinput{common_opts/explain_float}

\textinput{common_opts/explain_inside}

Examples
--------

To triangulate the points in the file samples.xyz, return the triangle
information, and make a grid for the given area and spacing, use

```julia
    D = triangulate("samples.xyz", region=(0,30,0,30), inc=2, save="surf.nc")
```

To draw the optimal Delaunay triangulation network based on the same
file using a 15-cm-wide Mercator map, use

```julia
    D = triangulate("samples.xyz", region=(100,-90,30,34), network=true, proj=:Mercator)
    plot(D, pen=0.5, frame=(annot=1,), show=true)
```

To instead plot the Voronoi cell outlines, try

```julia
    D = triangulate("samples.xyz", region=(100,-90,30,34), network=true, voronoi=true, proj=:Mercator)
    plot(D, pen=0.5, frame=(annot=1,), show=true)
```

To combine the Voronoi outlines into polygons and paint them according to their ID, try

```julia
    D = triangulate("samples.xyz", region=(100,-90,30,34), network=true, voronoi=:polyg, proj=:Mercator)
    plot(D, pen="0.5p+cf", frame=(annot=1,), cmap="colors.cpt", show=true)
```

To grid the data using the natural nearest neighbor algorithm, try

```julia
    G = triangulate("samples.xyz", region=(100,-90,30,34), inc=0.5, voronoi=:polygon)
```

Notes
-----

The uncertainty propagation for bathymetric grids requires both horizontal
and vertical uncertainties and these are weighted given the local slope.
See the *Zambo et al.* [2014] and *Zhou and Liu* [2004] references for more details.


See Also
--------

\myreflink{greenspline},
\myreflink{nearneighbor},
\myreflink{contour},
\myreflink{sphdistance},
\myreflink{sphinterpolate},
\myreflink{sphtriangulate},
\myreflink{surface}

References
----------

Shewchuk, J. R., 1996, Triangle: Engineering a 2D Quality Mesh Generator
and Delaunay Triangulator, First Workshop on Applied Computational
Geometry (Philadelphia, PA), 124-133, ACM, May 1996.

Watson, D. F., 1982, Acord: Automatic contouring of raw data, *Comp. &
Geosci.*, **8**, 97-101.

Zambo, S., Elmore, P. A., Bourgeois, B. S., and Perkins, A. L., 2016,
Uncertainty estimation for sparse data gridding algorithms,
Proceedings of the U.S. Hydro Conference,National Harbor, MD, 16-19 March 2015.

Zhou, Q., and Liu, X., 2004, Error analysis on grid-based slope and aspect
algorithms, *Photogrammetric Eng. & Remote Sensing*, **70** (8), 957-962.

`Shewchuk's Homepage <http://www.cs.cmu.edu/~quake/triangle.html>`_
