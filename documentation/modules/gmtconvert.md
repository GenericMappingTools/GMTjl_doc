# gmtconvert

```julia
    gmtconvert(cmd0::String="", arg1=nothing, kwargs...)
```

## WARNING: ONLY HALF PORTED TO GMT.JL NEED HELP FOR FINISHING


Description
-----------

Can do a combination of nine tasks: (1) convert between binary and ASCII data tables, (2) paste
corresponding records from multiple files horizontally into a single
file, (3) extract a subset of the available columns, (4) only extract
segments whose header record matches a text pattern search, (5) only
list segment headers and no data records, (6) extract first and/or last
data record for each segment, (7) reverse the order of items on output,
(8) output only ranges of segment numbers, and (9) output only segments
whose record count matches criteria. Input (and hence output) may have multiple
sub-headers, and ASCII tables may have regular headers as well.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

Optional Arguments
------------------

- **A** or **hcat** : -- *hcat=true*\
    The records from the input files should be pasted horizontally, not
    appended vertically [Default]. All files must have the same number
    of segments and number of rows per segment. Note for binary input,
    all the files you want to paste must have the same number of columns
    (as set with **-bi**); ASCII tables can have different number of columns.

- **C** or **n_records** : -- *n_records=[**+l**\ *min*][**+u**\ *max*][**+i**]*\
    Only output segments whose number of records matches your given criteria:
    Append **+l**\ *min* to ensure all segment must have at least *min* records
    to be written to output [0], and append **+u**\ *max*  to ensure all segments
    must have at most *max* records to be written [inf].  You may append **+i**
    to invert the selection, i.e., only segments with record counts outside the
    given range will be output.

- **D** or **dump** : -- *dump=[*template*\ [**+o**\ *orig*]]*\
    For multiple segment data, dump each segment to a separate output
    file [Default writes a multiple segment file to standard output]. Append a
    format template for the individual file names; this template
    **must** contain a C format specifier that can format an integer
    argument (the running segment number across all tables); this is
    usually %d but could be %08d which gives leading zeros, etc.
    [Default is gmtconvert_segment\_%d.{txt\|bin}, depending on
    **-bo**]. Append **+o**\ *orig* to start the numbering from *orig*
    instead of zero.  Alternatively, give a template with
    two C format specifiers and we will supply the table number and the
    segment number within the table to build the file name.
    Append **+o**\ *torig*\ /*sorig* to start the numbering of tables
    from *torig* and numbering of segments within a table from *sorig*
    instead of zero.  The **+o** modifier will be stripped off before
    the *template* is used.

- **E** or **first_last** : -- *first_last=[**f|l|m|M** *stride*]*\
    Only extract the first and last record for each segment of interest
    [Default extracts all records]. Optionally, append **f** or **l** to
    only extract the first or last record of each segment, respectively.
    Alternatively, append **m**\ *stride* to extract every *stride* records;
    use **M** to also include the last record.

- **F** or **conn_method** : -- *conn_method=[**c|n|p|v**][**a|t|s|r| *refpoint*]*\
    Alter the way points are connected (by specifying a *scheme*) and data are grouped (by specifying a *method*).
    Append one of four line connection schemes:
    - **c** : Form continuous line segments for each group [Default].
    - **p** : Form line segments from a reference point reset for each group.
    - **n** : Form networks of line segments between all points in each group.
    - **v** : Form vector line segments suitable for :doc:`plot` **-Sv+s**.
    Optionally, append the one of four segmentation methods to define the group:
    - **a** : Ignore all segment headers, i.e., let all points belong to a single group,
    and set group reference point to the very first point of the first file.
    - **t** : Consider all data in each table to be a single separate group and reset the group reference point to the first point of each group.
    - **s** : Segment headers are honored so each segment is a group; the group
    reference point is reset to the first point of each incoming segment [Default].
    - **r** : Same as **s**, but the group reference point is reset after each record to the previous point (this method is only available with the **Fp** scheme).

    Instead of the codes **a|f|s|r** you may append the coordinates of a *refpoint* which will serve
    as a fixed external reference point for all groups.

- **I** or **invert** or **reverse** : -- *invert=true* **|** *invert=:tsr*\
    Invert the order of items, i.e., output the items in reverse order,
    starting with the last and ending up with the first item [Default
    keeps original order]. Append up to three items that should be
    reversed: **t** will reverse the order of tables, **s** will reverse
    the order of segments within each table, and **r** will reverse the
    order of records within each segment [Default].

- **L** or **list_only** : -- *list_only=true*\
    Only output a listing of all segment header records and no data
    records (requires ASCII data).

- **N** or **sort** : -- *sort=*col* [**+a|d**]*\
    Numerically sort each segment based on values in column *col*.
    The data records will be sorted such that the chosen column will
    fall into ascending order [**+a**, which is Default]. Append **+d**
    to sort into descending order instead. The **sort** option can be
    combined with any other ordering scheme except **conn_method** (segmentation)
    and is applied at the end.

- **Q** or **segments** : -- *segments=[**~**]\ *selection* *\
    Only write segments whose number is included in *selection* and skip
    all others. Cannot be used with |-S|. The *selection* syntax is
    *range*[,*range*,...] where each *range* of items is either a single
    segment *number* or a range with stepped increments given via *start*\ [:*step*:]\ :*stop*
    (*step* is optional and defaults to 1). A leading **~** will
    invert the selection and write all segments but the ones listed.  Instead
    of a list of ranges, use **+f** *file* to supply a file list with one *range* per line.

- **S** or **select_hdr** : -- *select_hdr=[**~**]\ *"search string"*\|\ **+f**\|\ *file*\ [**+e**] \| |-S|\ [**~**]/\ *regexp*/[**i**][**+e**]*\
    Only output those segments whose header record contains the
    specified text string. To reverse the search, i.e., to output
    segments whose headers do *not* contain the specified pattern, use
    **select_hdr=:~**. Should your pattern happen to start with ~ you need to
    escape this character with a backslash [Default output all
    segments]. Cannot be used with |-Q|. For matching segments based
    on aspatial values (via OGR/GMT format), give the search string as
    *varname*\ =\ *value* and we will compare *value* against the value
    of *varname* for each segment. **Note**: If the features are polygons
    then a match of a particular polygon perimeter also means that any
    associated polygon holes will also be matched. For matching segment
    headers against extended regular expressions enclose the expression
    in slashes. Append **i** for case-insensitive matching.
    For a list of such patterns, give **+f**\ *file* with one pattern per line.
    To give a single pattern starting with "+f", escape it with a backslash.
    Finally, append **+e** as last modifier to request an exact match [Default will
    match any sub-string in the target].

