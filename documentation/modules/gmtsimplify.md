# gmtsimplify

```julia
	gmtsimplify(cmd0::String="", arg1=nothing; kwargs...)
```

Line reduction using the Douglas-Peucker algorithm

Description
-----------

**simplify** reads one or more data files and apply the Douglas-Peucker line simplification algorithm.
The method recursively subdivides a polygon until a run of points can be replaced by a straight line
segment, with no point in that run deviating from the straight line by more than the tolerance.
Have a look at this site to get a visual insight on how the algorithm works
(https://en.wikipedia.org/wiki/Ramer–Douglas–Peucker_algorithm)

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

**-T** or **tol** or **tolerance** : -- *tolerance=tol*\
    Specifies the maximum mismatch tolerance in the user units. If the data are not Cartesian then
    append a suitable distance unit (see \myreflink{Units}).

Optional Arguments
------------------

\textinput{common_opts/opt_V}

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

\textinput{common_opts/opt_xy}

\textinput{common_opts/opt__distunits}

Examples
--------

To reduce the remote high-resolution GSHHG polygon for Australia down to
a tolerance of 500 km, use:

\begin{examplefig}{}
```julia
using GMT
D = gmtsimplify("@GSHHS_h_Australia.txt", tolerance="100k")
plot("@GSHHS_h_Australia.txt", plot=(data=D, lc=:red), show=true)
```
\end{examplefig}

To reduce the Cartesian lines xylines.txt using a tolerance of 0.45 and
write the reduced lines to file new_xylines.txt, run:

```julia
    D = gmtsimplify("xylines.txt", tol=0.45)
```

Notes
-----

There is a slight difference in how **simplify** processes lines versus closed polygons.
Segments that are explicitly closed will be considered polygons, otherwise we treat them
as line segments.  Hence, segments recognized as polygons may reduce to a 3-point polygon
with no area; these are suppressed from the output.

Bugs
----

One known issue with the Douglas-Peucker has to do with crossovers. Specifically, it cannot
be guaranteed that the reduced line does not cross itself. Depending on how many lines you
are considering it is also possible that reduced lines may intersect other reduced lines.
Finally, the current implementation only does Flat Earth calculations even if you specify
spherical; **simplify** will issue a warning and reset the calculation mode to Flat Earth.

References
----------

Douglas, D. H., and T. K. Peucker, Algorithms for the reduction of the
number of points required to represent a digitized line of its
caricature, *Can. Cartogr.*, **10**, 112-122, 1973.

This implementation of the algorithm has been kindly provided by Dr.
Gary J. Robinson, Department of Meteorology, University of Reading, Reading, UK;
his subroutine forms the basis for this program.

See Also
--------

\myreflink{gmtconnect},
\myreflink{gmtconvert},
\myreflink{gmtselect}
