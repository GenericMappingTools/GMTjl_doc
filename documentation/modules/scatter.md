# scatter

```julia
scatter(cmd0::String="", arg1=nothing; kwargs...)
```

*keywords: GMT, Julia, symbols plots, mapping*

Reads (x,y) pairs and plot symbols at those locations on a map/figure. The input can either be a file
name of a file with at least two columns (x,y), but optionally more, a GMTdatset object with also two
or more columns.

This module is a subset of `plot` to make it simpler to draw scatter plots. So many (fine)
controlling parameters are not listed here. For a finer control, user should consult the `plot` module.

Required Arguments
------------------

There are no required arguments but

Optional Arguments
------------------

\textinput{common_opts/opt_B}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_mfc}

- **zcolor** or **markerz** or **mz** : -- *zcolor=xx* **|** *zcolor=true*\
   Take the vector `xx` (same size as number os points in data) and interpolate the current color scale to paint the
   symbols based on that colr scale. The form `zcolor=true` is equivant to *zcolor=1:npoints*

- **S** or *symbol* or *marker* or *Marker* or *shape* : -- Default is `circle` with a diameter of 7 points
   - *symbol=symbol* string\
      A full GMT compact string.
   - *symbol=(symb=??, size=??, unit=??)*\
      Where *symb* is one \myreflink{Symbols} like `:circle`, *size* is symbol size in cm, unless *unit*
      is specified i.e. `:points`

   In alternative to the `symbol keyword, user can select the symbol name with either `marker or `shape
   and symbol size with `markersize` or `ms`. The value of these keywords can be either numeric
   (symb meaning size in cm) or string if an unit is appended, *e.g.*  markersize="5p"` This form of symbol
   selection allows also to specify a variable symbol size. All it's need for this is that the keyword's value
   be an array with the same number of elements as the number of data points. 

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_t}

\textinput{common_opts/opt_save_fig}


Examples
--------

A simple scatter of ten points plotted as red circles of 7 points size

\begin{examplefig}{}
```julia
using GMT
scatter(1:10,rand(10), fill=:red, show=true)
```
\end{examplefig}

A plot where symbol's size grows linearly

\begin{examplefig}{}
```julia
using GMT
sizevec = [s for s = 1:10] ./ 10;
scatter(1:10, 1:10, markersize = sizevec, marker=:square, fill=:green, show=1)
```
\end{examplefig}


See also
--------

The [`GMT man page`](http://docs.generic-mapping-tools.org/latest/plot.html)