# regiongeog

```
regiongeog(GI) --> Tuple{Float64}
```

Returns a tuple with (lon*min, lon*max, lat*min, lat*max) of the projected `GI` object limits converted
to geographic coordinates. Returns an empty tuple if `GI` has no registered referencing system.
`GI` can either a `GMTgrid`, a `GMTimage` or a file name (String) of one those types.
