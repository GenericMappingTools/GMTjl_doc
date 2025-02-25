# gadm

```julia
gadm(country, subregions...; children=false, names=false, children_raw=false, reportlevels=false)
```

Returns a \myreflink{GMTdataset} for the requested country, or country subregion(s)

- `country`: ISO 3166 Alpha 3 country code.

- `subregions`: Full official names in hierarchial order (provinces, districts, etc...).
   To know the names of all administrative children of parent, use the option `names`.

- `children`: When true, function returns all subregions of parent.

- `children_raw`: When true, function returns two variables -> parent, children, where children is a GDAL
  object E.g. when children is set to true and when querying just the country, second return parameter are
  the states/provinces. If `children` we return a Vector of GMTdataset with the polygons. If `children_raw`
  the second output is a GDAL object much like in [GADM](https://github.com/JuliaGeo/GADM.jl) (less the Tables.jl)

- `names`: Return a string vector with all `children` names. 

- `reportlevels`: just report the number of administrative levels (including the country) and exit.

Credits
-------

Addapted from the original [GADM](https://github.com/JuliaGeo/GADM.jl) (MIT Licensed)
and stripped from all of it's dependencies (ArchGDAL repaced by the GMT GDAL functions).
Expanded to also return all subregions of a particular administrative entity.

Examples
--------

```julia
# data of India's borders
data = gadm("IND")

# uttar -> the limits of the Uttar Pradesh state
uttar = gadm("IND", "Uttar Pradesh")

# uttar -> limits of all districts of the  Uttar Pradesh state
uttar = gadm("IND", "Uttar Pradesh", children=true)

# Names of all states of India
gadm("IND", names=true)
```
