# era5time

```julia
era5time(; year="", month="", day="", hour="") -> String
```

Select one or more date-times from a CDS ERA5 dataset.

This function returns a JSON formatted string that can be used as an input to the \myreflink{ecmwf} function `params` option.

- `year`: The year(s) to select. It can be a string to select a unique year, or a vector of strings or Ints to select multiple years.
  It can also be a range of years, e.g. "2010:2020".

- `month`: The month(s) to select. It can be a string to select a unique month, or a vector of strings or Ints to select multiple months.
  It can also be a range of months, e.g. "01:06".

- `day`: The day(s) to select. It can be a string to select a unique day, or a vector of strings or Ints to select multiple days.
  It can also be a range of days, e.g. "01:20".

- `hour`: The hour(s) to select. It can be a string to select a unique hour, or a vector of strings or Ints to select multiple hours.
  It can also be a range of hours, e.g. "01:10".

### Returns
A string with the JSON formatted date-time.

Examples
--------

```julia
# All times in 2023
var = era5time(year="2023")
"\"year\": [\"2023\"],\n\"month\": [\"5\"],\n\"day\": [\"13\"],\n\"time\": [\"2\"],\n"
```

See Also
--------

\myreflink{ecmwf}, \myreflink{era5vars}, \myreflink{listecmwfvars}
