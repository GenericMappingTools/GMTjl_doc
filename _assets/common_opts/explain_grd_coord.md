Geographical And Time Coordinates
---------------------------------

When the output grid type is netCDF, the coordinates will be labeled "longitude", "latitude",
or "time" based on the attributes of the input data or grid (if any) or on the **colinfo** or
**region** options. For example, both **colinfo="0x"** **colinfo="1t"** and **region="90w/90e/0t/3t"**
will result in a longitude/time grid. When the x, y, or z coordinate is time, it will be stored
in the grid as relative time since epoch as specified by `TIME_UNIT` and `TIME_EPOCH` in the
`gmt.conf` file or on the command line. In addition, the **unit** attribute of the time variable
will indicate both this unit and epoch.
