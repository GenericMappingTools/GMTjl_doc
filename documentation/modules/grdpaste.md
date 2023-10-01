# grdpaste

```julia
    grdpaste(cmd0::String="", arg1=nothing, arg2=nothing, kwargs...)
```

Join two grids along their common edge

*keywords: GMT, Julia, grid join*


Description
-----------

Combines *ingrid_a* and *ingrid_b* into *outgrid* by pasting them together along their common edge.
Files *ingrid_a* and *ingrid_b* must have the same grid spacings and registration, and must have one
edge in common. If in doubt, check with \myreflink{grdinfo} and use \myreflink{grdcut} and/or
\myreflink{grdsample} if necessary to prepare the edge joint. **Note**: For geographical grids, you may
have to use **colinfo** to handle periodic longitudes unless the input grids are properly recognized
as such via their meta-data. For stitching multiple grids, see \myreflink{grdblend} instead.


Required Arguments
------------------

*ingrid_a* : -- A grid file name or a \myreflink{Grid type}

*ingrid_a* : -- The other of two grids to be pasted together.


Optional Arguments
------------------

\textinput{common_opts/opt_-Grid}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_f}

Examples
--------

Suppose file_a.nc is 150E - 180E and 0 - 30N, and file_b.nc is 150E - 180E, -30S - 0,
then you can make outfile.nc which will be 150 - 180 and -30S - 30N by:

```julia
    G = grdpaste("file_a.nc", "file_b.nc", colinfo=:g);
```

See Also
--------

\myreflink{grdblend},
\myreflink{grdclip},
\myreflink{grdcut},
\myreflink{grdinfo},
\myreflink{grdsample}
