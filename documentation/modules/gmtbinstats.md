# gmtbinstats

```julia
gmtbinstats(cmd0::String="", arg1=nothing; kwargs...)
```

*keywords: GMT, Julia, hexagonal statistics*

Bin spatial data and determine statistics per bin.

Description
-----------

Reads arbitrarily located (x,y[,z][,w]) points (2-4 columns) and for each node in the specified grid
layout determines which points are within the given radius. These point are then used in the calculation
of the specified statistic. The results may be presented as is or may be normalized by the circle area
to perhaps give density estimates. Alternatively, select hexagonal tiling instead or a rectangular grid layout.

Required Arguments
------------------

- *table* : -- Either as a string with the filename in arg ``cmd0`` or as Matrix or GMTdataset in ``arg1``\
    A 2-4 column matrix holding (x,y[,z][,w]) data values. You must use `weights`
    to indicate that you have weights. Only **-Cn** will accept 2 columns only.


\textinput{common_opts/opt_I}

\textinput{common_opts/opt_R}


Optional Arguments
------------------

- **C** or **stats** or **statistic** : -- *stats=...*\
   Choose the statistic that will be computed per node based on the points that are within *radius* distance
   of the node. Select one of:

   - average or mean        # mean (average)
   - mad                    # median absolute deviation
   - range                  # full (max-min) range
   - iq or interquartil     # 25-75% interquartile range
   - min or minimum         # minimum (low)
   - min_pos or minimum_pos # minimum of positive values only
   - median                 # median
   - number or count        # number of values
   - LMS                    # LMS scale
   - mode                   # mode (maximum likelihood)
   - quantil[val]           # selected quantile (append desired quantile in 0-100% range [50], *e.g.* "quantil25")
   - rms                    # the r.m.s.
   - std                    # standard deviation
   - max or maximum         # maximum (upper)
   - max_neg or maximum_neg # maximum of negative values only
   - sum                    # the sum

- **nbins** : -- *nbins=n*\
    Set the number of hexagonal cells along the horizontal direction. Grid increment (`inc`) is computed
    x-data range and this number of cells. Default, when figure size is known, uses a simple heuristic to st increment.

- **threshold** : -- *threshold=xx*\
    Rows with computed stats lower then `threshold` are removed. Note that this option is not to be used
    when computing grids (will be ignored).

- **E** or **empty** : -- *empty=-9999*
    Set the value assigned to empty nodes. By default we use NaN.

- **N** or **normalize** : -- *normalize=true*\
    Normalize the resulting grid values by the area represented by the `search_radius` [no normalization].

- **S** or **search_radius** : -- *search_radius=rad*\
    Sets the `search radius` that determines which data points are considered close to a node.
    Append the distance unit if wished. Not compatible with **tiling**.

- **T** or **tiling** or **bins** : -- *tiling=rectangular* or *tiling=hexagonal*\
    Instead of circular, possibly overlapping areas, select non-overlapping tiling. Choose between `tiling=rectangular`
    or `tiling=hexagonal` binning. For `rectangular`, set bin sizes via **spacing** and we write the computed statistics
    to the grid file. For `tiling=hexagonal`, we write a table with the centers of the hexagons and the computed statistics.
    Here, the **spacing** setting is expected to set the ``y`` increment only and we compute the *x*-increment given the
    geometry. Because the horizontal spacing between hexagon centers in *x* and *y* have a ratio of ``sqrt(3)``, we will
    automatically adjust *xmax* in **region** to fit a whole number of hexagons. **Note**: Hexagonal tiling requires
    Cartesian data.

- **W** or **weights** : -- *weights=true* or *weights="+s"*\
   Input data have an extra column containing observation point weight. If weights are given then weighted
   statistical quantities will be computed while the count will be the sum of the weights instead of number
   of points. If your weights are actually uncertainties (one sigma) then use `weights="+s"` and we compute
   weight = 1/sigma.

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_a}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt__r}

\textinput{common_opts/opt__w}

\textinput{common_opts/opt_xy}


Examples
--------

To examine the population inside a circle of 1000 km radius for all nodes in a 5x5 arc degree grid,
using the remote file @capitals.gmt, and plot the resulting grid using default projection and colors, try

```julia
G = gmtbinstats("@capitals.gmt", a="2=population", region=:global360, inc=5, stats=:sum, search_radius="1000k");
imshow(G)
```

Make a hexbin plot with random numbers.

```julia
xy = rand(100,2) .* [5 3];
D = binstats(xy, region=(0,5,0,3), inc=1, tiling=:hex, stats=:number);
imshow(D, hexbin=true, ml=0.5, colorbar=true)
```