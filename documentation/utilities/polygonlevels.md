# polygonlevels

```julia
zvals = polygonlevels(D::GDtype, ids::Vector{String}, vals::Vector{<:Real}; kw...) -> Vector{Float64}

or

zvals = polygonlevels(D::GDtype, ids::Matrix{String}, vals::Vector{<:Real}; kw...) -> Vector{Float64}
```

Creates a vector with `zvals` to use in `plot` and where length(zvals) == length(D)
The elements of `zvals` are made up from the `vals`.

- `ids`: is a string Vector or Matrix with the ids (attribute names) of the \myreflink{GMTdataset} D.
         If a Matrix (2 columns only) then the `att` bellow must also have the two names (string vector
         with two elements) that will be matched against the two elements of each line of `ids`.
         The idea here is to match two conditions: `att[1] == ids[n,1] && att[2] == ids[n,2]`

- `vals`: is a vector with the numbers to be used in plot `level` to color the polygons.

- `attrib` or `att`: keyword to select which attribute to use when matching with contents of the `ids` strings.

- `nocase` or `insensitive`: a keyword from `kw`. Perform a case insensitive comparision between the contents of
         `ids` and the attribute specified with `attrib`. Default compares as case sensistive.

- `repeat`: keyword to replicate the previously known value until it finds a new segment ID for the case
            when a polygon have no attributes (may happen for the islands in a country).

Returns a Vector{Float64} with the same length as the number of segments in D. Its content are
made up from the contents of `vals` but may be repeated such that each polygon of the same family, i.e.
with the same `ids`, has the same value.

Examples
--------

*Realy need to provide one*

See Also
--------

\myreflink{inwhichpolygon}, \myreflink{getbyattrib}, \myreflink{coast}, \myreflink{plot3}
