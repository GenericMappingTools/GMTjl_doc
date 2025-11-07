# grdfft

Mathematical operations on grids in the spectral domain

(**Warning: Manual translate by Claude. Needs revision**)

## Synopsis

**grdfft** *ingrid* [ *ingrid2* ]
[ **G** | **outgrid** | **save** ]
[ **A** | **azim** | **azimuth** ]
[ **C** | **upward** | **continue** ]
[ **D** | **dfdz** | **differentiate** ]
[ **E** | **radial\_power** | **spectrum** ]
[ **F** | **filter** ]
[ **I** | **integrate** ]
[ **M** | **mgal45** ]
[ **N** | **inquire** | **fft\_params** ]
[ **Q** | **no\_wavenumber** ]
[ **S** | **scale** ]
[ **V** | **verbose** ]
[ **f** | **colinfo** ]

## Description

**grdfft** will take the 2-D forward Fast Fourier Transform and perform one or more mathematical operations in the frequency domain before transforming back to the space domain. An option is provided to scale the data before writing the new values to an output file. The horizontal dimensions of the grid are assumed to be in meters. Geographical grids may be used by specifying the **colinfo** option that scales degrees to meters. If you have grids with dimensions in km, you could change this to meters using **grdedit**.

## Required Arguments

*ingrid*
:   2-D binary grid file to be operated on. Can be a file name, a GMTgrid object, or a Matrix.

*ingrid2*
:   Optional second grid file for cross-spectral estimates (see **E** | **spectrum**).

## Optional Arguments

- **G** or **outgrid** or **save** : -- *save="outfile.grd"* **|** *save="table.txt"*\
    Specify the name of the output grid file or the 1-D spectrum table (see **spectrum**). This is optional for **spectrum** (output to standard output) but mandatory for all other options that require a grid output.

- **A** or **azim** : -- *azim=angle* **|** *azim=deg*\
    Take the directional derivative in the azimuth direction measured in degrees CW from north.

- **C** or **upward** : -- *upward=zlevel*\
    Upward (for *zlevel* > 0) or downward (for *zlevel* < 0) continue the field *zlevel* meters.

- **D** or **dfdz** : -- *dfdz=true* **|** *dfdz=scale* **|** *dfdz="<scale>g"*\
    Differentiate the field, i.e., take ∂/∂z of the grid z. This is equivalent to multiplying by kr in the frequency domain (kr is radial wave number). Options:
    - No argument or **true** : Multiply by kr [Default].
    - *scale* (Number) : Multiply by kr × *scale* instead.
    - **"<scale>g"** : Indicates that your data are geoid heights in meters and output should be gravity anomalies in mGal.
	  Here, *scale* is a numerical factor to multiply kr by (e.g., 2π × 6.673e-11 × 5.972e24 / 6371000³ = 6.2638e-7 for Earth).
	  Note that in this case, the whole value must be provided as a string.
    
    Repeatable. [Default is no scale].

- **E** or **radial\_power** : -- *radial\_power=true* **|** *spectrum=:r* **|** *radial\_power=(dir=:x, modifiers...)* **|** *radial\_power="r+w+n"*\
    Estimate power spectrum in the radial or a horizontal direction. No grid file is created. If one grid is given then f (i.e., frequency or wave number), power[f], and 1 standard deviation in power[f] are written to the file set by **save** [standard output]. If two grids are given we write f and 8 quantities: Xpower[f], Ypower[f], coherent power[f], noise power[f], phase[f], admittance[f], gain[f], coherency[f]. Each quantity is followed by its own 1-std dev error estimate, hence the output is 17 columns wide. Select your spectrum by choosing one of these directives:
    - **:r** or **dir=:r** : Choose a radial spectrum [Default].
    - **:x** or **dir=:x** : Compute the spectrum in the x-direction instead.
    - **:y** or **dir=:y** : Compute the spectrum in the y-direction instead.
    
    Two modifiers are available to adjust the output further:
    - **wavelength** or **w** : *wavelength=true* **|** *w=:k* -- Write wavelength w instead of frequency f, and if your grid is geographic you may further append **:k** to scale wavelengths from meter [Default] to km.
    - **normalize** or **n** : *normalize=true* **|** *n=true* -- Normalize spectrum so that the mean spectral values per frequency are reported [By default the spectrum is obtained by summing over several frequencies].

