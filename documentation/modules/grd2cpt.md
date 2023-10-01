# grd2cpt

```julia
	grd2cpt(cmd0::String="", arg1=nothing, kwargs...)
```

Make linear or histogram-equalized color palette table from grid

*keywords: GMT, Julia, histogram equalizetiond, colormaps*

Description
-----------

**grd2cpt** reads one or more grid and computes a static color palette (CPT). Once computed the
color palette stays as the current CPT until an image using it is finished, either with the `show`
command or saved to file. The CPT is based on an existing dynamic master CPT of your choice, and the
mapping from data value to colors is through the data's cumulative distribution function (CDF), so that
the colors are histogram equalized. Thus if the grid(s) and the resulting CPT are used in \myreflink{grdimage}
with a linear projection, the colors will be uniformly distributed in area on the plot. Let z be the data
values in the grid. Define CDF(Z) = (# of z < Z) / (# of z in grid). (NaNs are ignored). These z-values
are then normalized to the master CPT and colors are sampled at the desired intervals.

The color palette includes three additional colors beyond the range of z-values. These are the background
color (B) assigned to values lower than the lowest *z*-value, the foreground color (F) assigned to values
higher than the highest *z*-value, and the NaN color (N) painted wherever values are undefined. For color
tables beyond the current GMT offerings, visit [cpt-city](http://soliton.vm.bytemark.co.uk/pub/cpt-city/).

If the master CPT includes B, F, and N entries, these will be copied into the new master file.
If not, the parameters `COLOR_BACKGROUND`, `COLOR_FOREGROUND`, and `COLOR_NAN` from the
`gmt.conf` file or the command line will be used. This default behavior can be overruled
using the options **bg**, **overrule_bg** or **no_bg**.

The color model (RGB, HSV or CMYK) of the palette created by \myreflink{makecpt} will be the same as
specified in the header of the master CPT. When there is no `COLOR_MODEL` entry in the master CPT,
the `COLOR_MODEL` specified in the `gmt.conf` file or on the command line will be used.

Required Arguments
------------------

*ingrid* : -- A grid file name or a \myreflink{Grid type}

Optional Arguments
------------------

- **A** or **alpha** or **transparency** : -- *alpha=xx* **|** *alpha="xx+a"*\
    Sets a constant level of transparency (0-100) for all color slices.
    Append **+a** to also affect the fore-, back-, and nan-colors.

\textinput{common_opts/create_cpt}

- **D** or **bg** or **background** : -- *bg=true* **|** *bg=:i*\
    Select the back- and foreground colors to match the colors for lowest and highest *z*-values in the
    output CPT [Default uses the colors specified in the master file, or those defined by the parameters
    `COLOR_BACKGROUND`, `COLOR_FOREGROUND`, and `COLOR_NAN`]. Append **i** to match the colors for the lowest
    and highest values in the input (instead of the output) CPT.

- **E** or **nlevels** : -- *nlevels=true* **|** *nlevels=nlevels|"+c[+f<file>]"*\
    Create a linear color table by using the grid z-range as the new limits in the CPT, so the
    number of levels in the CPT remain unchanged. Alternatively, append *nlevels* and we will
    instead resample the color table into *nlevels* equidistant slices. As an option, append
    **+c** to estimate the cumulative density function of the data and assign color levels
    accordingly. If **+c** is used then you may optionally append **+f**<file> to save the CDF
    to *file*, or just use **+c+f** to return also a table with the CDF.

- **F** or **color_model** : -- *color_model=true|:r|:h|:c["+c"[label]]*\
    Force output CPT to be written with r/g/b codes, gray-scale values or color name (the default)
    or r/g/b codes only (**r**), or h-s-v codes (**h**), or c/m/y/k codes (**c**). Optionally or
    alternatively, append **+c** to write discrete palettes in categorical format.  If *label* is
    appended then we create labels for each category to be used when the CPT is plotted. The *label*
    may be a comma-separated list of category names (you can skip a category by not giving a name),
    or give *start*[-], where we automatically build monotonically increasing labels from *start*
    (a single letter or an integer). Append - to build ranges *start*-*start+1* instead. **Note**:
    If **+cM** is given and the number of categories is 12, then we automatically create a list of
    month names. Likewise, if **+cD** is given and the number of categories is 7 then we make a
    list of weekday names. The format of these labels will depend on the `FORMAT_TIME_PRIMARY_MAP`,
    `GMT_LANGUAGE` and possibly `TIME_WEEK_START` settings.

- **G** or **truncate** : -- *truncate=(zlo,zhi)*\
    Truncate the incoming CPT so that the lowest and highest z-levels are to *zlo* and *zhi*. If one of these
    equal NaN then we leave that end of the CPT alone. The truncation takes place before any resampling.
    See also [Manipulating CPTs](https://docs.generic-mapping-tools.org/dev/cookbook/features.html#manipulating-cpts)

- **I** or **inverse** or **reverse** : -- *inverse=true* **|** *inverse=:z*\
    Reverse the sense of color progression in the master CPT. Also exchanges the foreground and background colors,
    including those specified by the parameters `COLOR_BACKGROUND` and `COLOR_FOREGROUND`. Use **inverse=:z** to
    reverse the sign of z-values in the color table. Note that this change of *z*-direction happens before **truncate**
    and **range** values are used so the latter much be compatible with the changed *z*-range. See also
    [Manipulating CPTs](https://docs.generic-mapping-tools.org/dev/cookbook/features.html#manipulating-cpts)

- **L** or **datarange** or **clim** : -- *datarange=(minlimit, maxlimit)*\
    Limit range of CPT to *(minlimit, maxlimit)*, and don't count data outside this range when
    estimating CDF(Z). To set only one limit, specify the other limit as "-"
    [Default uses min and max of data.]

- **M** or **overrule_bg** : -- *overrule_bg=true*\
    Overrule background, foreground, and NaN colors specified in the master CPT with the values of the parameters
    `COLOR_BACKGROUND`, `COLOR_FOREGROUND`, and `COLOR_NAN` specified in the `gmt.conf` file or on the command line.
    When combined with **bg**, only `COLOR_NAN` is considered.

- **N** or **no_bg** or **nobg** : -- *no_bg=true*\
    Make all the background, foreground, and NaN-color fields be white (since we can't remove them like in plain GMT).

- **Q** or **log** : -- *log=true* **|** *log=:i|:o*\
    Selects a logarithmic interpolation scheme [Default is linear].  **log=:i** expects input
    z-values to be log10(z), assigns colors, and writes out z [Default]. **log=:o** takes
    log10(z) first, assigns colors, and writes out z.

\textinput{common_opts/opt_R}

- **S** or **symetric** : -- *symetric=:h|l|m|u*\
    Force the color table to be symmetric about zero (from -*R* to +*R*).
    Append flag to set the range *R*: **l** for *R* =|zmin|, **u** for *R* =
    |zmax|, **m** for *R* = min(|zmin|, |zmax|), or **h** for *R* = max(|zmin|, |zmax|).

- **T** or **range** : -- *range=(min,max,inc)* **|** *range=n*\
    Set steps in CPT. Calculate entries in CPT from *start* to *stop* in steps of (*inc*).
    Default chooses arbitrary values by a crazy scheme based on equidistant values for a
    Gaussian CDF. Use **range=n** to select *n* points from such a cumulative normal distribution [11].

- **V**
    Verbose operation. This will write CDF(Z) estimates to stderr. [Default is silent.]

- **W** or **wrap** or **categorical** : -- *wrap=true* **|** *wrap=:w*\
    Do not interpolate the input color table but pick the output colors starting at the beginning of the color table,
    until colors for all intervals are assigned. This is particularly useful in combination with a categorical color
    table, like "categorical". Alternatively, use **wrap=:w** to produce a wrapped (cyclic) color table that endlessly
    repeats its range.

- **Z** or **continuous** : -- *continuous=true*\
    Force a continuous CPT [Default is discontinuous].

- **name** or **save** : -- *save="name.cpt"*\
   Save the color map with the **save="name.cpt"**. When in modern mode this also automatically sets a
   required GMT option (-H).

\textinput{common_opts/opt_bo} This option only applies if **nlevels** selects CDF output. 

\textinput{common_opts/opt_h}

\textinput{common_opts/explain_transparency}

Color Hinges
------------

Some of the GMT master dynamic CPTs are actually two separate CPTs meeting at a *hinge*.
Usually, colors may change dramatically across the hinge, which is used to separate two
different domains (e.g., land and ocean across the shoreline, for instance). CPTs with a
hinge will have their two parts stretched to the required range separately, i.e., the
bottom part up to the hinge will be stretched independently of the part from the hinge
to the top, according to the prescribed new range.  Hinges are either *hard* or *soft*.
Soft hinges must be *activated* by appending **+h**[*hinge*] to the CPT name. If the
selected range does not include an activated soft or hard hinge then we only resample
colors from the half of the CPT that pertains to the range.
See [Of Colors and Color Legends](https://docs.generic-mapping-tools.org/dev/cookbook/cpts.html#of-colors-and-color-legends)
for more information.

Discrete versus Continuous CPT
------------------------------

All CPTs can be stretched, but only continuous CPTs can be sampled
at new nodes (i.e., by given an increment in **range**).  We impose this
limitation to avoid aliasing the original CPT.

Examples
--------

To get a reasonable and symmetrical color table for the data in the region 0/60/0/60
from the remote 5m relief file, using the geo color table, try:

\begin{examplefig}{}
```julia
using GMT
grd2cpt("@earth_relief_06m", region=(0,60,0,60), cmap=:geo, symetric=:u)
imshow("@earth_relief_06m", region=(0,60,0,60), coast=true)
```
\end{examplefig}

Sometimes you don't want to make a CPT (yet) but would find it
helpful to know that 90% of your data lie between z1 and z2, something
you cannot learn from \myreflink{grdinfo}. So you can do this to see some points
on the CDF(Z) curve (use **verbose=true** option to see more):

```julia
    grd2cpt("mydata.nc", verbose=true)
```

To make a CPT with entries from 0 to 200 in steps of 20, and ignore
data below zero in computing CDF(Z), and use the built-in master cpt
file relief, run

```julia
    C = grd2cpt("mydata.nc", cmap=:relief, datarange=(0,10000), range=(0,200,20))
```

To determine the empirical cumulative density function of a grid and
create a CPT that would give equal area to each color in the image,
and return the CDF table as well, try:

\begin{examplefig}{}
```julia
using GMT
C, cdf = grd2cpt("@earth_relief_10m", nlevels="11+c+f");
imshow("@earth_relief_10m", cmap=C)
```
\end{examplefig}

Here, cdf would be the cumulative hypsometric curve for the Earth.

See Also
--------

\myreflink{grdhisteq}, \myreflink{grdinfo}, \myreflink{makecpt}

References
----------

Crameri, F., (2018). Scientific colour-maps. Zenodo. http://doi.org/10.5281/zenodo.1243862

Crameri, F. (2018), Geodynamic diagnostics, scientific visualisation and StagLab 3.0,
*Geosci. Model Dev.*, 11, 2541-2562, doi:10.5194/gmd-11-2541-2018.
