# bar

```julia
	bar(cmd0::String="", arg1=[]; kwargs...)
```

Reads (x,y) pairs and plots a bar graph. This module is a subset of `plot` to make it simpler to draw bar
plots. So not all (fine) controlling parameters are listed here. For a finer control, user should
consult the \myreflink{plot} module.

If input is a MxN array and N > 2 it will plot a bar-group with M groups and N-1 bars in each group (first
column holds always the coordinates).

Parameters
----------

\textinput{common_opts/opt_B}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_mfc}

- *bar*\
   Vertical bar extending from base to *y*. By default, base is 0 and the bar widths are 0.8 of the width in
   x-units. You can change this by using (in alternative):
     - *width=xx*\
        where *xx* is the bar width in x-units (bar base remains = 0).
     - *base=xx*\
        where *xx* is the base value (bar width remains = 0.8).
     - *bar=??*\
        where *??* is a string with a full GMT syntax for this option (**-Sb**)
     - *bar=(width=xx,unit=xx,base=xx,height=xx)*\
        Attention, the order of members matters but only *width* is mandatory.
       - *width*\
          The bar width in x-units. To specify it in plot units, use the *unit* member with `cm`, `inch` or `point`.
       - *unit*\
          In case *width* is given in plot units. Valid units are `cm`, `inch` or `point`.
       - *base=xx*\
          where *xx* is the base value.
       - *height*\
          If the bar height is measured relative to base *xx* [Default is relative to origin].
          Cannot be used together with *base*.

- *bargap*\
   Controls the gap between the bars. The default is to let a space of 20% of the bar width but this can be
   changed by providing eithe a gap in the [0-1] interval or in percentage. *i.e.* `bargap=40` or `bargap=0.4`
   will create a space of 40% between the bars.

- *hbar*\
   Horizontal bar extending from base to x. Same as *bar* but now with respect to y axis, except that one
   cannot use *width* or *base* to change just those defaults (the use of it is restricted to the vertical
   bars case).

- *fill=["color1", "color2", ...]* **|** *fill=("color1", "color2", ...)* **|** *fill=(1,2,...)*\
   List of colors used to wrapp the bars inside each group. When using numbers that means patterns codes.

- *fillalpha=[...]*\
   When *fill* was used, control the transparency level. Numbers can be floats <= 1.0 or integeres in 0-100 range.

- *stack*\
   Plot a vertically (or horizontally if *hbar=true*) stacked group plot. The particular setting `stack=:waterfall`
   creates a waterfall chart, which is a form of data visualization that helps in understanding the cumulative
   effect of sequentially introduced positive or negative values. The input data for this option is a vector or
   one row matrix with the heights of each bar. A height o zero (0) has the special meaning of plotting the total
   accumulated up to that value. For these plots we can connect the bars with the `connector=true` or `connector=pen`
   option. Bar colors (three for the waterfall type) are controlled with the `fill` option but default values
   are provided. See example below.

\textinput{common_opts/opt_save_fig}

Examples
--------

A simple bar plot with 10 bars and automatic limits.

\begin{examplefig}{}
```julia
using GMT
bar(rand(10), show=true)
```
\end{examplefig}

A bar group with selected colors and transparency.
\begin{examplefig}{}
```julia
using GMT
bar([0. 1 2 3; 1 2 3 4], fillalpha=[0.3 0.5 0.7], fill=["red" "green" "blue"], show=true)
```
\end{examplefig}

A bar group with bars filled with patterns.
```julia
    bar([0 1 2 3; 1 2 3 4], fill=(1,2,3), show=1)
```

A bar group with error bars

\begin{examplefig}{}
```julia
using GMT
bar([0. 1 2 3; 1 2 3 4], error_bars=(y=[0.1 0.2 0.33; 0.2 0.3 0.4],), show=true)
```
\end{examplefig}

A waterfall chart.

\begin{examplefig}{}
```julia
using GMT
bar([1 2 3 0 -1 -2 0], stacked=:water, connector=true, bargap=25,
    xticks=(:A, :B, :C, :Partial, :D, :E, :Total), show=true)
```
\end{examplefig}

See also
--------

\myreflink{Bar plots} examples.

The [`GMT man page`](https://docs.generic-mapping-tools.org/latest/plot.html)