# meca

```julia
meca(cmd0::String="", arg1=nothing; kwargs...)
```

**meca** - Plot focal mechanisms

## Description

Reads data values from tables or input arguments and plots focal mechanisms (beachballs).
The module reads focal mechanism parameters and plots the corresponding beachballs on a map.
Several input format conventions are supported: Aki & Richards, Global CMT, moment tensor,
partial focal mechanism, and principal axis.

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

- **A** or **offset** : -- *offset=true* **|** *offset=(fill=..., offset=.., pen=..., size=...)*\
   Offsets beachballs to the longitude, latitude specified in the last two columns of the input. A line connects the original and relocated positions. Available modifiers:
   - **fill** : Symbol fill color
   - **offset** : Interpret the contents of the two columns as plot offsets instead, or append fixed offset dx[/dy] for all events.
   - **pen** : Line pen attributes
   - **size** : Set the size of the symbol. Prepend any of a|c|d|g|h|i|n|p|s|t|x to change the symbol fron the default [c] 

\textinput{common_opts/opt_B}

- **C** or **color** or **cmap** : -- *cmap=cpt*\
   Give a CPT to determine compressive quadrant fill based on depth (3rd column).

- **D** or **depth_range** : -- *depth_range=(depmin,depmax)*\
   Plot only events with depths between *depmin* and *depmax*.

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
   Set pen attributes for features [Default pen is 0.25p,black,solid]. This setting applies to **A**, **L**, **T**, **Fp**, **Ft**, and **Fz**, unless overruled by options to those arguments. See also \myreflink{Pen attributes}

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

## Examples

\myreflink{focal_mechanisms}

Plot focal mechanisms using Aki-Richards convention:

```julia
using GMT

# Create focal mechanism data  
D = mat2ds([0.0 5.0 0.0 0 90 0 5 0 0], ["Right Strike Slip"])

# Plot with fixed size beachballs
meca(D, region=(-1,4,1,6), proj=:Mercator, aki=2.5, fill=:black, show=true)
```

Plot using Global CMT convention with depth-based coloring:

```julia
# Background map
grdimage("@earth_relief", region=[-74,-59,5,15], proj=:guess, figsize=10, shade=true)
coast!(shorelines=true, borders=((type=1, pen=0.8),(type=2, pen=0.1)))

# Focal mechanisms with offsets
meca!("focal_data.txt", CMT=(scale=0.4, font=6), offset=true, fill=:black, show=true)
```

Plot multiple mechanisms with varying types:

```julia
using GMT

# Right lateral strike slip
D1 = mat2ds([0.0 5.0 0.0 0 90 0 5 0 0], ["Right Strike Slip"])
meca(D1, region=(-1,4,1,6), proj=:Mercator, aki=2.5, fill=:black)

# Thrust fault
D2 = mat2ds([0.0 3.5 0.0 0 45 90 5 0 0], ["Thrust"])
meca!(D2, aki=2.5, fill=:black)

# Normal fault
D3 = mat2ds([0.0 2.0 0.0 0 45 -90 5 0 0], ["Normal"])  
meca!(D3, aki=2.5, fill=:black, show=true)
```

## References

Aki, K., & Richards, P. G. (1980). *Quantitative seismology: theory and methods*. San Francisco: W. H. Freeman.

Dahlen, F. A., & Tromp, J. (1998). *Theoretical global seismology*. Princeton, N.J: Princeton University Press.

Frohlich, C. (1996). Cliff's Nodes Concerning Plotting Nodal Lines for P, SH and SV. *Seismological Research Letters*, **67**(1), 16–24, [https://doi.org/10.1785/gssrl.67.1.16](https://doi.org/10.1785/gssrl.67.1.16).

Lay, T., & Wallace, T. C. (1995). *Modern global seismology*. San Diego: Academic Press.

## See Also

\myreflink{coupe}, \myreflink{polar}, \myreflink{velo}