# grdfilter

**Filter a grid in the space (or time) domain**

## Synopsis

```julia
G = grdfilter(cmd0::String="", arg1=nothing; kwargs...)
```

## Description

`grdfilter` filters a grid in the time (or space) domain using one of the selected convolution or non-convolution
isotropic or rectangular filters and computes distances using Cartesian or Spherical geometries. The output grid
can optionally be generated as a sub-region of the input (via `region`/`R`) and/or with new increment (via `inc`/`I`)
or registration (via `toggle`/`T`). In this way, one may have "extra space" in the input data so that the edges
will not be used and the output can be within one half-width of the input edges. If the filter is low-pass, then
the output may be less frequently sampled than the input.

**Note:** For filtering in the frequency (or wavenumber) domain instead, see `grdfft`.

## Required Arguments

### Input Grid
- **First positional argument** or **`ingrid`**: Input grid as a file name (String) or a GMTgrid object
  - Optionally, append `=ID` for reading a specific file format [Default is `=nf`]
  - Append `?varname` for a specific netCDF variable
  - Modifiers supported:
    - `+b`: Select a band [Default is 0]
    - `+d`: Divide data values by given divisor [Default is 1]
    - `+n`: Replace data values matching invalid with NaN
    - `+o`: Offset data values by given offset [Default is 0]
    - `+s`: Scale data values by given scale [Default is 1]

### `distance` or `D`
Distance flag tells how grid (x, y) relates to filter width. **Required** option.

**Syntax:** `D=flag` or `distance=flag` where flag is one of:
- `D="p"` or `D=:p`: Grid (px,py) with width an odd number of pixels; Cartesian distances
- `D=0` or `D="0"`: Grid (x,y) same units as width, Cartesian distances
- `D=1` or `D="1"`: Grid (x,y) in degrees, width in km, Cartesian distances
- `D=2` or `D="2"`: Grid (x,y) in degrees, width in km, dx scaled by cos(middle y), Cartesian distances
- `D=3` or `D="3"`: Grid (x,y) in degrees, width in km, dx scaled by cos(y), Cartesian distances (slower)
- `D=4` or `D="4"`: Grid (x,y) in degrees, width in km, Spherical distance calculation (slower)
- `D=5` or `D="5"`: Grid (x,y) in Mercator -Jm1 img units, width in km, Spherical distance calculation

**Notes:**
- Flags 0-2 are fastest (weight matrix computed once)
- Flags 3-5 are slower (weights recomputed for each latitude)

**Examples:**
```julia
# Spherical distance calculation for geographic grid
G = grdfilter("@earth_relief_05m", filter="m600", D=4)

# Cartesian distances for projected grid
G = grdfilter(grid, filter="g100", D=0)
```

### `filter` or `F`
Sets the filter type and width. **Required** option.

**Syntax:** `F="xwidth[/width2][+modifiers]"` or `filter="xwidth[/width2][+modifiers]"`

Where `x` is the filter type code followed by the full diameter width. Append `/width2` for a rectangular filter (requires `D="p"` or `D=0`).

**Convolution Filters:**
- `b`: **Boxcar** - All weights are equal
- `c`: **Cosine Arch** - Weights follow a cosine arch curve  
- `g`: **Gaussian** - Weights given by Gaussian function (width is 6×sigma)
- `f`: **Custom** - Weights from filter weight grid file (requires `D=0`)
- `o`: **Operator** - Weights from filter weight grid file, sum to zero (requires `D=0`)

**Non-Convolution Filters:**
- `m`: **Median** - Returns median value [default]
  - `+qquantile`: Select another quantile (0-1 range) [default is 0.5]
- `p`: **Mode (probability)** - Returns modal value
  - `+l`: Return lowermost mode if multiple
  - `+u`: Return uppermost mode if multiple
- `h`: **Histogram Mode** - Modal value as center of dominant peak
  - Append `/binwidth` to specify binning interval
  - `+c`: Center bins on multiples of binwidth
  - `+l`: Return lowermost mode if multiple
  - `+u`: Return uppermost mode if multiple
- `l`: **Lower** - Return minimum of all values
- `L`: **Lower+** - Return minimum of all positive values only
- `u`: **Upper** - Return maximum of all values
- `U`: **Upper-** - Return maximum of all negative values only

**Modifiers:**
- `+h`: High-pass filtering [default is low-pass]
- `+c`: Center bins (for histogram mode)
- `+l`: Return lowermost value (for mode filters)
- `+u`: Return uppermost value (for mode filters)
- `+qquantile`: Specify quantile for median filter (0-1)

