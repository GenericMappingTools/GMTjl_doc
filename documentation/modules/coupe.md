# coupe

```julia
coupe(cmd0::String="", arg1=nothing; kwargs...)
```

**coupe** - Plot cross-sections of focal mechanisms

## Description

Reads data values from tables and plots focal mechanisms in cross-section plane. The name "coupe"
comes from the French verb "to cut". The best translation is a (vertical) cross section.
Unless **no_project** is used, a new dataset is created with transformed coordinates (x, y)
and the mechanism projected from the lower focal half-sphere (for horizontal plane) to the
half-sphere behind a vertical plane.

Mechanisms within the specified width of the cross-section are included. Events outside this distance are excluded.


## Focal Mechanism Conventions

### Aki & Richards (aki= or Sa)
Columns: lon, lat, depth, strike, dip, rake, magnitude, newlon, newlat, text

### Global CMT (CMT= or Sc)  
Columns: lon, lat, depth, strike1, dip1, rake1, strike2, dip2, rake2, mantissa, exponent, newlon, newlat, text

### Moment Tensor (moment_tensor= or Sm/Sz/Sd)
Columns: lon, lat, depth, mrr, mtt, mff, mrt, mrf, mtf, exponent, newlon, newlat, text

### Partial (partial= or Sp)
Columns: lon, lat, depth, strike1, dip1, strike2, fault_type, magnitude, newlon, newlat, text

### Principal Axis (principal_axis= or Sx/Sy)
Columns: lon, lat, depth, T_value, T_azim, T_plunge, N_value, N_azim, N_plunge, P_value, P_azim, P_plunge, exponent, newlon, newlat, text

## Required Arguments

- *table*\
   A data table (or matrices/datasets) containing focal mechanism parameters. The format depends on the convention specified.

- Defines the cross-section. Choose from four profiles : -- *Aa=(lon1, lat1, lon2, lat2)* **|** *Ab=(lon1, lat1, strike, length)* **|** *Ac=(x1, y1, strike, length)* **|** *Ad=(x1, y1, strike, length)*\
   
   **Aa** or **cross_ll_pts** *=(lon1, lat1, lon2, lat2)*
     *lon* and *lat* are the longitude and latitude of points 1 and 2 limiting the length of the cross-section.

   **Ab** or **cross_ll_azim** *=(lon1, lat1, strike, length)*  
   - lon1 and lat1 are the longitude and latitude of the beginning of the cross-section, strike is the azimuth of the direction of the cross-section, and length is the length along which the cross-section is made (in km). The other parameters are the same as for **Aa**a option.
 
   **Ac** or **cross_xy_pts** *=(x1, y1, x2, y2)*
   - The same as **Aa** option with x and y given as Cartesian coordinates.

   **Ad** or **cross_xy_azim** *=(x1, y1, strike, length)*
   - The same as **Ab** option with x and y given as Cartesian coordinates.

   Available modifiers (as named tuple elements):
   - **report** : Simply report the determined region and exit (no plotting takes places). By default
     (**report=:n**) we report a single numerical record with xmin xmax ymin ymax. Use **report=:t**
     to instead report a text record in the format `region="xmin/xmax/ymin/ymax"`.
   - **dip** : Dip of the plane on which the cross-section is made [Default: 90].
   - **region** : Get the plot domain from the cross-section parameters; append **a** for automatic
     rounding of the domain, **e** for the exact limits [Default], or **dx** to round the distances to integer multiples of **dx**.
   - **width** : The width in km of the cross-section on each side of a vertical plane or above and
     under an oblique plane [infinity], and min and max are the limits on distances from horizontal
     plane in km, along steepest descent direction.
   - **zrange** : control the depth range by appending **a** for automatic rounding, **e** to use the
     exact fit values [Default], **dz** to round depths to integer multiples of **dz**, or give desired
     *min/max* range. For **a** and **dz** you may prepend **s** to clamp the minimum depth at the surface (0).
     When automatic depth range selection is in effect we consider the size of the symbols so that no
     symbol close to the depth limits will be clipped.

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

- **S** or **convention** : *Convention-specific options*\
   Selects the input convention and symbol size. Choose from:
   - **aki** or **Sa** : Aki & Richards convention
   - **CMT** or **Sc** : Global CMT convention  
   - **moment_tensor** or **mt** or **Sm** : Seismic moment tensor (full)
   - **dev** or **Sz** : Deviatoric moment tensor (zero trace)
   - **dc** or **Sd** : Double couple from moment tensor (zero trace and determinant)
   - **partial** or **Sp** : Partial focal mechanism
   - **axis** or **principal_axis** or **Sx** : Principal axis
   - **principal** or **Sy** : Best double couple from principal axis

   Append *scale* to set the symbol size. Use tuple form to add modifiers:
   - `aki=(scale=val, ...)` or `CMT=(scale=val, ...)` etc.

   Available modifiers (as named tuple elements):
   - **angle** : Rotate text angle
   - **font** : Set text font  
   - **justify** : Text justification
   - **radius_moment** : Radius will be proportional to the seismic moment
   - **same_size** : Plot the same size for any magnitude
   - **offset** : Offset text by *dx/dy*
   - **refmag** : Reference magnitude for scaling

## Optional Arguments

\textinput{common_opts/opt_B}

- **C** or **color** or **cmap** : -- *cmap=cpt*\
   Give a CPT to determine compressive quadrant fill based on depth (3rd column).

