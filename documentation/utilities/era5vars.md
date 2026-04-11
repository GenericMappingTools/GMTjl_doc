# era5vars

```julia
era5vars(varID; single::Bool=true, pressure::Bool=false) -> String
```

Selec one or more variables from a CDS ERA5 dataset.

This function returns a JSON formatted string that can be used as an input to the \myreflink{ecmwf} function `params` option.
See the \myreflink{listecmwfvars} function for a list of available variables.

### Args
- `varID`: The variable name. It can be a string or a symbol to select a unique variavle, or a vector of
  strings/symbols to select multiple variables.

### Kwargs
- `single`: If true, only single-level variables are listed. If false, pressure-level variables are listed [Default is true].

- `pressure`: If true, only pressure-level variables are listed. If false, single-level variables are listed.
  [Default is false].

### Returns
A string with the JSON formatted variable name.

Examples
--------

```julia
# "t2m" is the 2m temperature and "skt" is the skin temperature
var = era5vars(["t2m", "skt"])
"\"variable\": [\n\t\"2m_temperature\",\n\t\"skin_temperature\"\n],"
```

See Also
--------

\myreflink{ecmwf}, \myreflink{era5time}, \myreflink{listecmwfvars}
