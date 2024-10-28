# coast

```julia
coast(cmd0::String=""; kwargs...)
```

*keywords: GMT, Julia, geographical mapping*

Plot continents, shorelines, rivers, and borders on maps

Description
-----------

Plots grayshaded, colored, or textured land-masses [or water-masses] on maps and optionally draws
coastlines, rivers, and political boundaries. Alternatively, it can (1) issue clip paths that will
contain all land or all water areas, or (2) dump the data to an ASCII table. The data files come in 5
different resolutions: (**f**)ull, (**h**)igh, (**i**)ntermediate, (**l**)ow, and (**c**)rude. The
full resolution files amount to more than 55 Mb of data and provide great detail; for maps of larger
geographical extent it is more economical to use one of the other resolutions. If the user selects to
paint the land-areas and does not specify fill of water-areas then the latter will be transparent
(i.e., earlier graphics drawn in those areas will not be overwritten). Likewise, if the water-areas are
painted and no land fill is set then the land-areas will be transparent. A map projection must be supplied.


- **J** or **proj** or **projection** : -- *proj=<parameters>*\
   Select map projection. More at ` ` \myreflink{proj}
<!-- \textinput{common_opts/opt_J} -->

\textinput{common_opts/opt_R}

\textinput{common_opts/explain_Acoast}

\textinput{common_opts/opt_B}

- **C** or **river\_fill** : -- *river\_fill=fill* **|** *river\_fill=(lake=true, river\_lake=true, fill=fill)*\
   Set the shade, color, or pattern for lakes and river-lakes [Default is the fill chosen for "wet" areas (*water*)]. Optionally, specify separate fills by using **river\_fill=(lake=true, fill=fill)** for lakes and **river\_fill=(river\_lake=true, fill=fill)** for river-lakes. To repeate the **river\_fill** option use a tuple of tuples.

- **clip** : -- *clip=:land* **|** *clip=:water|ocean* **|** *clip=:end*\
   **clip=:land** or **clip=:water|ocean** starts a clipping path. **clip=:end** marks end of existing clip path. No projection information is needed. Also supply **X** and **Y** settings if you have moved since the clip started.

- **D** or **res** or **resolution** : -- *res=:full* **|** *res=:auto*\
   Selects the resolution of the data set to use *full*, *high*, *intermediate*, *low*, and *crude*.
   The resolution drops off by 80% between data sets. The default is **res=:auto**, which chooses
   to automatically select the best resolution given the chosen map scale.

- **E** or **DCW** : -- *DCW=code1,code2,...* **|** *DCW=(country=code, continent=code, pen=pen, fill=fill, file=fname, inside=true, outside=false, adjust_r=??, , adjust_R=??, , adjust_e=??, headers=false)*\
   Select painting country polygons from the Digital Chart of the World. This is another dataset independent of GSHHG and hence the **area** and **resolution** options do not apply. **DCW="+l"** just list the countries and their codes [plotting takes place] and **DCW="+L"** shows states/territories for Argentina, Australia, Brazil, Canada, and the US. *country* or **name=code(s)**, where **code(s)** is a one or more comma-separated countries using the 2-character ISO 3166-1 alpha-2 convention. To select a state of a country (if available), append .state, e.g, US.TX for Texas. To specify a whole continent, use **continent=code**, with continent codes AF (Africa),AN (Antarctica), AS (Asia), EU (Europe), OC (Oceania), NA (North America), or SA (South America). Use **pen=pen** (see \myreflink{Pen attributes}) to draw polygon outlines and **fill=fill** (see \myreflink{Fill color/pattern}) to fill them [default is no fill]. At least one of these must be specified unless **dump** is in effect, in which case only one **DCW** option can be given. It is also possible to specify the parameters using simple Tuples. For example: **DCW=("PT", (0.5,"red","--"), "blue")** plots the polygon *PT* with a 0.5p red dashed line and filled with blue and **DCW=:PT** uses a default pen of 0.5. **DCW=(:PT, :blue)** fills with blue. You may repeat **DCW** to give different groups of items their own *pen/fill* settings. However, since we cannot repeat a keyword, the solution to setting different groupes is to use a tuple of tuples. An example would be *DCW=((country=:PT, pen=(2,:red), fill=:blue), (country=:ES, pen=(2,:blue)) )*. If neither **proj** nor **dump** are set then we just print the **region**. The **file=fname** is a new option in future GMT to let users select alternative DCW files. The **inside=true** (the default) means that data is ket _inside_ the clipping polygon. Use **outside=true** if want the reverse. **adjust_r=??** adjusts the region boundaries to be multiples of the steps indicated by _inc_ or _xinc/yinc_ or _winc/einc/sinc/ninc_. **adjust_R=??** adjusts the region boundaries adding the amounts specified by _inc_ or _xinc/yinc_ or _winc/einc/sinc/ninc_. **headers=true** place the country code in the segment headers via _-Zcode_ settings (for use with the **dump** option). 

