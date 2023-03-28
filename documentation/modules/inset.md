# inset

```julia
inset(kwargs...)
```

Manage figure inset setup and completion

The **inset** module is used to carve out a sub-region of the current plot canvas and
restrict further plotting to that section of the canvas. The inset setup is started with the **inset(...)**
directive that defines the placement and size of the inset. Subsequent plot commands will be directed
to that window. The inset is completed via the **inset(:end)** directive, which reverts operations to the full
canvas and restores the plot region and map projection that was in effect prior to the setup of the inset.


Description
-----------

The **inset(...)** defines the dimension and placement of the inset canvas. It records the current region and
projection so that we may return to the initial plot environment when  the inset is completed. The user may
select any plot region and projection once plotting in the inset, but if the first command uses a projection
that leaves off the scale or width then we supply a scale or width to fill the inset as best as possible, given
the inset size and margins (if selected). **Note**: If you wish to let the inset dimensions be determined by the
region and projection that will be used to draw in the inset, then give these arguments in the **inset()** command.


Required Arguments
------------------

- **D** or **inset** or **inset_box** or **insetbox** : -- *inset_box=(map=true, inside=true, outside=true, norm=true, paper=true, anchor=XX, size=XX, width=XX, justify=code, offset=XX)*\
    Define the map inset rectangle on the map. Specify the rectangle in one of three ways:

    1. Use `map=(lon,lat)` for map coordinates. Requires both **region** and **proj** to be set.
    2. Use `inside=code` or `outside=code` for setting the refpoint via a 2-char justification code that refers to
         the (invisible) projected map bounding box. Requires both **region** and **proj** to be set.
    3. Use `norm=(x,y)` for normalized bounding box coordinates (0-1). Requires both **region** and **proj** to be set.
    4. Use `paper=(x,y)` for plot coordinates (append cm, inch, or point).

    Use **size=(length,width)** (or **width**) of bounding rectangle or box in plot coordinates (inches, cm, etc.).
    By default, the anchor point on the scale is assumed to be the bottom left corner (BL), but this can be changed
    by using **justify=??** where *??* stands for a 2-char justification code *justify* (see \myreflink{text}).
    Note: with the default **outside=true**, the *justify* defaults to the same as **anchor**, if **inside=true** is used then *justify* defaults to the mirror opposite of **anchor**. Specify inset box attributes via the **box** option [outline only].

    Alternatively, use **inset_box="west/east/south/north"** of geographic rectangle bounded by parallels and
    meridians; append **+r** if the coordinates instead are the lower left and upper right corners of the desired
    rectangle. (Or, give *xmin/xmax/ymin/ymax* of bounding rectangle in projected coordinates and optionally
    append **+u**unit [Default coordinate unit is meter (e)]. NOTE that this form requires passing the options
    as a string and it uses the terse pure GMT syntax.

Optional Arguments
------------------

- **C** or **clearance** : -- *clearance=val* **|** *clearance=(left=val, right=val, bott=val, bottom=val, top=val))*\
    Reserve a space of dimension *clearance* between the actual inset plot area and the given inset box on the specified
    side, using *side* values from **left=val**, **right=val**, **bottom=val**, or **top=val**, or **lr=val** for both
    *left* and *right* or **tb=val** for both *top* and *bott*. No *side* means all sides. Alternatively, if all sides
    are to be set you can also give a pair of values separated by slashes (for setting separate horizontal and vertical
    margins), or the full set of four separate margins. Such space will be left untouched by the inset map plotting.
    Append units as desired  (**c**m, **i**nch, or **p**oint) [Default is set by `PROJ_LENGTH_UNIT`].

- **F** or **box** : -- *box=(clearance=val, fill=color, inner=true, pen=pen, rounded=true, shaded=XX)*\
    Without further options, draws a rectangular border around the map inset using `MAP_FRAME_PEN`. The following
    modifiers can be appended to |-F|, with additional explanation and examples provided in the
    [The background panel](https://docs.generic-mapping-tools.org/dev/cookbook/features.html#background-panel)
    cookbook section:

    - **clearance=val** where *val* is either *gap* or *(xgap,ygap)*, or *(lgap,rgap,bgap,tgap)* where these items are uniform, separate in x- and y-direction, or individual side spacings between the map embellishment and the border for each side.
    
    - **fill=color**, where *color* is any valid color setting (see \myreflink{Setting color}, to fill the scale panel [no fill].
    
    - **inner=true** to draw a secondary, inner border as well. We use a uniform *gap* between borders of *2p* and the `MAP_DEFAULTS_PEN` unless other values are specified (like **inner="gap/pen"**). 
    
    - **pen=pen**, to specify different \myreflink{Pen attributes} attributes.
    
    - **rounded=true** to draw rounded rectangular borders instead, with a *6p* corner radius. You can override this radius by using another value instead of *true*.
    
    - **shadded=true** or **shadded=(dx,dy)** or **shadded=shade** to draw an offset background shaded region. Here, *dx/dy* indicates the shift relative to the foreground frame [*4p/-4p*]and *shade* sets the fill style to use for shading ("gray50").

\textinput{common_opts/opt_J}

- **N** or **noclip** or **no\_clip** : *noclip=true*\
    Do **not** clip features extruding outside map inset boundaries [Default will clip].

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_V}

Synopsis (end mode)
-------------------

The **inset(:end)** command finalizes the current inset, which returns the plotting environment to the state
prior to the start of the inset. The previous region and map projection will be in effect going forward.


Examples
--------

To make a simple basemap plot that demonstrates the inset module, try

\begin{examplefig}{}
```julia
using GMT
gmtbegin()
	basemap(region=(0,40,20,60), proj=:merc, frame=(annot=:afg, fill=:lightgreen))
	inset(inset_box=(anchor=:TR, width=6.4, offset=0.5), box=(fill=:pink, pen=0.5), margins=0.6)
		basemap(region=:global360, proj=(name=:laea, center=[20,20]), figsize=5, frame=:afg)
		text(text="INSET", font=18, region_justify=:TR, offset=(away=true, shift=-0.4), noclip=true)
	inset(:end)
	text(text="MAP", font=18, region_justify=:BL, offset=(away=true, shift=0.5))
gmtend(:show)
```
\end{examplefig}