- **F** or **filter** : -- *filter=(lc, lp, hp, hc)* **|** *filter="lc/lp/hp/hc"* **|** *filter=(dir=:x, lc=lc, lp=lp, hp=hp, hc=hc)* **|** *filter=(dir=:r, lo=lo, hi=hi)* **|** *filter=(dir=:y, lo=lo, hi=hi, order=n)*\
    Filter the data. Place **:x** or **:y** immediately after **F** (or use **dir=:x** or **dir=:y**) to filter x or y direction only; default is isotropic [**:r**]. Choose between a cosine-tapered band-pass, a Gaussian band-pass filter, or a Butterworth band-pass filter:
    
    **Cosine-taper**:
    Specify four wavelengths *lc/lp/hp/hc* in correct units (see **colinfo**) to design a bandpass filter: wavelengths greater than *lc* or less than *hc* will be cut, wavelengths greater than *lp* and less than *hp* will be passed, and wavelengths in between will be cosine-tapered. E.g., `filter=(1000000, 250000, 50000, 10000), colinfo=:g` will bandpass, cutting wavelengths > 1000 km and < 10 km, passing wavelengths between 250 km and 50 km. To make a highpass or lowpass filter, give hyphens (-) or `missing` for *hp/hc* or *lc/lp*. E.g., `filter=(dir=:x, lp=missing, hp=50, hc=10)` will lowpass x, passing wavelengths > 50 and rejecting wavelengths < 10. `filter=(dir=:y, lc=1000, lp=250, hp=missing)` will highpass y, passing wavelengths < 250 and rejecting wavelengths > 1000.
    
    **Gaussian band-pass**:
    Append *lo/hi*, the two wavelengths in correct units (see **colinfo**) to design a bandpass filter. At the given wavelengths the Gaussian filter weights will be 0.5. To make a highpass or lowpass filter, give a hyphen (-) or `missing` for the *hi* or *lo* wavelength, respectively. E.g., `filter=(lo=missing, hi=30)` will lowpass the data using a Gaussian filter with half-weight at 30, while `filter=(lo=400, hi=missing)` will highpass the data.
    
    **Butterworth band-pass**:
    Append *lo/hi/order*, the two wavelengths in correct units (see **colinfo**) and the filter order (an integer) to design a bandpass filter. At the given cut-off wavelengths the Butterworth filter weights will be 0.707 (i.e., the power spectrum will therefore be reduced by 0.5). To make a highpass or lowpass filter, give a hyphen (-) or `missing` for the *hi* or *lo* wavelength, respectively. E.g., `filter=(lo=missing, hi=30, order=2)` will lowpass the data using a 2nd-order Butterworth filter, with half-weight at 30, while `filter=(lo=400, hi=missing, order=2)` will highpass the data.
    
    Note: For filtering in the time (or space) domain instead, see **grdfilter**.

- **I** or **integrate** : -- *integrate=true* **|** *integrate=scale* **|** *integrate="<scale>g"*\
    Integrate the field, i.e., compute ∫ z(x,y) dz. This is equivalent to divide by kr in the frequency domain (kr is radial wave number). Options:
    - No argument or **true** : Divide by kr [Default].
    - *scale* (Number) : Divide by kr × *scale* instead.
    - **<scale>g** : Indicates that your data set is gravity anomalies in mGal and output should be geoid heights in meters.
	  Note that in this case, the whole value must be provided as a string.
    
