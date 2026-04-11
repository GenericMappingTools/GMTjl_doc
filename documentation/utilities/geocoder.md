# geocoder

```julia
D = geocoder(address::String; options=String[])
```

Get the geocoder info for a given address by calling the GDAL/OGR
[geocoding functions](https://gdal.org/doxygen/ogr__geocoding_8h.html).

### Arguments
- `address`: The string to geocode.

- `options`: These are the options passed to GDAL and in the form of a vector of strings. For example,
  the default is equivalent to `options=["SERVICE", "OSM_NOMINATIM"]`.
    - ``"CACHE_FILE"`` : Defaults to ``"ogr_geocode_cache.sqlite"`` (or otherwise ``"ogr_geocode_cache.csv"`` if the
      SQLite driver isn't available). Might be any CSV, SQLite or PostgreSQL datasource.
    - ``"READ_CACHE"`` : ``"TRUE"`` (default) or "FALSE"
    - ``"WRITE_CACHE"`` : ``"TRUE"`` (default) or "FALSE"
    - ``"SERVICE"``: ``"OSM_NOMINATIM"`` (default), ``"MAPQUEST_NOMINATIM"``, ``"YAHOO"``, ``"GEONAMES"``,
        ``"BING"`` or other value.
      Note: ``"YAHOO"`` is no longer available as a free service.
    - ``"EMAIL"``: used by ``"OSM_NOMINATIM"``. Optional, but recommended.
    - ``"USERNAME"``: used by ``"GEONAMES"``. Compulsory in that case.
    - ``"KEY"``: used by BING. Compulsory in that case.
    - ``"APPLICATION"``: used to set the User-Agent MIME header. Defaults to GDAL/OGR version string.
    - ``"LANGUAGE"``: used to set the Accept-Language MIME header. Preferred language order for showing search results.
    - ``"DELAY"``: minimum delay, in second, between 2 consecutive queries. Defaults to 1.0.
    - ``"QUERY_TEMPLATE"``: URL template for GET requests. Must contain one and only one occurrence of %s in it.
      If not specified, for ``["SERVICE", "OSM_NOMINATIM"]``, ``"MAPQUEST_NOMINATIM"``, ``"YAHOO"``, ``"GEONAMES"``
      or ``"BING"``, the URL template is hard-coded.
    - ``"REVERSE_QUERY_TEMPLATE"``: URL template for GET requests for reverse geocoding. Must contain one and only
      one occurrence of {lon} and {lat} in it. If not specified, for ``["SERVICE", "OSM_NOMINATIM"]``,
      ``"MAPQUEST_NOMINATIM"``, ``"YAHOO"``, ``"GEONAMES"`` or ``"BING"``, the URL template is hard-coded.


Returns
-------
A \myreflink{GMTdataset} with the longitude, latitude, and full attribute dictionary returned by the geocoder for
the input address. This dataset contains only one point but geocoding service resturns also a BoundingBox
containing that point. When the `address` is very specific that BB is tiny arround the point, but when the
query is general (for example,just the name of a city or even a country), the BB is large and may be very
useful to use in the `mosaic` program. For that purpose, the returned BB is sored in the \myreflink{GMTdatset}
``ds_bbox`` field.

Examples
--------

```julia
    geocoder("Paris, France")
```

See Also
--------

\myreflink{mosaic}