- **getR** or **getregion** or **get_region** : -- *getR=code1,code2,...*\
   Return the region corresponding to the code/list-of-codes passed in as argument. The code(s) are the same
   as in the **DCW** option above.

\textinput{common_opts/opt_box}

- **G** or **land** : -- *land=fill*\
   Select filling (see \myreflink{Fill color/pattern}) "dry" areas. Append the shade, color, or pattern.

- **I** or **rivers** : -- *rivers=type* **|** *rivers=(type, pen)* **|** *rivers=(type=type, pen=pen)*\
   Draw rivers. Specify the *type* of rivers and [optionally] append pen attributes [Default pen: width = default, color = black, style = solid].\
   Choose *type* from the list of river types below; To repeat this option, use a tuple of tuples but only the NamedTuple version is allowed (the simpler **rivers=(type, pen)** doesn't allow repetitions).

      0 = Double-lined rivers (river-lakes)
      1 = Permanent major rivers
      2 = Additional major rivers
      3 = Additional rivers
      4 = Minor rivers
      5 = Intermittent rivers - major
      6 = Intermittent rivers - additional
      7 = Intermittent rivers - minor
      8 = Major canals
      9 = Minor canals
      10 = Irrigation canals

      You can also choose from several preconfigured river groups:

      a = All rivers and canals (0-10)
      A = All rivers and canals except river-lakes (1-10)
      r = All permanent rivers (0-4)
      R = All permanent rivers except river-lakes (1-4)
      i = All intermittent rivers (5-7)
      c = All canals (8-10)

\textinput{common_opts/opt_map_scale}

- **M** or **dump** : -- *dump=true*\
   Dumps a single multisegment ASCII (or binary, see **-bo**) file to standard output. No plotting occurs. Specify one of **DCW**, **rivers**, **borders** or **shore**. Note: if **dump** is used with **DCW** then **region** or the **+r** modifier to **DCW** are not required as we automatically determine the region given the selected geographic entities.

- **minpts** : -- *minpts=??*\
   Minimum number of points in a DCW polygon. If the number of points in a polygon is less than this value, it will be dropped.
   This option is only available when used together with **E** or **DCW**. Useful when the country polygons are used in \myreflink{zonal_stats} and you want to get rid of the small polygons that only consume time.

- **N** or **borders** : -- *borders=type* **|** *borders=(type, pen)* **|** *borders=(type=type, pen=pen)*\
   Draw political boundaries. Specify the *type* of boundary and optionally append pen attributes [Default pen: width = default, color = black, style = solid].\
   Choose *type* from the list of boundaries below. To repeat this option, use a tuple of tuples but only the NamedTuple version is allowed (the simpler **borders=(type, pen)** doesn't allow repetitions).

      1 = National boundaries
      2 = State boundaries within the Americas
      3 = Marine boundaries
      a = All boundaries (1-3)

- **S** or **water** or **ocean** : -- *water=fill*\
   Select filling of "wet" areas. Append the shade, color, or pattern;  [Default is no fill].

\textinput{common_opts/opt_rose}

\textinput{common_opts/opt_compass}

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

- **W** or **shore** or **shorelines** or **coast** or **coastlines** : -- *shore=pen* **|** *shore=(level=lev, pen=pen)*\
   Draw shorelines [the Default]. Append pen attributes (see \myreflink{Pen attributes}) [Defaults: width = default,
   color = black,style = solid] which apply to all four levels. To set the pen for each level differently, use the
   form **shore=(level=levnum, pen=pen)**, where **levnum** is 1-4 and represent coastline, lakeshore, island-in-lake
   shore, and lake-in-island-in-lake shore. To repeat the **shore** option, use a tuple of tuples. When specific
   level pens are set, those not listed will not be drawn [Default draws all levels; but see **area**].  Note, the
   equivalent of the `borders` and `rivers` form **shore=(level,pen)** is not possible here because the parser cannot
   tell if `shore=(2,:red)` means plot *level=2* in red or all levels with a line thicknes of 2 points and color `red`. 

- **Z** : -- *Z=true* **|** *Z=grid*\
   Add a third column to the **dump** option (**Z** is ignored if **dump** is not set). This third column will be filled
   with zeros when **Z=true** or it interpolates the grid _grid_ (a file name or a \myreflink{GMTgrid} object) with
   \myreflink{grdrack} at the locations of the coastline. This is particularly useful if one wants to drape a coastline
   on top of a \myreflink{grdview} plot.

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_t}

\textinput{common_opts/opt_save_fig}

Examples
--------

To plot Great Britain, Italy, and France in blue with a red outline and Spain, Portugal and Greece in yellow
(no outline), and pick up the plot domain form the extents of these countries, use:

\begin{examplefig}{}
```julia
using GMT
coast(proj=:Mercator, DCW=((country="GB,IT,FR", fill=:blue, pen=(0.25,:red)),
                           (country="ES,PT,GR", fill=:yellow)), show=true)
```
\end{examplefig}

\textinput{common_opts/explain_gshhg}