**Examples:**
```julia
# Median filter, 600 km width
G = grdfilter("input.nc", F="m600", D=4)

# Gaussian filter, 100 km width
G = grdfilter(grid, filter="g100", distance=4)

# High-pass Gaussian filter
G = grdfilter(grid, F="g100+h", D=4)

# 25th percentile (lower quartile)
G = grdfilter(grid, filter="m600+q0.25", D=4)

# Rectangular boxcar filter
G = grdfilter(grid, F="b50/20", D=0)

# Histogram mode with 10-unit bins
G = grdfilter(grid, filter="h600/10", D=4)
```

## Optional Arguments

### `outgrid` or `G` or `save`
Output grid file name or let the function return a GMTgrid object.

**Syntax:** `G="filename.nc"` or `outgrid="filename.nc"`

**Modifiers:**
- `=ID`: Write specific file format
- `+d`: Divide data values by divisor
- `+n`: Replace invalid with NaN  
- `+o`: Offset data values (or `+oa` for automatic)
- `+s`: Scale data values (or `+sa` for automatic)

**Examples:**
```julia
# Save to file
grdfilter("input.nc", filter="m600", D=4, G="filtered.nc")

# Return GMTgrid object (default)
G = grdfilter("input.nc", filter="m600", D=4)
```

### `inc` or `I` or `spacing`
Set the output grid spacing.

**Syntax:** `I=x_inc[/y_inc]` or `inc="x_inc[/y_inc]"` or `spacing=x_inc`

**Geographic coordinates units:**
- `d`: Arc degrees
- `m`: Arc minutes
- `s`: Arc seconds
- `e`, `f`, `k`, `M`, `n`, `u`: Length units (converted to degrees)

**Modifiers:**
- `+e`: Adjust max extent to fit increment exactly
- `+n`: Specify number of nodes instead of increment

**Examples:**
```julia
# 0.5 degree spacing
G = grdfilter(grid, F="m600", D=4, I=0.5)

# Different x and y spacing
G = grdfilter(grid, filter="g100", D=4, inc="1/0.5")

# 30 arc minutes
G = grdfilter(grid, F="m600", D=4, I="30m")

# 100 nodes in x, 50 in y
G = grdfilter(grid, filter="g50", D=4, I="100+n/50+n")
```

### `nans` or `N`
Determine how NaN-values in input grid affect filtered output.

**Syntax:** `N="directive"` or `nans="directive"`

**Directives:**
- `i`: Ignore all NaNs in calculation [Default]
- `p`: Force output to NaN if any NaN found in filter circle
- `r`: Like `i` but preserve NaN if input node was NaN (co-registered grids only)

**Examples:**
```julia
# Ignore NaNs (default)
G = grdfilter(grid, F="m600", D=4, N="i")

# Propagate NaNs
G = grdfilter(grid, filter="g100", D=4, nans="p")

# Preserve input NaNs
G = grdfilter(grid, F="m600", D=4, N="r")
```

\textinput{common_opts/opt_R}

### `region` or `R`
Specify the output region (sub-region of input).

**Syntax:** `R=(xmin, xmax, ymin, ymax)` or `R="xmin/xmax/ymin/ymax"` or `region=...`

**Examples:**
```julia
# Tuple format
G = grdfilter(grid, F="m600", D=4, R=(150, 250, 10, 40))

# String format  
G = grdfilter(grid, filter="g100", D=4, region="150/250/10/40")

# Extract Pacific region
G = grdfilter("@earth_relief_05m", F="m600", D=4, R=(150,250,10,40), I=0.5)
```

### `toggle` or `T`
Toggle the node registration for output grid (gridline ↔ pixel).

**Examples:**
```julia
# Toggle registration
G = grdfilter(grid, F="m600", D=4, T=true)

# Equivalent using toggle keyword
G = grdfilter(grid, filter="g100", D=4, toggle=true)
```

### `registration` or `r`
Set node registration explicitly.

**Syntax:** `r="g"` (gridline) or `r="p"` (pixel)

**Examples:**
```julia
# Force gridline registration
G = grdfilter(grid, F="m600", D=4, r="g")

# Force pixel registration
G = grdfilter(grid, filter="g100", D=4, registration="p")
```

### `verbose` or `V`
Control verbosity level.

**Syntax:** `V=true` or `V=level` or `verbose=level`

**Examples:**
```julia
# Verbose output
G = grdfilter(grid, F="m600", D=4, V=true)

# Specific verbosity level
G = grdfilter(grid, filter="g100", D=4, verbose=:w)
```

### `colinfo` or `f`
Specify data types of input/output columns (time or geographical data).

