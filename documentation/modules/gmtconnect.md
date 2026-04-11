# gmtconnect

```julia
	gmtconnect(cmd0::String="", arg1=nothing, kwargs...)
```

Connect individual lines whose end points match within tolerance

Description
-----------

Reads a multi-column data set and examines the coordinates of the end points of all line
segments. If a pair of end points are identical or closer to each other than the specified
separation *cutoff* then the two line segments are joined into a single segment. The process
repeats until all the remaining endpoints no longer pass the tolerance test; the resulting
segments are then written out to standard output or specified output file. If it is not
clear what the separation tolerance should be then use **linkfile** to get a list of all
separation distances and analyze them to determine a suitable cutoff.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

Optional Arguments
------------------

- **C** or **closed** : -- *closed=true* **|** *closed=closed_file*\
    Write all the already-closed polygons to file *closed* [gmtconnect_closed.txt] and all
    open segments to standard output. No connection will take place. Use **tolerance=cutoff**
    to set a minimum separation [0], and then any existing polygon whose first and last point
    are separated by less that *cutoff* will be considered to be closed. Note that if
    *cutoff* is > 0 then we explicitly close all polygons on output.

- **D** or **dump** : -- *dump=true* **|** *dump="template"*\
    For multiple segment data, dump each segment to a separate output file [Default writes a
    single multiple segment file]. Append a format template for the individual file names;
    this template **must** contain a C format specifier that can format an integer argument
    (the segment number); this is usually %d but could be %08d for leading zeros, etc. Optionally,
    it may also contain the format %c *before* the integer; this will then be replaced by
    C (closed) or O (open) to indicate segment type. [Default is gmtconnect_segment_%d.txt].
    Note that segment headers will be written in either case. For composite segments, a generic
    segment header will be written and the segment headers of individual pieces will be written
    out as comments to make it possible to identify where the connected pieces came from.

- **L** or **links** or **linkfile** : -- *links=true* **|** *linkfile="file"*\
    Writes link information to the specified file [gmtconnect_link.txt] (or return its contents). For each segment we
    write the original segment id, and for the beginning and end point of the segment we report the
    id of the nearest segment, whether it is the beginning (B) or end (E) point that is closest,
    and the distance between those points in units determined by **tolerance**.

- **Q** or **list** or **listfile** : -- *list=true* **|** *listfile="template"*\
    Used with **dump** to write a list file with the names of the individual output files.
    Optionally, append a filename template for the individual file names; this template
    **may** contain a C format specifier that can format an character (C or O for closed
    or open, respectively). [Default is gmtconnect_list.txt].

- **T** or **tolerance** : -- *tolerance=true* **|** *tolerance=cutoff* **|** *tolerance="cutoff+sdist"*\
    Specifies the separation tolerance in the data coordinate units [0]; for geographic data
    append distance unit (see \myreflink{Units}). If two lines have end-points that are closer
    than *cutoff* they will be joined. Optionally, append **+s** *dist* which adds the extra
    requirement that a link will only be made if the *second* closest connection exceeds the
    *dist* distance. The latter distance must be given in the same units as *cutoff*. However,
    if **tolerance** is used with no arguments then we close every line segment or polygon
    *regardless* of the gap distance between the first and last point in the segment.

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_a}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_o}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt_xy}

\textinput{common_opts/opt__distunits}

Examples
--------

To combine the digitized segment lines segment\_\*.txt (whose Cartesian
coordinates are in cm) into as few complete lines as possible, assuming
the end points' digitization error could be up to 0.1 mm, run::

```julia
    D = connect("segment_*.txt", tolerance=0.1)
```

To combine the digitized segments in the multisegment file my_lines.txt
(whose coordinates are in lon,lat) into as few complete lines as
possible, assuming the end points digitization error could be up to 150 m, and write
the complete segments to individual files called Map_segment_0001.txt,
Map_segment_0002.txt, etc., run::

```julia
    connect("my_lines.txt", tolerance="150e", dump="Map_segment_%04d.txt")
```

Bugs
----

The line connection does not work if a line only has a single point.
However, **connect** will correctly add the point to the nearest segment.
Running **connect** again on the new set of lines will eventually connect
all lines that satisfy the criteria given in **tolerance**.

See Also
--------

\myreflink{gmtsimplify},
\myreflink{gmtspatial},
\myreflink{mapproject}
