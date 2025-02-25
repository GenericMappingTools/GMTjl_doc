# inpolygon

```julia
in = inpolygon(x, y, polygon)

or

in = inpolygon(point, polygon)
```

Returns `in` indicating if the query points specified by `x` and `y` are inside of the polygon area defined by:
- `polygon`: a GMTdatset defining the polygon or a Mx2 matrix of reals that should have the
  first and last elements equal.

- `point`: a Mx2 matrix or a two elements vector with the x and y point coordinates. Depending on the number of
  query points in `point`, we return either an ``Int`` or a ``Vector{Int}``.

### Returns:
- in = 1
- on = 0
- out = -1

## Reference

- Hao et al. 2018. [Optimal Reliable Point-in-Polygon Test and Differential Coding Boolean Operations on Polygons]
  (https://www.mdpi.com/2073-8994/10/10/477)


See Also
--------

\myreflink{inwhichpolygon}
