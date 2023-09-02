# contour

```julia
	contour(cmd0::String="", arg1=nothing; kwargs...)
```

Contour plot from table data by direct triangulation


Description
-----------

Reads data from file or table and produces a raw contour plot by triangulation. By default,
the optimal Delaunay triangulation is performed (using either Shewchuk's [1996] or Watson's
[1982] method as selected during GMT installation; type **gmt("gmtget GMT_TRIANGULATE")**
to see which method is selected, but the user may optionally provide a second file with
network information, such as a triangular mesh used for finite element modeling. In addition
to contours, the area between contours may be painted according to the CPT. Alternatively,
the *x, y, z* positions of the contour lines may be saved to one or more output files
(or standard output) and no plot is produced.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}


Optional Arguments
------------------

- **A** or **annot** : -- *annot=annot\_int* **|** *annot=(int=annot\_int, disable=true, single=true, labels=labelinfo)*\
  *annot\_int* is annotation interval in data units; it is ignored if contour levels are given in a file.
  [Default is no annotations]. Use *annot=(disable=true,)* to disable all annotations implied by **cont**.
  Alternatively do *annot=(single=true, int=val)* to plot *val* as a single contour. The optional *labelinfo* controls the specifics of the label formatting and consists of a named tuple with the following control arguments \myreflink{Label formatting}

\textinput{common_opts/opt_B}

\textinput{common_opts/explain_Ccontours}

- **D** or **dump** : -- *dump=fname*\
  Dump contours as data line segments; no plotting takes place. Append filename template which may contain
  C-format specifiers. If no filename template is given we return the result in a GMTdataset. If filename has no
  specifiers then we write all lines to a single file. If a float format (e.g., %6.2f) is found we substitute
  the contour z-value. If an integer format (e.g., %06d) is found we substitute a running segment count. If
  an char format (%c) is found we substitute C or O for closed and open contours. The 1-3 specifiers may be
  combined and appear in any order to produce the the desired number of output files (e.g., just %c gives
  two files, just %f would separate segments into one file.

- **E** or **index** : -- *index="indexfile[+b]"* **|** *index=dataset*\
  Give name of file with network information. Each record must contain triplets of node numbers for
  a triangle [Default computes these using Delaunay triangulation (see \myreflink{triangulate})].
  If the *indexfile* is binary and can be read the same way as the binary input *table* then you
  can append **+b** to spead up the reading [Default reads nodes as ASCII]. **index=dataset**
  uses a already *in-memory* matrix or GMTdataset.

- **G** or **labels** : -- *labels=()*\
  The required argument controls the placement of labels along the quoted lines. Choose among five
  controlling algorithms as explained in \myreflink{Placement methods}

- **I** or **fill** or **colorize** : -- *fill=true*\
  Color the triangles using the CPT.

- **L** or **mesh** : -- *mesh=pen*\ 
  Draw the underlying triangular mesh using the specified pen attributes [Default is no mesh].

- **N** or **no_clip** : -- *no_clip=true*\
  Do NOT clip contours or image at the boundaries [Default will clip to fit inside region **region**].

- **Q** or **cut** : -- *cut=np* **|** *cut=length&unit[+z]*\
  Do not draw contours with less than *np* number of points [Draw all contours]. Alternatively, give
  instead a minimum contour length in distance units, including **c** (Cartesian distances using user
  coordinates) or **C** for plot length units in current plot units after projecting the coordinates.
  Optionally, append **+z** to exclude the zero contour.

- **S** or **skip** : -- *skip=true* **|** skip=:p|:t*\
  Skip all input *xyz* points that fall outside the region [Default uses all the data in the
  triangulation]. Alternatively, use **skip=:t** to skip triangles whose three vertices are
  all outside the region.  **skip=true** is interpreted as **skip=:p**.

- **T** or **ticks** : -- *ticks=(local\_high=true, local\_low=true, gap=gap, closed=true, labels=labels)*\
  Will draw tick marks pointing in the downward direction every *gap* along the innermost closed contours only;
  set *closed=true* to tick all closed contours. Use *gap=(gap,length)* and optionally tick mark *length*
  (append units as **c**, **i**, or **p**) or use defaults [*"15p/3p"*]. User may choose to tick only local
  highs or local lows by specifying *local\_high=true*, *local\_low=true*, respectively. Set *labels* to
  annotate the centers of closed innermost contours (i.e., the local lows and highs). If no *labels* (*i.e*,
  set *labels=""*) is set, we use - and + as the labels. Appending exactly two characters, *e.g.*, *labels=:LH*,
  will plot the two characters (here, *L* and *H*) as labels. For more elaborate labels, separate the low and hight
  label strings with a comma (*e.g.*, *labels="lo,hi"*). If a file is given by **cont**, and **ticks** is set,
  then only contours marked with upper case C or A will have tick marks [and annotations]. 

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_pen}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_save_fig}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

Normally, the annotated contour is selected for the legend. You can select the regular contour instead, or both of them, by considering the *label* to be of the format [*annotcontlabel*][/*contlabel*]. If either label contains a slash (/) character then use | as the separator for the two labels instead.
.. include:: explain_-l.rst_

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_xy}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt_t}

\textinput{common_opts/opt__distunits}

Examples
--------

To make a raw contour plot from the remote file Table_5.11.txt and draw the
contours every 25 and annotate every 50, using the default Cartesian projection, try

\begin{examplefig}{}
```julia
using GMT
contour("@Table_5_11.txt", pen=:thin, contour=25, annot=50, show=true)
```
\end{examplefig}

To use the same data but only contour the values 750 and 800, use

\begin{examplefig}{}
```julia
using GMT
contour("@Table_5_11.txt", annot=[750,800], pen=0.5, show=true)
```
\end{examplefig}

To create a color plot of the numerical temperature solution obtained on a triangular mesh
whose node coordinates and temperatures are stored in temp.xyz and mesh arrangement is given
by the file mesh.ijk, using the colors in temp.cpt, run

```julia
    contour("temp.xyz", index="mesh.ijk", region=(0,150,0,100), figscale=0.25,
            cmap="temp.cpt", labels=true, pen=0.25, show=true)
```

To save the triangulated 100-m contour lines in topo.txt and separate
them into multisegment files (one for each contour level), try

```julia
    contour("topo.txt", contour=100, dump="contours_%.0f.txt")
```

\textinput{common_opts/contour_notes}

\textinput{common_opts/auto_legend_info}

See Also
--------

\myreflink{grdcontour},
\myreflink{grdimage},
\myreflink{nearneighbor},
\myreflink{basemap}, \myreflink{colorbar},
\myreflink{surface},
\myreflink{triangulate}
