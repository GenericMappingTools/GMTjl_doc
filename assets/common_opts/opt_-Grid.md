- **G** or **save** or **outgrid** or **outfile** : -- *outgrid=[=ID][+ddivisor][+ninvalid][+ooffset|a][+sscale|a][:driver[dataType][+coptions]]*\
   Give the name of the output grid file. Optionally, append `=ID` for writing a specific file format
   (See [full description](https://docs.generic-mapping-tools.org/dev/gmt.html#grd-inout-full)).
   The following modifiers are supported:
   - +d - Divide data values by given divisor [Default is 1].
   - +n - Replace data values matching invalid with a NaN.
   - +o - Offset data values by the given offset, or append a for automatic range offset to preserve precision for integer grids [Default is 0].
   - +s - Scale data values by the given scale, or append a for automatic scaling to preserve precision for integer grids [Default is 1].

   **Note1:** Any offset is added before any scaling. +sa also sets +oa (unless overridden). To write specific
   formats via GDAL, use =gd and supply driver (and optionally dataType) and/or one or more concatenated
   GDAL -co options using +c. See the [“Writing grids and images”](https://docs.generic-mapping-tools.org/dev/cookbook/features.html#write-grids-images) cookbook section for more details.

   **Note2:** This is optional and to be used only when saving the result directly on disk. Otherwise,
   just use the `G = modulename(...)` form.