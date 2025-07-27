# Weather Maps


## A Relative humidity map

This example, originates in this GMT Forum [post](https://forum.generic-mapping-tools.org/t/examples-showing-the-usage-of-grdmath/5977),
and computes the relative humidity of the air from grids of temperature and dew-point temperature.
Some meteorological models only provide the temperature and dew-point temperature, so if one wants
relative humidity, it is necessary to compute it from these two related variables.

\begin{examplefig}{}
```julia
using GMT
GMT.resetGMT() # hide

# Download air temperature at 2 meters and dew point temperature at 2 meters
ecmwf(:forecast, vars="2t", filename="2td.grd")   # Temperature
T  = gmtread("2td.grd");
ecmwf(:forecast, vars="2d", filename="2td.grd")   # Dew point temperature
Td = gmtread("2td.grd");

rm("2td.grd") # Hide remove the temporary file

# Function to compute the relative humidity
esat(x) = 6.0178*exp.(17.27*x ./ (x .+ 237.3))

Grh = 100*esat(Td) / esat(T);
viz(Grh, proj=:guess, title="Relative humidity", colorbar=true)
```
\end{examplefig}

##  Wind barbs

\begin{examplefig}{}
```julia
using GMT
GMT.resetGMT() # hide

# Download the ecmwf forcasts for the _u_ and _v_ components of the wind at 10 meters above the surface
ecmwf(:forecast, var="10u", limits="IHO23", filename="u10.grd")
ecmwf(:forecast, var="10v", limits="IHO23", filename="v10.grd")

windbarbs("u10.grd", "v10.grd", Q="0.25c+s20+w0.15c", I="x10", proj=:guess)
rm("u10.grd") # Hide
rm("v10.grd") # Hide
coast!(shore=true, show=true)
```
\end{examplefig}