- **M** or **mgal45** : -- *mgal45=value*\
    Specify the value of the gravity in mili Gals at 45 degrees latitude (used to convert gravity anomalies to geoid heights). Default is 980619.9203 mGal (Moritz's 1980 IGF value). This value needs to be changed accordingly when using data from other planets.

- **N** or **inquire** : -- *inquire=true* **|** *inquire=:a* **|** *inquire=(mode=:f, modifiers...)* **|** *inquire="a+d+e+t50+v+w+z"*\
    Choose or inquire about suitable grid dimensions for FFT and set optional parameters. Control the FFT dimension via these directives:
    - **:a** or **mode=:a** : Let the FFT select dimensions yielding the most accurate result.
    - **:f** or **mode=:f** : Force the FFT to use the actual dimensions of the data.
    - **:m** or **mode=:m** : Let the FFT select dimensions using the least work memory.
    - **:r** or **mode=:r** : Let the FFT select dimensions yielding the most rapid calculation.
    - **:s** or **mode=:s** : Just present a list of optional dimensions, then exit.
    - *nx/ny* or **size=(nx, ny)** : Do FFT on array size nx/ny (must be >= grid file size).
    
    Without a directive we expect nx/ny which will do FFT on array size nx/ny (must be >= grid file size). Default chooses dimensions >= data which optimize speed and accuracy of FFT. If FFT dimensions > grid file dimensions, data are extended and tapered to zero.
    
    Control detrending of data by appending a modifier for removing a linear trend. The default action is to remove a best-fitting linear plane (**+d**):
    - **detrend** or **+d** : *detrend=true* -- Detrend data, i.e. remove best-fitting linear trend.
    - **mean** or **+a** : *mean=true* -- Only remove the mean value.
    - **mid** or **+h** : *mid=true* -- Only remove the mid value, i.e. 0.5 × (max + min).
    - **leave** or **+l** : *leave=true* -- Leave data alone.
    
    Control extension and tapering of data by appending a modifier to control how the extension and tapering are to be performed:
    - **extend** or **+e** : *extend=true* -- Extend the grid by imposing edge-point symmetry [Default].
    - **mirror** or **+m** : *mirror=true* -- Extends the grid by imposing edge mirror symmetry.
    - **no\_extend** or **+n** : *no\_extend=true* -- Turns off data extension.
    
    Tapering is performed from the data edge to the FFT grid edge [100%]. Change this percentage via modifier:
    - **taper** or **+t** : *taper=width* -- Set taper width as percentage.
    
    When **+n** is in effect, the tapering is applied instead to the data margins as no extension is available [0%].
    
    Control messages being reported:
    - **+v** : *verbose\_fft=true* -- Report suitable dimensions during processing.
    
    Control writing of temporary results: For detailed investigation you can write the intermediate grid being passed to the forward FFT; this is likely to have been detrended, extended by point-symmetry along all edges, and tapered. Use these modifiers to save such grids:
    - **write** or **+w** : *write="suffix"* -- Set the suffix from which output file name(s) will be created (i.e., *ingrid\_suffix.ext*) [Default is "tapered"], where ext is your file extension.
    - **save\_fft** or **+z** : *save\_fft=true* **|** *save\_fft=:p* -- Save the complex grid produced by the forward FFT. By default we write the real and imaginary components to *ingrid\_real.ext* and *ingrid\_imag.ext*. Append **:p** to instead use the polar form of magnitude and phase to files *ingrid\_mag.ext* and *ingrid\_phase.ext*.

- **Q** or **no\_wavenumber** : -- *no\_wavenumber=true*\
    Selects no wavenumber operations. Useful in conjunction with **inquire** modifiers when you wish to write out the 2-D spectrum (or other intermediate grid products) only.

- **S** or **scale** : -- *scale=factor* **|** *scale=:d*\
    Multiply each element by *factor* in the space domain (after the frequency domain operations). [Default is 1.0]. Alternatively, append **:d** to convert deflection of vertical to micro-radians.

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_f}

## Grid Distance Units

If the grid does not have meter as the horizontal unit, append **+u***unit* to the input file name to convert from the specified unit to meter. If your grid is geographic, convert distances to meters by supplying **colinfo=:g** instead.

