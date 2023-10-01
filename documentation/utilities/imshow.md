# imshow

```julia
imshow(arg1; kw...)

or

viz(arg1; kw...)
```

keywords: GMT, Julia, automatic visualization

The second form shown above means that `viz` is an alias of `imshow`.

`imshow`, or `viz`, is a front end to the \myreflink{grdimage}, \myreflink{grdview}, \myreflink{plot} and \myreflink{plot3}
programs that accepts \myreflink{GMTgrid}, \myreflink{GMTimage}, \myreflink{GMTdataset} as well as plain matrices
or strings with file names of grids or images. The normal options of the \myreflink{grdimage}
and \myreflink{grdview} programs also apply here but some clever guessing of suitable necessary parameters is done
if they are not provided. Contrary to other image producing modules the "show' keyword is not necessary to
display the image. Here it is set by default. If user wants to use *imshow* to create layers of a more complex
fig he can use *show=false* for the intermediate layers.

This module uses an internal logic to decide whether use \myreflink{grdimage}, \myreflink{grdview} or \myreflink{plot}.
Namely, when the `view` option is used \myreflink{grdview} is choosed and a default vertical scale is assigned.
However, sometimes we want a rotated plot, optionally tilted, but not 3D view. In that case use the option `flat=true`,
which forces the use of \myreflink{grdimage}.

The `kw` keyword/values are used to pass options to \myreflink{grdimage}, etc..., modules. But other than this, we can
also use them to call a subset of GMT.jl modules. For example ``viz(..., coast=true, colorbar=true)``, or a full set of
of \myreflink{coast} options like ``imshow(..., coast=(land=:tomato, ocean=:blue, shore=0.5))``.

Examples
--------

Plot vertical shaded illuminated view of the Mexican hat

\begin{examplefig}{}
```julia
using GMT

G = gmt("grdmath -R-15/15/-15/15 -I0.3 X Y HYPOT DUP 2 MUL PI MUL 8 DIV COS EXCH NEG 10 DIV EXP MUL =");
imshow(G, shade="+a45")
```
\end{examplefig}

Same as above but add automatic contours

\begin{examplefig}{}
```julia
using GMT	# Hide
G = gmt("grdmath -R-15/15/-15/15 -I0.3 X Y HYPOT DUP 2 MUL PI MUL 8 DIV COS EXCH NEG 10 DIV EXP MUL =");	# Hide

imshow(G, shade="+a45", contour=true)
```
\end{examplefig}

See Also
--------

\myreflink{grdimage}, \myreflink{grdview}, \myreflink{plot}, \myreflink{plot3}
