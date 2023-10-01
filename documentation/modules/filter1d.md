# filter1d

```julia
filter1d(cmd0::String="", arg1=[]; kwargs...)
```

Time domain filtering of 1-D data tables

*keywords: GMT, Julia, 1D filter*

Description
-----------

General time domain filter for multiple column time series data. The user specifies which column
is the time (i.e., the independent variable). (See **timecol** option below). The fastest operation
occurs when the input time series are equally spaced and have no gaps or outliers and the special
options are not needed. **filter1d** has options **gap_width**, **quality**, and **symetry** for
unevenly sampled data with gaps.  For spatial series there is an option to compute along-track
distances and use that as the independent variable for filtering.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

- **F** or **filter** : -- *filter=type* | *filter=(type,width[,"highpass"])*\
    Sets the filter `type`. Choose among convolution and non-convolution
    filters. Append the filter code followed by the full filter
    *width* in same units as time column. By default we
    perform low-pass filtering; use the **highpass** to select high-pass filtering.
    Some filters allow for optional arguments and a modifier. Available convolution
    filter types are:

    - **b**oxcar: All weights are equal.

    - **c**osine Arch: Weights follow a cosine arch curve.

    - **g**aussian: Weights are given by the Gaussian function.

    - **f** Custom: Instead of *width* give name of a one-column file with your own weight coefficients.

    Non-convolution filter types are:

    - **m**edian: Returns median value.

    - **p**robability Maximum likelihood (a mode estimator): Return modal value. If more than one
      mode is found we return their average value. Append **+l** or **+u** if you rather want to
      return the lowermost or uppermost of the modal values.

    - **l**ower: Return the minimum of all values.

    - **L**ower: Return minimum of all positive values only.

    - **u**pper: Return maximum of all values.

    - **U**pper: Return maximum of all negative values only.

    Upper case type **B**, **C**, **G**, **M**, **P**, **F** will use robust filter versions: i.e.,
    replace outliers (2.5 L1 scale off median, using 1.4826 * median absolute deviation [MAD])
    with median during filtering.

    In the case of **L** | **U** it is possible that no data passes the initial sign test; in that
    case the filter will return 0.0.  Apart from custom coefficients (**f**), the other filters may
    accept variable filter widths by passing *width* as a two-column time-series file with filter
    widths in the second column. The filter-width file does not need to be co-registered with the
    data as we obtain the required filter width at each output location via interpolation. For
    multi-segment data files the filter file must either have the same number of segments or just
    a single segment to be used for all data segments.


Optional Arguments
------------------

- **D** or **inc** or **increment** : -- *inc=increment*\
    *increment* is used when series is NOT equidistantly sampled. Then *increment* will be the
    abscissae resolution, i.e., all abscissae will be rounded off to a multiple of *increment*.
    Alternatively, resample data with \myreflink{sample1d}.

- **E** or **end** or **ends** : -- *ends=true*\
    Include Ends of time series in output. Default loses half the filter-width of data at each end.

- **L** or **gap_width** : -- *gap_width=width*\
    Checks for Lack of data condition. If input data has a gap exceeding
    `width` then no output will be given at that point [Default does not check Lack].

- **N** or **time_col** or **timecol** : -- *timecol=t_col*\
    Indicates which column contains the independent variable (time). The
    left-most column is 0, while the right-most is (*n_cols - 1*) [Default is 0].

- **Q** or **quality** : -- *quality=q_factor*\
    Assess Quality of output value by checking mean weight in
    convolution. Enter *q_factor* between 0 and 1. If mean weight <
    *q_factor*, output is suppressed at this point [Default does not check Quality].

- **S** or **symetry** : -- *symetry=factor*\
    Checks symmetry of data about window center. Enter a factor between
    0 and 1. If ( (abs(n_left - n_right)) / (n_left + n_right) ) >
    *factor*, then no output will be given at this point [Default does not check Symmetry].

\textinput{common_opts/opt_range}

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

\textinput{common_opts/opt__j}

\textinput{common_opts/opt_o}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_xy}

\myreflink{units}

Examples
--------

To filter the remote CO2 data set in the file MaunaLoa_CO2.txt (year, CO2)
with a 5 year Gaussian filter, try

\begin{examplefig}{}
```julia
using GMT
D = filter1d("@MaunaLoa_CO2.txt", filter=(type=:gauss, width=5));
plot("@MaunaLoa_CO2.txt", legend="Raw data")
plot!(D, lc=:blue, legend="Filtered", show=1)
```
\end{examplefig}

Data along track often have uneven sampling and gaps which we do not want to interpolate using
\myreflink{sample1d}. To find the median depth in a 50 km window every 25 km along the track of
cruise v3312, stored in v3312.txt, checking for gaps of 10km and asymmetry of 0.3:

```julia
D = filter1d("v3312.txt", filter=(:Median,50), range=(0,100000,25), gap_width=10, symetry=0.3)
```

To smooth a noisy geospatial track using a Gaussian filter of full-width 100 km
and not shorten the track, and add the distances to the file, use

```julia
D = filter1d("track.txt", range="k+a", ends=true, filter=(:gaussian, 200))
```

See Also
--------

\myreflink{sample1d},
\myreflink{gmtsplit}
