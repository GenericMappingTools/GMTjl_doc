# meteostat

```julia
D = meteostat()
```

Download the Meteostat stations list and return it as a GMTdataset.

---

```julia
[D =] meteostat(lon::Real, lat::Real, [granularity::Dates.Period,] [startdate::Date,] [enddate::Date,] verbose::Bool=true)
```

Retrieve weather data, obtained from the [Meteostat](https://meteostat.net/en/), for the
station that is closest to the given coordinates.


### Args
- `lon`: Longitude of the location.

- `lat`: Latitude of the location.

- `granularity`: The granularity of the data. It can be either `Day` or `Hour` (from the `Dates` module),
   where `Day` means one value per day and `Hour` means one value per hour. `Day` is the default.

- `startdate`: The start date of the data to extract. If not provided, it defaults to the first day of the
   current year for `Hour` granularity or an old year (1900), such that the entire time series is downloaded,
   for `Day` granularity.

- `enddate`: The end date of the data to extract. If not provided, it defaults to today.

- `verbose`: If `true`, print download/load file information.

The files are downloaded from the Meteostat endpoint and saved in a cache folder in the _tmp_ directory. Later
reuse reads from the cache folder when files are not older than a day to ensure that the most updated data is used. 

### Returns
A \myreflink{GMTdataset} with the data from the closest station to the given coordinates.

### Example

Download data from the stations that are closest to the given coordinates.

\begin{examplefig}{}
```julia
using GMT
D = meteostat(-8.0, 37.0, Date(2023), Date(2024))
viz(D)
```
\end{examplefig}

---
```julia
D = meteostat(ID::String, [granularity::Dates.Period,] [startdate::Date,] [enddate::Date,] verbose::Bool=true) -> GMTdataset
```

Same as above but using a station ID or Name instead of a location specified by coordinates. `ID` can be the
5 characters station ID or a part of the station Name (see the `meteostat()` function). The second form is less
reliable since partial names (case sensitive) may match multiple stations.

### Example

Plot 2018 temperature data for Vancouver, BC.

\begin{examplefig}{}
```julia
using GMT
D = meteostat("Vancouver", Date(2018,1,1), Date(2018,12,31));
viz(D, title="Temperature in Vancouver, BC")
```
\end{examplefig}


See Also
--------

\myreflink{weather}, \myreflink{ecmwf}
