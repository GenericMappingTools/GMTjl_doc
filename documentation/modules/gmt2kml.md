# gmt2kml

Convert GMT data table to Google Earth KML file.

*keywords: GMT, Julia, KML*

Description
-----------

**gmt2kml** reads one or more GMT table file and converts them to a single output file using
Google Earth's KML format. Data may represent points, lines, polygons, or wiggles, and you may
specify additional attributes such as title, altitude mode, colors, pen widths, transparency,
regions, and data descriptions. You may also extend the feature down to ground level (assuming
it is above it) and use custom icons for point symbols. Finally, there are controls on visibility
depending on level of detail settings, altitude, regions, including the status upon loading into
Google Earth as well as fading depending on zoom.

The input files should contain the following columns:

*lon* *lat* [ *alt* ] [ *timestart* [ *timestop* ] ]

where *lon* and *lat* are required for all features, *alt* is optional for all features
(see also **mode** and **cmap**), and *timestart* and *timestop* apply to events and timespan
features. For wiggles, the *alt* column is required but is expected to represent an along-track
data anomaly such as gravity, magnetics, etc. These values will be scaled to yield distances
from the line in degrees.

The output of this function can be sent back to Julia as a \myreflink{GMTdataset} but most of times
there is no real interest in that. The more useful usage is to redirect the result into a disk file
since that's what GE reads. To do this, one should use the **|>="fname"** or **write="fname"** options.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

Optional Arguments
------------------

- **A** or **mode** : -- *mode=:a|:g|s* **|** *mode="a|g|s<altitude>"*\
    Select one of three altitude modes recognized by Google Earth that
    determines the altitude (in m) of the tile layer: **a** absolute
    altitude, **g** altitude relative to sea surface or ground, **s**
    altitude relative to seafloor or ground. To plot the tiles at a
    fixed altitude, append an altitude *altitude* (in m). Use 0 to clamp the
    features to the chosen reference surface. [By default the tiles are clamped
    to the sea surface or ground].

\textinput{common_opts/use_cpt_grd}

- **D** or **descript** : -- *descript=descriptfile*\
    File with HTML snippets that will be included as part of the main
    description content for the KML file [no description]. See SEGMENT
    INFORMATION below for feature-specific descriptions.

