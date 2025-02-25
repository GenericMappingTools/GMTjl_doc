# scatter3

```julia
scatter3(cmd0::String="", arg1=[]; kwargs...)
```

Reads (x,y,z) triplets and plot symbols at those locations on a map. This module is a subset of `plot` to make
it simpler to draw scatter plots. So many (fine) controlling parameters are not listed here. For a
finer control, user should consult the `plot` module.

Parameters
----------

\textinput{common_opts/opt_B}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R_3D}

\textinput{common_opts/opt_mfc}

- **S** or **symbol** or **marker** or **Marker** or **shape** : --  Default is `cube` with size of 7 points
   - *symbol=symbol string*\
      A full GMT compact string.
   - *symbol=(symb=..., size=..., unit=...)*\
      Where *symb* is one \myreflink{Symbols} like `:circle`, *size* is
      symbol size in cm, unless *unit* is specified i.e. `:points`

   In alternative to the *symbol* keyword, user can select the symbol name with either *marker* or *shape*
   and symbol size with *markersize*, *ms* or just *size*. The value of these keywords can be either numeric
   (symb meaning size in cm) or string if an unit is appended, *e.g.*  *markersize=5p*. This form of symbol
   selection allows also to specify a variable symbol size. All it's need for this is that the keywrd's value
   be an array with the same number of elements as the number of data points. 

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_save_fig}

Examples
--------

A scatter of ten points plotted as black cubes of 7 points size using the default perspective of 200,30

\begin{examplefig}{}
```julia
using GMT
scatter3(rand(10,10,3), zsize=4, marker=:cube, mc=:darkgreen, show=true)
```
\end{examplefig}

See also
--------

The [`GMT man page`](http://docs.generic-mapping-tools.org/latest/plot.html)