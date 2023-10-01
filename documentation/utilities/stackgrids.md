# stackgrids

```julia
stackgrids(names::Vector{String}, v=nothing; zcoord=nothing, zdim_name="time",
	       z_unit="", save="", mirone=false)
```

*keywords: GMT, Julia, cube grid stack*

Stack a bunch of single grids in a multiband cube like file.

- `names`: A string vector with the names of the grids to stack

- `v`: A vector with the vertical coordinates. If not provided one with 1:length(names) will be generated.
  - If `v` is a TimeType use the `z_unit` keyword to select what to store in file (case insensitive).
    - `decimalyear` or `yeardecimal` converts the DateTime to decimal years (Floa64)
    - `milliseconds` (or just `mil`) will store the DateTime as milliseconds since 0000-01-01T00:00:00 (Float64)
    - `seconds` stores the DateTime as seconds since 0000-01-01T00:00:00 (Float64)
    - `unix` stores the DateTime as seconds since 1970-01-01T00:00:00 (Float64)
    - `rata` stores the DateTime as days since 0000-12-31T00:00:00 (Float64)
    - `Date` or `DateTime` stores as a string representation of a DateTime.

- `zdim_name`: The name of the vertical axes (default is "time")

- `zcoord`: Keyword same as `v` (may use one or the other).

- `save`: The name of the file to be created.

- `mirone`: Does not create a cube file but instead a file named "automatic_list.txt" (or whaterver `save=xxx`)
   to be used in the Mirone `Empilhador` tool.

Returns
-------

A \myreflink{GMTgrid} cube object, or `nothing` if the `save` option is used.


See Also
--------

\myreflink{cubeplot}, \myreflink{slicecube}, \myreflink{xyzw2cube}
