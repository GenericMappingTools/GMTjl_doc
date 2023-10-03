# image

```julia
    image(cmd0::String="", arg1=nothing; kwargs...)
```

*keywords: GMT, Julia, image plots*

Plot raster or EPS images


Description
-----------

**image** reads an Encapsulated PostScript file or a raster image file and plots it on a map.
The image can be scaled arbitrarily, and 1-bit raster images can be (1) inverted, i.e., black
pixels (on) becomes white (off) and vice versa, or (2) colorized, by assigning different
foreground and background colors, and (3) made transparent where one of back- or foreground
is painted only. As an option, the user may choose to convert colored raster images to grayscale
using TV's YIQ-transformation. For raster files, the user can select which color to be made
transparent. The user may also choose to replicate the image which, when preceded by appropriate
clip paths, may allow larger custom-designed fill patterns to be implemented (the **pattern**
mechanism offered in most GMT programs is limited to rasters smaller than 146 by 146).

Required Arguments
------------------

*imagefile*
    This must be an Encapsulated PostScript (EPS) file or a raster
    image. An EPS file must contain an appropriate BoundingBox. A raster
    file can have a depth of 1, 8, 24, or 32 bits and is read via GDAL.

Optional Arguments
------------------

\textinput{common_opts/opt_B}

- **D** or **pos** or **position** : -- *pos=(map=true, inside=true, outside=true, norm=true, paper=true, anchor=XX, dpi=XX, width=XX, justify=code, repeat=n, offset=XX)*\
    Sets reference point on the map for the image using one of four coordinate systems:
    - (1) Use **map=true** for map (user) coordinates,
    - (2) use **inside=true** or **outside=true** (the default) for setting **anchor** via a 2-char 
      justification code that refers to the (invisible) map domain rectangle,
    - (3) use **norm=true** for normalized (0-1) coordinates, or
    - (4) use **paper=true** for plot coordinates (inches, cm, etc.). All but **paper=true**
      requires both **region** and **proj** to be specified.

    By default, the anchor point on the scale is assumed to be the bottom left corner (BL), but
    this can be changed by adding **justify=:code** where *:code* is a 2-char justification code
    (see \myreflink{text}). **Note**: If `inside` is used (the default) then *justify* defaults
    to the same as `refpoint`, if `outside` is used then `justify` defaults to the mirror opposite
    of `refpoint`. Specify image size in one of two ways: Use **dpi=val** to set the dpi of the
    image in *val* dots per inch, or use **width=width** or **width=(width,height)** to set the width
    (and height) of the image in plot coordinates (inches, cm, etc.). If *height* is not given,
    the original aspect ratio of the image is maintained. If *width* is negative we use the absolute
    value and interpolate image to the device resolution using the PostScript image operator. If
    neither size nor *dpi* is set then we revert to the default dpi [`GMT_GRAPHICS_DPU`]. Optionally,
    use **replicate=nx** or **replicate=(nx,ny)** to replicate the image *nx* times horizontally and
    *ny* times vertically. If *ny* is omitted, it will be identical to *nx* [Default is 1/1].

\textinput{common_opts/opt_box}

- **G** or **bit_color** or **bit_bg|fg|alpha** : -- *bit_bg=color* **|** *bit_fg=color* **|** *bit_alpha=color* **|** *bit_color=color[+b|+f|+t]* \
    Change certain pixel values to another color or make them transparent. For 1-bit images you can
    specify an alternate *color* for the background (**bit_bg=color**) or the foreground (**bit_bf=color**)
    pixels, or give no color to make those pixels transparent. Alternatively, for color images you
    can select a single *color* that should be made transparent instead (**bit_alpha=color**).
    The last form, **G** or **bit_color**, allows using the plain GMT syntax, but does not let
    set more than one of the bg, fg or alpha settings.

- **I** or **invert** : -- *invert=true*\
   Invert 1-bit image before plotting. This is what is done when you use **G=:P** to invert patterns
   in other GMT plotting programs. Ignored if used with color images.

\textinput{common_opts/opt_J}

- **M** or **monochrome** : -- *monochrome=true*\
    Convert color image to monochrome grayshades using the (television) YIQ-transformation.

\textinput{common_opts/opt_R}
For perspective **view**, optionally append *zmin,zmax*.

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_t}

Notes
-----

The **bit_color** and **invert** options are for raster images only. They have
no effect when placing Encapsulated *PostScript* files.

Examples
--------

To plot the remote image needle.jpg, scaling it be 7 cm wide (height is scaled accordingly), use:

\begin{examplefig}{}
```julia
using GMT
image("@needle.jpg", pos=(paper=true, anchor=(0,0), width=7), show=1)
```
\end{examplefig}

To plot the same file but reversing the bands, use:

\begin{examplefig}{}
```julia
using GMT
image("@needle.jpg+b2,1,0", pos=(paper=true, anchor=(0,0), width=7), show=1)
```
\end{examplefig}

To only plot its red band as gray shade, use:

\begin{examplefig}{}
```julia
using GMT
image("@needle.jpg+b0", pos=(paper=true, anchor=(0,0), width=7), show=1)
```
\end{examplefig}

To include an Encapsulated PostScript file gallo.eps with its upper right corner 5 cm to the
right and 2.5 cm up from the current location, and have its width scaled to 4 cm, while
keeping the aspect ratio, use:

\begin{examplefig}{}
```julia
using GMT
image("@gallo.eps", pos=(paper=true, anchor=(5,2.5), justify=:TR, width=4), show=1)
```
\end{examplefig}

To replicate the 1-bit remote raster image vader1.png, colorize it (dark gray background and
yellow foreground), and setting each of 6 by 12 tiles to be 2.5 cm wide, use:

\begin{examplefig}{}
```julia
using GMT
image("@vader1.png", bit_bg=:darkgray, bit_fg=:yellow,
      pos=(paper=true, anchor=(0,0), width=5, repeat=(6,12)), show=1)
```
\end{examplefig}

See Also
--------

\myreflink{legend}, \myreflink{colorbar}, \myreflink{plot}, \myreflink{psconvert}