- **E** or **extrude** : -- *extrude=true* **|** *extrude="+e"* *extrude="+s"*\
    Control how lines and polygons are rendered in Google Earth.
    Use **+e** to extrude the feature down to ground level [no extrusion].
    Use **+s** to connect points with straight lines (which may intersect
    the Earth's surface and be invisible) [tessellate onto surface].

- **F** or **feature_type** : -- *feature_type=:e|:s|:t|:l|:p|:w*\
    Sets the feature type. Choose from points (**e**vent, **s**ymbol, or **t**imespan), **l**ine, **p**olygon,
    or **w**iggle [symbol]. The first two columns of the input file should contain (*lon*, *lat*).
    When altitude or value is required (i.e., no *altitude* value was given with **mode**, or
    **cmap** is set), the third column needs to contain the *altitude* (in m) or *value*.
    The event (**feature_type=:e**) is a symbol that should only be active at a particular *time*,
    given in the next column. Timespan (**feature_type=:t**) is a symbol that should only be active
    during a particular time period indicated by the next two columns (*timestart*, *timestop*).
    Use NaN to indicate unbounded time limits. If used, times should be in ISO format
    yyyy-mm-ddThh:mm:ss[.xxx] or in GMT relative time format (see **colinfo**). For wiggles, the
    data anomaly is required to be in the 3rd input column. If you also need to plot the track
    itself then do that separately with **feature_type=:l**.

- **G** or **fill** : -- *fill=color* **|** *fill="+f|+n"*\
    Sets *color* for fill (modifier **+f** [Default]) or label font (modifier **+n**).
    Fill sets infill color for symbols, extrusions, polygons and positive anomaly wiggles
    [Default is light orange at 75% transparency]. Alternatively, use **fill="+f"** to turn off
    such infill. Text labels: Specify *color* for the font [Default is white]. Alternatively,
    use **fill="+n"** to instead disable the labels.

- **I** or **icon** : -- *icon=URL*\
    Specify the URL to an alternative icon that should be used for the symbol [Default is a Google
    Earth circle]. If the URL starts with + then we will prepend ``http://maps.google.com/mapfiles/kml/``
    to the name. To turn off icons entirely (e.g., when just wanting a text label), use **icon=-**.
    [Default is a local icon with no directory path].

- **K** or **not_over** : -- *not_over=true*\
    Allow more KML code to be appended to the output later [finalize the KML file].

- **L** or **extra_data** : -- *extra_data="name1,name2,..."*\
    Extended data given. Append one or more column names separated by commas. We will expect the
    listed data columns to exist in the input immediately following the data coordinates required
    for the selected feature set by **feature**, and they will be encoded in the KML file as Extended
    Data sets, whose attributes will be available in a Google Earth balloon when the item is selected.
    The data file must have enough data columns and trailing text to accommodate the number of columns
    requested. If the number of extended data is one larger than the number of available numerical
    columns then the entire trailing text is set as the last extended data column.  Otherwise, the
    trailing text is split into individual words and set as separate extended columns.

- **N** or **feature_name** : -- *feature_name=true* **|** *feature_name="t|col|name\_template|name"*\
    By default, if segment headers contain a **-L**"label string" then we use that for the name of
    the KML feature (polygon, line segment or set of symbols). Default names for these segments are
    "Line %d" and "Point Set %d", depending on the feature, where %d is a sequence number of line
    segments within a file. Each point within a line segment will be named after the line segment
    plus a sequence number.  Default is simply "Point %d". Alternatively, select one of these options: 
     1. append *col* to supply individual symbol labels as the string formatted from the *col* data column, 
     2. append **t** to let individual symbol labels be the trailing text of each record 
     3. append a string that may include %d or a similar integer format to assign unique name
        IDs for each feature, with the segment number (for lines and polygons) or point number
        (symbols) appearing where %d is placed,
     4. give no arguments to turn symbol labeling off; line segments will still be named.
        
    Also note that option (2) is not available unless input is an ASCII file.

- **O** or **overlay** : -- *overlay=true*\
    Append KML code to an existing KML file [initialize a new KML file]. **WARNING** the use of this
    option requires saving the result to file (that is, not returning it as a dataset) **and** the use
    of ``append="kmlfile"`` and **not** any of the ``|>="kmlfile"`` or ``write="kmlfile"`` file saving
    options.

- **Qa** or **wiggles** or **wiggle_fixedazim** or **wiggle_scale=** : -- *wiggles=az* **|** *wiggle_fixedazim=az* **|** *wiggle_scale=scale*\
    Option in support of wiggle plots (requires **feature_type=:w**). You may control which directions the
    positive wiggles will tend to point to with **wiggles=**azim. The appended *azimuth* defines
    a half-circle centered on the selected azimuth [0] where positive anomalies will plot. If outside
    then switch by 180 degrees. Alternatively, use **wiggle_fixedazim** to set a fixed *azimuth*
    with no further variation. Scaling is also required via **wiggle_scale=**scale.  Set a wiggle
    scale in *z*-data units per the user's units (given via the trailing unit taken from
    d|m|s|e|f|k|M|n|u [e]). This scale is then inverted to yield degrees per user z-unit and used
    to convert wiggle anomalies to map distances and positions.

- **R** or **region** : -- *region=:e* **|** *region=(w,e,s,n)*\
    Issue a single Region tag. Use **region=(w,e,s,n)** to set a particular region (will ignore points
    outside the region), or **region=:e** to determine and use the exact domain of the data
    (single file only) [no region tags issued].

- **S** or **ilscale** : -- *ilscale="c<scale>"* **|** *ilscale="n<scale>"*\
    Scale icons or labels. Here, **ilscale="c<scale>"** sets a scale for the symbol
    icon, whereas **ilscale="n<scale>"** sets a scale for the name labels [1 for both].

- **T** or **title** : -- *title=title* **|** *title=("title","FolderName")*\
    Sets the document title [default is unset]. Optionally, set also the *FolderName*; this allows
    you, with **overlay**, **not_over**, to group features into folders within the KML document.
    [The default folder name is "*Name* Features", where *Name* is Point, Event, Timespan, Line,
    Polygon or Wiggle].

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_pen}

- **Z** or **attrib** : -- *attrib="+aalt_min/alt_max][+fminfade/maxfade][+lminLOD/maxLOD][+o][+v]"*\
    Set one or more attributes of the Document and Region tags. Append **+aalt\_min/alt\_max**
    to specify limits on visibility based on altitude. Add **+f**fade\_min/fade\_max** to fade
    in and out over a ramp [abrupt]. Add **+llod\_min/lod\_max** to specify limits on visibility
    based on Level Of Detail, where a *lod\_max* of -1 means it is visible to infinite size.
    Add **+o** to open a older or document in the sidebar when loaded [closed].
    Add **+v** to make a feature *not* visible when loaded [visible].

