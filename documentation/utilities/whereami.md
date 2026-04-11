# whereami

```julia
D = whereami() -> GMTdataset
```

Shows your current location plus some additional information (Timezone, Country, City, Zip, IP address).

Examples
--------

```julia
julia> whereami()
Attribute table
┌───────────┬───────────────┬───────────────┬──────────┬──────────┬────────┐
│      City │      Timezone │            IP │      Zip │  Country │ Region │
├───────────┼───────────────┼───────────────┼──────────┼──────────┼────────┤
│ Quarteira │ Europe/Lisbon │ 95.92.214.205 │ 8125-168 │ Portugal │   Faro │
└───────────┴───────────────┴───────────────┴──────────┴──────────┴────────┘
BoundingBox: [-8.1026, -8.1026, 37.0658, 37.0658]

1×2 GMTdataset{Float64, 2}
 Row │     Lon      Lat
─────┼──────────────────
   1 │ -8.1026  37.0658
```
