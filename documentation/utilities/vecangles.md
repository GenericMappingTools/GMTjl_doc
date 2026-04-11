# vecangles

```
angles, ind = vecangles(lonlat0::VecOrMat{Real}, lonlat1::Matrix{Real}; proj::String="",
                        s_srs::String="", epsg::Integer=0, sorted=true)
```

Computes the angles between lines taken from the central point `lonlat0` and those passed in the Mx2 matrix `lonlat1`. 

Args:

* `lonlat1`:  - coordinates of point 1 in the given projection (or a matrix with several points).
* `lonlat2`:  - coordinates of point 2 in the given projection (or a matrix with same size as `lonlat1`).
* `proj` or `s_srs`:  - the given projection whose ellipsoid we move along. Can be a proj4 string or an WKT.
* `epsg`:     - Alternative way of specifying the projection [Default is WGS84].
* `sorted`:   - By default we sort the lines azimuth so that the angles refer to contiguous line.
  If `sorted` is set to `false` we compute the angles in the order of points as given in `lonlat2`.

### Returns

* `angles` - A Float64 vector with the angles between center and points determined by the arguments plus the
  angle betwen the lines from center to first and from center to last point.
* `ind` - A vector of Int with the order obtained by sorting the lines azimuths (when `sorted=true`).
  Apply it to `lonlat2[ind,:]` to get the point distribution order in the same way as `angles`.
  Neddless, ofc, if `sorted=false`.