- **D** or **offset** : -- *offset=true* **|** *offset=(dist_is_geog=true, fill=..., offset=.., pen=..., size=...)*\
   Offsets beachballs with connecting line and symbol. Modifiers:
   - **dist_is_geog** : If alternate geographical coordinates are given in the two columns, convert them to distance, depth coordinates.
   - **fill** : Symbol fill color
   - **offset** : Interpret the contents of the two columns as plot offsets instead, or append fixed offset dx[/dy] for all events.
   - **pen** : Line pen attributes
   - **size** : Set the size of the symbol. Prepend any of a|c|d|g|h|i|n|p|s|t|x to change the symbol fron the default [c] 

- **E** or **extensionfill** : -- *extensionfill=fill*\
   Selects filling of extensive quadrants [Default is white].

- **F** : -- *Fa=true* **|** *Fa=[size[/Psymbol[Tsymbol]]]* **,** *Fe|Fg|Fr=fill* **,** *Fp|Ft|Fz=pen* **,** *Fo=true*\
   Aliases:
   - **Fa** or **PT_axes** : Computes and plots P and T axes with symbols. Optionally specify size and (separate) P and T axis symbols from the following: (c) circle, (d) diamond, (h) hexagon, (i) inverse triangle, (p) point, (s) square, (t) triangle, (x) cross. [Default: 6p/cc]
   - **Fe** or **T_axis_color** : Sets the color or fill pattern for the T axis symbol. [Default as set by **extensionfill**]
   - **Fo** or **psvelo** : Old psvelomeca format (no depth in 3rd column)
   - **Fg** or **P_axis_color** : Sets the color or fill pattern for the P axis symbol. [Default as set by **extensionfill**]
   - **Fr** or **label_box** : Draw a box behind the label (if any). [Default fill is white]
   - **Fp** or **P_axis_pen** : Draws the P axis outline using default pen (see **W**), or sets pen attributes.
   - **Ft** or **T_axis_pen** : Draws the T axis outline using default pen (see **W**), or sets pen attributes.
   - **Fz** or **zero_trace** : Overlay zero trace moment tensor using default pen (see **W**), or sets pen attributes.

- **G** or **fill** or **extensionfill** : -- *fill=color*\
   Selects filling of compressive quadrants [Default is black].

- **H** or **scale** : -- *scale=scale*\
   Scale symbol sizes and pen widths on a per-record basis using the *scale* read from the data file.
   The symbol size is either provided by -S or via the input size column. Alternatively, append a
   constant scale that should be used instead of reading a scale column.

- **I** or **intens** or **intensity** : -- *intens=val* **|** *intens=:a*\
   Use the supplied intens value (nominally in the ±1 range) to modulate the compressional fill color
   by simulating illumination [none]. If no intensity is provided we will instead read intens from an
   extra data column after the required input columns determined by -S.

- **L** or **pen_outline** : -- *pen_outline=pen*\
   Draws the "beach ball" outline using specified pen attributes.

- **M** or **same_size** or **samesize** : -- *same_size=true*\
   Use the same size for all beachballs. Size is set from the magnitude columns, but the same size is used regardless of magnitude.

- **N** or **no_clip** or **noclip** : -- *no_clip=true*\
   Do NOT skip symbols that fall outside the map border [Default clips symbols].

- **T** or **nodal** : -- *nodal=plane* **|** *nodal=(plane=val, pen=...)*\
   Plot nodal planes and circumference only. Specify which plane(s) to draw:
   - **0** : Both planes
   - **1** : Only first nodal plane  
   - **2** : Only second nodal plane
   
   Use tuple form to set pen: `nodal=(plane=0, pen=pen_spec)`

   For double couple mechanisms, the **nodal** option renders the beach ball transparent by drawing only
   the nodal planes and the circumference. For non-double couple mechanisms, **nodal=0** option overlays
   best double couple transparently.

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

- **W** or **pen** : -- *pen=pen*\
   Set pen attributes for text string or default pen attributes for fault plane edges. [Default: 0.25p,black,solid].

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_t}

\textinput{common_opts/opt_xy}


## Data Column Order

The **convention** option determines how many size columns are required to generate the selected symbol,
but if size is not given then we expect to read size from file. In addition, your use of options **scale**,
**intens** and **transparency** will require extra columns. The order of the data record is fixed regardless
of option order, even if not all items may be activated. We expect data columns to come in the following order:

`lon lat depth symbol-columns [size] [scale] [intens] [transp [transp2]] [trailing-text]`

where items given in brackets are optional and under the control of the stated options: **convention**
without a size selects the optional size-columns, **scale** selects the optional scale column, **intens**
selects the optional intens column, and **transparency**  selects the optional transp column(s).
Trailing text is always optional. Notes: (1) depth is normally required but will not be expected if **Fo**
is given to meca. (2) You can use **incols** to rearrange your data record to match the expected format.


## References

Aki, K., & Richards, P. G. (1980). *Quantitative seismology: theory and methods*. San Francisco: W. H. Freeman.

Dahlen, F. A., & Tromp, J. (1998). *Theoretical global seismology*. Princeton, N.J: Princeton University Press.

Frohlich, C. (1996). Cliff's Nodes Concerning Plotting Nodal Lines for P, SH and SV. *Seismological Research Letters*, **67**(1), 16–24, [https://doi.org/10.1785/gssrl.67.1.16](https://doi.org/10.1785/gssrl.67.1.16).

## See Also

\myreflink{meca}, \myreflink{polar}, \myreflink{velo}