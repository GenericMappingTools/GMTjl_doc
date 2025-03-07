# spectrum1d

```julia
	spectrum1d(cmd0::String="", arg1=nothing, kwargs...)
```

Description
-----------

Reads X [and Y] values from the first [and second] columns [or *x[y]file*]. These values are treated as
timeseries *X*\ (*t*) [*Y*\ (*t*)] sampled at equal intervals spaced *dt* units
apart. There may be any number of lines of input. ``spectrum1d`` will
create file[s] containing auto- [and cross- ] spectral density estimates
by *Welch*'s [1967] method of ensemble averaging of multiple overlapped windows,
using standard error estimates from *Bendat and Piersol* [1986].

The output has 3 columns: f or w, p, and e. f or w is the frequency or wavelength, p is the spectral density estimate, and e is
the one standard deviation error bar size. If the **output** option is used, up to eight files are
created; otherwise only one (xpower) is written.

- *name_stem*.xpower\
    Power spectral density of *X*\ (*t*). Units of X \* X \* *dt*.
- *name_stem*.ypower\
    Power spectral density of *Y*\ (*t*). Units of Y \* Y \* *dt*.
- *name_stem*.cpower\
    Power spectral density of the coherent output. Units same as ypower.
- *name_stem*.npower\
    Power spectral density of the noise output. Units same as ypower.
- *name_stem*.gain\
    Gain spectrum, or modulus of the transfer function. Units of (Y / X).
- *name_stem*.phase\
    Phase spectrum, or phase of the transfer function. Units are radians.
- *name_stem*.admit\
    Admittance spectrum, or real part of the transfer function. Units of (Y / X).
- *name_stem*.coh\
    (Squared) coherency spectrum, or linear correlation coefficient as a
    function of frequency. Dimensionless number in [0, 1]. The
    Signal-to-Noise-Ratio (SNR) is coh / (1 - coh). SNR = 1 when coh = 0.5.

In addition, a single file with all of the above as individual columns will
be written to standard output (unless disabled via **multifiles**).

**WARNING** The above, as well as some other parts of this manual were written for the CLI
(Command Line Interface) version of this module and are guaranteed  to work exactly as described.
More testing is needed.


Required Arguments
------------------

*table*
    A file name, a \myreflink{GMTdataset} or a Mx2 matrix  holding $X(t)$ [$Y(t)$] samples in the first 1 [or 2] columns.

- **S** or **size** : -- *size=segment_size*\
    *segment_size* is a radix-2 number of samples per window for ensemble averaging. The smallest frequency estimated is
    1.0/(*segment_size* \* *dt*), while the largest is 1.0/(2 \* *dt*). One standard error in power spectral density is approximately
    1.0 / sqrt(*n_data* / *segment_size*), so if *segment_size = 256*, you need 25,600 data to get a one standard error bar of 10%.
    Cross-spectral error bars are larger and more complicated, being a
    function also of the coherency.

Optional Arguments
------------------

- **C** or **components** or **output** : -- *output=(xpower=true, ypower=true, cpower=true, npower=true", phase=true, admitt=true, gain=true, coh=true)*\
    Read the first two columns of input as samples of two time-series, *X*\ (*t*) and *Y*\ (*t*).
    Consider *Y*\ (*t*) to be the output and *X*\ (*t*) the input in a linear system with noise. Estimate the
    optimum frequency response function by least squares, such that the noise output is minimized and the
    coherent output and the noise output are uncorrelated. Optionally specify up to 8 directives from the set
    refered above in any order to create only those output files instead of the default [all]. Use in alternatively
    a string made of the `acgnopxy` characters, or the expanded version that uses the keywords.
    - **a** or `admitt=true`: Admittance spectrum, or real part of the transfer function.
    - **c** or `cpower=true`: Power spectral density of the coherent output.
    - **g** or `gain=true`: Gain spectrum, or modulus of the transfer function.
    - **n** or `npower=true`: Power spectral density of the noise output.
    - **o** or `coh=true`: Squared coherency spectrum, or linear correlation coefficient as a function of frequency.
    - **p** or `phase=true`: Phase spectrum, or phase of the transfer function.
    - **x** or `xpower=true`: Power spectral density of *X*\ (*t*).
    - **y** or `ypower=true`: Power spectral density of *Y*\ (*t*).

- **D** or **sample_dist** : -- *sample_dist=dt*\
    *dt* Set the spacing between samples in the time-series [Default = 1].

- **L** or **leave_trend** : -- *leave_trend="h|m"*\
    Leave trend alone. By default, a linear trend will be removed prior to the transform. Alternatively, use **leave_trend=m**
    to just remove the mean value or **h** to remove the mid-value.

- **N** or **name** : -- *name=name_stem*\
    Supply an alternate name stem to be used for each individual output file [Default = "spectrum"].
    If this option is given with no argument then we disable the writing of individual
    output files and instead write a single composite results table.

- **T** or **multifiles** : -- *multifiles=true*\
    Disable the creation of a single composite results table. Only individual output
    files for each selected component (see **output**) will be created.

\textinput{common_opts/opt_V}

- **W** or **wavelength** : -- *wavelength=true*\
    Write Wavelength rather than frequency in column 1 of the output file[s] [Default = frequency, (cycles / *dt*)].

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_bo}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

Examples
--------

Suppose `data.g` is gravity data in mGal, sampled every 1.5 km. To write
its power spectrum, in mGal^2-km, to the file data.xpower, use:

```julia
D = spectrum1d("data.g", size=256, sample_dist=1.5);
```

Suppose in addition to gravity data you have also the topography data.t in meters sampled at the
same points as gravity. To estimate various features of the transfer function, considering topography
as input and gravity as output, stored in the first and second columns of the data.tg use:

```julia
D = spectrum1d("data.tg", size=256, sample_dist=1.5, output=true);  # 'true' here means 'all'
```

Tutorial
--------

The output of spectrum1d is in units of power spectral density, and so to get units
of data-squared you must divide by delta_t, where delta_t is the sample spacing.
(There may be a factor of 2 pi somewhere, also. If you want to be sure of the
normalization, you can determine a scale factor from Parseval's theorem: the sum of
the squares of your input data should equal the sum of the squares of the outputs
from spectrum1d, if you are simply trying to get a periodogram. [See below.])

Suppose we simply take a data set, x(t), and compute the discrete Fourier transform
(DFT) of the entire data set in one go. Call this X(f). Then suppose we form X(f)
times the complex conjugate of X(f).

P_raw(f) = X(f) * X'(f), where the ' indicates complex conjugation.

P_raw is called the periodogram. The sum of the samples of the periodogram equals the
sum of the samples of the squares of x(t), by Parseval's theorem. (If you use a DFT
subroutine on a computer, usually the sum of P_raw equals the sum of x-squared, times M,
where M is the number of samples in x(t).)

Each estimate of X(f) is now formed by a weighted linear combination of all of the
x(t) values. (The weights are sometimes called "twiddle factors" in the DFT literature.)
So, no matter what the probability distribution for the x(t) values is, the probability
distribution for the X(f) values approaches [complex] Gaussian, by the Central Limit
Theorem. This means that the probability distribution for P_raw(f) approaches chi-squared
with two degrees of freedom. That reduces to an exponential distribution, and the
variance of the estimate of P_raw is proportional to the square of the mean, that is,
the expected value of P_raw.

In practice if we form P_raw, the estimates are hopelessly noisy. Thus P_raw is not useful,
and we need to do some kind of smoothing or averaging to get a useful estimate, P_useful(f).

There are several different ways to do this in the literature. One is to form P_raw and
then smooth it. Another is to form the auto-covariance function of x(t), smooth, taper and
shape it, and then take the Fourier transform of the smoothed, tapered and shaped auto-covariance.
Another is to form a parametric model for the auto-correlation structure in x(t), then compute
the spectrum of that model. This last approach is what is done in what is called the
"maximum entropy" or "Berg" or "Box-Jenkins" or "ARMA" or "ARIMA" methods.

*Welch*'s method is a tried-and-true method. In his method, you choose a segment length,
**size**=_N_, so that estimates will be made from segments of length *N*. The frequency samples
(in cycles per delta_t unit) of your P_useful will then be at *k* /(*N* \* *delta_t*),
where *k* is an integer, and you will get *N* samples (since the spectrum is an even
function of *f*, only *N*/2 of them are really useful). If the length of your entire
data set, x(t), is *M* samples long, then the variance in your P_useful will decrease
in proportion to *N/M*. Thus you need to choose *N* << *M* to get very low noise and
high confidence in P_useful. There is a trade-off here; see below.

There is an additional reduction in variance in that Welch's method uses a Von Hann
spectral window on each sample of length *N*. This reduces side lobe leakage and has
the effect of smoothing the (*N* segment) periodogram as if the X(f) had been
convolved with [1/4, 1/2, 1/4] prior to forming P_useful. But this slightly widens
the spectral bandwidth of each estimate, because the estimate at frequency sample *k*
is now a little correlated with the estimate at frequency sample k+1. (Of course this
would also happen if you simply formed P_raw and then smoothed it.)

Finally, *Welch*\ 's method also uses overlapped processing. Since the Von Hann window is
large in the middle and tapers to near zero at the ends, only the middle of the segment
of length *N* contributes much to its estimate. Therefore in taking the next segment
of data, we move ahead in the x(t) sequence only *N*/2 points. In this way, the next
segment gets large weight where the segments on either side of it will get little weight,
and vice versa. This doubles the smoothing effect and ensures that (if *N* << *M*)
nearly every point in x(t) contributes with nearly equal weight in the final answer.

*Welch*'s method of spectral estimation has been widely used and widely studied. It is very
reliable and its statistical properties are well understood. It is highly recommended in
such textbooks as "Random Data: Analysis and Measurement Procedures" [*Bendat and Piersol*, 1986].

In all problems of estimating parameters from data, there is a classic trade-off between
resolution and variance. If you want to try to squeeze more resolution out of your data
set, then you have to be willing to accept more noise in the estimates. The same trade-off
is evident here in Welch's method. If you want to have very low noise in the spectral
estimates, then you have to choose *N* << *M*, and this means that you get only *N*
samples of the spectrum, and the longest period that you can resolve is only *N* \* *delta_t*.
So you see that reducing the noise lowers the number of spectral samples and lowers the
longest period. Conversely, if you choose *N* approaching *M*, then you approach the
periodogram with its very bad statistical properties, but you get lots of samples and
a large fundamental period.

The other spectral estimation methods also can do a good job. Welch's method was selected
because the way it works, how one can code it, and its effects on statistical distributions,
resolution, side-lobe leakage, bias, variance, etc. are all easily understood. Some of the
other methods (e.g. Maximum Entropy) tend to hide where some of these trade-offs are
happening inside a "black box".


See Also
--------

\myreflink{grdfft}

References
----------

Bendat, J. S., and A. G. Piersol, 1986, Random Data, 2nd revised ed., John Wiley & Sons.

Welch, P. D., 1967, The use of Fast Fourier Transform for the estimation
of power spectra: a method based on time averaging over short, modified
periodograms, IEEE Transactions on Audio and Electroacoustics, Vol AU-15, No 2.
