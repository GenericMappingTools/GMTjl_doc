# grdmath

Reverse Polish Notation (RPN) calculator for grids (element by element)

Description
-----------

**grdmath** will perform operations like add, subtract, multiply, and
hundreds of other operands on one or more grid files or constants using
[Reverse Polish Notation (RPN)](https://en.wikipedia.org/wiki/Reverse_Polish_notation)
syntax. Arbitrarily complicated expressions may therefore be evaluated; the
final result is written to an output grid file. Grid operations are
element-by-element, not matrix manipulations. Some operators only
require one operand (see below). If no grid files are used in the
expression then options |-R|, |-I| must be set. The expression **=** *outgrid* can occur as many times as
the depth of the stack allows in order to save intermediate results.
Complicated or frequently occurring expressions may be coded as a macro
for future use or stored and recalled via named memory locations.

OK, but RPN is quite painfull to master for other than simple expressions and for it the normal
Julia operators are much easier to use. However, there are many operators that are handy and
already programmed or even kind of unique like for example **LDISTG** that computes distances
to coastlines. So, there is still interest in **grdmath** but due to its nature it was nor wrapped
into a vebose version and for using it one must use the \myreflink{Monolithic} mode.

For the full manual, consult the main GMT [grdmath manual](https://docs.generic-mapping-tools.org/dev/grdmath.html)

Examples
--------

To compute all distances to north pole, try::

```julia
    G = grdmath("-Rg -I1 0 90 SDIST =")
```

To create a grid with resolution 0.5x0.5 degrees with distances in km from the coast line, use::

```julia
    G = grdmath("-RNO,IS -Dc -I.5 LDISTG =")
```