- **T** or **skip** : -- *skip=[**h**][**d**\ [[**~**]\ *selection*]]*\
    Suppress the writing of certain records on output.  Append **h** to
    suppress segment headers [Default], and/or **d** to suppress duplicate
    data records. Use **skip=:hd** to suppress both types of records.  By default,
    all columns must be identical across the two records to skip the record.
    Alternatively, append a column *selection* to only use those columns
    in the comparisons instead. The *selection* syntax is
    *range*\ [,\ *range*,...] where each *range* of items is either a single
    column *number* or a range with stepped increments given via *start*\ [:*step*:]\ :*stop*
    (*step* is optional and defaults to 1). A leading **~** will
    invert the selection and select all columns but the ones listed. To add the
    trailing text to the comparison as well, add the column *t* to the list.
    If no numerical columns are specified, just *t*, then we only consider trailing text.

\textinput{common_opts/opt_V}

- **W** or **word2num** : -- *word2num=true* **|** *word2num="+n"*\
    Attempt to convert each word in the trailing text to a number and append
    such values to the numerical output columns. Text that cannot be converted
    (because they are not numbers) will appear as NaNs. Use modifier **+n** to
    exclude the columns with NaNs. **Note**: These columns are identified based on
    the first input record only.

\textinput{common_opts/opt_a}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt__j}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt__w}

\textinput{common_opts/opt_xy}


Examples
--------

To convert the binary file test.b (single precision) with 4 columns to ASCII:

```julia
    convert("test.b", bi="4f", save="test.dat")
```

To convert the multiple segment ASCII table test.txt to a double precision binary file:

```julia
    convert("test.txt", b=:o, save="test.b")
```

If the file instead is the binary file results.b which has 9 single-precision values
per record, we extract the last column and columns 4-6 with the command:

```julia
    D = convert("results.b", outcol="8,4-6", binary_in="9s")
```

To extract all segments in the file big_file.txt whose headers contain
the string "RIDGE AXIS", try:

```julia
    D = convert("big_file.txt", select_hdr="RIDGE AXIS")
```

To only get the segments in the file big_file.txt whose headers exactly
matches the string "Spitsbergen", try:

```julia
    D = convert("big_file.txt", select_hdr="Spitsbergen+e")
```

To invert the selection of segments whose headers begin with "profile "
followed by an integer number and any letter between "g" and "l", try:

```julia
    D = convert(select_hdr="~\"/^profile [0-9]+[g-l]$/\"")
```

To reverse the order of segments in a file without reversing the order
of records within each segment, try:

```julia
    convert("lots_of_segments.txt", invert=:s)
```

To extract segments 20 to 40 in steps of 2, plus segment 0 in a file, try:

```julia
    convert("lots_of_segments.txt", segments="0,20:2:40")
```

To extract the attribute ELEVATION from an ogr gmt file like this:

```julia
    # @VGMT1.0 @GPOINT
    ...
    # @NELEVATION|DISPX|DISPY
    # @Tdouble|double|double
    # FEATURE_DATA
    # @D4.945000|-106500.00000000|-32700.00000000
    -9.36890245902635 39.367156766570389
```

do

```julia
    D = convert("file.gmt", aspatial="ELEVATION")
```

To connect all points in the file sensors.txt with the specified origin at 23.5/19, try:

```julia
    Dlines = convert("sensors.txt", conn_method=(23.5,19))
```

To write all segments in the two files A.txt and B.txt to
individual files named profile_005000.txt, profile_005001.txt, etc.,
where we reset the origin of the sequential numbering from 0 to 5000, try:

```julia
    convert("A.txt", "B.txt", D="profile_%6.6d.txt+o5000")
```

To only read rows 100-200 and 500-600 from file junk.txt, try:

```julia
    D = convert("junk.txt", q="100-200,500-600")
```

To get all rows except those bad ones between rows 1000-2000, try:

```julia
    D = convert("junk.txt", q="~1000-2000")
```

See Also
--------

\myreflink{gmtinfo},
\myreflink{gmtselect}
