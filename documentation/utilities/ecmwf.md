# ecmwf

```julia
ecmwf(; filename="", cb::Bool=false, dataset="", params::AbstractString="", key::String="",
          url::String="", region="", format="netcdf", dryrun::Bool=false, verbose::Bool=true)
```

Retrieves data from the Climate Data Store [CDS](https://cds.climate.copernicus.eu) service.


---
    ecmwf(:forecast; levlist="", kw...)

Download forecast datasets or just some variables from the ECMWF. (see man after that of first mode)


---
Get ERA5 data from the Copernicus Climate Change Service (C3S) Climate Data Store (CDS) using the CDS API.

- `filename`: The name of the file to save the data to. If not provided, the function will generate a
   name based on the dataset and the data format.

- `cb`: A boolean indicating whether to use the clipboard contents. If true, the function will use the
  ``clipboard()`` to fetch its contents. The clipboard should contain a valid API request code as generated
   by the CDS website. This site provides a ``Show API request`` button at the bottom of the download tab
   of each dataset. After clicking it, the user can copy the request code with a Control-C (or click ``Copy``
   button) which will and paste it into the clipboard.

- `dataset`: The name of the dataset to retrieve. This option can be skipped if the `dataset` option
   is provided in the `params` argument, or is included clipboard copy (the `cb` option is set to true).

- `params`: A JSON string containing the request parameters. This string should be in the format expected
   by the CDSAPI. When using input via this option the `dataset` option is mandatory.
   If you feel brave, you can create the request parametrs yourself and pass them as a two elements string
   vector with the output of the ``era5vars()`` and ``era5time()`` functions. In this case, a region selection
   and pressure levels, if desired, must be provided via the `region` and `levlist` options. The `region`
   option has the same syntax in all other GMT.jl modules that use it, _e.g._ the ``coast`` function.

- `key`: The API key for the CDSAPI server. Default is the value in the ``.cdsapirc`` file in the home directory.
   but if that file does not exist, the user can provide the `key` and `url` as arguments. Instructions on how
   to create the ``.cdsapirc`` file for your user account can be found at [CDS](https://cds.climate.copernicus.eu/how-to-api)

- `url`: The URL of the CDS API server. Default is https://cds.climate.copernicus.eu/api

- `levlist`: List of pressure levels to retrieve. It can be a string to select a unique level, or a vector
   of strings or Ints to select multiple levels. But it can also be a range of levels, e.g. "1000:-100:500". 
   This option is only used when the `params` argument is provided as a string vector.

- `region`: Specify a region of a specific geographic area. It can be provided as a string with form "N/W/S/E"
   or a 4-element vector or tuple with numeric data. This option is only used when the `params` argument is
   provided as a string vector.

- `format`: The format of the data to download. Default is "netcdf". Other options is "grib".

- `dryrun`: A boolean indicating whether to print the `params` from the outputs of the `era5vars()` and
  `era5time()` functions. I this case, we just print the `params` and return without trying to download any file.

- `verbose`: A boolean indicating whether to print the attemps to connect to the CDS server. Default is true.

### Credits
This function is based in part on bits of CDSAPI.jl but doesn't require any of the dependencies of that package.

Examples
--------

```julia
# Copy the following code by selecting it and pressing Ctrl-C

{"product_type": ["reanalysis"],
    "variable": [
        "10m_u_component_of_wind",
        "10m_v_component_of_wind"
    ],
    "year": ["2024"],
    "month": ["12"],
    "day": ["06"],
    "time": ["16:00"],
    "data_format": "netcdf",
    "download_format": "unarchived",
    "area": [58, 6, 55, 9]
}

# Now call the function but WARNING: DO NOT COPY_PASTE it as it would replace the clipboard contents
ecmwf(dataset="reanalysis-era5-single-levels", cb=true)
```

### Let's dare and build the request ourselves
```julia
var = era5vars(["t2m", "skt"])			# "t2m" is the 2m temperature and "skt" is the skin temperature
datetime = era5time(hour=10:14);
ecmwf(dataset="reanalysis-era5-land", params=[var, datetime], region=(-10, 0, 30, 45))
```


---
    ecmwf(:forecast; levlist="", kw...)

Download forecast data


### Kwargs
- `cube`: If true [the default], when downloading pressure levels variables, save them data as a netCDF 3D cubes instead
   of one file per layer (when `cube=false`).

- `date`: The date to select. It can be a string to select a unique date, a ``DateTime`` object, or a Int.
   Where the Int is the number of days to go back from today. If the Int is greater than 3, an error is raised.
   If the date is a string, it must be in the form YYYYMMDD or YYYY-MM-DD.

- `dryrun`: Print the URL of the requested data and return without trying to download anything.

- `format`: The format in which to save the downloaded data. It can be "grib" or "netcdf". Default is "netcdf".

- `levlist`: The pressure levels to select. It can be a string to select a unique pressure level,
   or a vector of strings or Ints to select multiple pressure levels.

- `model`: A string with the model to select. Either "ifs" or "aifs". Default is "ifs".

- `param, variable, var, vars`: The variable(s) to select. It can be a string to select a unique variable, or a vector
   of strings or Ints to select multiple variables. When variable(s) is requested, we download only those
   variables as separate files. The names of those files are the same as the variable names with the .grib2 extension.
   NOTE: Not specifying a variable will download the entire forecast grib file for each forecast step selected with the `step` option.

\textinput{common_opts/opt_R}

- `root`: The root URL of the CDS ERA5 dataset. Default is "https://data.ecmwf.int/forecasts".

- `step`: An Int with the forecast step to select.

- `stream`: The stream to select. It can be one of: "oper", "enfo", "waef", "wave", "scda", "scwv", "mmsf". Default is "oper".

- `time`: The time in hours to select. It can be a string a ``Time`` object, or a Int. What ever it is,
   it will floored to 0, 6, 12 or 18. The default is the current hour.

- `stream`: A string with the stream to select, it must be one of: "oper", "enfo", "waef", "wave", "scda", "scwv", "mmsf". Default is "oper".

- `type`: A string with the type of forecast to select, it must be one of: "fc", "ef", "ep", "tf". Default is "fc".

Example
-------

Get the latest 10m wind and 2m temperature forecast for today.

```julia
ecmwf(:forecast, vars=["10u", "2t"])
```


See Also
--------

\myreflink{weather}, \myreflink{era5vars}, \myreflink{era5time}, \myreflink{listecmwfvars}