**Examples:**
```julia
# Time/geographic data specification
G = grdfilter(grid, F="m600", D=4, f="0x,1t")
```

### `cores` or `x`
Limit number of cores used in multi-threaded algorithms.

**Syntax:** `x=n` where:
- `n > 0`: Use n cores
- `n < 0`: Use (all - n) cores
- `x=true`: Use all available cores [default]

**Examples:**
```julia
# Use 4 cores
G = grdfilter(grid, F="m600", D=4, x=4)

# Use all but 2 cores
G = grdfilter(grid, filter="g100", D=4, cores=-2)

# Single-threaded
G = grdfilter(grid, F="m600", D=4, x=1)
```

## Examples

### Basic Filtering

```julia
using GMT

# Load Earth relief data
grid = gmtread("@earth_relief_05m", region=(140,260,0,50))

# Apply median filter with 600 km width (spherical distances)
G = grdfilter(grid, filter="m600", D=4, region=(150,250,10,40), inc=0.5)
```

### High-Pass Filtering

```julia
# High-pass filter (residuals from low-pass)
G_residual = grdfilter("@earth_relief_05m", 
    F="m600+h", 
    D=4, 
    R=(150,250,10,40), 
    I=0.5)
```

### Different Filter Types

```julia
# Gaussian smoothing
G_gauss = grdfilter(grid, filter="g100", distance=4)

# Boxcar (moving average)
G_box = grdfilter(grid, F="b200", D=4)

# Cosine arch
G_cos = grdfilter(grid, filter="c150", D=4)

# Maximum value in window
G_max = grdfilter(grid, F="u500", D=4)

# Minimum value in window
G_min = grdfilter(grid, filter="l500", D=4)
```

### Quantile Filtering

```julia
# Lower quartile (25th percentile)
G_q25 = grdfilter(grid, F="m600+q0.25", D=4)

# Upper quartile (75th percentile)
G_q75 = grdfilter(grid, filter="m600+q0.75", D=4)

# 90th percentile
G_q90 = grdfilter(grid, F="m600+q0.9", D=4)
```

### Custom Filter from Grid

```julia
# Create custom anisotropic Gaussian filter
# exp(-0.5*r^2) where r^2 = (2x^2 + y^2 - 2xy)/6
filter_grid = grdmath("-R-10/10/-10/10 -I1 X 2 POW 2 MUL Y 2 POW ADD X Y MUL 2 MUL SUB 6 DIV NEG 2 DIV EXP DUP SUM DIV")

# Apply custom filter
G = grdfilter("ripples.nc", F="f$(filter_grid)", D=0, G="smooth.nc")
```

### Rectangular Filters

```julia
# Rectangular boxcar filter (100 km × 50 km)
G = grdfilter(grid, F="b100/50", D=0, I=1)

# Rectangular Gaussian
G = grdfilter(grid, filter="g200/100", D=0)
```

### Variable Filter Width

```julia
# Create variable width grid (must match output dimensions)
width_grid = # ... GMTgrid with varying filter widths

# Apply variable width median filter
G = grdfilter(grid, F=width_grid, D=4, I=0.5)
```

### Sub-Region Extraction with Filtering

```julia
# Filter and extract Pacific region
G_pacific = grdfilter("@earth_relief_05m",
    filter="m600",
    distance=4,
    region=(150, 250, 10, 40),
    inc=0.5)
```

### NaN Handling

```julia
# Ignore NaNs (default)
G1 = grdfilter(grid, F="m600", D=4, N="i")

# Propagate NaNs (conservative)
G2 = grdfilter(grid, F="m600", D=4, nans="p")

# Preserve input NaNs only
G3 = grdfilter(grid, F="m600", D=4, N="r")
```

### Multi-Threaded Processing

```julia
# Use all available cores (default)
G = grdfilter(grid, F="m600", D=4)

# Use 8 cores
G = grdfilter(grid, filter="g100", D=4, x=8)

# Single-threaded
G = grdfilter(grid, F="m600", D=4, cores=1)
```

### Comparison of Filter Types

\begin{examplefig}{}
```julia
using GMT

# Original data
grid = gmtread("@earth_relief_05m", region=(150,200,10,40))

# Apply different filters
G_median = grdfilter(grid, F="m600", D=4, I=0.5)
G_gauss = grdfilter(grid, F="g600", D=4, I=0.5)
G_boxcar = grdfilter(grid, F="b600", D=4, I=0.5)
G_mode = grdfilter(grid, F="p600", D=4, I=0.5)

# Visualize differences
subplot(grid=(2,2), F=(width=20, height=15))
    grdimage(G_median, panel=(1,1), title="Median")
    grdimage(G_gauss, panel=(1,2), title="Gaussian")
    grdimage(G_boxcar, panel=(2,1), title="Boxcar")
    grdimage(G_mode, panel=(2,2), title="Mode")
subplot(:show)
```
\end{examplefig}

