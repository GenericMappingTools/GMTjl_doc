# fitcircle

```julia
	fitcircle(cmd0::String="", arg1=nothing, kwargs...)
```

Find mean position and great [or small] circle fit to points on sphere

Description
-----------

Reads lon,lat [or lat,lon] values from the first two columns. These are converted to Cartesian
three-vectors on the unit sphere. Then two locations are found: the mean of the input positions,
and the pole to the great circle which best fits the input positions. The user may choose one or
both of two possible solutions to this problem. The first is called `L1` (*i.e.* **norm=1**)
and the second is called `L2` (*i.e.* **norm=2**). When the data are closely grouped along a
great circle both solutions are similar. If the data have large dispersion, the pole to the great
circle will be less well determined than the mean. Compare both solutions as a qualitative check.

The `L1` solution is so called because it approximates the minimization of the sum of absolute
values of cosines of angular distances. This solution finds the mean position as the Fisher average
of the data, and the pole position as the Fisher average of the cross-products between the mean and
the data. Averaging cross-products gives weight to points in proportion to their distance from the mean,
analogous to the "leverage" of distant points in linear regression in the plane.

The `L2` solution is so called because it approximates the minimization of the sum of squares of
cosines of angular distances. It creates a 3 by 3 matrix of sums of squares of components of the
data vectors. The eigenvectors of this matrix give the mean and pole locations. This method may be
more subject to roundoff errors when there are thousands of data. The pole is given by the eigenvector
corresponding to the smallest eigenvalue; it is the least-well represented factor in the data and is
not easily estimated by either method.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

- **L** or **norm** : -- *norm=1* **|** *norm=2* **|** *norm=3*\
    Specify the desired *norm* as 1 or 2, or use or **norm=3** to see both solutions.

Optional Arguments
------------------

- **F** or **coord** or **coordinates** : -- *coord=flags*\
    Traditionally, **fitcircle** will write its results in the form of a text report, with
    the values intermingled with report sentences. Use **coord** to only return data
    coordinates, and append *flags* to specify which coordinates you would like. You
    can choose one or more items from **f**lat Earth mean location, **m**ean location,
    **n**orth pole of great circle, **s**outh pole of great circle, and
    **c**ircle (pole of small circle and its colatitude, which requires **small_circle**).

- **S** or **small_circle** : -- *small_circle=true* **|** *small_circle=lat*\
    Attempt to fit a small circle instead of a great circle. The pole will be constrained to lie
    on the great circle connecting the pole of the best-fit great circle and the mean location of
    the data. Optionally append the desired fixed **lat**itude of the small circle [Default will
    determine the optimal latitude].

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_a}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_o}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_xy}


Examples
--------

To find the parameters of a great circle that most closely fits the (lon,lat) points
in the remote file *@sat_03.txt* (hosted in a GMT server) in a least-squares sense, try

```julia
    fitcircle("@sat_03.txt", norm=2, coord=:mean)
```

Suppose you have lon,lat,grav data along a twisty ship track in the file
ship.xyg. You want to project this data onto a great circle and resample
it in distance, in order to filter it or check its spectrum. Do the following:

```julia
    Df = fitcircle("ship.xyg", norm=2)
    D1 = project("ship.xyg", origin=(ox,oy), pole=(px,py), sort=true, outvars=:pz);
    D2 = sample1d(D1, S=-100, I=1);
```

Here, *ox,oy* is the lon/lat of the mean from **fitcircle**, and *px,py* is the lon/lat
of the pole. The output has distance, gravity data sampled every 1 km along the
great circle which best fits ship.xyg

If you have lon, lat points in the file data.txt and wish to return the northern
hemisphere great circle pole location using the `L2` norm, try

```julia
    D = fitcircle("data.txt", norm=2, coordinates=:north)
```


See Also
--------

\myreflink{gmtvector},
\myreflink{project},
\myreflink{mapproject},
\myreflink{sample1d}
