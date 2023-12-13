# getbyattrib

```julia
getbyattrib(D::Vector{<:GMTdataset}[, index::Bool=false]; kw...)

or

filter(D::Vector{<:GMTdataset}; kw...)

or

findall(D::Vector{<:GMTdataset}; kw...)
```

*keywords: GMT, Julia, spatial filter*

Take a \myreflink{GMTdataset} vector and return only its elements that match the condition(s) set by the `kw` keywords.
Note, this assumes that `D` has its `attrib` fields set with usable information.

NOTE: Instead of ``getbyattrib`` one can use instead ``filter`` (..., `index=false`) or ``findall`` (..., `index=true`)

- `attrib name(s)=value(s)`: Easier to explain by examples: `NAME="Antioquia"`, select all elements that have
  that attribute/value combination. `NAME=("Antioquia", "Caldas")`, picks elements that have those `NAME` attributes.
  Add as many as wished. If using two `kwargs` the second works as a condition. ``(..., NAME=("Antioquia", "Caldas"), feature_id=0)``
  means select all elements from ``Antioquia`` and ``Caldas`` that have the attribute `feature_id` = 0.

- `attrib` or `att`: (OLD SYNTAX) A NamedTuple with the attribname, attribvalue as in `att=(NAME_2="value",)`.
  Use more elements if wishing to do a composite match. E.g. `att=(NAME_1="val1", NAME_2="val2")` in which
  case only segments matching the two conditions are returned.

- `index`: Use this `positional` argument = `true` to return only the segment indices that match the `att` condition(s).

Returns
-------

Either a vector of \myreflink{GMTdataset}, or a vector of Int with the indices of the segments that match th
query condition. Or `nothing` if the query results in an empty GMTdataset 

Examples
--------

```julia
D = filter(D, NAME_2="Porto");
```

See Also
--------

\myreflink{inwhichpolygon}, \myreflink{polygonlevels}