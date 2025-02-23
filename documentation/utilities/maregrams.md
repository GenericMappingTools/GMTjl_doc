# maregrams

```
D = maregrams(list::Bool=false, code="", name="", days::Real=2, starttime::String="", printurl=false)
or

D = maregrams(lon::Real, lat::Real; days=2, starttime::String="")
```

*keywords: GMT, Julia, Plate Kinematics*

Download maregrams data from [www.ioc-sealevelmonitoring.org](http://www.ioc-sealevelmonitoring.org).

The default is to download the last 2 days, but length and duration is configurable by input options.
Since the use of this function requires knowing the station code or name, we provide also the possibility
to use coordinates to find the nearest station. The file with stations data locations and names is stored in
the `TESTSDIR/assets/maregs_online.csv` file, which can be accessed using `d = GMT.read_maregrams()` and its
contents are returned in the `d` dictionary. Note that not all stations sites are always on and running, so
errors when requesting data from some stations are, unfortunately, not so uncommon.

Our reference stations data is a bit old (needs update) and we can find more stations online listed at the
[www.ioc-sealevelmonitoring.org](http://www.ioc-sealevelmonitoring.org) site. If user provides a station code
that we don't know about, but is a valid one, we still return the data for that station. Example:
`D = maregrams(code="tdoj")`

### Args
- `lon, lat`: (Second form) Coordinates of a point that is used to find the closest station to that point.
   This is an alternative way of selecting a station instead of using `code` or `name` that require knowing them.

### Kwargs
- `list::Bool`: If true, returns a GMTdataset with the list all available stations and their codes and coords.

- `code`: Station code (See the output of `list`)

- `name`: In alternative to `code` give the station name (See the output of `list`)

- `days`: Number of days to be downloaded. It can be a decimal number.

- `starttime`: Start time in ISO8601 format (_e.g._ `"2019-01-01T00:00:00"`, or just the date `"2019-01-01"`).

- `printurl`: If true, prints the station's URL. Useful for getting more info about the sation and its data.

### Returns
- `D`: \myreflink{GMTdataset} with the maregrams data.

### Example

Get the time series for 4 days starting at February 1 2025 for the station with code "lgos" (Lagos, Portugal)

\begin{examplefig}{}
```julia
using GMT

D = maregrams(code="lgos", days=4, starttime="2025-02-01");
viz(D, title="Tide Gauge at Lagos (Portugal)")
```
\end{examplefig}
