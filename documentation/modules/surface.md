# surface

```julia
    surface(cmd0::String="", arg1=nothing; kwargs...)
```

*keywords: GMT, Julia, grid interpolation, minimum curvature*

Description
-----------

Reads randomly-spaced (x,y,z) triples from file or table and produces a binary file of
gridded values z(x,y) by solving the differential equation (away from data points)

    $$ (1 - t) \nabla ^2(z) + t \nabla (z) = 0 $$

where *t* is a tension factor between 0 and 1, and $\nabla$ indicates the
Laplacian operator. Here, *t* = 0 gives the "minimum curvature" solution.
Minimum curvature can cause undesired oscillations and false local maxima or minima
(See Smith and Wessel, 1990), and you may wish to use *t* > 0 to suppress these
effects. Experience suggests *t* ~ 0.25 usually looks good for potential
field data and *t* should be larger (*t* ~ 0.35) for steep topography data.
*t* = 1 gives a harmonic surface (no maxima or minima are possible except
at control data points). It is recommended that the user preprocess the
data with \myreflink{blockmean}, \myreflink{blockmedian}, or \myreflink{blockmode} to avoid
spatial aliasing and eliminate redundant data. You may impose lower
and/or upper bounds on the solution. These may be entered in the form of
a fixed value, a grid with values, or simply be the minimum/maximum
input data values. Natural boundary conditions are applied at the edges,
except for geographic data with 360-degree range where we apply periodic
boundary conditions in the longitude direction.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

\textinput{common_opts/opt_I}

Optional Arguments
------------------

- **A** or **aspect_ratio** : -- *aspect_ratio=ar* **|** *aspect_ratio=:m*\
    Aspect ratio. If desired, grid anisotropy can be added to the equations. Enter *ar*,
    where *dy = dx / ar* relates the grid dimensions. For geographic data, you may use
    **aspect_ratio=:m** to set the aspect ratio to the cosine of the mean latitude
    [Default = 1 assumes isotropic grid.]

- **C** or **convergence** : -- *convergence=clim* **|** *convergence="clim%"*\
    Convergence limit. Iteration is assumed to have converged when the maximum absolute change
    in any grid value is less than *clim*. (Units same as data z units). Alternatively, give
    limit in percentage of rms deviation by appending %. [Default is scaled to $10^{-4}$ of
    the root-mean-square deviation of the data from a best-fit (least-squares) plane.].
    This is the final convergence limit at the desired grid spacing; for intermediate
    (coarser) grids the effective convergence limit is divided by the grid spacing multiplier.

\textinput{common_opts/opt_J}
    Select the data map projection. This projection is only used to add a referencing info
    to the grid formats that support it. E.g., netCDF, GeoTIFF, and others supported by GDAL.

- **D** or **breakline** : -- *breakline="bfile"* **|** *breakline="bfile+z[level]"*\
    Use *x, y, z* data in the *bfile* file (or a GMTdataset) as a `soft breakline`. A `soft breakline`
    is a line whose vertices will be used to constrain the nearest grid nodes without
    any further interpolation. A coastline or a lake shore are good examples of
    `soft breaklines`. Multi-segments files are accepted. If your lines do not have
    *z*-values or you wish to override those with a constant z-value, then append
    **+z**level to the filename. If no value is given then we default to 0.

\textinput{common_opts/opt_-Grid}

- **Ll** or **lower** and **Lu** or **upper** : -- *lower=??* **|** *upper=??*\
    Impose limits on the output solution. **??** in **lower=??** sets the lower bound. It can
    be the name of a grid file with lower bound values, a fixed value, **d** to set to minimum
    input value, or **u** for unconstrained [Default]. *upper* sets the upper bound and can be
    the name of a grid file with upper bound values, a fixed value, **d** to set to maximum
    input value, or **u** for unconstrained [Default]. Grid files used to set the limits may
    contain NaNs. In the presence of NaNs, the limit of a node masked with NaN is unconstrained.
    **Note**: Grids given via **L** must be compatible with the desired output domain and increments.

