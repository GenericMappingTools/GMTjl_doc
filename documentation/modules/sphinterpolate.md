# sphinterpolate

```julia
	sphinterpolate(cmd0::String="", arg1=nothing, kwargs...)
```

*keywords: GMT, Julia, spherical grid interpolation*

Spherical gridding in tension of data on a sphere.

Description
-----------

Reads *lon, lat, z* from file or table and performs a Delaunay triangulation to set up a
spherical interpolation in tension. The final grid is saved to the specified file.
Several options may be used to affect the outcome, such as choosing local versus global
gradient estimation or optimize the tension selection to satisfy one of four criteria.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

\textinput{common_opts/opt_I}

\textinput{common_opts/opt_R}

Optional Arguments
------------------

- **D** or **skipdup** : *skipdup=true* **|** *skipdup=:east*\
    Skip duplicate points since the spherical gridding algorithm cannot handle them.
    [Default assumes there are no duplicates, except possibly at the poles].
    Append a repeating longitude (*east*) to skip records with that longitude instead
    of the full (slow) search for duplicates.

- **Q** or **tension** : -- *tension=mode*\
    Specify one of four ways to calculate tension factors to preserve
    local shape properties or satisfy arc constraints [Default is no tension]. Use:
    - **tension=:p** for piecewise linear interpolation; no tension is applied.
    - **tension=:l** for local Smooth interpolation with local gradient estimates.
    - **tension=:g** for global Smooth interpolation with global gradient estimates. You may
      optionally append *N/M/U* (*e.g. (invented)* **tension="g1/2/3**), where *N* is the number
      of iterations used to converge at solutions for gradients when variable tensions are
      selected (e.g., **var_tension** only) [3], *M* is the number of Gauss-Seidel iterations used
      when determining the global gradients [10], and *U* is the maximum change in a gradient at
      the last iteration [0.01].
    - **tension=:s** for smoothing. Optionally append *E/U/N* [/0/0/3], where *E* is Expected
      squared error in a typical (scaled) data value, and *U* is Upper bound on weighted sum
      of squares of deviations from data. Here, *N* is the number of iterations used to converge
      at solutions for gradients when variable tensions are selected (e.g., **var_tension** only) [3]

\textinput{common_opts/opt_-Grid}

- **T** or **var_tension** : *var_tension=true*\
    Use variable tension.

\textinput{common_opts/opt_V}

- **Z** or **scale** : -- *scale=true*\
    Before interpolation, scale data by the maximum data range [no scaling].

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt__r}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt_xy}

Examples
--------

To interpolate data from the remote file mars370d.txt using the piecewise
method for a 1x1 global grid, then plot it, try:

\begin{examplefig}{}
```julia
using GMT
G = sphinterpolate("@mars370d.txt", region=:global, inc=1, tension=:p)
imshow(G, proj=:guess, shade=true)
```
\end{examplefig}

To interpolate the points in the file testdata.txt on a global 1x1
degree grid with no tension, use:

```julia
    G = sphinterpolate("testdata.txt", region=:global, inc=1)
```

Notes
-----

The STRIPACK algorithm and implementation expect that there are no duplicate points
in the input.  It is best that the user ensures that this is the case.  GMT has tools,
such as \myreflink{blockmean} and others, to combine close points into single entries.
Also, **sphinterpolate** has a **skipdup** option to determine and exclude duplicates, but
it is a very brute-force yet exact comparison that is very slow for large data sets.
A much quicker check involves appending a specific repeating longitude value.
Detection of duplicates in the STRIPACK library will exit the module.

See Also
--------

\myreflink{greenspline},
\myreflink{nearneighbor},
\myreflink{sphdistance},
\myreflink{sphtriangulate},
\myreflink{surface},
\myreflink{triangulate}

References
----------

Renka, R, J., 1997, Algorithm 772: STRIPACK: Delaunay Triangulation and
Voronoi Diagram on the Surface of a Sphere, *AMC Trans. Math. Software*,
**23**\ (3), 416-434.

Renka, R, J,, 1997, Algorithm 773: SSRFPACK: Interpolation of scattered
data on the Surface of a Sphere with a surface under tension, *AMC
Trans. Math. Software*, **23**\ (3), 435-442.