## Distance Flag Details

The distance flag (`D`) determines how grid coordinates relate to filter width:

| Flag | Grid Units | Width Units | X Scaling | Distance Calc | Speed |
|------|------------|-------------|-----------|---------------|-------|
| `p` | Pixels | Pixels (odd) | None | Cartesian | Fast |
| `0` | Any | Same as grid | None | Cartesian | Fast |
| `1` | Degrees | Kilometers | None | Cartesian | Fast |
| `2` | Degrees | Kilometers | cos(mid_y) | Cartesian | Fast |
| `3` | Degrees | Kilometers | cos(y) | Cartesian | Slow |
| `4` | Degrees | Kilometers | cos(y) | Spherical | Slow |
| `5` | Mercator | Kilometers | cos(y) | Spherical | Slow |

**Recommendations:**
- Use `D=4` for accurate geographic filtering (most common)
- Use `D=0` for Cartesian grids or custom filters
- Use `D=1` or `D=2` for faster approximate geographic filtering
- Use `D=5` for Mercator projected grids from `img2mercgrd`

## Filter Type Comparison

| Filter | Type | Use Case | Notes |
|--------|------|----------|-------|
| **Boxcar (b)** | Convolution | Simple smoothing | Equal weights, sharp cutoff |
| **Cosine Arch (c)** | Convolution | Smooth lowpass | Gradual weight decay |
| **Gaussian (g)** | Convolution | Standard smoothing | Width = 6σ, smooth decay |
| **Median (m)** | Non-convolution | Outlier removal | Robust to spikes |
| **Mode (p)** | Non-convolution | Peak detection | Finds most common value |
| **Histogram Mode (h)** | Non-convolution | Peak detection | Like mode with binning |
| **Min/Max (l/u)** | Non-convolution | Envelope detection | Extract extremes |
| **Custom (f)** | Convolution | Specialized | User-defined weights |
| **Operator (o)** | Convolution | Derivatives | Weights sum to zero |

## Limitations

1. **Mercator grids** (D=5): Input must be created by `img2mercgrd` with origin at Equator
2. **Performance**: If output increments are not integer multiples of input increments, filtering is considerably slower
3. **Custom filters** (f/o): Require `D=0` and odd dimensions; output spacing must match or be integer multiples of input
4. **Variable width**: Filter width grid must match output grid dimensions and registration

## Tips for Julia Users

1. **Input formats**: GMT.jl accepts:
   - GMTgrid objects
   - File names as strings
   - Remote GMT datasets (e.g., `"@earth_relief_05m"`)

2. **Output options**:
   - Omit `G` to return GMTgrid object
   - Specify `G="filename.nc"` to save to file
   - Use `save=` as alias for `G=`

3. **Boolean options**: Use `true` instead of empty strings:
   - `T=true` not `T=""`
   - `V=true` not `V=""`

4. **Keyword flexibility**: Most options have multiple aliases:
   - `filter=` or `F=`
   - `distance=` or `D=`
   - `region=` or `R=`
   - `inc=` or `I=` or `spacing=`

5. **Piping workflows**: GMTgrid objects can be piped through functions:
   ```julia
   result = gmtread("input.nc") |>
            g -> grdfilter(g, F="m600", D=4) |>
            g -> grdimage(g, proj=:Mercator, show=true)
   ```

6. **Performance**: For large grids, consider:
   - Using coarser output increments
   - Smaller filter widths
   - Faster distance flags (D=0,1,2 vs D=4)
   - Limiting cores if memory constrained

## Geographical and Time Coordinates

When the output grid type is netCDF, coordinates are labeled "longitude", "latitude", or "time" based on input attributes or `f`/`R` options. Time coordinates are stored as relative time since epoch (specified by `TIME_UNIT` and `TIME_EPOCH`).

## See Also

GMT.jl related functions:
- `grdfft` - Filtering in frequency domain
- `grdmath` - Grid calculator operations
- `grdproject` - Map projection transformations
- `grdsample` - Resampling grids
- `grdgradient` - Gradient calculations

## References

- GMT Documentation: [https://docs.generic-mapping-tools.org/latest/grdfilter.html](https://docs.generic-mapping-tools.org/latest/grdfilter.html)
- GMT.jl Documentation: [https://www.generic-mapping-tools.org/GMTjl_doc/](https://www.generic-mapping-tools.org/GMTjl_doc/)