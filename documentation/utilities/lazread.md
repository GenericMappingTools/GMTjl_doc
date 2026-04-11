# lazread

```julia
out = lazread(FileName::AbstractString; out::String="xyz", do_grid=false, do_image=false,
              type::DataType=Float64, class=0, startstop="1:end")
```

Read data from a LIDAR laz (laszip compressed) or las format file.

### Args

- `FileName`: Name of the input LIDAR file.

### Kwargs

- `out`: Select what data to output. The default is "xyz" meaning that only these three are sent out.
   Examples include: "xyz", "xy", "yx", "z", "xyzi", "xyzt", "xyzit", "xyzti", "xyzic" "xyzc",
   "RGB", "RGBI", "xyRGB", "xyRGBI".
   where 'i' stands for intensity (UInt16), 'c' for classification (Int8) and 't' for GPS time (Float64)

- `do_grid`: If true, the output is a GMTgrid. This implicitly sets `out="xyz"` and `type=Float32`.
   The grid is built using the `nearneighbor` algorithm. It is recommended to use the `-R` and `-I` options,
   but if not provided, the grid is built using the extent of the data and a crude estimate of the increment.

- `do_image`: If true, the output is a GMTimage. This implicitly sets `out="xyRGB"` and of course it will
   error if the laz file does not contain RGB data. If another color combination is desired, specify it
   explicitly, e.g., `out="xyIRG"`. Like the `do_grid` option, it is recommended to use the `-R` and `-I` options,
   to control the image extent and resolution.

- `type`: The float components (xyz) may be required in Float32. The default is Float64.

- `startstop="start:stop"`: A string that restricts the output to the points from start to stop.

- `class`: Restrict the output to the points belonging to the classification 'class' (an Integer).
   This option implies two passes, with the first for counting the number of points in class.

### Returns

`out` is Type with the folowing fields: `stored`, `grd`, `img`, `ds`, `dsv`, where `stored` is a string
indicating what data is stored in output. `grd` is a GMTgrid if `grid` is true or we read a _grided_ laz file.
`img` is a GMTimage if `image` was set to true and the laz file contains RGB data.
`ds` is a \myreflink{GMTdataset} with the xyz data, and `dsv`is a vector of GMTdataset if input opion `out` was set
to something else than "xyz" or "xy". The reason for assembling the output in a Type is make the output of
`lazread` be type stable. Use ``getproperty(out, Symbol(out.stored))`` toget the normal GMT types directly, or,
do the reading via ``gmtread`` that will do this for you.

### Example

To write the x,y,z data to file "lixo.laz" do:

```julia
D = gmtread(TESTSDIR * "/assets/test.laz")
```

See Also
--------

\myreflink{lazwrite}, \myreflink{gmtread}
