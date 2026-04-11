# getbyattrib

```julia
getbyattrib(D::Vector{<:GMTdataset}[, index::Bool=false]; kw...)

or

filter(D::Vector{<:GMTdataset}; kw...)

or

findall(D::Vector{<:GMTdataset}; kw...)
```

Take a \myreflink{GMTdataset} vector and return only its elements that match the condition(s) set by the `kw` keywords.
Note, this assumes that `D` has its `attrib` fields set with usable information.

NOTE: Instead of ``getbyattrib`` one can use instead ``filter`` (..., `index=false`) or ``findall`` (..., `index=true`)

- `attrib name(s)=value(s)`: Easier to explain by examples: `NAME="Antioquia"`, select all elements that have
  that attribute/value combination. `NAME=("Antioquia", "Caldas")`, picks elements that have those `NAME` attributes.
  Add as many as wished. If using two `kwargs` the second works as a condition. ``(..., NAME=("Antioquia", "Caldas"), feature_id=0)``
  means select all elements from ``Antioquia`` and ``Caldas`` that have the attribute `feature_id` = 0.

  A second set of attributes can be used to select elements by region, number of polygon vertices and area.
  For that, name the keyword with a leading underscore, e.g. `_region`, `_nps`, `_area`, `_unique`. Their values are
  passed respectively a 4 elements tuple and numbers. _E.g._ `_region=(-8.0, -7.0, 37.0, 38.0)`, `_nps=100`, `_area=10`,
  `_aspect=0.5`. Areas are in square km when input is in geographic coordinates, otherwise square data units.
  The aspect ratio passed to the `_aspect` option is width/height of the bounding box, not of the polygon itself.
  Values <= 1, == 1 and >= 1 select polygons with aspect ratios less than, equal to and greater than the specified value.
  The `_unique` case is a bit special and is meant to be used when more than one polygon share the same attribute
  value (e.g. countries with islands).  In that case, set the value of `_unique` to the name of the attribute that
  is shared by the polygons (e.g. `_unique="NAME"`).  By default (e.g. `_unique=true`), the attribute name is `Feature_ID`
  which is the one used by GMT when creating unique IDs for polygons read from OGR formats (.shp, .geojson, etc).
  If this attrib name is not found, we search for `CODE` which is
  the one assigned by GMT when extracting polygons from the internal GMT coasts database. If none of these is found,
  it is users responsibility to provide a valid attribute name. The uniqueness is determined by selecting the polygon
  with the largest area.

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

```julia
D = filter(D, _region="(-8.0, -7.0, 37.0, 38.0)", _nps=100);
```

See Also
--------

\myreflink{inwhichpolygon}, \myreflink{polygonlevels}