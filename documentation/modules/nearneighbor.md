# nearneighbor

```julia
    nearneighbor(cmd0::String="", arg1=nothing; kwargs...)
```

*keywords: GMT, Julia, grid interpolation, nearest neighbor*

Grid table data using a "Nearest neighbor" algorithm

Description
-----------

Reads randomly-spaced (*x,y,z*[,*w*]) triples [quadruplets] from file or table 
and uses a nearest neighbor algorithm to assign a weighted average value to each node that
has one or more data points within a search radius (*R*) centered on the
node with adequate coverage across a subset of the chosen sectors. The
node value is computed as a weighted mean of the nearest point from each
sector inside the search radius. The weighting function and the averaging
used is given by

$$ w(r_i) = \frac{w_i}{1 + d(r_i) ^ 2}, \quad d(r) = \frac {3r}{R}, \quad \bar{z} = \frac{\sum_i^n w(r_i) z_i}{\sum_i^n w(r_i)} $$

where *n* is the number of data points that satisfy the selection criteria and
$r_i$ is the distance from the node to the *i*'th data point. If no data
weights are supplied then $w_i = 1$.

\begin{examplefig}{}
```julia
using GMT

plot([0.75 1.25], region=(0,2,0,2), figscale=4, marker=:circ, ms=5, pen=:thick, fill="lightgreen@70", frame=(grid=0.25,))
d = [0.04 1.8; 0.3 0.3; 0.31 0.7; 0.65 1.88; 0.9 0.44; 0.88 0.2; 1.3 0.8; 1.72 1.1; 1.33 1.59; 1.8 1.9; 1.82 0.5; 1.6 1.3;
# inside but not close enough
0.5	0.9; 0.3 1.3; 0.8 1.7; 0.6 1.65]
plot!(d, marker=:circ, ms=0.25, fill=:black)
plot!([0.52 1.52; 0.6 1.2; 1.15 1.3; 1 0.88], marker=:circ, ms=0.25, fill=:red)
d = [0.75 1.25; 0.5 0.9; NaN NaN; 0.75 1.25; 0.52 1.52; NaN NaN; 0.75 1.25; 0.6 1.2; NaN NaN; 0.75 1.25; 1.15 1.3; NaN NaN; 0.75 1.25; 1 0.88]
plot!(d, pen=:thinnest)
plot!([0.25 1.25; 1.25 1.25; NaN NaN; 0.75 0.75; 0.75 1.75], pen=:thicker)
plot!([0.75 1.25; 1.10355 1.60355], pen=(1,:dash))
text!(mat2ds([1 1.4; 1.03 0.93],["R", "r@-i@-"]), font=(16,"Times-Italic"), justify=:BL)
showfig()
```
\end{examplefig}

   Search geometry includes the search radius (R) which limits the points
   considered and the number of sectors (here 4), which restricts how points inside
   the search radius contribute to the value at the node. Only the closest point
   in each sector (red circles) contribute to the weighted estimate.

Required Arguments
------------------

*table*
    3 [or 4, see **weights**] column data from file or \myreflink{GMTdataset} holding (*x,y,z*[,*w*]) data values.
    If no file is specified, **nearneighbor** will read from standard input.

\textinput{common_opts/opt_-Grid}

\textinput{common_opts/opt_I}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

- **S** or **search_radius** : -- *search_radius=rad*\
    Sets the *search_radius* that determines which data points are considered
    close to a node. Append the distance unit (see \myreflink{Units}).

Optional Arguments
------------------

- **E** or **empty** : -- *empty=??*\
    Set the value assigned to empty nodes [NaN].

\textinput{common_opts/opt_V}

- **N** or **sectors** or **nn** or **nearest** : -- *sectors=n_sectors* **|** *sectors=(n=n\_sectors, min\_sectors=n_min)*\
    The circular search area centered on each node is divided into *n_sectors* sectors.
    Average values will only be computed if there is *at least* one value inside each of
    at least *n_min* of the sectors for a given node. Nodes that fail this test are assigned
    the value NaN (but see **empty**). If **min_sectors** is omitted then *n_min* is set
    to be at least 50% of *n_sectors* (i.e., rounded up to next integer) [Default is a quadrant
    search with 100% coverage, i.e., *n_sectors* = *n_min* = 4]. Note that only the nearest
    value per sector enters into the averaging; the more distant points are ignored. Alternatively,
    use **sectors:nn** or **sectors=:nearest** to call GDALʻs nearest neighbor algorithm instead.

- **W** or **weights** : -- *weights=true*\
    Input data have a 4th column containing observation point weights. These are multiplied
    with the geometrical weight factor to determine the actual weights used in the calculations.

\textinput{common_opts/opt_a}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_n}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt__r}

\textinput{common_opts/opt__w}

\textinput{common_opts/opt_xy}

\textinput{common_opts/opt__distunits}

Examples
--------

To grid the data in the remote file @ship_15.txt at 5x5 arc minutes using a search radius of
15 arch minutes, and plot the resulting grid using default projection and colors, do

\begin{examplefig}{}
```julia
using GMT
G = nearneighbor("@ship_15.txt", region=(245,255,20,30), inc="5m", S="15m")
imshow(G)
```
\end{examplefig}

To create a gridded data set from the file seaMARCII_bathy.lon_lat_z
using a 0.5 min grid, a 5 km search radius, using an octant search with
100% sector coverage, and set empty nodes to -9999:

```julia
    G = nearneighbor("seaMARCII_bathy.lon_lat_z", region=(242,244,-22,-20), inc="0.5m",
                     empty=-9999, search_radius="5k", sectors=(n=8, min_sectors=8))
```

To make a global grid file from the data in geoid.xyz using a 1 degree grid, a 200 km search radius,
spherical distances, using an quadrant search, and set nodes to NaN only when fewer than two quadrants
contain at least one value:

```julia
    G = nearneighbor("geoid.xyz", region=(0,360,-90,90), inc=1, -Lg search_radius="200k", sectors=4)
```

See Also
--------

\myreflink{blockmean},
\myreflink{blockmedian},
\myreflink{blockmode},
\myreflink{greenspline},
\myreflink{sphtriangulate},
\myreflink{surface},
\myreflink{triangulate}
