# grdtrend

```julia
	grdtrend(cmd0::String="", arg1=nothing, arg2=nothing; kwargs...)
```

Fit trend surface to grids and compute residuals

*keywords: GMT, Julia, trend surfaces*

Description
-----------

**grdtrend** reads a 2-D grid and fits a low-order polynomial trend to these data by
[optionally weighted] least-squares. The trend surface is defined by:

$$m_1 + m_2x + m_3y + m_4xy + m_5x^2 + m_6y^2 + m_7x^3 + m_8x^2y + m_9xy^2 + m_{10}y^3$$

The user must specify **-N**\ *n_model*, the number of model parameters
to use; thus, **-N**\ *3* fits a bilinear trend, **-N**\ *6* a quadratic
surface, and so on. Optionally, append **+r** to the |-N| option to
perform a robust fit. In this case, the program will iteratively
reweight the data based on a robust scale estimate, in order to converge
to a solution insensitive to outliers. This may be handy when separating
a "regional" field from a "residual" which should have non-zero mean,
such as a local mountain on a regional surface.
Optionally, you may choose to fit a trend that varies only along the *x* or *y* axis,
in which case you select an *n_model* from 1 (constant) to 4 (cubic).

If data file has values set to NaN, these will be ignored during fitting;
if output files are written, these will also have NaN in the same locations.

Required Arguments
------------------

The 2-D gridded data set.

**-N** or **model** : -- *model=n_model* **|** *model=(n=?, robust=true, xonly=true, yonly=true)*\
    *n_model* sets the ID of the highest model parameters to fit. Use **model=(n=n_model, robust=true**
    for robust fit. As an option, add either **xonly=true** or **yonly=true** to only fit a model that
    depends on *x* or *y* terms, respectively. This means we either fit
    $m_1 + m_2x + m_3x^2 + m_4x^3$ or $m_1 + m_2y + m_3y^2 + m_4y^3$. Note that *n_model* may only
    be 1-4 for the one-dimensional fits but may be 1-10 for the two-dimensional surface fits.

Optional Arguments
------------------

- **D** or **diff** : -- *diff=true* **|** *diff="diff.grd"*\
    Compute and return the difference (input data - trend). The form **diff="diff.grd"**
    writes the resul to to the file *diff.grd*.

\textinput{common_opts/opt_R}

- **T** or **trend** : -- *trend=true* **|** *trend="trend.grd"*\
    Compute and return the fitted trend. The form **trend="trend.grd"**
    writes the resul to to the file *trend.grd*.

\textinput{common_opts/opt_V}

**-W** or **weights** : -- *weights="weight.grd[+s]"*\
    If *weight.grd* exists, it will be read and used to solve a weighted
    least-squares problem. [Default: Ordinary least-squares fit]. Append
    **+s** to instead read data uncertainties (one sigma) and create weights
    as 1/sigma^2. If the robust option has been selected, the weights used
    in the robust fit will be written to *weight.nc*.

Remarks
-------

The domain of x and y will be shifted and scaled to [-1, 1] and the
basis functions are built from Legendre polynomials. These have a
numerical advantage in the form of the matrix which must be inverted and
allow more accurate solutions. NOTE: The model parameters listed with
**verbose** are Legendre polynomial coefficients; they are not numerically
equivalent to the $m_j$ in the equation described above. The description
above is to allow the user to match **model** with the order of the
polynomial surface. See \myreflink{grdmath} if you need to evaluate the trend
using the reported coefficients.

Examples
--------

To remove a planar trend from the remote grid earth_relief_05m for the region around Hawaii:

```julia
    G = grdtrend("@earth_relief_05m", region=(180,240,10,40), model=3, diff=true)
```

To do a robust fit of a bicubic surface to hawaii_topo.nc, writing the
result in hawaii_trend.nc and the weights used in hawaii_weight.nc,
and reporting the progress:

```julia
    grdtrend("hawaii_topo.nc", model=(n=10, robust=true), trend="hawaii_trend.nc",
             weights="hawaii_weight.nc", verbose=true)
```

See Also
--------

\myreflink{grdfft}, \myreflink{grdfilter}, \myreflink{grdmath}
