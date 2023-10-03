# gmtsplit

```julia
	gmtsplit(cmd0::String="", arg1=nothing; kwargs...)
```

*keywords: GMT, Julia, break lines*

Split xyz[dh] data tables into individual segments

Description
-----------

**gmtsplit** reads a series of (x,y[,z]) records [or optionally
(x,y[,z],d,h); see |-S| option] from standard input [or *xy[z][dh]file*]
and splits this into separate lists of (x,y[,z]) series, such that each
series has a nearly constant azimuth through the x,y plane. There are
options to choose only those series which have a certain orientation, to
set a minimum length for series, and to high- or low-pass filter the z
values and/or the x,y values. **gmtsplit** is a useful filter between
data extraction and \myreflink{wiggle} plotting, and can also be used to
divide a large x,y[,z] dataset into segments.

Required Arguments
------------------

- *table*\
    Data from file or a *in-memory* array with 2, 3, or 5 columns holding (x,y,[z[,d,h]])
    data values. To use (x,y,z,d,h) input, sorted so that d is
    non-decreasing, specify the **dist_head** option; default expects (x,y,z) only.

Optional Arguments
------------------

- **A** or **azim_tol** : -- *azim_tol=(azimuth,tolerance)*\
    Write out only those segments which are within ±*tolerance* degrees of *azimuth* in
    heading,measured clockwise from North, [0 - 360]. [Default writes all acceptable segments,
    regardless of orientation].

- **C** or **course_change** : -- *course_change=ang*\
    Terminate a segment when a course change exceeding *ang* degrees of heading is detected [ignore course changes].

- **D** or **min_dist** or **min_distance** : -- *min_dist=distance*
    Do not write a segment out unless it is at least *distance* units long [0].

- **F** or **filter** : -- *filter=(xy\_filter,z\_filter)*
    Filter the z values and/or the x,y values, assuming these are functions of d coordinate.
    *xy\_filter* and *z\_filter* are filter widths in distance units. If a filter width is zero,
    the filtering is not performed. The absolute value of the width is the full width of a
    cosine-arch low-pass filter. If the width is positive, the data are low-pass filtered;
    if negative, the data are high-pass filtered by subtracting the low-pass value from the
    observed value. If *z\_filter* is non-zero, the entire series of input z values is filtered
    before any segmentation is performed, so that the only edge effects in the filtering will
    happen at the beginning and end of the complete data stream. If *xy\_filter* is non-zero,
    the data is first divided into segments and then the x,y values of each segment are filtered
    separately. This may introduce edge effects at the ends of each segment, but prevents a
    low-pass x,y filter from rounding off the corners of track segments. [Default = no filtering].

**N** or **multi** : -- *multi=true* **|** *multi="template"*\
    Write each segment to a separate output file. Default returns data in a GMTdataset. Optionally
    append a format template for the individual file names; this template **must** contain a C format
    specifier that can format an integer argument (the running segment number across all tables);
    this is usually %d but could be %08d which gives leading zeros, etc. [Default is gmtsplit\_segment\_%d.{txt\|bin},
    depending on **binary_out**]. Alternatively, give a template with two C format specifiers and we
    will supply the table number and the segment number within the table to build the file name.

- **Q** or **xyzdh** : -- *xyzdh=:flags*\
    Specify your desired output using any combination of *xyzdh*, in any order. Do not space between
    the letters. Use lower case. Default is **xyzdh=xyzdh** (**xyzdh=xydh** if only 2 input columns)].

- **S** or **dist_head** : -- *dist_head=true*\
    Both d and h are supplied. In this case, input contains x,y,z,d,h. [Default expects (x,y,z) input,
    and d,h are computed from delta x, delta y. Use **colinfo=:g** to indicate map data; then x,y are
    assumed to be in degrees of longitude, latitude, distances are considered to be in kilometers,
    and angles are actually azimuths. Otherwise, distances are Cartesian in same units as x,y and
    angles are counter-clockwise from horizontal].

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

.. |Add_-g| replace:: Do not let a segment have a gap exceeding *gap*; instead, split it into two segments. [Default ignores gaps].
\textinput{common_opts/opt_h}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt_xy}

Distance Calculations
---------------------

The type of input data is dictated by the **colinfo** option. If **colinfo=:g** is
given then x,y are in degrees of longitude, latitude, distances are in
kilometers, and angles are azimuths. Otherwise, distances are Cartesian
in same units as x,y and angles are counter-clockwise from horizontal.

Examples
--------

Suppose you want to make a wiggle plot of magnetic anomalies on segments
oriented approximately east-west from a NCEI-supplied cruise called JA020015 in the
region **region=(300,315,12,20)**. You want to use a 100 km low-pass filter to
smooth the tracks and a 500km high-pass filter to detrend the magnetic
anomalies. Try this:

```julia
    D = gmt("mgd77list JA020015 -R300/315/12/20 -Flon,lat,mag,dist,azim");
    D = split(D, azim_tol=(90,15), filter=(100,-500), min_dist=100, disthead=true, colinfo=:g);
    wiggle(region=(300,315,12,20), proj=:Merc, scale=1.5, title="JA020015", track=1,
           pen=0.75, fill=:gray, ampscale=200, show=true)
```

MGD-77 users: For this application we recommend that you extract dist,azim
from `mgd77list <supplements/mgd77/mgd77list>` rather than have
**gmtsplit** compute them separately.

Suppose you have been given a binary, double-precision file containing
lat, lon, gravity values from a survey, and you want to split it into
profiles named *survey_###.txt* (when gap exceeds 100 km). Try this:

```julia
    gmtsplit("survey.bin", multi="survey_%03d.txt", gap="d100k", min_dist=100,
             yx=true, colinfo=:g, binary_in="3d")
```

See Also
--------

\myreflink{filter1d}, \myreflink{wiggle}