- **M** or **mask** : -- *mask=max_radius*\
    After solving for the surface, apply a mask so that nodes farther than *max_radius* away from
    a data constraint are set to NaN. Append a distance unit (see \myreflink{Units}) if needed.
    One can also select the nodes to mask by using the **mask="<n_cells>c"** form. Here *n_cells*
    means the number of cells around the node controlled by a data point. As an example **mask="0c"**
    means that only the cell where the point lies is filled, **mask="1c"** keeps one cell beyond that
    (i.e. makes a 3x3 square neighborhood), and so on.

- **N** or **iterations** or **max_iterations** : -- *iterations=n_iter*\
    Number of iterations. Iteration will cease when **convergence** is reached or when number of
    iterations reaches *n_iter*.  This is the final iteration limit at the desired grid spacing;
    for intermediate (coarser) grids the effective iteration limit is scaled by the grid spacing
    multiplier [Default is 500].

- **Q** or **suggest** : -- *suggest=true* **|** *suggest=:r*\
    Suggest grid dimensions which have a highly composite greatest common factor. This allows
    surface to use several intermediate steps in the solution, yielding faster run times and
    better results. The sizes suggested by **suggest** can be achieved by altering **region**
    and/or **inc**. You can recover the **region** and **inc** you want later by using
    \myreflink{grdsample} or \myreflink{grdcut} on the output of **surface**. Alternatively,
    append **r** to have **surface** use the specified **region** setting exactly as given
    in the calculations [Default automatically seeks a slightly larger region if that allows
    for more intermediate steps to ensure the best possible convergence; the region is then
    trimmed back to what was requested in **region** upon output].

- **S** or **search_radius** : -- *search_radius=??* **|** *search_radius="??m|s"*\
    Search radius. Enter *search\_radius* in same units as x,y data; append **m** to indicate
    arc minutes or **s** for arc seconds. This is used to initialize the grid before the first
    iteration; it is not worth the time unless the grid lattice is prime and cannot have
    regional stages. [Default = 0.0 and no search is made.]

- **T** or **tension** : -- *tension=factor* **|** *search_radius="i|b_factor"*\
    Tension factor[s]. These must be between 0 and 1. Tension may be used in the interior solution
    (above equation, where it suppresses spurious oscillations) and in the boundary conditions
    (where it tends to flatten the solution approaching the edges). Using zero for both values
    results in a minimum curvature surface with free edges, i.e., a natural bicubic spline.
    Use **tension=i...**, where *...* is the *tension_factor* to set interior tension, and
    **tension=b...** to set boundary tension. If you do not prepend **i** or **b**, both will
    be set to the same value. [Default = 0 for both gives minimum curvature solution.]

\textinput{common_opts/opt_V}

- **W** or **log** : -- *log=true* **|** *log=logfile*\
    Write convergence information to *logfile* [Default is *surface_log.txt*].

- **Z** or **over_relaxation** : -- *over_relaxation=factor*\
    Over-relaxation factor. This parameter is used to accelerate the convergence; it is a number
    between 1 and 2. A value of 1 iterates the equations exactly, and will always assure stable
    convergence. Larger values overestimate the incremental changes during convergence, and will
    reach a solution more rapidly but may become unstable. If you use a large value for this factor,
    it is a good idea to monitor each iteration with the **verbose=:i** option. [Default = 1.4
    converges quickly and is almost always stable.]

- **preproc** : -- *preproc=true* **|** *preproc="blockmedian|blockmode"*\

    This option means that the data is previously passed through one of `block*` modules to decimate the data
    in each cell as strongly advised. `preproc=true` will use ``blockmean``. To use any of the other two,
    pass its name as value. *e.g.* `preproc="blockmedian"`.

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

\textinput{common_opts/opt__distunits}


Examples
--------

