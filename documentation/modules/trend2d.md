# trend2d

```julia
	trend2d(cmd0::String="", arg1=nothing, kwargs...)
```

Fit [weighted] [robust] polynomial for z = f(x,y) to xyz[w] data.

Description
-----------

**trend2d** reads x,y,z [and w] values from the first three [four] columns [or *xyz[w]file*]
and fits a regression model z = f(x,y) + e by [weighted] least squares. The fit may be made
robust by iterative reweighting of the data. The user may also search for the number of terms
in f(x,y) which significantly reduce the variance in z. n\_model may be in [1,10] to fit a
model of the following form (similar to \myreflink{grdtrend}):


$$z(x,y) = m_1 + m_{2}x + m_{3}y + m_{4}xy + m_{5}x^2 + m_{6}y^2 + m_{7}x^3 +
  m_{8}x^{2}y + m_{9}xy^2 + m_{10}y^3$$

The user must specify **model=n**, the number of model parameters to use; thus, fits a bilinear
trend, **model=6** a quadratic surface, and so on. Optionally, append **+r** to perform a robust
fit. In this case, the program will iteratively reweight the data based on a robust scale estimate,
in order to converge to a solution insensitive to outliers. This may be handy when separating a
"regional" field from a "residual" which should have non-zero mean, such as a local mountain on
a regional surface.

Required Arguments
------------------

- *table*\
    Data table(s) containing x,y,z [w] values in the first 3 [4] columns.

- **F** or **out** or **output** : -- *out=:xyzmrw* **|** *out=:p*\
    Specify up to six letters from the set {**x y z m r w**} in any order to create columns of output.
    **x** = x, **y** = y, **z** = z, **m** = model f(x,y), **r** = residual z - **m**,
    **w** = weight used in fitting. Alternatively, to just report the model parameters, use **out=:p**.

- **N** or **model** : -- *model=n* **|** *model="n+r"*\
    Specify the number of terms in the model, *n\_model*, and use *model="n_model+r"*
    to do a robust fit. E.g., a robust bilinear model is **model="4+r"**.

Optional Arguments
------------------

- **C** or **condition_number** : -- *condition\_number=number*\
    Set the maximum allowed condition number for the matrix solution. **trend2d** fits a
    damped least squares model, retaining only that part of the eigenvalue spectrum such
    that the ratio of the largest eigenvalue to the smallest eigenvalue is *condition\_#*.
    [Default: *condition\_#* = 1.0e06].

- **I** or **conf_level** : -- *conf\_level=true* **|** *conf\_level=level*\
    Iteratively increase the number of model parameters, starting at one, until *n\_model* is
    reached or the reduction in variance of the model is not significant at the *confidence\_level*
    level. You may set **conf_level=true** only, without an attached number; in this case the
    fit will be iterative with a default confidence level of 0.51. Or choose your own level
    between 0 and 1. See remarks section.

\textinput{common_opts/opt_V}

- **W** or **weights** : -- *weights=true* **|** *weights="+s|+w"*\
    Weights are supplied in input column 4. Do a weighted least squares fit [or start with
    these weights when doing the iterative robust fit]. Append **+s** to instead read data
    uncertainties (one sigma) and create weights as 1/sigma^2, or use the weights as read
    (**+w**) [Default reads only the first 2 columns].

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt__w}

\textinput{common_opts/opt_xy}

Remarks
-------

The domain of x and y will be shifted and scaled to [-1, 1] and the basis functions are built
from Chebyshev polynomials. These have a numerical advantage in the form of the matrix which
must be inverted and allow more accurate solutions. In many applications of **trend2d** the
user has data located approximately along a line in the x,y plane which makes an angle with
the x axis (such as data collected along a road or ship track). In this case the accuracy could
be improved by a rotation of the x,y axes. **trend2d** does not search for such a rotation;
instead, it may find that the matrix problem has deficient rank.  However, the solution is
computed using the generalized inverse and should still work out OK. The user should check the
results graphically if **trend2d** shows deficient rank. NOTE: The model parameters listed with
**verbose** are Chebyshev coefficients; they are not numerically equivalent to the m#s in the
equation described above. The description above is to allow the user to match **model** with
the order of the polynomial surface. For evaluating Chebyshev polynomials, see `grdmath`.

The **model="n_model+r"** (robust) and **conf_level** (iterative) options evaluate the
significance of the improvement in model misfit Chi-Squared by an F test. The default confidence
limit is set at 0.51; it can be changed with the **conf_level** option. The user may be
surprised to find that in most cases the reduction in variance achieved by increasing the number
of terms in a model is not significant at a very high degree of confidence. For example, with 120
degrees of freedom, Chi-Squared must decrease by 26% or more to be significant at the 95% confidence
level. If you want to keep iterating as long as Chi-Squared is decreasing, set *conf_level* to zero.

A low confidence limit (such as the default value of 0.51) is needed to make the robust method work.
This method iteratively reweights the data to reduce the influence of outliers. The weight is based
on the Median Absolute Deviation and a formula from Huber [1964], and is 95% efficient when the model
residuals have an outlier-free normal distribution. This means that the influence of outliers is
reduced only slightly at each iteration; consequently the reduction in Chi-Squared is not very
significant. If the procedure needs a few iterations to successfully attenuate their effect, the
significance level of the F test must be kept low.

Examples
--------

To remove a planar trend from data.xyz by ordinary least squares, use

```julia
    D = trend2d("data.xyz", out=:xyr, model=3)
```

To simply report the three coefficients, use

```julia
    trend2d("data.xyz", out=:p, model=3)
```

To make the above planar trend robust with respect to outliers, use

```julia
    D = trend2d("data.xyz", out=:xyr, model="3+r")
```

To find out how many terms (up to 10 in a robust interpolant are significant in fitting data.xyz, use

```julia
    trend2d("data.xyz", model="10+r", conf_level=true, verbose=true)
```

See Also
--------

\myreflink{grdtrend}, \myreflink{trend1d}

References
----------

Huber, P. J., 1964, Robust estimation of a location parameter, *Ann.
Math. Stat.*, **35**, 73-101.

Menke, W., 1989, Geophysical Data Analysis: Discrete Inverse Theory,
Revised Edition, Academic Press, San Diego.
