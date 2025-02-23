# pastplates

```
pastplates(; time=100, proj="", title="time", coastlines=true, fmt="png", name="", data=false, show=true)
```

*keywords: GMT, Julia, Plate Kinematics*

Plots the reconstruction of the past plates at a given time. Data is extracted from the GPLATES
https://gws.gplates.org website.

# Kwargs
- `time`: Time in Ma. Default is 100 Ma.

- `proj`: A projection string like that used, or example, in `coast()`. 

- `title`: Title of the plot

- `coastlines`: A boolean indicating if want to plot the coastlines.

- `fmt`: Format of the plot (Default is `png`)

- `name`: Name of the plot. Instead of using a default name, provide one and figure will be saved with that name.

- `data`: If true `pastplates` return the data in a form of a vector of `GMTdataset` instead of plotting it.
   The default is produce a minimally nice plot but for further enhancements, download the data and make a plot yourself. 

- `show`: If true (the default), automatically show the plot (ignored if `data=true`).

# Examples

Make a figure representing plates positions at 100 Ma ago.

\begin{examplefig}{}
```julia
using GMT

pastplates()
```
\end{examplefig}
