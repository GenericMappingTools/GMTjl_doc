- **N** or **dimensions** or **inquire** : -- _dimensions=[**a**|**f**|**m**|**r**|**s**|*nx/ny*][**+a**|**d**|**h**|**l**][**+e**|**n**|**m**][**+t**_width_][**+v**][**+w**[_suffix_]][**+z**[**p**]]_\
  Choose or inquire about suitable grid dimensions for FFT and set
  optional parameters. Control the FFT dimension via these directives:
  - **a** - Let the FFT select dimensions yielding the most accurate result.
  - **f** - Force the FFT to use the actual dimensions of the data.
  - **m** - Let the FFT select dimensions using the least work memory.
  - **r** - Let the FFT select dimensions yielding the most rapid calculation.
  - **s** - Just present a list of optional dimensions, then exit.
  Without a directive we expect **N**_nx/ny_ which will do FFT on array size *nx/ny*
  (must be >= grid file size). Default chooses dimensions >= data which optimize speed
  and accuracy of FFT. If FFT dimensions > grid file dimensions, data are extended and
  tapered to zero.\
  Control detrending of data by appending a modifier for removing a linear trend.
  Consult module documentation for the default action:
  - **+d** - Detrend data, i.e. remove best-fitting linear trend.
  - **+a** - Only remove the mean value.
  - **+h** - Only remove the mid value, i.e. 0.5 * (max + min).
  - **+l** - Leave data alone.
  Control extension and tapering of data by appending a modifier to control how
  the extension and tapering are to be performed:
  - **+e** - Extend the grid by imposing edge-point symmetry [Default].
  - **+m** - Extends the grid by imposing edge mirror symmetry.
  - **+n** - Turns off data extension.
  Tapering is performed from the data edge to the FFT grid edge [100%].
  Change this percentage via modifier **+t**_width_. When **+n** is in effect,
  the tapering is applied instead to the data margins as no extension is available [0%].\
  Control messages being reported:
  - **+v** - Report suitable dimensions during processing.
  Control writing of temporary results:
  For detailed investigation you can write the intermediate grid being passed
  to the forward FFT; this is likely to have been detrended, extended by
  point-symmetry along all edges, and tapered. Use these modifiers to ave such grids:
  - **+w** - Set the *suffix* from which output file name(s) will be created
    (i.e., *ingrid_prefix.ext*) [Default is "tapered"], where *ext* is your file extension
  - **+z** -  Save the complex grid produced by the forward FFT. By default we
    write the real and imaginary components to *ingrid_real.ext* and
    *ingrid_imag.ext*.  Append **p** to instead use the polar form of magnitude
    and phase to files *ingrid_mag.ext* and *ingrid_phase.ext*.
