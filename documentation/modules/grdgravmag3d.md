# grdgravmag3d

```julia
grdgravmag3d(cmd0::String="", arg1=nothing, kwargs...)
```

*keywords: GMT, Julia, gravity, magnetism*

Description
-----------

Compute the gravity or magnetic anomaly of a body described by one or (optionally) two grids.
The output can either be along a given set of xy locations or on a grid. This method is not
particularly fast but allows computing the anomaly of arbitrarily complex shapes.

Required Arguments
------------------

*grd_top* (and optionally *grd_bot*). Grid(s) whose gravity/mag effect is going to be computed.
If two grids are provided then the gravity/magnetic effect of the volume between them is computed.

