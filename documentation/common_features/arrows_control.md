# Vector Attributes

Set arrow parameters. They are specified by a keyword (*arrow*) and a named tuple.
Several modifiers may be provided for specifying the placement of vector heads, their shapes, and the
justification of the vector. Below, left and right refers to the side of the vector line when viewed from
the start point to the end point of a segment:

    arrow=(length=..., start=..., shape=..., pen=..., norm=..., etc)

- *len=xx* or *length=xx*\
   Length of the vector head. *xx* may be numeric, a string with the length and the
   units attached (as in len="2c") or a tuple with length and units as in *len=(2,:centimeters)*

- *angle=xx*\
   Sets the angle of the vector head apex [default 30]

- *magcolor=true*\
   Selects the vector data quantity *magnitude* for use with CPT color look-up [Default requires a separate
   data column following the 2 or 3 coordinates]. Requires that data quantity scaling (via **scale** or **uv**)
   and a CPT have been selected.

- *start=true*\
   Places a vector head at the beginning of the vector path [none]. Optionally, set
  - *start=:line* -- For a terminal line
  - *start=:arrow* -- For a arrow (the default)
  - *start=:circle* -- For a circle
  - *start=:tail* -- For a tail
  - *start=:open_arrow* -- For a plain open arrow
  - *start=:open_tail* -- For a plain open tail
  - *start=:left* -- For draw the left half-side
  - *start=:right* -- For draw the right half-side
- *stop=true*\
   Places a vector head at the end of the vector path [none]. Optionally, set the same values
   as the *start* case.
- *middle=true*\
   Places a vector head at the mid-point of the vector path [none]. Optionally, set the same
   values as the *start* case but it can't be used with the *start* and *stop* options. But it accepts two
   further options:
   - *middle=:forward*\
      Forward direction of the vector [the default]
   - *middle=:reverse*\
      Reverse direction of the vector.
- *fill=color*\
   Sets the vector head fill. The *color* value may contain any of valid ways ways of
   specifying color.
   - *fill=:none*\
      Turns off vector head fill.
- *shape=xx*\
   Sets the shape of the vector head (range -2/2). Determines the shape of the head of a vector.
   Normally (i.e., for vector_shape = 0), the head will be triangular, but can be changed to an arrow (1) or
   an open V (2). Intermediate settings give something in between. Negative values (up to -2) are allowed as
   well. Shortcuts available as:
   - *shape=:triang*     same as *shape=0*
   - *shape=:arrow*      same as *shape=1*
   - *shape=:V*          same as *shape=2*
- *half=:left*\
   Draw half-arrows, using only the left side of specified heads [default is both sides].
- *half=:right*\
   Draw half-arrows, using only the right side of specified heads [default is both sides].
- *norm=xx*\
   Scales down vector attributes (pen thickness, head size) with decreasing length, where vector
   plot lengths shorter than norm will have their attributes scaled by length/norm. *xx* may be a number or a
   string (number&unit). Optionally, append /min for the minimum shrink factor (in the 0-1 range) that we will
   shrink to.
- *pole=(plon,plat)* -- Specifies the oblique pole for the great or small circles.
- *pen=pen*\
   Sets the vector pen attributes. The *pen* value may contain any of valid ways of specifying pens.
   If pen has a leading '-' (and hence the *pen* value must be a string) then the head outline is not drawn.
- *ang1_ang2=true* or *start_stop=true*\
   Means that input angle, length data instead represent the start and stop opening angles of the arc
   segment relative to the given point. See **pole** to specify a specific pole for the arc [north pole].
- *trim=trim*\
   Shift the beginning or end point (or both) along the vector segment by the given trim. To
   select begin or end prepend a **b** or a **e** to the *trim* value (hence it must be a string). Append suitable
   unit (c, i, or p). If the modifiers b|e are not used then trim may be two values separated by a slash, which
   is used to specify different trims for the beginning and end. Positive trims will short the vector while
   negative trims will lengthen it [no trim].

In addition, all but circular vectors may take these options:

- *justify=??*\
   Determines how the input x,y point relates to the vector. Choose from
   - *justify=:begin*          -- The default
   - *justify=:end*
   - *justify=:center*
- *endpoint=true* or *endpt=true*\
   Means that input angle and length are provided instead the x, y coordinates of the vector end point.
   ATTENTION: when used from within `arrows()` use this directly as an `arrows` option
   instead of the `arrow=(...)` option because we need to know in advance the meaning of 3 & 4rth columns.

Finally, Cartesian vectors may take this option:

- *scale=[i|l]scale*\
   Expects a scale to magnify the polar length in the given unit. If **i** is prepended we use the inverse
   scale while if **l** is prepended then it is taken as a fixed length to override input lengths. Append char
   **q** if input magnitudes are given in data quantity units and we will scale them to current plot unit for
   Cartesian vectors or to km for geovectors. In addition, if **magcolor** is selected then the vector magnitudes
   may be used for CPT color-lookup (and no extra data column is required by the module's **cmap** option).

- *uv=true* or *uv=scale*\
   Expects input vx,vy vector components and uses the scale to convert to polar coordinates with length
   in given unit. ATTENTION: when used from within `arrows()` use this directly as an `arrows` option
   instead of the `arrow=(...)` option.