\textinput{common_opts/opt_a}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_xy}


Examples
--------

To plot colored symbols based on a CPT of the remote file @kml_pointsets.txt,
first make the CPT and then create the KML file thus:

```julia
    C = makecpt(cmap=:categorical)
    gmt2kml("@kml_pointsets.txt", cmap=C, |>="points.kml")
```

To convert a file with point locations (lon, lat) into a KML file with red circle symbols, try

```julia
    gmt2kml("mypoints.txt", fill="red+f", feature_type=:s, |>="mypoints.kml")
```

To convert a multisegment file with lines (lon, lat) separated by
segment headers that contain a **-L**\ labelstring with the feature
name, selecting a thick white pen, and title the document, try

```julia
    gmt2kml("mylines.txt", pen=(:thick,:white), feature_type=:l,
            title="Lines from here to there", |>="mylines.kml")
```

To convert a multisegment file with polygons (lon, lat) separated by
segment headers that contain a **-L**\ labelstring with the feature
name, selecting a thick black pen and semi-transparent yellow fill,
giving a title to the document, and prescribing a particular region limit, try

```julia
    gmt2kml("mypolygons.txt", fill="yellow@50+f", feature_type=:p, title="My polygons",
            region=(30,90,-20,40), |>="mypolygons.kml")
```

To extract contours and labels every 10 units from the grid temp.nc and plot
them in KML, using red lines at 75% transparency and red labels (no transparency), try

```julia
    D = grdcontour("temp.nc", scale=1, annot="10+tlabel.txt", cont=10, dump=true)
    gmt2kml(D, feature_type=:l, pen=(1,"red@75"), not_over=true, |>"contours.kml")
    gmt2kml("label.txt", overlay=true, feature_name=:t, feature_type=:s ilscale="n2",
            fill="red@0+n", icon="-", append="contours.kml")
```

To instead plot the contours as lines with colors taken from the cpt
file contours.cpt, try

```julia
    gmt2kml("contours.txt", feature_type=:l, cmap="contours.cpt", |>="contours.kml")
```

To plot magnetic anomalies as wiggles along track, with positive wiggles painted orange and
the wiggle line drawn with a black pen of width 2p, scaling the magnetic anomalies (in nTesla)
so that 50 nT equals 1 nm on the map, and place the wiggles 50m above the sea surface, use

```julia
    gmt2kml("magnetics_lon_lat_mag.txt", feature_type=:w, fill="orange+f",
            pen=2, mode="g50", wiggle_scale="50n", |>="wiggles.kml")
```

Limitations
-----------

Google Earth has trouble displaying filled polygons across the Dateline. For now you must
manually break any polygon crossing the dateline into a west and east polygon and plot
them separately. Google Earth also has other less obvious limitations on file size or
line length. These do not seem to be documented. If features do not show and you are
not getting an error, try to reduce the size of the file by splitting things up.

Making Kmz Files
----------------

Using the KMZ format is preferred as it takes less space. KMZ is simply a KML file and any data
files, icons, or images referenced by the KML, contained in a zip archive. One way to organize
large data sets is to split them into groups called Folders. A Document can contain any number
of folders. Using scripts you can create a composite KML file using the **not_over**, **overlay**
options just like you do with GMT plots. See **title** for switching between folders and documents.
The gmt_shell_scripts.sh contains function gmt_build_kmz that can assist in building a KMZ file
from any number of KML files (and optionally images they may refer to).

If you have made a series of KML files (which may depend on other items
like local PNG images), you can consolidate these into a single KMZ file
for saving space and for grouping related files together. The bash function
**gmt_build_kmz** in the `gmt_shell_functions.sh` can be used to
do this. You need to source gmt_shell_functions.sh first before you can use it.

Kml Hierarchy
-------------

GMT stores the different features in hierarchical folders by feature
type (when using **overlay**, **not_over** or **title=tit/foldername**), by input file
(if not standard input), and by line segment (using the name from the
segment header, or **feature_name**). This makes it more easy in Google Earth to
switch on or off parts of the contents of the Document.

Segment Information
-------------------

**gmt2kml** will scan the segment headers for substrings of the form
**-L**"*some label*" [also see **feature_name** discussion] and **-T**"*some
text description*". If present, these are parsed to supply name and
description tags, respectively, for the current feature.

See Also
--------

\myreflink{grd2kml}, \myreflink{kml2gmt}, \myreflink{psconvert}
