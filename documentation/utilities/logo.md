# logo

```julia
logo(cmd0::String=""; kwargs...)
```

Plots the GMT logo on a map. By default, the GMT logo is 5 cm wide and 2.5 cm high and will be
positioned relative to the current plot origin. Use various options to change this and to place
a transparent or opaque rectangular map panel behind the GMT logo.


Parameters
----------

- `pos | position | D`: Sets reference point on the map for the image using one of four coordinate systems.

- `box | F`: Without further options, draws a rectangular border around the GMT logo using `MAP_FRAME_PEN`.
    or map rose (T)

- `julia`: Create the Julia instead of the GMT logo. Provide circle diameter in centimeters

- `GMTjulia`: Create the GMT Julia GMT logo. Provide circle diameter in centimeters

- `kwargs`: keyword/arguments pairs as in \myreflink{plot} module


Examples
--------

Make a GMT Julia logo with circles of 1 cm.

\begin{examplefig}{}
```julia
using GMT

logo(GMTjulia=1, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{plot}