To grid 5 by 5 minute gravity block means from the ASCII data in hawaii_5x5.xyg, using a
*tension_factor* = 0.25, a *convergence_limit* = 0.1 mGal, and monitoring each iteration, try:

```julia
    G = surface("hawaii_5x5.xyg", region=(198,208,18,25), inc="5m", tension=0.25, convergence=0.1)
```

Notes
-----

While the region specified by **region** determines your final output grid, internally we may use
a slightly larger region that will allow for more intermediate grids (i.e., more common factors
between *n_columns - 1* and *n_rows - 1*). This should allow for better convergence in the final solution.

Gridding Geographic Data: Boundary Conditions
---------------------------------------------

The surface finite difference algorithm is Cartesian at heart, hence the *ad hoc*
option to change the aspect ratio for a suitable mean latitude (**aspect_ratio**). When
geographic data are supplied and the output grid has a 360 degree longitude range we will
impose periodic boundary conditions in longitude. However, no equivalent geographic
boundary condition can be applied at the poles since the finite difference solution
will not be valid there (actual spacing between the nodes at the poles is zero).
If you attempt this type of gridding you will be severely warned but the calculations
will continue.  Because the result is a geographic grid, the GMT i/o machinery will
interfere and detect inconsistencies at the pole points and replace all values along
a pole with their mean value. This will introduce further distortion into the
grid near the poles. We recommend you instead consider spherical gridding for global
data sets; see \myreflink{greenspline} (for modest data sets) or \myreflink{sphinterpolate}, or
project your data using a stereographic projection and grid the projected Cartesian data.

Gridding Geographic Data: Setting Increments
--------------------------------------------

Specifying grid increments in distance units (meters, km, etc.) for geographic (lon, lat)
grids triggers a conversion from the given increment to the equivalent increment in degrees.
This is done differently for longitude and latitude and also depends on chosen ellipsoid,
but ultimately is a great-circle approximation. For latitude we divide your *y*-increment
with the number of you chosen unit per degree latitude, while for longitude we divide your
*x*-increment by the number of such units per degree along the mid-parallel in your region. The
resulting degree increments may therefore not exactly match the increments you entered explicitly.
Hence, there may be rounding off in ways you don't want and cannot easily control, resulting in prime grid
dimensions. You can handle the situation via **suggest** but with the never-ending decimals in some
increments that is still a challenge. Another approach is to *not* grid geographic data
using length units as increments, due to the above conversion. It may be cleaner to specify
grid intervals in spherical degrees, minutes or seconds. That way you can control the grid
dimensions directly and avoid the round-off. Alternatively, if your region is far from Equator
and your are concerned about the difference in longitude and latitude increments in degrees
you could project all data to a local projection (e.g., UTM) to yield units of meters, and then
grid the projected data using meters as the final grid increment. Either approach avoids
"ugly" increments like 0.161697s and will let you specify intervals that are easily divisible
into the range. If increment choice is dictated by a need for a desired increment in meters
then the projection route will yield better results.

Bugs
----

**surface** will complain when more than one data point is found for any node and suggest that
you run \myreflink{blockmean}, \myreflink{blockmedian}, or \myreflink{blockmode} first. If you
did run these decimators and still get this message it usually means that your grid spacing is
so small that you need more decimals in the output format used. You may specify more decimal
places by editing the parameter `FORMAT_FLOAT_OUT` in your `gmt.conf` file prior to running the
decimators or choose binary input and/or output using single or double precision storage.

See Also
--------

\myreflink{blockmean},
\myreflink{blockmedian},
\myreflink{blockmode},
\myreflink{grdcut},
\myreflink{grdsample},
\myreflink{greenspline},
\myreflink{nearneighbor},
\myreflink{triangulate},
\myreflink{sphinterpolate}

References
----------

Smith, W. H. F, and P. Wessel, 1990, Gridding with continuous curvature
splines in tension, *Geophysics*, 55, 293-305, https://doi.org/10.1190/1.1442837.

