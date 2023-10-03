# grdclip

```julia
	grdclip(cmd0::String="", arg1=nothing; kwargs...)
```

*keywords: GMT, Julia, grid clip*

Clip the range of grid values

Description
-----------

Sets values < *low* to *below* and/or values > *high* to
*above*. You can also specify one or more intervals where all values should be
set to *between*, or replace individual values. Such operations are useful
when you want all of a continent or an ocean to fall
into one color or gray shade in image processing, when clipping of the
range of data values is required, or for reclassification of data values.
*above*, *below*, *between*, *old* and *new* can be any number or even NaN
(Not a Number). You must choose at least one of the **S?** options. Use
**region** to only extract a subset of the *ingrid* file.

Optional Arguments
------------------

\textinput{common_opts/opt_-Grid}

\textinput{common_opts/opt_R}

- **Sa** or **above** or **high** : -- above="high/above", **|** *above=(high,above)*\
    Set all data[i] > *high* to *above*.

- **Sb** or **below** or **low** : -- below="low/below", **|** *below=(low,below)*\
    Set all data[i] < *low* to *below*.

- **Si** or **between** : -- *between="low/high/between"* **|** *between=(low,high,between)*\
    Set all data[i] >= *low* and <= *high* to *between*.
    Repeat the option for as many intervals as are needed.

- **Sr** or **old** or **new** : -- *old="old/new"* **|** *old=(old,new)*\
    Set all data[i] == *old* to *new*. This is mostly useful when your data are known to be integer values.
    Repeat the option for as many replacements as are needed.

- **S** : -- *S="..."\
    Any of the above must use the short form **S?**. The current use of this is when one wants
    to repeat an **S?** option, which we cannot do because we can't repeat the *kwargs* key names.
    Example usage: `G2 = grdclip(G, S="a5/6 -Sb2/2 -Si3/4/3.5")`

\textinput{common_opts/opt_V}

Examples
--------

To set all values > 0 to NaN and all values < 0 to 0 in the remote file AFR.nc:

```julia
    Gnew_AFR = grdclip("@AFR.nc", above=(0,NaN), below=(0,0))
```

To reclassify all values in the 25-30 range to 99, those in 35-39 to 55,
exchange 17 for 11 and all values < 10 to 0 in file classes.nc, try

```julia
    Gnew_classes = grdclip("classes.nc", S="i25/30/99, -Si35/39/55", old=(17,11), between=(10,0))
```

See Also
--------

\myreflink{grdfill},
\myreflink{grdlandmask},
\myreflink{grdmask}, \myreflink{grdmath},
\myreflink{grd2xyz}, \myreflink{xyz2grd}