## Considerations

netCDF COARDS grids will automatically be recognized as geographic. For other geographical grids where you want to convert degrees into meters, select **colinfo=:g**. If the data are close to either pole, you should consider projecting the grid file onto a rectangular coordinate system using \myreflink{grdproject}.

## Data Detrending

The default detrending mode is to remove a best-fitting linear plane (**+d**). Consult and use **inquire** to select other modes.

## Normalization of Spectrum

By default, the power spectrum returned by **spectrum** simply sums the contributions from frequencies that are part of the output frequency. For x- or y-spectra this means summing the power across the other frequency dimension, while for the radial spectrum it means summing up power within each annulus of width delta\_q, the radial frequency (q) spacing. A consequence of this summing is that the radial spectrum of a white noise process will give a linear radial power spectrum that is proportional to q. Appending **normalize=true** will instead compute the mean power per output frequency and in this case the white noise process will have a white radial spectrum as well.

## Examples

To obtain the normalized radial spectrum from the remote data grid @white\_noise.nc, after removing the mean, try:

```julia
using GMT
D = grdfft("@white_noise.nc", spectrum=(dir=:r, normalize=true), inquire=(mean=true,))
```

To upward continue the sea-level magnetic anomalies in the file mag\_0.nc to a level 800 m above sealevel:

```julia
G = grdfft("mag_0.nc", upward=800, verbose=true, save="mag_800.nc")
```

To transform geoid heights in m (geoid.nc) on a geographical grid to free-air gravity anomalies in mGal:

```julia
G = grdfft("geoid.nc", dfdz=:g, verbose=true, save="grav.nc")
```

To transform gravity anomalies in mGal (faa.nc) to deflections of the vertical (in micro-radians) in the 038 direction, we must first integrate gravity to get geoid, then take the directional derivative, and finally scale radians to micro-radians:

```julia
G = grdfft("faa.nc", integrate=:g, azim=38, scale=1e6, verbose=true, save="defl_38.nc")
```

Second vertical derivatives of gravity anomalies are related to the curvature of the field. We can compute these as mGal/m² by:

```julia
G = grdfft("gravity.nc", dfdz=true, dfdz=true, verbose=true, save="grav_2nd_derivative.nc")
```

Note: To repeat **dfdz** twice, you would need to call grdfft twice in sequence or use the monolithic syntax.

To compute cross-spectral estimates for co-registered bathymetry and gravity grids, and report result as functions of wavelengths in km, try:

```julia
D = grdfft(["bathymetry.nc", "gravity.grd"], spectrum=(wavelength=:k,), colinfo=:g, verbose=true)
```

Or using two separate grid arguments:

```julia
bathy = gmtread("bathymetry.nc")
grav = gmtread("gravity.grd")
D = grdfft(bathy, grav, spectrum=(wavelength=:k,), colinfo=:g, verbose=true)
```

To examine the pre-FFT grid after detrending, point-symmetry reflection, and tapering has been applied, as well as saving the real and imaginary components of the raw spectrum of the data in topo.nc, try:

```julia
grdfft("topo.nc", inquire=(write=true, save_fft=true), colinfo=:g, verbose=true, 
       no_wavenumber=true)
```

You can now make plots of the data in topo\_taper.nc, topo\_real.nc, and topo\_imag.nc.

## Notes

### Repeating Operations

Some operations like **dfdz** and **integrate** can be repeated to get higher-order derivatives or multiple integrations. In GMT.jl, you have two options:

1. **Chain calls**: Call grdfft multiple times in sequence
2. **Monolithic syntax**: Use the GMT command string directly

Example for second derivative:
```julia
# Option 1: Chain calls
G1 = grdfft("gravity.nc", dfdz=true)
G2 = grdfft(G1, dfdz=true)

# Option 2: Monolithic syntax  
G = grdfft("gravity.nc", D="-D -D", save="output.nc")
```

## See Also

\myreflink{grdfilter}, \myreflink{grdproject}